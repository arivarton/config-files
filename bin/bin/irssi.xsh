session_name = 'irc-session'
window_name = 'irssi-vidarr'
resolution = $(xrandr | grep -e '[^dis]connected primary' | cut -d ' ' -f 4 | sed 's/\+.*//g')
width = int(int($(echo @(resolution) | cut -d 'x' -f 1).strip()) / 6)
height = int(int($(echo @(resolution) | cut -d 'x' -f 2).strip()) / 18)
main_pane = 1
nicklist_pane = 2
window_list_pane = 0

# True if no session exists
if !(tmux has-session -t @(session_name) 2> /dev/null).returncode:
    # Create a new session with main pane
    tmux new-session -s @(session_name) -n @(window_name) -d -x @(width) -y @(height) "irssi"
    # Make panes stay open after shell command exit
    tmux set-option remain-on-exit on
    # Create the nicklist pane
    tmux split-window -t @(window_name) -h -l 30 "cat ~/.irssi/nicklistfifo"
    # Create the server pane
    tmux split-window -t @(window_name) -h -b -l 40 -t 0 "perl ~/.irssi/scripts/adv_windowlist.pl"
    # Select main window as pane
    tmux select-pane -t @(main_pane)
