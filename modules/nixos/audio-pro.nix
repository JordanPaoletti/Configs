# Pro-audio system stack: PipeWire in pro-audio mode, JACK emulation, and
# musnix realtime tuning.
#
# Requires inputs.musnix.nixosModules.musnix in the machine's module list.
# User-facing apps (Ardour, alsa-scarlett-gui, plugins) live in
# modules/opts/audio.nix on the home-manager side.
{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    myAudio = {
      enable = lib.mkEnableOption "pro audio system configuration";

      cardMatch = lib.mkOption {
        type = lib.types.str;
        default = "~alsa_card.usb-Focusrite.*";
        description = ''
          WirePlumber match for the interface's ALSA card. A leading "~"
          makes it a regex. Confirm the real name with `wpctl status` or
          `pw-dump | jq -r '.[].info.props."device.name"'`.
        '';
      };

      rate = lib.mkOption {
        type = lib.types.int;
        default = 48000;
        description = "Default sample rate.";
      };

      quantum = lib.mkOption {
        type = lib.types.int;
        default = 256;
        description = "Default PipeWire quantum in frames. Raise if you hear xruns.";
      };

      headroom = lib.mkOption {
        type = lib.types.int;
        default = 0;
        description = "Extra ALSA buffer headroom in frames. Raise if you hear xruns.";
      };

      headphoneNode = lib.mkOption {
        type = lib.types.str;
        default = "alsa_output.usb-Focusrite_Scarlett_18i20_USB_P98A3KP180A95F-00.pro-output-0";
        description = ''
          PipeWire node name of the interface's pro-audio playback device.
          Loopback target for the "Desktop Audio" sink below, so ordinary
          apps get a friendly output even though pro-audio mode itself only
          exposes raw numbered ports. Find it with `pw-dump | grep
          pro-output` while the card is in pro-audio profile.
        '';
      };

      headphonePorts = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [
          "AUX6"
          "AUX7"
        ];
        description = ''
          Raw port names (audio.channel) on headphoneNode that the hardware
          router patches through to the physical headphone jack — see
          machines/music/docs/scarlett-18i20-routing.md. Confirm with
          `pw-dump | grep playback_AUX` while in pro-audio profile; changes
          if the router's PCM-to-jack patch is ever repatched.
        '';
      };
    };
  };

  config = lib.mkIf config.myAudio.enable {
    # performance governor, threadirqs, @audio memlock/rtprio limits, and
    # LV2/VST/CLAP search paths that already include ~/.nix-profile/lib.
    musnix.enable = true;

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;

      extraConfig.pipewire."92-pro-audio" = {
        "context.properties" = {
          "default.clock.rate" = config.myAudio.rate;
          "default.clock.allowed-rates" = [
            44100
            48000
            88200
            96000
          ];
          "default.clock.quantum" = config.myAudio.quantum;
          "default.clock.min-quantum" = 64;
          "default.clock.max-quantum" = 2048;
        };
      };

      # Ordinary desktop apps still work fine against the raw pro-audio
      # node, but with no UCM device names PipeWire has no idea which
      # channels are "headphones" and defaults new stereo streams to
      # channels 1-2. This loopback gives them a friendly, fixed sink
      # wired to the actual headphone-jack channels instead. Ardour/JACK
      # clients are unaffected — they patch the raw node directly.
      extraConfig.pipewire."93-desktop-audio-loopback" = {
        "context.modules" = [
          {
            name = "libpipewire-module-loopback";
            args = {
              "node.description" = "Desktop Audio (Scarlett Headphones)";
              "capture.props" = {
                "node.name" = "desktop-audio-headphones";
                "media.class" = "Audio/Sink";
                "audio.position" = [
                  "FL"
                  "FR"
                ];
              };
              "playback.props" = {
                "node.name" = "desktop-audio-headphones.playback";
                "node.target" = config.myAudio.headphoneNode;
                "audio.position" = config.myAudio.headphonePorts;
                "stream.dont-remix" = true;
              };
            };
          }
        ];
      };

      # Expose every hardware channel as its own port instead of letting ACP
      # guess a consumer stereo/surround layout.
      wireplumber.extraConfig."51-pro-audio-interface" = {
        "monitor.alsa.rules" = [
          {
            matches = [ { "device.name" = config.myAudio.cardMatch; } ];
            actions.update-props = {
              "device.profile" = "pro-audio";
              "api.alsa.period-size" = config.myAudio.quantum;
              "api.alsa.headroom" = config.myAudio.headroom;
            };
          }
        ];
        # device.profile above only sets the profile WirePlumber tries on
        # first-ever discovery. After that, WirePlumber persists whatever
        # profile was last active per device.name and restores it on every
        # boot BEFORE re-evaluating device.profile, permanently pinning
        # this card to whatever it last happened to be switched to (HiFi,
        # in practice). Disabling restore is what actually makes pro-audio
        # stick. See docs/scarlett-18i20-troubleshooting.md.
        "wireplumber.settings" = {
          "device.restore-profile" = false;
        };
      };
    };
  };
}
