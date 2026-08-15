# Scarlett 18i20 Gen 3 — Hardware Connectivity Layout

Reference for how ALSA/PipeWire's channel numbering and naming map onto the
physical jacks on the Focusrite Scarlett 18i20 (3rd Gen), and how the
onboard router/mixer sits between them. Companion to
[scarlett-18i20-troubleshooting.md](./scarlett-18i20-troubleshooting.md).

Source of truth for the ALSA-side names: the UCM ("Use Case Manager")
config nixpkgs ships for this card —

```
<nixpkgs alsa-ucm-conf>/share/alsa/ucm2/USB-Audio/Focusrite/Scarlett-18i20-HiFi.conf
```

Find the exact store path on this system with:

```shell
find /nix/store -maxdepth 1 -iname "*alsa-ucm-conf*" -type d
```

## The three layers

```
PipeWire sink/source            ALSA UCM "device"        Hardware router (alsa-scarlett-gui)
("Headphones 1" in GNOME)  <-->  ("Line 1", PCM ch 7-8)  <-->  Analogue Output 7/8  <-->  physical jack
```

1. **PipeWire sink name** — what you pick in GNOME Sound settings /
   `wpctl status`. Comes from the UCM device's `Comment` field.
2. **ALSA UCM device** — a fixed slice of the interface's USB PCM stream.
   Always available, always carries signal when the app plays to it.
   *Not* physically wired to anything by itself.
3. **Hardware router** — a crosspoint matrix living on the interface
   itself, edited via `alsa-scarlett-gui`. Decides which PCM channels (or
   internal Mixer outputs) actually reach which analogue/digital output
   jack. This is stored on the device's firmware/NVRAM, independent of the
   OS.

A signal only makes it out of a jack if all three layers line up. Steps 1-2
are host-side and always consistent (defined by the UCM conf below); step 3
is set by hand per-unit and is the one that can silently be "unpatched".

## PCM channel map (UCM `HiFi` profile)

The card exposes a single 20-channel USB PCM stream. The `HiFi` UCM profile
splits it into named stereo/mono devices. Channel numbers below are
1-indexed (as shown in `alsa-scarlett-gui`); the UCM conf itself is
0-indexed internally.

| UCM device | PipeWire sink name | PCM channels (1-idx) | Notes |
|---|---|---|---|
| `Line 1` | Headphones 1 | 7–8 | Same PCM pair as `Line 6` — conflicting devices, can't both be the active sink at once |
| `Line 2` | Headphones 2 | 9–10 | |
| `Line 3` | Line Output 1+2 | 1–2 | |
| `Line 4` | Line Output 3+4 | 3–4 | |
| `Line 5` | Line Output 5+6 | 5–6 | |
| `Line 6` | Line Output 7+8 | 7–8 | Conflicts with `Line 1` (same channels, alternate name) |
| `Line 7` | Line Output 9+10 | 9–10 | |
| `SPDIF 1` | S/PDIF Output | 11–12 | |
| `Direct 1` | ADAT Optical Output | 13–20 | 8-channel ADAT block |

Captures (`Mic 1`/`Mic 2`/`Line 8`-`13` = Input 1-8, `SPDIF 2`/`SPDIF 3` =
S/PDIF In, `Direct 2` = ADAT In) are all mono, one UCM device per input
channel.

**Why "Headphones 1" and "Line Output 7+8" are the same PCM pair:** the
18i20's rear TRS jacks for Analogue Out 7/8 are electrically shared with
the front headphone amp for Headphones 1 (and likewise 9/10 with
Headphones 2). ALSA just offers two names for the same underlying channels
depending on how you intend to use them; only one can be the active UCM
device at a time.

## What `alsa-scarlett-gui`'s router actually shows

The router matrix works in terms of the interface's **physical** output
labels, not the PCM/UCM names above:

- `Analogue 1`–`10` — rear balanced TRS outputs. 7-8 and 9-10 double as the
  front headphone jacks (Headphones 1 / Headphones 2).
- `SPDIF 1`–`2`
- `ADAT 1`–`8`

Each physical output's source can be either:
- a **PCM channel** directly (`PCM 7` → `Analogue Output 7`) — what you
  want for plain desktop/DAW playback with no hardware monitoring, or
- an internal **Mixer output** (`Mixer A`–`H` or similar, varies by
  firmware) — a configurable summing mix of PCM + hardware inputs, used for
  zero-latency direct monitoring while recording.

The matrix sums whatever sources are connected to a given output, so a
direct PCM connection and a Mixer connection can both feed the same jack
simultaneously without conflict.

### Known-good routing for plain desktop listening

| Physical output | Source to connect |
|---|---|
| Analogue Output 7 | PCM 7 |
| Analogue Output 8 | PCM 8 |
| Analogue Output 9 | PCM 9 (if using Headphones 2 too) |
| Analogue Output 10 | PCM 10 |

This is what was missing on 2026-08-15 — PCM 7-10 were dangling
(unconnected), while Analogue 7-10 were only fed from empty Mixer channels
C-F, producing silence despite a correctly-selected, unmuted PipeWire sink.
