set(STM32_H7_TYPES
    H723xx H725xx  H730xx H730xxQ H733xx H735xx
    H743xx H753xx  H750xx H742xx  H745xx H755xx H747xx H757xx
    H7A3xx H7A3xxQ H7B3xx H7B3xxQ H7B0xx H7B0xxQ
)
set(STM32_H7_TYPE_MATCH
   "H723.." "H725.."  "H730.." "H730..Q" "H733.." "H735.."
   "H743.." "H753.."  "H750.." "H742.."  "H745.." "H755.." "H747.." "H757.."
   "H7A3.." "H7A3..Q" "H7B3.." "H7B3..Q" "H7B0.." "H7B0..Q"
)
set(STM32_H7_RAM_SIZES
    128K 128K 128K 128K 128K 128K
    128K 128K 128K 128K 128K 128K 128K 128K
    128K 128K 128K 128K 128K 128K
)
set(STM32_H7_M4_RAM_SIZES
      0K   0K   0K   0K   0K   0K
      0K   0K   0K   0K 288K 288K 288K 288K
      0K   0K   0K   0K   0K   0K
)

set(STM32_H7_CCRAM_SIZES 
      0K   0K   0K   0K   0K   0K
      0K   0K   0K   0K   0K   0K   0K   0K
      0K   0K   0K   0K   0K   0K
)

set(STM32_H7RS_TYPES
    H7R3xx H7S3xx
    H7R7xx H7S7xx
)
set(STM32_H7RS_TYPE_MATCH
   "H7R3.." "H7S3.."
   "H7R7.." "H7S7.."
)
set(STM32_H7RS_RAM_SIZES
    620K 620K
    620K 620K
)
set(STM32_H7RS_CCRAM_SIZES 
    0K   0K
    0K   0K
)

set(STM32_H7_DUAL_CORE
      H745xx H755xx H747xx H757xx
)

stm32_util_create_family_targets(H7 M7)

target_compile_options(STM32::H7::M7 INTERFACE 
    -mcpu=cortex-m7 -mfpu=fpv5-sp-d16 -mfloat-abi=hard
)
target_link_options(STM32::H7::M7 INTERFACE 
    -mcpu=cortex-m7 -mfpu=fpv5-sp-d16 -mfloat-abi=hard
)
target_compile_definitions(STM32::H7::M7 INTERFACE 
    -DCORE_CM7
)

stm32_util_create_family_targets(H7 M4)

target_compile_options(STM32::H7::M4 INTERFACE 
    -mcpu=cortex-m4 -mfpu=fpv4-sp-d16 -mfloat-abi=hard
)
target_link_options(STM32::H7::M4 INTERFACE 
    -mcpu=cortex-m4 -mfpu=fpv4-sp-d16 -mfloat-abi=hard
)
target_compile_definitions(STM32::H7::M4 INTERFACE 
    -DCORE_CM4
)

stm32_util_create_family_targets(H7RS)

target_compile_options(STM32::H7RS INTERFACE 
    -mcpu=cortex-m7 -mfpu=fpv5-sp-d16 -mfloat-abi=hard
)

target_link_options(STM32::H7RS INTERFACE 
    -mcpu=cortex-m7 -mfpu=fpv5-sp-d16 -mfloat-abi=hard
)

function(stm32h7_get_actual_family DEVICE FAMILY)
    if(${DEVICE} MATCHES "(STM32)?H7(R|S).*")
        set(FAMILY H7RS PARENT_SCOPE)
    endif()
endfunction()

function(stm32h7_get_memory_info DEVICE TYPE CORE FLASH FLASH_ORIGIN RAM RAM_ORIGIN TWO_FLASH_BANKS)
    if(${TYPE} IN_LIST STM32_H7_DUAL_CORE)
        set(${TWO_FLASH_BANKS} TRUE PARENT_SCOPE)  
    else()
        set(${TWO_FLASH_BANKS} FALSE PARENT_SCOPE)
    endif()
    if(NOT CORE)
        set(CORE "M7")
    endif()
    list(FIND STM32_H7_TYPES ${TYPE} TYPE_INDEX)
    if(CORE STREQUAL "M7")
        list(GET STM32_H7_RAM_SIZES ${TYPE_INDEX} RAM_VALUE)
        set(${RAM} ${RAM_VALUE} PARENT_SCOPE)
        set(${FLASH_ORIGIN} 0x8000000 PARENT_SCOPE)
        set(${RAM_ORIGIN} 0x20000000 PARENT_SCOPE)
    elseif((${TYPE} IN_LIST STM32_H7_DUAL_CORE) AND (CORE STREQUAL "M4"))
        list(GET STM32_H7_M4_RAM_SIZES ${TYPE_INDEX} RAM_VALUE)
        set(${RAM} ${RAM_VALUE} PARENT_SCOPE)
        set(${FLASH_ORIGIN} 0x8100000 PARENT_SCOPE)
        set(${RAM_ORIGIN} 0x10000000 PARENT_SCOPE)
    else()
        message(FATAL_ERROR "Unknown core ${CORE}")
    endif()
