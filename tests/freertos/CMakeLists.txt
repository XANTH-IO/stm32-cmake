cmake_minimum_required(VERSION 3.16)
set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_SOURCE_DIR}/../../cmake/stm32_gcc.cmake)

if(NOT TEST_FAMILIES)
    set(TEST_FAMILIES C0 F0 F1 F2 F3 F4 F7 G0 G4 H5 H7 H7RS L0 L1 L4 L5 MP1 MP2 U0 U5 WB WB0 WBA WL)
endif()

# Generate the family long names list by prepending STM32 to elements in TEST_FAMILIES
list(TRANSFORM TEST_FAMILIES PREPEND STM32 OUTPUT_VARIABLE TEST_FAMILIES_LONG_NAMES)

list(TRANSFORM TEST_FAMILIES_LONG_NAMES APPEND _FREERTOS_PORT OUTPUT VARIABLE FREE_RTOS_PORTS)

project(freertos-test C ASM)
set(CMAKE_INCLUDE_CURRENT_DIR TRUE)

stm32_fetch_cube(${TEST_FAMILIES})

find_package(CMSIS COMPONENTS ${TEST_FAMILIES_LONG_NAMES} REQUIRED)
find_package(HAL COMPONENTS ${TEST_FAMILIES_LONG_NAMES} REQUIRED)
find_package(FreeRTOS COMPONENTS ${TEST_FAMILIES_LONG_NAMES} ${FREE_RTOS_PORTS} REQUIRED)

set(SOURCES main.c)

foreach(FAMILY ${TEST_FAMILIES})
    stm32_get_devices_by_family(STM_DEVICES FAMILY ${FAMILY})
    list(GET STM_DEVICES -1 DEVICE)
    stm32_get_cores(CORES FAMILY ${FAMILY} DEVICE ${DEVICE})
    
    if(CORES)
        list(GET CORES 0 CORE)
        set(CORE "::${CORE}")
    else()
        unset(CORE)
    endif()
    
    add_executable(freertos-test-${FAMILY} ${SOURCES})
    target_link_libraries(freertos-test-${FAMILY}
        ${FREERTOS_NAMESPACE}::STM32::${FAMILY}${CORE}::Timers
        ${FREERTOS_NAMESPACE}::STM32::${FAMILY}${CORE}::Heap::4
        ${FREERTOS_NAMESPACE}::STM32::${FAMILY}${CORE}::STM32${FAMILY}_FREERTOS_PORT
        HAL::STM32::${FAMILY}${CORE}::CORTEX
        CMSIS::STM32::${DEVICE}${CORE}
        STM32::NoSys
    )
endforeach()
