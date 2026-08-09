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
      };
    };
  };
}
