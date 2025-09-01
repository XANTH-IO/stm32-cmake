set(STM32_N6_TYPES 
    N645xx
    N647xx
    N655xx
    N657xx
)
set(STM32_N6_TYPE_MATCH
    "N645.0"
    "N647.0" 
    "N655.0"
    "N657.0"
)
set(STM32_N6_RAM_SIZES 
    4200K
    4200K
    4200K
    4200K
)
set(STM32_N6_CCRAM_SIZES 
    0K
    0K
    0K
    0K
)

stm32_util_create_family_targets(N6)

target_compile_options(STM32::N6 INTERFACE 
    -mcpu=cortex-m55
)
target_link_options(STM32::N6 INTERFACE 
    -mcpu=cortex-m55
)

set(STM32_N6_DEVICES
    N645A0
    N645B0
    N645I0
    N645L0
    N645X0
    N645Z0
    N647A0
    N647B0
    N647I0
    N647L0
    N647X0
    N647Z0
    N655A0
    N655B0
    N655I0
    N655L0
    N655X0
    N655Z0
    N657A0
    N657B0
    N657I0
    N657L0
    N657X0
    N657Z0
)
list(APPEND STM32_ALL_DEVICES STM32_N6_DEVICES)

list(APPEND STM32_SUPPORTED_FAMILIES_LONG_NAME
    STM32N6
)

list(APPEND STM32_FETCH_FAMILIES N6)

# SERIE SS2328

set(CUBE_N6_VERSION  v1.2.0)
set(CMSIS_N6_VERSION v1.2.0)
set(HAL_N6_VERSION   v1.2.0)
