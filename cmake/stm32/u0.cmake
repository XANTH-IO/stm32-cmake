set(STM32_U0_TYPES
    U031xx
    U073xx
    U083xx
)
set(STM32_U0_TYPE_MATCH 
    "U031.[468]"
    "U073.[8BC]"
    "U083.C"
)
set(STM32_U0_RAM_SIZES 
    12K
    40K
    40K
)
set(STM32_U0_CCRAM_SIZES 
     0K
     0K
     0K
)

stm32_util_create_family_targets(U0)

target_compile_options(STM32::U0 INTERFACE 
    -mcpu=cortex-m0plus
)
target_link_options(STM32::U0 INTERFACE 
    -mcpu=cortex-m0plus
)

set(STM32_U0_DEVICES
    U031C6
    U031C8
    U031F4
    U031F6
    U031F8
    U031G6
    U031G8
    U031K4
    U031K6
    U031K8
    U031R6
    U031R8
    U073C8
    U073CB
    U073CC
    U073H8
    U073HB
    U073HC
    U073K8
    U073KB
    U073KC
    U073M8
    U073MB
    U073MC
    U073R8
    U073RB
    U073RC
    U083CC
    U083HC
    U083KC
    U083MC
    U083RC
)
list(APPEND STM32_ALL_DEVICES STM32_U0_DEVICES)

list(APPEND STM32_SUPPORTED_FAMILIES_LONG_NAME
    STM32U0
)

list(APPEND STM32_FETCH_FAMILIES U0)

# SERIE SS2133

set(CUBE_U0_VERSION  v1.3.0)
set(CMSIS_U0_VERSION v1.1.0)
set(HAL_U0_VERSION   v1.1.0)
