import os
import subprocess


def toggle_mic_status(qtile):
    try:
        # Execute the command to get the current mic status
        result = subprocess.run(
            ['amixer', 'get', 'Capture'], stdout=subprocess.PIPE, check=True)
        output = result.stdout.decode('utf-8')

        # Determine the current mic status
        if '[off]' in output:
            status = 'off'
        elif '[on]' in output:
            status = 'on'
        else:
            status = 'unknown'

        # Change the mic status
        if status == 'off':
            subprocess.run(['amixer', 'set', 'Capture', 'cap'])
            new_status = 'on'
        elif status == 'on':
            subprocess.run(['amixer', 'set', 'Capture', 'nocap'])
            new_status = 'off'
        else:
            new_status = 'unknown'

        # Show a notification with the new mic status
        subprocess.run(['notify-send', f'Microphone is {new_status}'])

    except subprocess.CalledProcessError:
        subprocess.run(['notify-send', 'Failed to toggle microphone status'])


def window_to_previous_screen(qtile, switch_group=False, switch_screen=False):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group, switch_group=switch_group)
        if switch_screen == True:
            qtile.cmd_to_screen(i - 1)


def window_to_next_screen(qtile, switch_group=False, switch_screen=False):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group, switch_group=switch_group)
        if switch_screen == True:
            qtile.cmd_to_screen(i + 1)


# NOTE: widget custom functions

# Not used currently
def get_mic_status():
    result = subprocess.run(
        ['amixer', 'get', 'Capture'], stdout=subprocess.PIPE)
    output = result.stdout.decode('utf-8')
    if '[off]' in output:
        return '󰍭'
    else:
        return '󰍬'


def get_network_name():
    try:
        # Execute the command to get the active connections
        result = subprocess.run(['nmcli', '-t', '-f', 'TYPE,NAME', 'connection',
                                'show', '--active'], stdout=subprocess.PIPE, check=True)
        output = result.stdout.decode('utf-8').strip()

        # Parse the output to get the name of the active Wi-Fi connection
        for line in output.splitlines():
            connection_type, name = line.split(
                ':', 1)  # Separar solo en el primer ':'
            if connection_type == '802-11-wireless':
                return name

        return 'None'
    except subprocess.CalledProcessError:
        return 'None'
