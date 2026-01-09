.PHONY: run fmt

SRC := $(wildcard *.ml *.mli)

run: test_list_maps
	./test_list_maps

test_list_maps: $(SRC)
	ocamlc -c maps_interface.mli
	ocamlc -c maps.ml
	ocamlc -o test_list_maps maps.cmo test_list_maps.ml

utop: test_list_maps
	utop -init .utopinit

fmt:
	for f in $(SRC); do \
		ocamlformat $$f --inplace --enable-outside-detected-project; \
	done
