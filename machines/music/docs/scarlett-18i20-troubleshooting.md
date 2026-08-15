# Scarlett 18i20 Gen 3 — No Audio Output Troubleshooting

Playbook for diagnosing "no sound out of `<output>`" issues on the `music`
machine with the Focusrite Scarlett 18i20 (3rd Gen). Written up after
tracking down a real case of silence on the "Headphones 1" output — see
[Root cause found](#root-cause-found-2026-08-15) below.

Related config:
- `modules/nixos/audio-pro.nix` — system-level PipeWire/musnix setup (`myAudio.enable`)
- `modules/opts/audio.nix` — user packages incl. `alsa-scarlett-gui`, `scarlett-mode` (`myDaw.enable`)
- [scarlett-18i20-routing.md](./scarlett-18i20-routing.md) — hardware channel layout reference

## Step 1 — Confirm PipeWire sees the interface and what's default

```shell
wpctl status
```

Look under `Audio > Devices` for a `Scarlett 18i20 3rd Gen [alsa]` entry, and
under `Settings > Default Configured Devices` for the sink/source currently
selected. Expected (healthy) output looks like:

```
Audio
 ├─ Devices:
 │      55. Scarlett 18i20 3rd Gen              [alsa]
...
Settings
 └─ Default Configured Devices:
         0. Audio/Sink    alsa_output.usb-Focusrite_Scarlett_18i20_USB_..._sink
         1. Audio/Source  alsa_input.usb-Focusrite_Scarlett_18i20_USB_..._source
```

If the device isn't listed at all, it's a USB/kernel/udev problem, not a
routing problem — check `dmesg` for `snd_usb_audio` errors and re-seat the
USB cable before going further.

## Step 2 — Check which ALSA UCM profile is active

`audio-pro.nix` tries to force the card into the `pro-audio` profile via a
WirePlumber rule (raw numbered ports, for JACK/Ardour routing). Desktop
listening with a friendly name like "Headphones 1" only happens under the
`HiFi` UCM profile instead. Check which one is actually active:

```shell
scarlett-mode status
```

Expected output lists the available profiles with their index, e.g.:

```
device 55: HiFi (Direct1, Direct2, Line1, Line10, ...)
  0	off
  1	HiFi (Direct1, Direct2, Line1, Line10, ...)
  2	HiFi (Direct1, Direct2, Line6, ...)
  3	Direct 48kHz
  4	pro-audio
```

The first line (`device 55: <name>`) is the **currently active** profile. If
you picked "Headphones 1"/"Headphones 2" in GNOME Sound settings, you want
`HiFi` active — `pro-audio` mode doesn't expose those friendly per-jack
sinks at all, only raw numbered ports meant for a patchbay/DAW.

> **Resolved (2026-08-15):** `audio-pro.nix`'s WirePlumber rule set
> `device.profile = "pro-audio"`, but the card kept coming up on `HiFi`
> anyway, with no errors logged anywhere.
>
> First (wrong) lead: `device.profile` looked like it should be getting
> silently overridden by WirePlumber's own auto-profile policy, so
> `api.acp.auto-profile = false` was added alongside it. Dead end — reading
> WirePlumber's own `alsa.lua` source showed `api.acp.auto-profile = false`
> is already the built-in default, set before any rule runs. Not the cause.
>
> Actual root cause, found by reading WirePlumber's `device/*.lua` policy
> scripts directly: WirePlumber persists the last-active profile per device
> (`state-profile.lua`, keyed by `device.name`, saved to a state file every
> time any client — GNOME, `scarlett-mode`, anything — sets a profile via
> the standard `Profile` param with `save: true`). A `find-stored-profile`
> hook runs *before* the hook that reads our `device.profile` rule and
> short-circuits the whole selection chain if a stored profile exists — so
> once the card had ever been on `HiFi`, it stayed pinned there on every
> future boot regardless of the rule. This is also why manual
> `wpctl set-profile`/`scarlett-mode pro` always worked: nothing
> re-evaluates the profile after a manual set, so it just stuck until the
> next reboot re-ran the (broken) automatic selection.
>
> **Decision:** this machine is single-purpose for music production, so
> `pro-audio` was made the permanent, unconditional default rather than
> something toggled per-session. **Fix:** added
> `wireplumber.settings.device.restore-profile = false` (global — disables
> WirePlumber's profile-memory for *all* devices on this machine, not just
> the Scarlett; acceptable here since no other device on this box has more
> than one meaningful profile). Requires `sudo nixos-rebuild switch` and a
> reboot or USB replug to take effect (`monitor.alsa.rules` is only
> evaluated at device discovery, not on config reload).
>
> **Trade-off this reopens:** `pro-audio` mode has no "Headphones 1" sink —
> it only exposes 20 raw numbered ports, so forcing it permanently would
> otherwise re-break the headphone listening fix from earlier in this doc.
> Fixed by adding a `libpipewire-module-loopback` (`93-desktop-audio-
> loopback` in `audio-pro.nix`) that creates a permanent "Desktop Audio
> (Scarlett Headphones)" sink for ordinary apps, hard-wired to the raw
> node's `playback_AUX6`/`playback_AUX7` ports — the same channels the
> router patches to the physical headphone jack. Ardour/JACK clients are
> unaffected; they patch the raw pro-audio node directly via `qpwgraph`.
> See [scarlett-18i20-routing.md](./scarlett-18i20-routing.md) for the raw
> port-name reference.
>
> A WirePlumber lua error (`alsa.lua:398: attempt to concatenate a nil
> value`, in the SplitPCM HW node error-logging path) was also observed
> once in the journal ~3 min after service start, coinciding with initial
> device enumeration. It did not reproduce on manual profile switches and
> was unrelated to this bug — worth another look only if node creation
> starts failing outright.

Switch profiles manually if needed:

```shell
scarlett-mode pro     # -> pro-audio, for Ardour/JACK
scarlett-mode alsa    # -> off
# (HiFi is selected automatically by PipeWire/WirePlumber's ACP logic
#  when the interface is opened for normal desktop playback)
```

## Step 3 — Confirm the specific sink isn't muted or at zero volume

Find the sink's numeric ID from `wpctl status` (under `Audio > Sinks` or
nested under `Filters` when in `HiFi` profile — look for
`..._HiFi__Line1__sink` for "Headphones 1"), then:

