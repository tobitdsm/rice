#!/usr/bin/env python3

import subprocess
import mido

DEVICE = "nanoKONTROL2"

# Track 8
VOLUME_CC = 7   # volume slider
BRIGHTNESS_CC = 23  # pan knob
MUTE_CC = 55    # mute button

# Transport
PLAY_CC = 41
STOP_CC = 42
REWIND_CC = 43
FORWARD_CC = 44

# Workspace navigation
WORKSPACE_PREV_CC = 58  # track prev
WORKSPACE_NEXT_CC = 59  # track next

# Move current window
MOVE_PREV_CC = 61   # marker prev
MOVE_NEXT_CC = 62   # marker next

# Update
UPDATE_CC = 46  # cycle


def run(*args):
    subprocess.Popen(
        args,
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )


def set_volume(value):
    volume = value / 127.0

    run(
        "wpctl",
        "set-volume",
        "@DEFAULT_AUDIO_SINK@",
        f"{volume:.3f}",
    )


def toggle_mute():
    run(
        "wpctl",
        "set-mute",
        "@DEFAULT_AUDIO_SINK@",
        "toggle",
    )


def set_brightness(value):
    brightness = round(value / 127.0 * 100)

    run(
        "brightnessctl",
        "set",
        f"{brightness}%",
    )


def main():
    ports = mido.get_input_names()

    matches = [
        port for port in ports
        if DEVICE.lower() in port.lower()
    ]

    if not matches:
        print("nanoKONTROL2 not found.")
        print("\nAvailable MIDI inputs:")
        for port in ports:
            print(f"  {port}")
        raise SystemExit(1)

    port_name = matches[0]

    print(f"Opening MIDI device: {port_name}")

    with mido.open_input(port_name) as port:
        for msg in port:

            if msg.type != "control_change":
                continue

            cc = msg.control
            value = msg.value

            # Continuous controls
            if cc == VOLUME_CC:
                set_volume(value)

            elif cc == BRIGHTNESS_CC:
                set_brightness(value)

            # Toggle controls:
            # These intentionally respond to every event.
            elif cc == MUTE_CC:
                toggle_mute()

            elif cc == PLAY_CC:
                run("playerctl", "play-pause")

            # Normal buttons:
            # Trigger only on the press event (value > 0).
            elif value > 0:

                if cc == STOP_CC:
                    run("playerctl", "stop")

                elif cc == REWIND_CC:
                    run("playerctl", "previous")

                elif cc == FORWARD_CC:
                    run("playerctl", "next")

                elif cc == WORKSPACE_PREV_CC:
                    run("hyprctl", "dispatch", "hl.dsp.focus({ workspace = 'e-1' })")

                elif cc == WORKSPACE_NEXT_CC:
                    run("hyprctl", "dispatch", "hl.dsp.focus({ workspace = 'e+1' })")

                elif cc == MOVE_PREV_CC:
                    run(
                        "hyprctl",
                        "dispatch",
                        "hl.dsp.window.move({ workspace = 'e-1' })"
                    )

                elif cc == MOVE_NEXT_CC:
                    run(
                        "hyprctl",
                        "dispatch",
                        "hl.dsp.window.move({ workspace = 'e+1' })"
                    )

                elif cc == UPDATE_CC:
                    subprocess.Popen(("kitty", "-e", "bash", "-ic", "mirror; limit update"))


if __name__ == "__main__":
    main()

