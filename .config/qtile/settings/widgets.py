import subprocess
from libqtile import widget
from .theme import colors
from .custom_functions import get_network_name, get_mic_status

# Get the icons at https://www.nerdfonts.com/cheat-sheet (you need a Nerd Font)

def base(fg='text', bg='dark'):
    return {
        'foreground': colors[fg],
        'background': colors[bg]
    }


def separator():
    return widget.Sep(**base(), linewidth=0, padding=5)


def icon(fg='text', bg='dark', fontsize=16, text="?"):
    return widget.TextBox(
        **base(fg, bg),
        fontsize=fontsize,
        text=text,
        padding=3
    )


def powerline(fg="light", bg="dark"):
    return widget.TextBox(
        **base(fg, bg),
        text="",  # Icon: nf-oct-triangle_left
        fontsize=35,
        padding=-1
    )


def workspaces():
    return [
        separator(),
        widget.GroupBox(
            **base(fg='light'),
            font='Mononoki Nerd Font',
            fontsize=19,
            margin_y=3,
            margin_x=0,
            padding_y=8,
            padding_x=5,
            borderwidth=1,
            active=colors['active'],
            inactive=colors['inactive'],
            rounded=False,
            highlight_method='block',
            urgent_alert_method='block',
            urgent_border=colors['urgent'],
            this_current_screen_border=colors['focus'],
            this_screen_border=colors['grey'],
            other_current_screen_border=colors['dark'],
            other_screen_border=colors['dark'],
            disable_drag=True
        ),
        separator(),
        widget.WindowName(**base(fg='focus'), fontsize=14, padding=5),
        separator(),
    ]

primary_widgets = [
    *workspaces(),

    separator(),

    powerline('color4', 'dark'),

    # icon(bg="color4", text='󰂯 '),

    widget.TextBox(
        **base(fg='text', bg='color4'),
        fontsize=16,
        text='󰂯',
        padding=3,
        mouse_callbacks={'Button1': lambda: subprocess.Popen(
            'blueman-manager', shell=True), },
    ),

    # widget.Bluetooth(
    #     background=colors['color4'],
    #     mouse_callbacks={'Button1': lambda: subprocess.Popen(
    #         'blueman-manager', shell=True), },
    # ),

    powerline('color3', 'color4'),

    icon(bg="color3", text=' '),  # Icon: nf-fa-feed

    # widget.Net(**base(bg='color3'), interface='wlp0s20f3'),
    widget.GenPollText(
        **base(bg='color3'),
        func=get_network_name,
        update_interval=10, 
    ),

    powerline('color2', 'color3'),

    widget.CurrentLayoutIcon(**base(bg='color2'), scale=0.65),

    widget.CurrentLayout(**base(bg='color2'), padding=5),

    powerline('color1', 'color2'),

    icon(bg="color1", fontsize=17, text='󰃰 '),

    widget.Clock(**base(bg='color1'), format='%d/%m/%Y - %H:%M:%S '),

    powerline('dark', 'color1'),

    widget.Systray(background=colors['dark'], padding=5),

    widget.Volume(volume_app="pavucontrol", **base(fg='light', bg='dark')),

    separator(),

    # widget.GenPollText(
    #     **base(bg='dark'),
    #     func=get_mic_status,
    #     update_interval=1,
    #     mouse_callbacks={'Button1': lambda: subprocess.Popen(
    #         'amixer set Capture toggle', shell=True)},
    # ),
]

secondary_widgets = [
    *workspaces(),

    separator(),

    powerline('color1', 'dark'),

    widget.CurrentLayoutIcon(**base(bg='color1'), scale=0.65),

    widget.CurrentLayout(**base(bg='color1'), padding=5),

    powerline('color2', 'color1'),

    icon(bg="color2", fontsize=17, text='󰃰 '),  # Icon: nf-mdi-calendar_clock
    widget.Clock(**base(bg='color2'), format='%d/%m/%Y - %H:%M:%S ',),

    # powerline('dark', 'color2'),
]

widget_defaults = {
    'font': 'Mononoki Nerd Font',
    'fontsize': 14,
    'padding': 1,
}
extension_defaults = widget_defaults.copy()
