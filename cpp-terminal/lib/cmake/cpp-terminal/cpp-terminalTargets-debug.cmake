#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "cpp-terminal::cpp-terminal" for configuration "Debug"
set_property(TARGET cpp-terminal::cpp-terminal APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(cpp-terminal::cpp-terminal PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/lib/cpp-terminal.lib"
  )

list(APPEND _cmake_import_check_targets cpp-terminal::cpp-terminal )
list(APPEND _cmake_import_check_files_for_cpp-terminal::cpp-terminal "${_IMPORT_PREFIX}/lib/cpp-terminal.lib" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
