#!/bin/bash
START1="$(date +%s%N)"
build/bin/bug

echo "The code took: $[ ($(date +%s%N) - ${START1})/1000000 ] milliseconds"