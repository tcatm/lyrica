# Lyrica
The PID 1 for [Prismriver](https://github.com/rein/prismriver), but can also be used standalone.

A safe, comprehensible and efficient PID 1/init replacement written in OCaml.

# Default behaviour
By default, Lyrica executes `/bin/rc.init`.

It will also run, for the corresponding signals:
 - `/bin/rc.shutdown reboot` for `SIGINT`
 - `/bin/rc.shutdown poweroff` for `SIGUSR1`
 - Reaps children for `SIGCHLD`

In short, it behaves as [sinit](http://git.suckless.org/sinit) does. 

Presently, to modify the paths of the executed commands requires modification of `lyrica.ml` and recompilation.

In the future, this may be altered to facilitate ease of use.

<img src="img/if-big.png" height="211" width="149">

The "Init Freedom" logo is courtesy of [Devuan](https://devuan.org) and is public domain!
