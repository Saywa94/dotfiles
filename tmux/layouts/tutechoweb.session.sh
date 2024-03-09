#### DO NOT USE THIS IN LOCAL ENVIRONMENT ####
session_root "/home/ubuntu/tutechoweb"

if initialize_session "TuTechoweb"; then

  new_window "editor"

  new_window "terminal"
  split_h 50

  select_window 1
  run_cmd "nvim"

fi

finalize_and_go_to_session
