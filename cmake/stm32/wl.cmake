# Note: Can't support STM32WL33 yet because cmsis doesn't provide startup

set(STM32_WL_TYPES
#    WL33xx WL33xx
    WL54xx WL55xx WL5Mxx
    WLE4xx WLE4xx WLE4xx WLE5xx WLE5xx WLE5xx
)

set(STM32_WL_TYPE_MATCH 
#    "WL33.8" "WL33.[BC]"
    "WL54.." "WL55.." "WL5MOC"
    "WLE4.8" "WLE4.B" "WLE4.C" "WLE5.8" "WLE5.B" "WLE5.C"
)

# this is RAM size allocated to M4 core
# Note devices with 20 and 48K RAM can use only half of available RAM because 
# there are 2 split sections of RAM and our default linker script only manages 
# one section.
set(STM32_WL_M4_RAM_SIZES 
#     0K  0K
    32K 32K 32K
    10K 24K 64K 10K 24K 64K
)

# this is RAM size allocated to M0PLUS core
set(STM32_WL_M0PLUS_RAM_SIZES 
#    16K 32K
    32K 32K 32K
     0K  0K  0K  0K  0K  0K
)

set(STM32_WL_CCRAM_SIZES 
    # 0K 0K
    0K 0K 0K
    0K 0K 0K 0K 0K 0K
)

stm32_util_create_family_targets(WL M4)

target_compile_options(STM32::WL::M4 INTERFACE 
    -mcpu=cortex-m4 -mfloat-abi=soft
)
target_link_options(STM32::WL::M4 INTERFACE 
    -mcpu=cortex-m4 -mfloat-abi=soft
)

stm32_util_create_family_targets(WL M0PLUS)

target_compile_options(STM32::WL::M0PLUS INTERFACE 
    -mcpu=cortex-m0plus -mfloat-abi=soft
)
target_link_options(STM32::WL::M0PLUS INTERFACE 
    -mcpu=cortex-m0plus -mfloat-abi=soft
)

function(stm32wl_get_memory_info DEVICE TYPE CORE RAM FLASH_ORIGIN RAM_ORIGIN TWO_FLASH_BANKS)
    list(FIND STM32_WL_TYPES ${TYPE} TYPE_INDEX)
    set(INDEX 0)
    foreach(REGEXP ${STM32_WL_TYPE_MATCH})
        if(${DEVICE} MATCHES ${REGEXP})
            set(FOUND TRUE)
            set(M_INDEX ${INDEX})
        endif()
        math(EXPR INDEX "${INDEX}+1")
    endforeach()
    if(NOT ${FOUND})
        message(FATAL_ERROR "Unsupported device ${DEVICE}")
    endif()
    list(GET STM32_WL_M0PLUS_RAM_SIZES ${M_INDEX} RAM_M0PLUS_VALUE)
    list(GET STM32_WL_M4_RAM_SIZES ${M_INDEX} RAM_M4_VALUE)
    if(NOT (RAM_M0PLUS_VALUE EQUAL 0K) AND NOT (RAM_M4_VALUE EQUAL 0K))
        # dual core (WL5X)
        set(${TWO_FLASH_BANKS} TRUE PARENT_SCOPE)
        if(CORE STREQUAL "M4")
            set(${RAM} ${RAM_M4_VALUE} PARENT_SCOPE)
            set(${FLASH_ORIGIN} 0x08000000 PARENT_SCOPE)
            set(${RAM_ORIGIN} 0x20000000 PARENT_SCOPE)            
        elseif(CORE STREQUAL "M0PLUS")
            set(${RAM} ${RAM_M0PLUS_VALUE} PARENT_SCOPE)
            set(${FLASH_ORIGIN} 0x08020000 PARENT_SCOPE)
            set(${RAM_ORIGIN} 0x20008000 PARENT_SCOPE)
        else()
            message(FATAL_ERROR "Unknown core ${CORE}")
        endif()
    elseif(NOT (RAM_M0PLUS_VALUE EQUAL 0K) AND (RAM_M4_VALUE EQUAL 0K))
        # single M0+ core (WL33)
        set(${TWO_FLASH_BANKS} FALSE PARENT_SCOPE)
        if(CORE STREQUAL "M0PLUS")
            set(${RAM} ${RAM_M0PLUS_VALUE} PARENT_SCOPE)
            set(${FLASH_ORIGIN} 0x10040000 PARENT_SCOPE)
            set(${RAM_ORIGIN} 0x20000000 PARENT_SCOPE)
        else()
            message(FATAL_ERROR "Type ${TYPE} has no core ${CORE}")
        endif()
    elseif((RAM_M0PLUS_VALUE EQUAL 0K) AND NOT (RAM_M4_VALUE EQUAL 0K))
        # single M4 core (WLEX)
        set(${TWO_FLASH_BANKS} FALSE PARENT_SCOPE)
        if(CORE STREQUAL "M4")
            set(${RAM} ${RAM_M4_VALUE} PARENT_SCOPE)
            set(${FLASH_ORIGIN} 0x08000000 PARENT_SCOPE)
            set(${RAM_ORIGIN} 0x20000000 PARENT_SCOPE)
        else()
            message(FATAL_ERROR "Type ${TYPE} has no core ${CORE}")
        endif()
    else()
        message(FATAL_ERROR "Unknown core ${CORE}")
    endif()
endfunction()

function(stm32wl_get_device_cores DEVICE TYPE CORES)
    list(FIND STM32_WL_TYPES ${TYPE} TYPE_INDEX)
    list(GET STM32_WL_M0PLUS_RAM_SIZES ${TYPE_INDEX} RAM_M0PLUS_VALUE)
    list(GET STM32_WL_M4_RAM_SIZES ${TYPE_INDEX} RAM_M4_VALUE)
    if (RAM_M4_VALUE EQUAL 0K)
        set(${CORES} M0PLUS PARENT_SCOPE)
    elseif (RAM_M0PLUS_VALUE EQUAL 0K)
        set(${CORES} M4 PARENT_SCOPE)
    else()
        set(${CORES} M4 M0PLUS PARENT_SCOPE)
    endif()
endfunction()

set(STM32WL_HAL_REMOVE_ITEM STM32WL)
set(STM32WL_HAL_APPENDS STM32WL_M4 STM32WL_M0PLUS)

set(STM32_WL_DEVICES
    # WL33C8
    # WL33CB
    # WL33CC
    # WL33K8
    # WL33KB
    # WL33KC
    WL54CC
    WL54JC
    WL55CC
    WL55JC
    WL5MOC
    WLE4C8
    WLE4CB
    WLE4CC
    WLE4J8
    WLE4JB
    WLE4JC
    WLE5C8
    WLE5CB
    WLE5CC
    WLE5J8
    WLE5JB
    WLE5JC
)
list(APPEND STM32_ALL_DEVICES STM32_WL_DEVICES)

list(APPEND STM32_SUPPORTED_FAMILIES_LONG_NAME
    STM32WL_M0PLUS
    STM32WL_M4
)

list(APPEND STM32_FETCH_FAMILIES WL)

# SERIE SS2026

set(CUBE_WL_VERSION  v1.3.0)
set(CMSIS_WL_VERSION v1.2.0)
set(HAL_WL_VERSION   v1.3.0)
