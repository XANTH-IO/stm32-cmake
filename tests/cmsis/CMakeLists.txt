cmake_minimum_required(VERSION 3.16)
set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_SOURCE_DIR}/../../cmake/stm32_gcc.cmake)

if(NOT TEST_FAMILIES)
    set(TEST_FAMILIES C0 F0 F1 F2 F3 F4 F7 G0 G4 H5 H7 H7RS L0 L1 L4 L5 U0 U5 WB WB0 WBA WL)
endif()

if("MP1" IN_LIST TEST_FAMILIES)
    message(WARNING "CMSIS for MP1 devices requires HAL, this test is expected to fail for the MP1 family")
endif()

if("MP2" IN_LIST TEST_FAMILIES)
    message(WARNING "CMSIS for MP1 devices requires HAL, this test is expected to fail for the MP2 family")
endif()

project(cmsis-test C ASM)

if(FETCH_ST_SOURCES)
    stm32_fetch_cmsis(${TEST_FAMILIES})
endif()

list(TRANSFORM TEST_FAMILIES PREPEND STM32 OUTPUT_VARIABLE TEST_FAMILIES_LONG_NAMES)
find_package(CMSIS COMPONENTS "${TEST_FAMILIES_LONG_NAMES}" REQUIRED)

set(SOURCES main.c)

include(stm32/devices)

foreach(FAMILY ${TEST_FAMILIES})
    stm32_get_devices_by_family(STM_DEVICES FAMILY ${FAMILY})
    stm32_get_cores(CORES FAMILY ${FAMILY})
    foreach(DEVICE ${STM_DEVICES})
        stm32_get_chip_type(${FAMILY} ${DEVICE} TYPE)
        
        if(NOT CORES)
            stm32_get_memory_info(FAMILY ${FAMILY} DEVICE ${DEVICE} FLASH SIZE FLASH_SIZE)
            stm32_get_memory_info(FAMILY ${FAMILY} DEVICE ${DEVICE} RAM SIZE RAM_SIZE)
            message(STATUS "STM32${DEVICE}: ${FAMILY} family, type ${TYPE}, ${FLASH_SIZE} flash, ${RAM_SIZE} RAM")
            add_executable(cmsis-test-${DEVICE} ${SOURCES})
            target_link_libraries(cmsis-test-${DEVICE} CMSIS::STM32::${DEVICE} STM32::NoSys)
        else()
            stm32_get_cores(DEV_CORES FAMILY ${FAMILY} DEVICE ${DEVICE})
            foreach(CORE ${DEV_CORES})
                stm32_get_memory_info(FAMILY ${FAMILY} DEVICE ${DEVICE} CORE ${CORE} FLASH SIZE FLASH_SIZE)
                stm32_get_memory_info(FAMILY ${FAMILY} DEVICE ${DEVICE} CORE ${CORE} RAM SIZE RAM_SIZE)
                message(STATUS "STM32${DEVICE}: ${FAMILY} family, type ${TYPE}, core ${CORE}, ${FLASH_SIZE} flash, ${RAM_SIZE} RAM")
                add_executable(cmsis-test-${DEVICE}-${CORE} ${SOURCES})
                target_link_libraries(cmsis-test-${DEVICE}-${CORE} CMSIS::STM32::${DEVICE}::${CORE} STM32::NoSys)
            endforeach()
        endif()
    endforeach()
endforeach()
