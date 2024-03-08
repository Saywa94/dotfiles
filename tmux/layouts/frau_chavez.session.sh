# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/frau-chavez"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "frau_chavez"; then

  # Create a new window inline within session layout definition.
  new_window "editor"

  new_window "terminal"
  split_h 50

  select_pane 1
  run_cmd "clear && ll && echo"" && git log -4"

  select_pane 2
  run_cmd "npm run dev"

  select_pane 1

  select_window 1
  run_cmd "nvim"

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
