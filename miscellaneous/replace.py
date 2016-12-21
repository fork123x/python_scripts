#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
This module works like sed -i.bak 's/old_str/new_str/g' without regex enabled
Authors: xululu
"""
import sys
import fileinput


if len(sys.argv) < 4:
    sys.stderr.write("no input file! Usage: python replace.py old_str new_str file1 file2 ...\n")
    sys.exit(1)
old_str = sys.argv[1]
new_str = sys.argv[2]

for line in fileinput.input(files=sys.argv[3:], inplace=True, backup='.bak'):
    sys.stdout.write(line.replace(old_str, new_str))
