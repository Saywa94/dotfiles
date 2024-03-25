session_root "~/thastore"

if initialize_session "thastore"; then

  # Create a new window inline within session layout definition.
  new_window "editor"
  run_cmd ". .venv/bin/activate"

  new_window "terminal"
  run_cmd ". .venv/bin/activate"

  select_window 1
  run_cmd "nvim"

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
