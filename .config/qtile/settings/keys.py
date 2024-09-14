# Qtile keybindings
import os
from libqtile.config import Key
from libqtile.lazy import lazy
from .custom_functions import toggle_mic_status, window_to_previous_screen, window_to_next_screen

mod = "mod4"
alt = "mod1"

screenshots_dir = os.path.expanduser("~/Pictures/Screenshots")

if not os.path.exists(screenshots_dir):
    os.makedirs(screenshots_dir)

keys = [Key(key[0], key[1], *key[2:]) for key in [
    # ------------ Window Configs ------------

    # Switch between windows in current stack pane
    ([mod], "j", lazy.layout.down()),
    ([mod], "k", lazy.layout.up()),
    ([mod], "h", lazy.layout.left()),
    ([mod], "l", lazy.layout.right()),
    ([mod], "space", lazy.layout.next()),

    # Fullscreen
    ([mod], "f", lazy.window.toggle_fullscreen()),

    # Change window sizes (MonadTall)
    ([mod, "shift"], "l", lazy.layout.grow()),
    ([mod, "shift"], "h", lazy.layout.shrink()),

    # Toggle floating
    ([mod, "shift"], "f", lazy.window.toggle_floating()),

    # Move windows up or down in current stack
    ([mod, "shift"], "j", lazy.layout.shuffle_down()),
    ([mod, "shift"], "k", lazy.layout.shuffle_up()),

    # Toggle between different layouts as defined below
    ([mod], "Tab", lazy.next_layout()),
    ([mod, "shift"], "Tab", lazy.prev_layout()),

    # Kill window
    ([mod], "w", lazy.window.kill()),

    # Switch focus of monitors
    ([mod], "period", lazy.next_screen()),
    ([mod], "comma", lazy.prev_screen()),

    # Restart Qtile
    ([mod, "control"], "r", lazy.restart()),

    ([mod, "control"], "q", lazy.shutdown()),
    ([mod], "r", lazy.spawncmd()),


    # ------------ App Configs ------------

    # Menu
    ([alt], "space", lazy.spawn("rofi -show drun")),

    # Window Nav
    ([mod, "shift"], "m", lazy.spawn("rofi -show")),

    # Browser
    ([mod], "b", lazy.spawn("brave")),

    # File Explorer
    ([mod], "e", lazy.spawn("thunar")),

    # Terminal
    ([mod], "Return", lazy.spawn("alacritty")),

    # Redshift
    ([mod], "r", lazy.spawn("redshift -O 4000")),
    ([mod, "shift"], "r", lazy.spawn("redshift -x")),

    # Screenshot
    ([mod], "s", lazy.spawn(f"scrot -f -e 'xclip -selection clipboard -t image/png -i $f' {screenshots_dir}/screenshot_%b%d%Y-%H%M%S.png")),
    ([mod, 'shift'], "s", lazy.spawn(f"scrot -s -f -e 'xclip -selection clipboard -t image/png -i $f' {screenshots_dir}/screenshot_%b%d%Y-%H%M%S.png")),

    ([mod, 'control'], "1", lazy.spawn(f"scrot -s -f -M 0 -e 'xclip -selection clipboard -t image/png -i $f' {screenshots_dir}/screenshot_%b%d%Y-%H%M%S.png")),
    ([mod, 'control'], "2", lazy.spawn(f"scrot -s -f -M 1 -e 'xclip -selection clipboard -t image/png -i $f' {screenshots_dir}/screenshot_%b%d%Y-%H%M%S.png")),


    # ------------ Hardware Configs ------------

    # Volume
    ([], "XF86AudioLowerVolume", lazy.spawn(
        "amixer set Master 5%-"
    )),
    ([], "XF86AudioRaiseVolume", lazy.spawn(
        "amixer set Master 5%+"
    )),
    ([], "XF86AudioMute", lazy.spawn(
        "amixer -D pulse set Master 1+ toggle"
    )),

    # Brightness
    ([], "XF86MonBrightnessUp", lazy.spawn("xbacklight -inc 10")),
    ([], "XF86MonBrightnessDown", lazy.spawn("xbacklight -dec 10")),
    ([mod, 'shift'], "XF86MonBrightnessDown", lazy.spawn("xbacklight -set 1%")),

    # Media
    ([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
    ([], "XF86AudioNext", lazy.spawn("playerctl next")),
    ([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
    ([], "XF86AudioStop", lazy.spawn("playerctl stop")),

    # Get and toggle mic status
    ([mod], "F9", lazy.function(toggle_mic_status)),
]]

# Move to next screen

keys.extend([
    # MOVE WINDOW TO NEXT SCREEN
    Key([mod, "shift"], "Right", lazy.function(
        window_to_next_screen, switch_screen=True)),
    Key([mod, "shift"], "Left", lazy.function(
        window_to_previous_screen, switch_screen=True)),
])
