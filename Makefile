.PHONY: run fmt utop clean

SRC := $(wildcard *.ml *.mli)

run: test_maps
	./test_maps

test_maps: maps_interface.mli impl_maps_list.ml impl_maps_array.ml
	ocamlc -c maps_interface.mli
	ocamlc -c impl_maps_list.ml
	ocamlc -c impl_maps_array.ml
	ocamlc -o test_maps impl_maps_list.cmo impl_maps_array.cmo test_maps.ml

utop: test_maps
	utop -init .utopinit

fmt:
	for f in $(SRC); do \
		ocamlformat $$f --inplace --enable-outside-detected-project; \
	done

clean:
	git clean -fx
