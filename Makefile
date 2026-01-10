.PHONY: run fmt utop clean

SRC := $(wildcard *.ml *.mli)

run: test_maps_list
	./test_maps_list

test_maps_list: $(SRC)
	ocamlc -c maps_interface.mli
	ocamlc -c impl_maps_list.ml
	ocamlc -o test_maps_list impl_maps_list.cmo test_maps_list.ml

utop: test_maps_list
	utop -init .utopinit

fmt:
	for f in $(SRC); do \
		ocamlformat $$f --inplace --enable-outside-detected-project; \
	done

clean:
	git clean -fx
