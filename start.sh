#!/usr/bin/env bash

./codeccli build -s

./codeccli start tester 30000 0 -f
