all:
	ocamlfind ocamlopt -linkpkg\
		-package unix\
		lyrica.mli lyrica.ml -o lyrica 

clean:
	rm {*.cmi,*.cmx,*.o}

doc:
	mkdir -p doc/
	ocamldoc lyrica.ml lyrica.mli -d doc/ -html -keep-code -t "Lyrica"
