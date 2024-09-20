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

set(VARIANTS "#" "SECURE" "NON_SECURE")

if(NOT CORES)
    message(TRACE "Single Core")
    set(CORES "#")
endif()

foreach(CORE ${CORES})
    if(CORE STREQUAL "#")
        unset(CORE)
        unset(CORE_C)
        unset(CORE_U)
        unset(CORE_D)
    else()
        set(CORE_C "::${CORE}")
        set(CORE_U "_${CORE}")
        set(CORE_D "-${CORE}")
    endif()

    foreach(PORT ${STM32${FAMILY}${CORE_U}_FREERTOS_PORT})
        foreach(VARIANT ${VARIANTS})

            message(TRACE "Iterrating ${FAMILY} ${CORE} ${PORT} ${VARIANT}")
            if(VARIANT STREQUAL "#")
                unset(VARIANT_C)
                unset(VARIANT_D)
            else()
                set(VARIANT_C "::${VARIANT}")
                string(TOLOWER "-${VARIANT}" VARIANT_D)
            endif()
            
            set(EXE freertos-test-${FAMILY}${CORE_U}-${PORT}${VARIANT_D})
            set(LIB FreeRTOS::STM32::${FAMILY}${CORE_C}::${PORT}${VARIANT_C})

            if(TARGET ${LIB})
                message(STATUS "Create executable ${EXE} with lib ${LIB}")
                add_executable(${EXE}
                    ${SOURCES}
                )
                target_link_libraries(${EXE}
                    FreeRTOS::STM32::${FAMILY}${CORE_C}::Timers
                    FreeRTOS::STM32::${FAMILY}${CORE_C}::Heap::4
                    ${LIB}
                    HAL::STM32::${FAMILY}${CORE_C}::CORTEX
                    CMSIS::STM32::${DEVICE}${CORE_C}
                    STM32::NoSys
                )
            else()
                message(TRACE "Not creating ${EXE} becaue ${LIB} dosen't exist")
            endif()
        endforeach()
    endforeach()
endforeach()
