# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/AoC"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "aoc"; then

  # Create a new window inline within session layout definition.
  new_window "main"

  split_h 30
  run_cmd "cd source/2022"

  select_pane 1
  run_cmd "nvim ."

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
