#!/bin/bash

[ -f "/tmp/bst_dump1.dot" ] && dot -Tpng /tmp/bst_dump1.dot | display &
[ -f "/tmp/bst_dump2.dot" ] && dot -Tpng /tmp/bst_dump2.dot | display &

