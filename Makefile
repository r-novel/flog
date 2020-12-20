SHELL := /bin/bash

PATH-PROJECT := $(shell pwd)
PATH-BIN := $(PATH-PROJECT)/bin
PATH-OBJ := $(PATH-BIN)

.DEFAULT: default
.PHONY: all default build
.PHONY: all clean

default: build
build: logo ensure-bin flog

logo:
	@echo \
		-e \
		"\x1B[5;49;36m     		 \\n" \
		"   __ _               \\n" \
		"  / _| |              \\n" \
		" | |_| | ___   __ _   \\n" \
		" |  _| |/ _ \ / _\` | \\n" \
		" | | | | (_) | (_| |  \\n" \
		" |_| |_|\___/ \__, |  \\n" \
		"               __/ |  \\n" \
		"              |___/   \\n" \
		"\033[0m \\n"

FC = gfortran
FLAGS = -fpic -O3

flog : flog.f90 test/flog_test.f90
	$(FC) $(FLAGS) $+ -o $(PATH-BIN)/$@

.PHONY: clean

clean:
	rm -rvf \
		$(PATH-OBJ)/* && rm -rf $(PATH-PROJECT)/*.mod

ensure-bin:
	mkdir -p $(PATH-BIN)
