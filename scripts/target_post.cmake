# Part of the Fluid Corpus Manipulation Project (http://www.flucoma.org/)
# Copyright 2017-2019 University of Huddersfield.
# Licensed under the BSD-3 License.
# See license.md file in the project root for full license information.
# This project has received funding from the European Research Council (ERC)
# under the European Union’s Horizon 2020 research and innovation programme
# (grant agreement No 725899).

target_link_libraries(${PROG}
  PRIVATE
  FLUID_DECOMPOSITION
  FLUID_CLI_WRAPPER
  HISSTools_AudioFile
)

target_include_directories(
  ${PROG}
  PRIVATE 
  "${FLUID_VERSION_PATH}"
)

set_target_properties(${PROG} 
    PROPERTIES
    CXX_STANDARD 14
    CXX_STANDARD_REQUIRED ON
    CXX_EXTENSIONS OFF
)

if (APPLE)
  #targeting <= 10.9, need to explicitly set libc++
  target_compile_options(${PROG} PRIVATE -stdlib=libc++)
  target_link_libraries(${PROG} PRIVATE -stdlib=libc++)
endif()

#set AVX, or whatever
if(DEFINED FLUID_ARCH)  
    target_compile_options(${PROG} PRIVATE ${FLUID_ARCH})
endif()

if(MSVC)
  target_compile_options(${PROG} PRIVATE  -D_USE_MATH_DEFINES /W3)
else()
  target_compile_options(${PROG} PRIVATE -Wall -Wextra -Wpedantic -Wno-c++11-narrowing)
endif(MSVC)

set_target_properties(
  ${PROG}
  PROPERTIES
  RUNTIME_OUTPUT_DIRECTORY ${FLUCOMA_CLI_RUNTIME_OUTPUT_DIRECTORY}
  RUNTIME_OUTPUT_DIRECTORY_RELEASE ${FLUCOMA_CLI_RUNTIME_OUTPUT_DIRECTORY}
  RUNTIME_OUTPUT_DIRECTORY_DEBUG ${FLUCOMA_CLI_RUNTIME_OUTPUT_DIRECTORY}
)

get_property(HEADERS TARGET FLUID_DECOMPOSITION PROPERTY INTERFACE_SOURCES)
source_group(TREE "${fluid_decomposition_SOURCE_DIR}/include" FILES ${HEADERS})
