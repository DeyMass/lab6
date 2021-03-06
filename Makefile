debug: export LDFLAGS := $(LDFLAGS) $(LINK_FLAGS)

# Build and output paths
release: export BUILD_PATH := build/release
release: export BIN_PATH := bin/release
debug: export BUILD_PATH := build/debug
debug: export BIN_PATH := bin/debug

# Find all source files in the source directory
SOURCES = $(shell find $(SRC_PATH)/ -name '*.$(SRC_EXT)')
LIB_SOURCES = $(filter-out $(SRC_PATH)/main.c, $(SOURCES))
TEST_SOURCES = $(shell find $(TEST_PATH)/ -name '*.$(SRC_EXT)')

# Set the object file names, with the build path prepended
# in source directory place
OBJECTS = $(SOURCES:$(SRC_PATH)/%.$(SRC_EXT)=$(BUILD_PATH)/$(SRC_PATH)/%.o)
TEST_OBJECTS = \
    $(LIB_SOURCES:$(SRC_PATH)/%.$(SRC_EXT)=$(BUILD_PATH)/$(SRC_PATH)/%.o) \
    $(TEST_SOURCES:$(TEST_PATH)/%.$(SRC_EXT)=$(BUILD_PATH)/$(TEST_PATH)/%.o)

# Set the dependency files that will be used to add header dependencies
DEPS = $(OBJECTS:.o=.d) $(TEST_OBJECTS:.o=.d)

# Release build
.PHONY: release
release: dirs
	@echo "Beginning release build"
	@$(MAKE) all --no-print-directory
	@echo
	@./$(BIN_PATH)/$(TEST_BIN_NAME)

# Debug build for gdb debugging
.PHONY: debug
debug: dirs
	@echo "Beginning debug build"
	@$(MAKE) all --no-print-directory
	@echo
	@./$(BIN_PATH)/$(TEST_BIN_NAME)

# Create the directories used in the build
.PHONY: dirs
dirs:
	@echo "Creating directories"
	@mkdir -p $(dir $(OBJECTS))
	@mkdir -p $(dir $(TEST_OBJECTS))
	@mkdir -p $(BIN_PATH)

# Removes all build files
.PHONY: clean
clean:
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
