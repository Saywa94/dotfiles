session_root "~/Projects/tutecho_client"

if initialize_session "tutecho_client"; then

  # Window 1
  new_window "editor"

  # Window 2
  new_window "terminal"
  split_h 50

  select_pane 2
  run_cmd "ll"

  select_pane 1

  # Window 3
  new_window "docker"
  run_cmd "docker ps -a"

  select_window 1
  run_cmd "nvim"

fi

finalize_and_go_to_session
