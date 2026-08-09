{
  config,
  pkgs,
  lib,
  ...
}:
let
  # nixpkgs ardour links libjack2 via DT_RUNPATH, so it loads jack2's libjack
  # and hunts for a jackd server that does not exist under PipeWire. Putting
  # pipewire's jack lib on LD_LIBRARY_PATH wins over RUNPATH (what pw-jack
  # does), which makes Ardour's JACK backend work. The ALSA backend is
  # unaffected, so both are selectable from Audio/MIDI Setup.
  ardour-pw = pkgs.symlinkJoin {
    name = "ardour-pw-${pkgs.ardour.version}";
    paths = [ pkgs.ardour ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      for f in "$out"/bin/*; do
        [ -e "$f" ] || continue
        wrapProgram "$f" \
          --prefix LD_LIBRARY_PATH : ${pkgs.pipewire.jack}/lib
      done

      # Desktop entries may Exec the unwrapped binary by absolute path;
      # repoint them at the wrappers so the launcher matches the CLI.
      for d in "$out"/share/applications/*.desktop; do
        [ -e "$d" ] || continue
        if [ -L "$d" ]; then
          target=$(readlink -f "$d")
          rm "$d"
          cp "$target" "$d"
          chmod +w "$d"
        fi
        substituteInPlace "$d" --replace-quiet "${pkgs.ardour}/bin/" "$out/bin/"
      done
    '';
    meta = pkgs.ardour.meta // {
      mainProgram = "ardour9";
    };
  };

  # Hands the interface between PipeWire (pro-audio profile, shared with the
  # desktop) and Ardour's ALSA backend (exclusive, lowest latency) at runtime,
  # so switching does not need a rebuild.
  scarlett-mode = pkgs.writeShellApplication {
    name = "scarlett-mode";
    runtimeInputs = with pkgs; [
      pipewire
      wireplumber
      jq
    ];
    text = ''
      MATCH="''${SCARLETT_MATCH:-alsa_card.usb-Focusrite}"

      find_device() {
        pw-dump | jq -r --arg m "$MATCH" '
          first(
            .[]
            | select(.type == "PipeWire:Interface:Device")
            | select((.info.props."device.name" // "") | test($m))
            | .id
          )
        '
      }

      profile_index() {
        pw-dump "$1" | jq -r --arg n "$2" '
          first(.[0].info.params.EnumProfile[]? | select(.name == $n) | .index)
        '
      }

      current_profile() {
        pw-dump "$1" | jq -r 'first(.[0].info.params.Profile[]?.name)'
      }

      list_profiles() {
        pw-dump "$1" | jq -r '.[0].info.params.EnumProfile[]? | "  \(.index)\t\(.name)"'
      }

      dev=$(find_device)
      if [ -z "$dev" ]; then
        echo "scarlett-mode: no device matching '$MATCH' found" >&2
        echo "hint: set SCARLETT_MATCH to a regex over device.name" >&2
        exit 1
      fi

      case "''${1:-status}" in
        pro | pro-audio)
          target=pro-audio
          ;;
        off | alsa)
          target=off
          ;;
        status)
          echo "device $dev: $(current_profile "$dev")"
          list_profiles "$dev"
          exit 0
          ;;
        *)
          echo "usage: scarlett-mode [pro|off|status]" >&2
          exit 2
          ;;
      esac

      idx=$(profile_index "$dev" "$target")
      if [ -z "$idx" ]; then
        echo "scarlett-mode: device $dev has no '$target' profile" >&2
        echo "available:" >&2
        list_profiles "$dev" >&2
        exit 1
      fi

      wpctl set-profile "$dev" "$idx"
      echo "device $dev -> $target (profile $idx)"
    '';
  };
in
{
  options = {
    myDaw = {
      enable = lib.mkEnableOption "myDaw";
    };
  };

  config = lib.mkIf config.myDaw.enable {
    home.packages = with pkgs; [
      ardour-pw
      scarlett-mode

      # Focusrite Scarlett internal mixer: routing matrix, gain, 48V, pad, air.
      alsa-scarlett-gui

      # Routing / troubleshooting
      qpwgraph
      pavucontrol
      jack_capture
      pipewire.jack # pw-jack, for launching other JACK clients

      # LV2 plugins; these land in ~/.nix-profile/lib/lv2, which musnix's
      # LV2_PATH already covers.
      lsp-plugins
      calf
      x42-plugins
      zam-plugins
    ];
  };
}
