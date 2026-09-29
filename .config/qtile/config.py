import os

from libqtile import hook

import libqtile.resources

from settings.groups import groups
from settings.keys import keys
from settings.mouse import mouse
from settings.screens import screens
from settings.path import qtile_path
from settings.layouts import layouts, floating_layout
from settings.widgets import widget_defaults, extension_defaults

import subprocess
    
@hook.subscribe.startup_once
def autostart():
    script = os.path.expanduser("~/.config/qtile/autostart.sh")
    subprocess.run([script])

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False

auto_fullscreen = True
focus_on_window_activation = "smart"
focus_previous_on_window_remove = False
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# xcursor theme (string or None) and size (integer) for Wayland backend
wl_xcursor_theme = None
wl_xcursor_size = 24

idle_inhibitors = []  # type: list

wmname = "LG3D"
