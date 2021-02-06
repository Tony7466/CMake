include(Compiler/Clang)
__compiler_clang(C)

cmake_policy(GET CMP0025 appleClangPolicy)
if(APPLE AND NOT appleClangPolicy STREQUAL NEW)
  return()
endif()

if("x${CMAKE_C_COMPILER_FRONTEND_VARIANT}" STREQUAL "xMSVC")
  set(CMAKE_C_COMPILE_OPTIONS_EXPLICIT_LANGUAGE -TC)
  set(CMAKE_C_CLANG_TIDY_DRIVER_MODE "cl")
  if((NOT DEFINED CMAKE_DEPENDS_USE_COMPILER OR CMAKE_DEPENDS_USE_COMPILER)
      AND CMAKE_GENERATOR MATCHES "Makefiles|WMake"
      AND CMAKE_DEPFILE_FLAGS_C)
    set(CMAKE_C_DEPENDS_USE_COMPILER TRUE)
  endif()
elseif("x${CMAKE_C_COMPILER_FRONTEND_VARIANT}" STREQUAL "xGNU")
  set(CMAKE_C_COMPILE_OPTIONS_EXPLICIT_LANGUAGE -x c)
  if((NOT DEFINED CMAKE_DEPENDS_USE_COMPILER OR CMAKE_DEPENDS_USE_COMPILER)
      AND CMAKE_GENERATOR MATCHES "Makefiles|WMake"
      AND CMAKE_DEPFILE_FLAGS_C)
    # dependencies are computed by the compiler itself
    set(CMAKE_C_DEPFILE_FORMAT gcc)
    set(CMAKE_C_DEPENDS_USE_COMPILER TRUE)
  endif()
endif()

if(NOT "x${CMAKE_C_SIMULATE_ID}" STREQUAL "xMSVC")
  if(CMAKE_C_COMPILER_VERSION VERSION_GREATER_EQUAL 2.1)
    set(CMAKE_C90_STANDARD_COMPILE_OPTION "-std=c90")
    set(CMAKE_C90_EXTENSION_COMPILE_OPTION "-std=gnu90")

    set(CMAKE_C99_STANDARD_COMPILE_OPTION "-std=c99")
    set(CMAKE_C99_EXTENSION_COMPILE_OPTION "-std=gnu99")
  endif()

  if(CMAKE_C_COMPILER_VERSION VERSION_GREATER_EQUAL 3.1)
    set(CMAKE_C11_STANDARD_COMPILE_OPTION "-std=c11")
    set(CMAKE_C11_EXTENSION_COMPILE_OPTION "-std=gnu11")
  elseif(CMAKE_C_COMPILER_VERSION VERSION_GREATER_EQUAL 3.0)
    set(CMAKE_C11_STANDARD_COMPILE_OPTION "-std=c1x")
    set(CMAKE_C11_EXTENSION_COMPILE_OPTION "-std=gnu1x")
  endif()

  if(CMAKE_C_COMPILER_VERSION VERSION_GREATER_EQUAL 6.0)
    set(CMAKE_C17_STANDARD_COMPILE_OPTION "-std=c17")
    set(CMAKE_C17_EXTENSION_COMPILE_OPTION "-std=gnu17")
  endif()

  if(CMAKE_C_COMPILER_VERSION VERSION_GREATER_EQUAL 9.0)
    set(CMAKE_C23_STANDARD_COMPILE_OPTION "-std=c2x")
    set(CMAKE_C23_EXTENSION_COMPILE_OPTION "-std=gnu2x")
  endif()
else()
  set(CMAKE_C90_STANDARD_COMPILE_OPTION "")
  set(CMAKE_C90_EXTENSION_COMPILE_OPTION "")
  set(CMAKE_C99_STANDARD_COMPILE_OPTION "")
  set(CMAKE_C99_EXTENSION_COMPILE_OPTION "")

  if(CMAKE_C_COMPILER_VERSION VERSION_GREATER_EQUAL 13.0)
    set(CMAKE_C11_STANDARD_COMPILE_OPTION "/std:c11")
    set(CMAKE_C11_EXTENSION_COMPILE_OPTION "/std:c11")

    set(CMAKE_C17_STANDARD_COMPILE_OPTION "/std:c17")
    set(CMAKE_C17_EXTENSION_COMPILE_OPTION "/std:c17")
  else()
    set(CMAKE_C11_STANDARD_COMPILE_OPTION "")
    set(CMAKE_C11_EXTENSION_COMPILE_OPTION "")

    set(CMAKE_C17_STANDARD_COMPILE_OPTION "")
    set(CMAKE_C17_EXTENSION_COMPILE_OPTION "")
  endif()
endif()

if(CMAKE_C_COMPILER_VERSION VERSION_GREATER_EQUAL 2.1)
  set(CMAKE_C90_STANDARD__HAS_FULL_SUPPORT ON)
  set(CMAKE_C99_STANDARD__HAS_FULL_SUPPORT ON)
endif()

if(CMAKE_C_COMPILER_VERSION VERSION_GREATER_EQUAL 3.0)
  set(CMAKE_C11_STANDARD__HAS_FULL_SUPPORT ON)
endif()

if(NOT "x${CMAKE_C_SIMULATE_ID}" STREQUAL "xMSVC")
  __compiler_check_default_language_standard(C 2.1 99 3.5.2 11 11.0 17)
else()
  set(CMAKE_C_STANDARD_DEFAULT "")
endif()
