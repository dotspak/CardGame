#!/bin/bash
for file in *; do
    [[ -f "${file}" ]] && [[ "${file}" =~ (^[0-9]+) ]] && mv ${file} ${file/${BASH_REMATCH[1]}}
done