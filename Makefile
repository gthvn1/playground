.PHONY: run fmt

SRC := $(wildcard *.ml *.mli)

run: test_maps
	./test_maps

test_maps:
	ocamlc -c maps_interface.mli
	ocamlc -c maps.ml
	ocamlc -o test_maps maps.cmo test_maps.ml

fmt:
	for f in $(SRC); do \
		ocamlformat $$f --inplace --enable-outside-detected-project; \
	done
