# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/Projects/tutecho_client"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "tutecho_client"; then

  # Create a new window inline within session layout definition.
  new_window "editor"

  new_window "terminal"
  split_h 50

  select_pane 2
  run_cmd "ll"

  select_pane 1

  select_window 1
  run_cmd "nvim"

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
