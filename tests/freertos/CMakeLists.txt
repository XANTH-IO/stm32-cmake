cmake_minimum_required(VERSION 3.16)
set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_SOURCE_DIR}/../../cmake/stm32_gcc.cmake)

if(NOT FAMILY)
    message(FATAL_ERROR "Need to set FAMILY")
endif()

project(freertos-test C ASM)
set(CMAKE_INCLUDE_CURRENT_DIR TRUE)

stm32_get_devices_by_family(STM_DEVICES FAMILY ${FAMILY})
list(GET STM_DEVICES -1 DEVICE)
stm32_get_cores(CORES FAMILY ${FAMILY} DEVICE ${DEVICE})

if(CORES)
    foreach(CORE ${CORES})
        list(APPEND FREERTOS_PORTS ${STM32${FAMILY}_${CORE}_FREERTOS_PORT})
    endforeach()
else()
    set(FREERTOS_PORTS ${STM32${FAMILY}_FREERTOS_PORT})
endif()

if(FETCH_ST_SOURCES)
    stm32_fetch_cube(${FAMILY})
endif()

find_package(CMSIS COMPONENTS STM32${FAMILY} REQUIRED)
find_package(HAL COMPONENTS STM32${FAMILY} REQUIRED)
find_package(FreeRTOS COMPONENTS ${FREERTOS_PORTS} STM32${FAMILY} REQUIRED)

set(SOURCES main.c)

if(CORES)
    foreach(CORE ${CORES})
        if(STM32${FAMILY}_${CORE}_FREERTOS_PORT)
            add_executable(freertos-test-${FAMILY}-${CORE} 
                ${SOURCES}
            )
            target_link_libraries(freertos-test-${FAMILY}-${CORE}
                FreeRTOS::STM32::${FAMILY}::${CORE}::Timers
                FreeRTOS::STM32::${FAMILY}::${CORE}::Heap::4
                FreeRTOS::STM32::${FAMILY}::${CORE}::${STM32${FAMILY}_${CORE}_FREERTOS_PORT}
                HAL::STM32::${FAMILY}::${CORE}::CORTEX
                CMSIS::STM32::${DEVICE}::${CORE}
                STM32::NoSys
            )
        endif()
    endforeach()
else()
    if(STM32${FAMILY}_FREERTOS_PORT)
        add_executable(freertos-test-${FAMILY} ${SOURCES})
        target_link_libraries(freertos-test-${FAMILY}
            FreeRTOS::STM32::${FAMILY}::Timers
            FreeRTOS::STM32::${FAMILY}::Heap::4
            FreeRTOS::STM32::${FAMILY}::${STM32${FAMILY}_FREERTOS_PORT}
            HAL::STM32::${FAMILY}${CORE}::CORTEX
            CMSIS::STM32::${DEVICE}${CORE}
            STM32::NoSys
        )
    endif()
endif()
