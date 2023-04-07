#!/usr/bin/env bash

export PATH=$PATH:$HOME/axial/bin


# Using grep OPTIONS (see X-grep.sh)

export GREP_OPT_EXCLUDE=${GREP_OPT_EXCLUDE:-'node_modules,py_cache,'}
export GREP_OPT_EXCLUDE_DIR=${GREP_OPT_EXCLUDE_DIR:-'node_modules,dist,py_cache,__cache__'}
