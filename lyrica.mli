(** A simple and efficient [init] implementation. *)

(** Simply an {e int list} which holds every possible signal.
    None is provided by default in Sys, so one was simply implemented
    as a list of all possible signals. *)
val full_signal_set : int list

(** Pretty-print a message. {^ Serves no practical use. } *)
val log : ?status:bool -> string -> unit

(** Check the acquired PID is indeed 1, and suspend execution if not. *)
val checkpid : unit -> unit  

(** Spawn a forked process for the given command/filename,
    create a new session for it and unblock all signals. *)
val spawn : string -> string array -> unit

(** Wait until all child processes have exited. Recurs until an exception
    is raised indicating all children have been reaped. *)
val reap_children : unit -> unit

(** Pause and wait for a signal using {e sigsuspend}, then recur. *)
val wait_forever : unit -> unit

(** Install signal handler function for the given signal. *)
val install_handler : int -> (unit -> unit) -> unit
