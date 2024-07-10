set(STM32_WB0_TYPES
    WB05 WB06 WB07 WB09
)

set(STM32_WB0_TYPE_MATCH
    "WB05.." "WB06.." "WB07.." "WB09.."
)

set(STM32_WB0_RAM_SIZES
    24K 32K 64K 64K
)

set(STM32_WB0_CCRAM_SIZES 
    0K 0K 0K 0K
)

stm32_util_create_family_targets(WB0)

target_compile_options(STM32::WB0 INTERFACE 
    -mcpu=cortex-m0plus
)
target_link_options(STM32::WB0 INTERFACE 
    -mcpu=cortex-m0plus
)

set(STM32_WB0_DEVICES
    # WB05KN
    WB05KZ
    # WB05TN
    WB05TZ
    WB06CC
    WB06KC
    WB07CC
    WB07KC
    WB09KE
    WB09TE
)
list(APPEND STM32_ALL_DEVICES STM32_WB0_DEVICES)

list(APPEND STM32_SUPPORTED_FAMILIES_LONG_NAME
    STM32WB0
)

list(APPEND STM32_FETCH_FAMILIES WB0)

set(HAL_WB0_URL https://github.com/STMicroelectronics/stm32wb0x_hal_driver)

set(CUBE_WB0_VERSION  v1.0.0)
set(CMSIS_WB0_VERSION v1.0.0)
set(HAL_WB0_VERSION   v1.0.0)
