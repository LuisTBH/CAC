#!/bin/bash

{ printf "cac\n.cac\n1\n$1\n2\nyes\n\n\e\e4\n"; sleep 2; } | telnet pdujupiter.disca.upv.es
