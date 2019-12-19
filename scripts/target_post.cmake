
target_link_libraries(${PROG}
  PRIVATE
  FLUID_DECOMPOSITION
  FLUID_CLI_WRAPPER
  HISSTools_AudioFile
)

set_target_properties(${PROG} 
    PROPERTIES
    CXX_STANDARD 14
    CXX_STANDARD_REQUIRED ON
    CXX_EXTENSIONS OFF
)

if (APPLE)
  #targeting <= 10.9, need to explicitly set libc++
  target_compile_options(${PROG}  PRIVATE -stdlib=libc++)
  target_link_libraries(${PROG} PRIVATE -stdlib=libc++)
endif()

if(MSVC)
  target_compile_options(
    ${PROG} PRIVATE $<$<NOT:$<CONFIG:DEBUG>>: /arch:AVX> -D_USE_MATH_DEFINES /W3
  )
  
else()
  target_compile_options(  
    ${PROG} PUBLIC $<$<NOT:$<CONFIG:DEBUG>>: -mavx>  -Wall -Wextra -Wpedantic  -Wno-c++11-narrowing 
  )
endif(MSVC)

set_target_properties(
  ${PROG}
  PROPERTIES
  RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
  RUNTIME_OUTPUT_DIRECTORY_RELEASE "${CMAKE_BINARY_DIR}/bin"
  RUNTIME_OUTPUT_DIRECTORY_DEBUG "${CMAKE_BINARY_DIR}/bin"
)

get_property(HEADERS TARGET FLUID_DECOMPOSITION PROPERTY INTERFACE_SOURCES)
source_group(TREE "${fluid_decomposition_SOURCE_DIR}/include" FILES ${HEADERS})
