from libqtile.config import Key
from libqtile.lazy import lazy
import os

altgr = "mod5"
mod = "mod4"
alt = "mod1"
screenshots_dir = os.path.expanduser("~/Pictures/Screenshots")

keys = [
    # Switch between windows in current stack pane
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),

    # Move windows between left/right columns or move up/down
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Change window sizes (monadtall)
    Key([mod, "control"], "l", lazy.layout.grow()),
    Key([mod, "control"], "h", lazy.layout.shrink()),

    # Toggle between split and unsplit sides of stack.
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),

    # Terminal
    Key([mod], "Return", lazy.spawn("alacritty")),

    # Toggle between different layouts
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod, "shift"], "Tab", lazy.prev_layout()),

    # Kill focused window
    Key([mod], "w", lazy.window.kill()),

    # Full screen
    Key([mod], "f", lazy.window.toggle_fullscreen()),

    # Toggle floating
    Key([mod], "t", lazy.window.toggle_floating()),

    # Reload config
    Key([mod, "control"], "r", lazy.reload_config()),

    # Restart Qtile
    Key([mod, "control", "shift"], "r", lazy.spawn("qtile cmd-obj -o cmd -f restart")),

    # Shutdown Qtile
    Key([mod, "control"], "q", lazy.shutdown()),

    # Spawn a command using a prompt widget
    Key([mod], "r", lazy.spawncmd()),

    # ------------ App Configs ------------

    # Menu
    Key([alt], "space", lazy.spawn("rofi -show drun")),
    Key([alt, 'shift'], "v", lazy.spawn("rofi -modi \"clipboard:greenclip print\" -show clipboard -run-command -no-show-icons '{cmd}'")),
    Key([alt, 'shift'], "e", lazy.spawn("rofi -show emoji -emoji-mode copy -no-show-icons")),
    Key([alt, 'shift'], "space", lazy.spawn("rofi -show calc -modi calc -no-show-match -no-sort -hint-welcome \"Sup bro!\" -no-show-icons -calc-command \"echo -n '{result}' | xclip -selection clipboard\"")),
    # Key([mod, 'shift'], "x", lazy.spawn("powermenu")),
    Key([mod, 'shift'], "x", lazy.spawn("bash -c '$HOME/.local/scripts/powermenu'")),

    # Window Nav
    Key([mod, "shift"], "m", lazy.spawn("rofi -show")),

    # Browser
    Key([mod], "b", lazy.spawn("brave")),

    # File Explorer
    Key([mod], "e", lazy.spawn("thunar")),

    # Redshift
    Key([mod], "r", lazy.spawn("redshift -O 4000")),
    Key([mod, "shift"], "r", lazy.spawn("redshift -x")),

    # Screenshot
    Key([mod], "s", lazy.spawn(f"scrot -f -e 'xclip -selection clipboard -t image/png -i $f' {screenshots_dir}/screenshot_%b%d%Y-%H%M%S.png")),
    Key([mod, 'shift'], "s", lazy.spawn(f"scrot -s -f -e 'xclip -selection clipboard -t image/png -i $f' {screenshots_dir}/screenshot_%b%d%Y-%H%M%S.png")),
    Key([mod, 'control'], "1", lazy.spawn(f"scrot -s -f -M 0 -e 'xclip -selection clipboard -t image/png -i $f' {screenshots_dir}/screenshot_%b%d%Y-%H%M%S.png")),
    Key([mod, 'control'], "2", lazy.spawn(f"scrot -s -f -M 1 -e 'xclip -selection clipboard -t image/png -i $f' {screenshots_dir}/screenshot_%b%d%Y-%H%M%S.png")),

    # Betterlockscreen
    Key([mod], "x", lazy.spawn("betterlockscreen -l")),

    # ------------ Hardware Configs ------------

    # Volume
    Key([], "XF86AudioLowerVolume", lazy.spawn("pamixer --decrease 5")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pamixer --increase 5")),
    Key([], "XF86AudioMute", lazy.spawn("pamixer --toggle-mute")),

    # Media
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
    Key([], "XF86AudioStop", lazy.spawn("playerctl stop")),
]

# Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )
