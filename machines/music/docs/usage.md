# Scarlett 18i20 — Day-to-Day Usage

How to actually get sound moving on the `music` machine: the CLI tools this
config installs, what each is for, and the minimal steps to go from a fresh
boot to recording/playing in Ardour or just listening to a browser tab.

Related:
- [scarlett-18i20-routing.md](./scarlett-18i20-routing.md) — hardware channel/jack reference
- [scarlett-18i20-troubleshooting.md](./scarlett-18i20-troubleshooting.md) — diagnosing silence
- `modules/nixos/audio-pro.nix` (`myAudio.enable`) — system PipeWire/musnix config
- `modules/opts/audio.nix` (`myDaw.enable`) — the packages below

## What's configured, and what that means for you

- The card boots straight into WirePlumber's **`pro-audio`** profile and
  stays there (`wireplumber.settings.device.restore-profile = false` in
  `audio-pro.nix`) — there is no "HiFi"/"Headphones 1" sink anymore, only 20
  raw numbered ports (`playback_AUX0`–`19`) meant for patching.
- A permanent loopback sink, **"Desktop Audio (Scarlett Headphones)"**,
  covers ordinary apps (browser, notification sounds, etc.) — it appears as
  a normal sink in GNOME Sound settings / `pavucontrol` and is hard-wired to
  the headphone-jack AUX pair (`myAudio.headphonePorts`, default `AUX6`/`AUX7`).
  Nothing to configure here day to day — just pick it as the output device.
- Everything else (Ardour, other JACK clients) talks to the raw pro-audio
  node directly and needs manual patching — that's what the tools below are
  for.

## CLI tools

### `scarlett-mode` — check/force the ALSA profile

Wrapper around `wpctl set-profile`. Mainly useful for confirming the card is
actually in `pro-audio` (it should always be, per the above) or temporarily
forcing it off for exclusive-ALSA use by another app.

```shell
scarlett-mode status   # show current profile + list all available profiles/indices
scarlett-mode pro      # force pro-audio
scarlett-mode off      # force off (alsa/off also accepted for the arg)
```

`status` output:

```
device 55: pro-audio
  0	off
  1	HiFi (Direct1, Direct2, Line1, Line10, ...)
  ...
  4	pro-audio
```

Set `SCARLETT_MATCH` (regex over `device.name`) if you ever have more than
one Focusrite device attached; defaults to `alsa_card.usb-Focusrite`.

### `alsa-scarlett-gui` — hardware router / mixer / gain

The only way to edit the interface's **onboard** routing matrix (which PCM
channels or internal Mixer outputs reach which physical jack), input
gain/48V/pad/air switches, and monitor mix. This setting lives on the
device's own NVRAM, not in PipeWire/ALSA config — it persists across
reboots and OS reinstalls by itself.

```shell
alsa-scarlett-gui
```

You only need this when:
- setting up a **new** output/input routing (see
  [scarlett-18i20-routing.md](./scarlett-18i20-routing.md) for the
  known-good matrix already applied), or
- adjusting input gain, 48V phantom power, pad, or air on the physical
  inputs — none of that is exposed through PipeWire.

### `qpwgraph` — patch PipeWire/JACK ports

Visual patchbay for connecting Ardour's (or any JACK/PipeWire client's)
ports to the Scarlett's raw `playback_AUX*`/`capture_AUX*` ports. This is
the main tool you'll touch every session.

```shell
qpwgraph
```

Typical session: open it, find your client's output ports on one side and
`Scarlett 18i20 3rd Gen` (`pro-output-0`/`pro-input-0`) on the other, drag
connections. Layouts can be saved/reloaded as `.qpwgraph` patchbay files if
you want a one-click reconnect for a recurring session setup.

### `wpctl` — quick inspection, no GUI

Already covered in detail in the troubleshooting doc; the two you'll use
most in normal operation:

```shell
wpctl status                 # see all devices/sinks/sources and current defaults
wpctl set-default <id>       # change GNOME's default sink/source (e.g. to
                              # the Desktop Audio loopback sink)
```

### `pw-dump` — raw introspection

Only needed when a port name changed (e.g. after repatching the hardware
router, or debugging a mismatch) and you need ground truth:

```shell
pw-dump | grep pro-output    # find the Scarlett's raw node name
pw-dump | grep playback_AUX  # list its raw playback ports
```

### `pavucontrol` — volume mixer

Standard PulseAudio-compatible mixer (works fine over PipeWire's `pulse`
shim). Useful for per-application volume control on the Desktop Audio sink;
not needed for routing.

### `jack_capture` / `pw-jack`

`jack_capture` records any JACK port(s) straight to a file, handy for
quick capture without opening Ardour. `pw-jack` (from `pipewire.jack`)
prefixes any command to make it register as a JACK client against
PipeWire's JACK emulation — useful for third-party tools not already
patched like `ardour-pw` is.

## Ardour

Launch with `ardour9` (the `ardour-pw` wrapper — plain `ardour` isn't
installed). In **Window → Audio/MIDI Setup**:

- **Audio System**: `JACK`, not `ALSA` — see the reasoning in this doc's
  companion discussion; short version is `ardour-pw` is specifically
  wrapped to talk to PipeWire's JACK emulation, and using ALSA directly
  would grab the interface exclusively and lock out PipeWire (and thus the
  desktop loopback sink) entirely.
- Sample rate / buffer size are inherited from PipeWire's quantum/rate
  (`myAudio.rate`/`myAudio.quantum` in `audio-pro.nix`) — changing them in
  Ardour's dialog changes them PipeWire-wide, not just for Ardour.

After launching, patch Ardour's Master bus (and any input tracks) to the
Scarlett's raw AUX ports via **Window → Audio Connections** or externally
via `qpwgraph`. See
[scarlett-18i20-routing.md](./scarlett-18i20-routing.md) for which AUX
pair reaches which physical jack.

## Quick reference: common tasks

| Task | Tool |
|---|---|
| Confirm card is in pro-audio | `scarlett-mode status` |
| Patch Ardour output to headphones/monitors | `qpwgraph` |
| Change input gain / 48V / pad / air | `alsa-scarlett-gui` |
| Switch GNOME's default output | GNOME Sound settings, or `wpctl set-default <id>` |
| Per-app volume | `pavucontrol` |
| Find a raw port name after a router change | `pw-dump \| grep playback_AUX` |
| Quick record without opening Ardour | `jack_capture` |
