SHELL := /bin/bash

STD := c++17
# Compiler
CXX := g++
CXXF := -g -O0 -std=$(STD) -pthread 
CXXW := -Wall -Wextra -Werror
CXXL := -D LOGURU_WITH_STREAMS=1 -D LOGURU_STACKTRACES=0
# Linker
LD := $(CXX)
LF := -pthread -lpthread

#####################
# Output Definitions
#####################
BUILD_DIR := build
OBJ_DIR := $(BUILD_DIR)/obj
BIN_DIR := $(BUILD_DIR)/bin
TARGET := $(BIN_DIR)/application
TEST_TARGET := $(BIN_DIR)/test

#####################
# Input Definitions
#####################
# Main file to Filter out for tests
SRC_DIR := ./src
INC_DIR := ./lib
TEST_DIR := ./test
MAIN_NAME := $(SRC_DIR)/main.cpp

# Sources used to build the application
SRC_PATHS := $(shell find $(SRC_DIR) -name '*.cpp')
OBJ := $(addprefix $(OBJ_DIR)/,$(notdir $(SRC_PATHS:.cpp=.o)))

# Includes
INC_PATHS := $(shell find $(INC_DIR) -name '*.cpp')
OBJ := $(OBJ) $(addprefix $(OBJ_DIR)/,$(notdir $(INC_PATHS:.cpp=.o)))
INC_DIRS := $(wildcard $(INC_DIR)/*)
INCLUDES := $(addprefix -I, $(INC_DIRS))

# Testing Sources used to build the unit test
SRC_PATHS_TEST := $(filter-out $(MAIN_NAME),$(SRC_PATHS))
TEST_PATHS := $(shell find $(TEST_DIR) -name '*.cpp') $(SRC_PATHS_TEST)
TEST_OBJ := $(addprefix $(OBJ_DIR)/,$(notdir $(TEST_PATHS:.cpp=.o)))

# VPATH for searching for missing sources used for reference to %.cpp
VPATH := $(dir $(SRC_PATHS) $(TEST_PATHS) $(INC_PATHS))

.PHONY: clean test

default: $(TARGET)
	@echo -----------------------------------------------
	@echo Build done, run with     $(TARGET)

# Directory Creation

$(OBJ_DIR):
	mkdir -p $@

$(BIN_DIR):
	mkdir -p $@

$(OBJ_DIR)/%.o: %.cpp
	$(CXX) $(CXXF) $(CXXW) $(CXXL) $(INCLUDES) -I$(SRC_DIR) -c $< -o $@

$(TARGET): $(BIN_DIR) $(OBJ_DIR) $(OBJ)
	$(LD) $(LF) $(OBJ) -o $@

$(TEST_TARGET): $(BIN_DIR) $(OBJ_DIR) $(TEST_OBJ)
	$(LD) $(LF) $(TEST_OBJ) -o $@

test: $(TEST_TARGET)
	$(TEST_TARGET)
	

clean:
	@rm -r $(BUILD_DIR)
