# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.12

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/local/Cellar/cmake/3.12.0/bin/cmake

# The command to remove a file.
RM = /usr/local/Cellar/cmake/3.12.0/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/basar/Workspace/ore-protocol/contracts

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/basar/Workspace/ore-protocol/contracts/build

# Include any dependencies generated for this target.
include ore.standard_token/CMakeFiles/ore.standard_token.wasm.dir/depend.make

# Include the progress variables for this target.
include ore.standard_token/CMakeFiles/ore.standard_token.wasm.dir/progress.make

# Include the compile flags for this target's objects.
include ore.standard_token/CMakeFiles/ore.standard_token.wasm.dir/flags.make

ore.standard_token/CMakeFiles/ore.standard_token.wasm.dir/src/ore.standard_token.cpp.o: ore.standard_token/CMakeFiles/ore.standard_token.wasm.dir/flags.make
ore.standard_token/CMakeFiles/ore.standard_token.wasm.dir/src/ore.standard_token.cpp.o: ../ore.standard_token/src/ore.standard_token.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/basar/Workspace/ore-protocol/contracts/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object ore.standard_token/CMakeFiles/ore.standard_token.wasm.dir/src/ore.standard_token.cpp.o"
	cd /Users/basar/Workspace/ore-protocol/contracts/build/ore.standard_token && //usr/local/bin/eosio-cpp  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/ore.standard_token.wasm.dir/src/ore.standard_token.cpp.o -c /Users/basar/Workspace/ore-protocol/contracts/ore.standard_token/src/ore.standard_token.cpp

ore.standard_token/CMakeFiles/ore.standard_token.wasm.dir/src/ore.standard_token.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/ore.standard_token.wasm.dir/src/ore.standard_token.cpp.i"
	cd /Users/basar/Workspace/ore-protocol/contracts/build/ore.standard_token && //usr/local/bin/eosio-cpp $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/basar/Workspace/ore-protocol/contracts/ore.standard_token/src/ore.standard_token.cpp > CMakeFiles/ore.standard_token.wasm.dir/src/ore.standard_token.cpp.i

ore.standard_token/CMakeFiles/ore.standard_token.wasm.dir/src/ore.standard_token.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/ore.standard_token.wasm.dir/src/ore.standard_token.cpp.s"
	cd /Users/basar/Workspace/ore-protocol/contracts/build/ore.standard_token && //usr/local/bin/eosio-cpp $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/basar/Workspace/ore-protocol/contracts/ore.standard_token/src/ore.standard_token.cpp -o CMakeFiles/ore.standard_token.wasm.dir/src/ore.standard_token.cpp.s

# Object files for target ore.standard_token.wasm
ore_standard_token_wasm_OBJECTS = \
"CMakeFiles/ore.standard_token.wasm.dir/src/ore.standard_token.cpp.o"

# External object files for target ore.standard_token.wasm
ore_standard_token_wasm_EXTERNAL_OBJECTS =

ore.standard_token/ore.standard_token.wasm: ore.standard_token/CMakeFiles/ore.standard_token.wasm.dir/src/ore.standard_token.cpp.o
ore.standard_token/ore.standard_token.wasm: ore.standard_token/CMakeFiles/ore.standard_token.wasm.dir/build.make
ore.standard_token/ore.standard_token.wasm: ore.standard_token/CMakeFiles/ore.standard_token.wasm.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/basar/Workspace/ore-protocol/contracts/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable ore.standard_token.wasm"
	cd /Users/basar/Workspace/ore-protocol/contracts/build/ore.standard_token && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/ore.standard_token.wasm.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
ore.standard_token/CMakeFiles/ore.standard_token.wasm.dir/build: ore.standard_token/ore.standard_token.wasm

.PHONY : ore.standard_token/CMakeFiles/ore.standard_token.wasm.dir/build

ore.standard_token/CMakeFiles/ore.standard_token.wasm.dir/clean:
	cd /Users/basar/Workspace/ore-protocol/contracts/build/ore.standard_token && $(CMAKE_COMMAND) -P CMakeFiles/ore.standard_token.wasm.dir/cmake_clean.cmake
.PHONY : ore.standard_token/CMakeFiles/ore.standard_token.wasm.dir/clean

ore.standard_token/CMakeFiles/ore.standard_token.wasm.dir/depend:
	cd /Users/basar/Workspace/ore-protocol/contracts/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/basar/Workspace/ore-protocol/contracts /Users/basar/Workspace/ore-protocol/contracts/ore.standard_token /Users/basar/Workspace/ore-protocol/contracts/build /Users/basar/Workspace/ore-protocol/contracts/build/ore.standard_token /Users/basar/Workspace/ore-protocol/contracts/build/ore.standard_token/CMakeFiles/ore.standard_token.wasm.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : ore.standard_token/CMakeFiles/ore.standard_token.wasm.dir/depend

