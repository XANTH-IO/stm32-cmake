set(STM32_C0_TYPES 
    C011xx
    C031xx
    C071xx
)
set(STM32_C0_TYPE_MATCH 
    "C011.[46]"
    "C031.[46]"
    "C071.[8B]"
)
set(STM32_C0_RAM_SIZES 
     6K
    12K
    24K
)
set(STM32_C0_CCRAM_SIZES 
     0K
     0K
     0K
)

stm32_util_create_family_targets(C0)

target_compile_options(STM32::C0 INTERFACE 
    -mcpu=cortex-m0plus
)
target_link_options(STM32::C0 INTERFACE 
    -mcpu=cortex-m0plus
)

set(STM32_C0_DEVICES
    C011D6
    C011F4
    C011F6
    C011J4
    C011J6
    C031C4
    C031C6
    C031F4
    C031F6
    C031G4
    C031G6
    C031K4
    C031K6
    C071C8
    C071CB
    C071F8
    C071FB
    C071G8
    C071GB
    C071K8
    C071KB
    C071R8
    C071RB
)
list(APPEND STM32_ALL_DEVICES STM32_C0_DEVICES)

list(APPEND STM32_SUPPORTED_FAMILIES_LONG_NAME
    STM32C0
)

list(APPEND STM32_FETCH_FAMILIES C0)

# SERIE SS2200

set(CUBE_C0_VERSION  v1.4.0)
set(CMSIS_C0_VERSION v1.2.0)
set(HAL_C0_VERSION   v1.2.0)
