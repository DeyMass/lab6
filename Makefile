# The name of the executable to be created
BIN_NAME = $(shell basename $$PWD)
TEST_BIN_NAME = $(BIN_NAME)_test
# Compiler used
CC = gcc
# Extension of source files used in the project
SRC_EXT = c
# Path to the source directory, relative to the makefile
SRC_PATH = src
TEST_PATH = test
# Space-separated pkg-config libraries used by this project
LIBS =
# General compiler flags
COMPILE_FLAGS = -Wall -Wextra
# Additional release-specific flags
RCOMPILE_FLAGS = -D NDEBUG -O2
# Additional debug-specific flags
DCOMPILE_FLAGS = -D DEBUG -O0 -g
# Add additional include paths
INCLUDES = -I $(SRC_PATH)/ -I thirdparty/
# General linker settings
LINK_FLAGS = -lm

# Function used to check variables. Use on the command line:
# make print-VARNAME
# Useful for debugging and adding features
print-%: ; @echo $*=$($*)

# Shell used in this makefile
# bash is used for 'echo -en'
SHELL = /bin/bash

# Append pkg-config specific libraries if need be
ifneq ($(LIBS),)
	$(RM) -r build
	$(RM) -r bin

# Main rule
.PHONY: all
all: $(BIN_PATH)/$(BIN_NAME) $(BIN_PATH)/$(TEST_BIN_NAME)

# Link the executable
$(BIN_PATH)/$(BIN_NAME): $(OBJECTS)
	@echo "Linking: $@"
	$(CC) $(OBJECTS) $(LDFLAGS) -o $@

$(BIN_PATH)/$(TEST_BIN_NAME): $(TEST_OBJECTS)
	@echo "Linking: $@"
	$(CC) $(TEST_OBJECTS) $(LDFLAGS) -o $@

# Add dependency files, if they exist
-include $(DEPS)

# Source file rules
# After the first compilation they will be joined with the rules from the
# dependency files to provide header dependencies
$(BUILD_PATH)/$(SRC_PATH)/%.o: $(SRC_PATH)/%.$(SRC_EXT)
	@echo "Compiling: $< -> $@"
	$(CC) $(CFLAGS) $(INCLUDES) -MP -MMD -c $< -o $@

$(BUILD_PATH)/$(TEST_PATH)/%.o: $(TEST_PATH)/%.$(SRC_EXT)
	@echo "Compiling: $< -> $@"
	$(CC) $(CFLAGS) $(INCLUDES) -MP -MMD -c $< -o $@
