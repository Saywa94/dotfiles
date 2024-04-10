session_root "~/Projects/tutechoweb"

if initialize_session "TuTechoweb"; then

  # Create a new window inline within session layout definition.
  new_window "editor"

  new_window "terminal"
  split_h 50

  select_pane 2
  run_cmd "ll"

  select_pane 1

  new_window "docker"
  run_cmd "docker ps -a"

  select_window 1
  run_cmd "nvim"

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
