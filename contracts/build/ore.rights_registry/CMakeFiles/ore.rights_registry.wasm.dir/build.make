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
include ore.rights_registry/CMakeFiles/ore.rights_registry.wasm.dir/depend.make

# Include the progress variables for this target.
include ore.rights_registry/CMakeFiles/ore.rights_registry.wasm.dir/progress.make

# Include the compile flags for this target's objects.
include ore.rights_registry/CMakeFiles/ore.rights_registry.wasm.dir/flags.make

ore.rights_registry/CMakeFiles/ore.rights_registry.wasm.dir/src/ore.rights_registry.cpp.o: ore.rights_registry/CMakeFiles/ore.rights_registry.wasm.dir/flags.make
ore.rights_registry/CMakeFiles/ore.rights_registry.wasm.dir/src/ore.rights_registry.cpp.o: ../ore.rights_registry/src/ore.rights_registry.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/basar/Workspace/ore-protocol/contracts/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object ore.rights_registry/CMakeFiles/ore.rights_registry.wasm.dir/src/ore.rights_registry.cpp.o"
	cd /Users/basar/Workspace/ore-protocol/contracts/build/ore.rights_registry && //usr/local/bin/eosio-cpp  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/ore.rights_registry.wasm.dir/src/ore.rights_registry.cpp.o -c /Users/basar/Workspace/ore-protocol/contracts/ore.rights_registry/src/ore.rights_registry.cpp

ore.rights_registry/CMakeFiles/ore.rights_registry.wasm.dir/src/ore.rights_registry.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/ore.rights_registry.wasm.dir/src/ore.rights_registry.cpp.i"
	cd /Users/basar/Workspace/ore-protocol/contracts/build/ore.rights_registry && //usr/local/bin/eosio-cpp $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/basar/Workspace/ore-protocol/contracts/ore.rights_registry/src/ore.rights_registry.cpp > CMakeFiles/ore.rights_registry.wasm.dir/src/ore.rights_registry.cpp.i

ore.rights_registry/CMakeFiles/ore.rights_registry.wasm.dir/src/ore.rights_registry.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/ore.rights_registry.wasm.dir/src/ore.rights_registry.cpp.s"
	cd /Users/basar/Workspace/ore-protocol/contracts/build/ore.rights_registry && //usr/local/bin/eosio-cpp $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/basar/Workspace/ore-protocol/contracts/ore.rights_registry/src/ore.rights_registry.cpp -o CMakeFiles/ore.rights_registry.wasm.dir/src/ore.rights_registry.cpp.s

# Object files for target ore.rights_registry.wasm
ore_rights_registry_wasm_OBJECTS = \
"CMakeFiles/ore.rights_registry.wasm.dir/src/ore.rights_registry.cpp.o"

# External object files for target ore.rights_registry.wasm
ore_rights_registry_wasm_EXTERNAL_OBJECTS =

ore.rights_registry/ore.rights_registry.wasm: ore.rights_registry/CMakeFiles/ore.rights_registry.wasm.dir/src/ore.rights_registry.cpp.o
ore.rights_registry/ore.rights_registry.wasm: ore.rights_registry/CMakeFiles/ore.rights_registry.wasm.dir/build.make
ore.rights_registry/ore.rights_registry.wasm: ore.rights_registry/CMakeFiles/ore.rights_registry.wasm.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/basar/Workspace/ore-protocol/contracts/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable ore.rights_registry.wasm"
	cd /Users/basar/Workspace/ore-protocol/contracts/build/ore.rights_registry && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/ore.rights_registry.wasm.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
ore.rights_registry/CMakeFiles/ore.rights_registry.wasm.dir/build: ore.rights_registry/ore.rights_registry.wasm

.PHONY : ore.rights_registry/CMakeFiles/ore.rights_registry.wasm.dir/build

ore.rights_registry/CMakeFiles/ore.rights_registry.wasm.dir/clean:
	cd /Users/basar/Workspace/ore-protocol/contracts/build/ore.rights_registry && $(CMAKE_COMMAND) -P CMakeFiles/ore.rights_registry.wasm.dir/cmake_clean.cmake
.PHONY : ore.rights_registry/CMakeFiles/ore.rights_registry.wasm.dir/clean

ore.rights_registry/CMakeFiles/ore.rights_registry.wasm.dir/depend:
	cd /Users/basar/Workspace/ore-protocol/contracts/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/basar/Workspace/ore-protocol/contracts /Users/basar/Workspace/ore-protocol/contracts/ore.rights_registry /Users/basar/Workspace/ore-protocol/contracts/build /Users/basar/Workspace/ore-protocol/contracts/build/ore.rights_registry /Users/basar/Workspace/ore-protocol/contracts/build/ore.rights_registry/CMakeFiles/ore.rights_registry.wasm.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : ore.rights_registry/CMakeFiles/ore.rights_registry.wasm.dir/depend

