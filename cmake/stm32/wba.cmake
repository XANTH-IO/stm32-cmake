set(STM32_WBA_TYPES
    WBA54xx WBA55xx
)

set(STM32_WBA_TYPE_MATCH
    "WBA54.[EG]" "WBA55.[EG]"
)

set(STM32_WBA_RAM_SIZES 
    0K 0K
)
set(STM32_WBA_CCRAM_SIZES 
    0K 0K
)

stm32_util_create_family_targets(WBA)

target_compile_options(STM32::WBA INTERFACE 
    -mcpu=cortex-m33 -mfpu=fpv5-sp-d16 -mfloat-abi=hard
)
target_link_options(STM32::WBA INTERFACE 
    -mcpu=cortex-m33 -mfpu=fpv5-sp-d16 -mfloat-abi=hard
)

function(stm32wba_get_memory_info DEVICE RAM_SIZE)
    stm32_extract_info(${DEVICE} FLASH_CODE F)

    if(F STREQUAL "E")
        set(RAM "96K")
    elseif(F STREQUAL "G")
        set(RAM "128K")
    else()
        message(FATAL_ERROR "Unable to get RAM size for ${DEVICE}.")
    endif()

    set(${RAM_SIZE} ${RAM} PARENT_SCOPE)
endfunction()

set(STM32_WBA_DEVICES
    WBA54CE
    WBA54CG
    WBA54KE
    WBA54KG
    WBA55CE
    WBA55CG
    WBA55UE
    WBA55UG
)
list(APPEND STM32_ALL_DEVICES STM32_WBA_DEVICES)

list(APPEND STM32_SUPPORTED_FAMILIES_LONG_NAME
    STM32WBA
)

list(APPEND STM32_FETCH_FAMILIES WBA)

# SERIE SS2261

set(CUBE_WBA_VERSION  v1.3.1)
set(CMSIS_WBA_VERSION v1.3.0)
set(HAL_WBA_VERSION   v1.3.0)
