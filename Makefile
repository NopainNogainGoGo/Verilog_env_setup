# =============================================================================
# Project  : MIPS Single-Cycle CPU
# File     : Makefile
# Tool     : Synopsys VCS
# Author   : Henry Wu
#
# -----------------------------------------------------------------------------
# Description
# -----------------------------------------------------------------------------
# This Makefile is used to compile and run the RTL simulation of a
# MIPS single-cycle CPU using Synopsys VCS.
#
# The project keeps a clean directory structure:
#
#   MIPS_SingleCycle_CPU/
#   ¢u¢w¢w src/       : RTL source files
#   ¢u¢w¢w sim/       : testbench and filelist.f
#   ¢u¢w¢w build/     : VCS generated files and simulation results
#   ¢u¢w¢w script/    : utility scripts
#   ¢u¢w¢w syn/       : synthesis-related files
#   ¢|¢w¢w Makefile
#
# All source files are managed by:
#   sim/filelist.f
#
#
# -----------------------------------------------------------------------------
# Main commands
# -----------------------------------------------------------------------------
#   make
#       Compile and run RTL simulation.
#
#   make run
#       Same as make. Compile and run RTL simulation.
#
#   make sim
#       Same as make run.
#
#   make env
#       Show project paths and VCS environment information.
#
#   make clean
#       Remove the build/ directory and all generated simulation files.
#
# -----------------------------------------------------------------------------
# Output files
# -----------------------------------------------------------------------------
# All generated files are placed inside build/:
# This keeps the root project directory clean.
#
# -----------------------------------------------------------------------------
# Notes
#
# This Makefile should be executed under:
#
#      /home..../MIPS_SingleCycle_CPU
# =============================================================================

SHELL := /bin/bash

ROOT_DIR  := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
SRC_DIR   := $(ROOT_DIR)/src
SIM_DIR   := $(ROOT_DIR)/sim
BUILD_DIR := $(ROOT_DIR)/build

VCS := vcs

TOP := top_tb

FILELIST := $(SIM_DIR)/filelist.f
SIMV     := simv
LOG      := test.log

VCS_OPTS := -R -sverilog -f $(FILELIST) -full64 -debug_access+all +v2k

.PHONY: all run sim build env clean

all: run

build:
	@mkdir -p $(BUILD_DIR)

run: build
	@cd $(BUILD_DIR) && \
	$(VCS) $(VCS_OPTS) \
		+incdir+../src \
		+incdir+../sim \
		-top $(TOP) \
		-o $(SIMV) | tee $(LOG)

sim: run

env:
	@echo "ROOT_DIR  = $(ROOT_DIR)"
	@echo "SRC_DIR   = $(SRC_DIR)"
	@echo "SIM_DIR   = $(SIM_DIR)"
	@echo "BUILD_DIR = $(BUILD_DIR)"
	@echo "VCS       = $$(command -v $(VCS) 2>/dev/null || echo NOT_FOUND)"
	@echo "TOP       = $(TOP)"
	@echo "FILELIST  = $(FILELIST)"

clean:
	@rm -rf $(BUILD_DIR)
	@echo "Clean done."