```shell
wpctl get-volume <id>
```

Expected: `Volume: <0.00-1.00>` with no `[MUTED]` suffix. If `[MUTED]` is
present, unmute with `wpctl set-mute <id> 0`. Note this is PipeWire's
*software* volume for that node — it is independent of the interface's own
physical volume knobs and independent of the hardware router (Step 4).

For deeper node detail (channel map, which hardware channels it's split
from):

```shell
wpctl inspect <id>
```

Relevant fields to check: `audio.position` (should be `[ FL, FR ]` for a
stereo headphone sink), `device.profile.description` (should read e.g.
`"Headphones 1"`), `api.alsa.split.position` (the underlying hardware
channel pair, e.g. `[AUX6,AUX7]` = hardware channels 7-8 in 1-indexed
terms).

## Step 4 — Check the hardware router (the step that's easy to miss)

The 18i20 has an onboard DSP mixer/router chip. Sending correct, unmuted
signal to a PipeWire sink like "Headphones 1" only produces sound if the
interface's **internal routing matrix** actually patches that PCM pair
through to the physical output jack. This is a hardware-side setting store
on the interface itself — the OS has no say in it beyond what you configure
via `alsa-scarlett-gui`.

```shell
alsa-scarlett-gui
```

Open the router/mixer tab and check the crosspoint matrix:
- Confirm the PCM channel pair matching the sink you selected (see
  [scarlett-18i20-routing.md](./scarlett-18i20-routing.md) for the
  PCM-number-to-jack mapping) is actually connected to a physical output.
- The matrix sums multiple sources per output — a direct `PCM N →
  Analogue Output N` connection can coexist with an existing `Mixer output
  → Analogue Output N` connection; you don't need to remove the mixer path
  to add the direct one.

### Root cause found (2026-08-15)

On this unit, PCM channels 7-10 (the pair "Headphones 1" and "Headphones 2"
are split from) were **not connected to anything** in the router. Analogue
Outputs 7-10 were instead wired from Mixer outputs C-F, and nothing fed
those mixer channels — so PCM playback had nowhere to go and the interface
was correctly silent.

**Fix:** in `alsa-scarlett-gui`'s router matrix, connected `PCM 7 →
Analogue Output 7` and `PCM 8 → Analogue Output 8` directly (and the 9/10
pair for Headphones 2). Left the existing Mixer C-F → Analogue 7-10
connections in place — the matrix sums sources, so both paths coexist
without conflict.

## Step 5 — Verify

Use GNOME Settings' Sound panel "Test Speakers" feature (safer than
scripting a tone through `pw-play` — you don't want a surprise gain
mismatch driving headphones at full volume) and confirm audio comes out of
the correct jack.