endfunction()

function(stm32h7_get_device_cores CORES)
    set(ARG_OPTIONS "")
    set(ARG_SINGLE DEVICE)
    set(ARG_MULTIPLE "")
    cmake_parse_arguments(PARSE_ARGV 1 ARG "${ARG_OPTIONS}" "${ARG_SINGLE}" "${ARG_MULTIPLE}") 

    if(NOT ARG_DEVICE)
        set(CORE_LIST M7 M4)
    else()
        stm32_get_chip_type(H7 ${ARG_DEVICE} TYPE)
        if(${TYPE} IN_LIST STM32_H7_DUAL_CORE)
            set(CORE_LIST M7 M4)
        else()
            set(CORE_LIST M7)
        endif()
    endif()

    set(${CORES} ${CORE_LIST} PARENT_SCOPE)
endfunction()

set(STM32H7_FIND_REMOVE_ITEM STM32H7)
set(STM32H7_FIND_APPENDS STM32H7_M7 STM32H7_M4)

set(STM32_H7_DEVICES
    H723VE
    H723VG
    H723ZE
    H723ZG
    H725AE
    H725AG
    H725IE
    H725IG
    H725RE
    H725RG
    H725VE
    H725VG
    H725ZE
    H725ZG
    H730AB
    H730IB
    H730VB
    H730ZB
    H733VG
    H733ZG
    H735AG
    H735IG
    H735RG
    H735VG
    H735ZG
    H742AG
    H742AI
    H742BG
    H742BI
    H742IG
    H742II
    H742VG
    H742VI
    H742XG
    H742XI
    H742ZG
    H742ZI
    H743AG
    H743AI
    H743BG
    H743BI
    H743IG
    H743II
    H743VG
    H743VI
    H743XG
    H743XI
    H743ZG
    H743ZI
    H745BG
    H745BI
    H745IG
    H745II
    H745XG
    H745XI
    H745ZG
    H745ZI
    H747AG
    H747AI
    H747BG
    H747BI
    H747IG
    H747II
    H747XG
    H747XI
    H747ZI
    H750IB
    H750VB
    H750XB
    H750ZB
    H753AI
    H753BI
    H753II
    H753VI
    H753XI
    H753ZI
    H755BI
    H755II
    H755XI
    H755ZI
    H757AI
    H757BI
    H757II
    H757XI
    H757ZI
    H7A3AG
    H7A3AI
    H7A3IG
    H7A3II
    H7A3LG
    H7A3LI
    H7A3NG
    H7A3NI
    H7A3QI
    H7A3RG
    H7A3RI
    H7A3VG
    H7A3VI
    H7A3ZG
    H7A3ZI
    H7B0AB
    H7B0IB
    H7B0RB
    H7B0VB
    H7B0ZB
    H7B3AI
    H7B3II
    H7B3LI
    H7B3NI
    H7B3QI
    H7B3RI
    H7B3VI
    H7B3ZI
)
list(APPEND STM32_ALL_DEVICES STM32_H7_DEVICES)

set(STM32_H7RS_DEVICES
    H7R3A8
    H7R3I8
    H7R3L8
    H7R3R8
    H7R3V8
    H7R3Z8
    H7R7A8
    H7R7I8
    H7R7L8
    H7R7Z8
    H7S3A8
    H7S3I8
    H7S3L8
    H7S3R8
    H7S3V8
    H7S3Z8
    H7S7A8
    H7S7I8
    H7S7L8
    H7S7Z8
)
list(APPEND STM32_ALL_DEVICES STM32_H7_DEVICES)

list(APPEND STM32_SUPPORTED_FAMILIES_LONG_NAME
    STM32H7_M4
    STM32H7_M7
    STM32H7RS
)

list(APPEND STM32_FETCH_FAMILIES H7 H7RS)

set(STM32H7_M7_FREERTOS_PORT ARM_CM7)
set(STM32H7_M4_FREERTOS_PORT ARM_CM4F)
set(STM32H7RS_FREERTOS_PORT ARM_CM7)

# SERIE SS1951

set(CUBE_H7_VERSION  v1.12.1)
set(CMSIS_H7_VERSION v1.10.4)
set(HAL_H7_VERSION   v1.11.3)

set(CUBE_H7RS_VERSION  v1.1.0)
set(CMSIS_H7RS_VERSION v1.1.0)
set(HAL_H7RS_VERSION   v1.1.0)
