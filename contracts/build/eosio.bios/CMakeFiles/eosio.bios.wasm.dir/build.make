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
include eosio.bios/CMakeFiles/eosio.bios.wasm.dir/depend.make

# Include the progress variables for this target.
include eosio.bios/CMakeFiles/eosio.bios.wasm.dir/progress.make

# Include the compile flags for this target's objects.
include eosio.bios/CMakeFiles/eosio.bios.wasm.dir/flags.make

eosio.bios/CMakeFiles/eosio.bios.wasm.dir/src/eosio.bios.cpp.o: eosio.bios/CMakeFiles/eosio.bios.wasm.dir/flags.make
eosio.bios/CMakeFiles/eosio.bios.wasm.dir/src/eosio.bios.cpp.o: ../eosio.bios/src/eosio.bios.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/basar/Workspace/ore-protocol/contracts/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object eosio.bios/CMakeFiles/eosio.bios.wasm.dir/src/eosio.bios.cpp.o"
	cd /Users/basar/Workspace/ore-protocol/contracts/build/eosio.bios && //usr/local/bin/eosio-cpp  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/eosio.bios.wasm.dir/src/eosio.bios.cpp.o -c /Users/basar/Workspace/ore-protocol/contracts/eosio.bios/src/eosio.bios.cpp

eosio.bios/CMakeFiles/eosio.bios.wasm.dir/src/eosio.bios.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/eosio.bios.wasm.dir/src/eosio.bios.cpp.i"
	cd /Users/basar/Workspace/ore-protocol/contracts/build/eosio.bios && //usr/local/bin/eosio-cpp $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/basar/Workspace/ore-protocol/contracts/eosio.bios/src/eosio.bios.cpp > CMakeFiles/eosio.bios.wasm.dir/src/eosio.bios.cpp.i

eosio.bios/CMakeFiles/eosio.bios.wasm.dir/src/eosio.bios.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/eosio.bios.wasm.dir/src/eosio.bios.cpp.s"
	cd /Users/basar/Workspace/ore-protocol/contracts/build/eosio.bios && //usr/local/bin/eosio-cpp $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/basar/Workspace/ore-protocol/contracts/eosio.bios/src/eosio.bios.cpp -o CMakeFiles/eosio.bios.wasm.dir/src/eosio.bios.cpp.s

# Object files for target eosio.bios.wasm
eosio_bios_wasm_OBJECTS = \
"CMakeFiles/eosio.bios.wasm.dir/src/eosio.bios.cpp.o"

# External object files for target eosio.bios.wasm
eosio_bios_wasm_EXTERNAL_OBJECTS =

eosio.bios/eosio.bios.wasm: eosio.bios/CMakeFiles/eosio.bios.wasm.dir/src/eosio.bios.cpp.o
eosio.bios/eosio.bios.wasm: eosio.bios/CMakeFiles/eosio.bios.wasm.dir/build.make
eosio.bios/eosio.bios.wasm: eosio.bios/CMakeFiles/eosio.bios.wasm.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/basar/Workspace/ore-protocol/contracts/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable eosio.bios.wasm"
	cd /Users/basar/Workspace/ore-protocol/contracts/build/eosio.bios && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/eosio.bios.wasm.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
eosio.bios/CMakeFiles/eosio.bios.wasm.dir/build: eosio.bios/eosio.bios.wasm

.PHONY : eosio.bios/CMakeFiles/eosio.bios.wasm.dir/build

eosio.bios/CMakeFiles/eosio.bios.wasm.dir/clean:
	cd /Users/basar/Workspace/ore-protocol/contracts/build/eosio.bios && $(CMAKE_COMMAND) -P CMakeFiles/eosio.bios.wasm.dir/cmake_clean.cmake
.PHONY : eosio.bios/CMakeFiles/eosio.bios.wasm.dir/clean

eosio.bios/CMakeFiles/eosio.bios.wasm.dir/depend:
	cd /Users/basar/Workspace/ore-protocol/contracts/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/basar/Workspace/ore-protocol/contracts /Users/basar/Workspace/ore-protocol/contracts/eosio.bios /Users/basar/Workspace/ore-protocol/contracts/build /Users/basar/Workspace/ore-protocol/contracts/build/eosio.bios /Users/basar/Workspace/ore-protocol/contracts/build/eosio.bios/CMakeFiles/eosio.bios.wasm.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : eosio.bios/CMakeFiles/eosio.bios.wasm.dir/depend

