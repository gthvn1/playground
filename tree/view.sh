#!/bin/bash

dot -Tpng /tmp/bst_dump1.dot | xview - &
dot -Tpng /tmp/bst_dump2.dot | xview - &

