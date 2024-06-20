session_root "~/OneDrive/Knowledge base/"

if initialize_session "obsidian"; then

  # Create a new window inline within session layout definition.
  new_window "editor"
  run_cmd "nvim"

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
