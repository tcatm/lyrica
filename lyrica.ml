open Unix

let full_signal_set =
  [ Sys.sigabrt
  ; Sys.sigalrm
  ; Sys.sigfpe
  ; Sys.sighup
  ; Sys.sigill
  ; Sys.sigint
  ; Sys.sigkill
  ; Sys.sigpipe
  ; Sys.sigquit
  ; Sys.sigsegv
  ; Sys.sigterm
  ; Sys.sigusr1
  ; Sys.sigusr2
  ; Sys.sigchld
  ; Sys.sigcont
  ; Sys.sigstop
  ; Sys.sigtstp
  ; Sys.sigttin
  ; Sys.sigttou
  ; Sys.sigvtalrm
  ; Sys.sigprof ]

let log ?(status = true) msg =
  if status then
    Printf.printf "[OK] %s\n" msg
  else
    Printf.printf "[FAIL] %s\n" msg

let checkpid () =
  match getpid () with
    | 1 -> log "PID 1 acquired!"
    | _ -> log "Failed to acquire PID 1." ~status:false ; exit 1

let spawn cmd args =
  let xs = Array.append [|cmd|] args in
    match fork () with
      | 0 -> 
        sigprocmask SIG_UNBLOCK full_signal_set |> ignore ;
        setsid () |> ignore ;
        execvp cmd xs
      | _ -> ()

let rec reap_children () =
  match wait () with
    | exception Unix.Unix_error (x, y, z) -> ()
    | _                                   -> reap_children ()

let rec wait_forever () =
  sigsuspend [] ;
  wait_forever () 

let install_handler signal fn =
  let handler = Sys.Signal_handle (fun _ -> fn ()) in
    Sys.set_signal signal handler

let () =
  chdir "/" ;
  checkpid () ;
  sigprocmask SIG_BLOCK full_signal_set |> ignore ;
  spawn "/bin/rc.init" [||] ;
  install_handler Sys.sigchld reap_children ;
  install_handler Sys.sigusr1 (fun _ -> spawn "/bin/rc.shutdown" [|"poweroff"|]) ;
  install_handler Sys.sigint (fun _ -> spawn "/bin/rc.shutdown" [|"reboot"|]) ;
  wait_forever ()
