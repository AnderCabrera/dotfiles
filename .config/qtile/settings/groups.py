# Qtile workspaces

from libqtile.config import Key, Group
from libqtile.lazy import lazy
from .keys import mod, alt, keys

groups = [Group(i) for i in [
    "   ", "   ", "   ", "   ", " 󰋩  ",  "   "
]]

for i, group in enumerate(groups, start=1):
    keys.extend(
        [
            # mod + group number = switch to group
            Key(
                [mod],
                str(i),
                lazy.group[group.name].toscreen(),
                desc=f"Switch to group {group.name}",
            ),
            # mod + shift + group number = switch to & move focused window to group
            Key(
                [mod, "shift"],
                str(i),
                lazy.window.togroup(group.name, switch_group=True),
                desc=f"Switch to & move focused window to group {group.name}",
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod + shift + group number = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )
