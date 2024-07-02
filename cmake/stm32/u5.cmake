set(STM32_U5_TYPES 
    U575xx U585xx
)
set(STM32_U5_TYPE_MATCH 
   "U575.." "U585.."
)

set(STM32_U5_RAM_SIZES 
    768K 768K
)

stm32_util_create_family_targets(U5)

target_compile_options(STM32::U5 INTERFACE 
    -mcpu=cortex-m33 -mfpu=fpv5-sp-d16 -mfloat-abi=hard
)
target_link_options(STM32::U5 INTERFACE 
    -mcpu=cortex-m33 -mfpu=fpv5-sp-d16 -mfloat-abi=hard
)

list(APPEND STM32_ALL_DEVICES
    U535CB
    U535CC
    U535CE
    U535JE
    U535NC
    U535NE
    U535RB
    U535RC
    U535RE
    U535VC
    U535VE
    U545CE
    U545JE
    U545NE
    U545RE
    U545VE
    U5750G
    U5750I
    U575AG
    U575AI
    U575CG
    U575CI
    U575OG
    U575OI
    U575QG
    U575QI
    U575RG
    U575RI
    U575VG
    U575VI
    U575ZG
    U575ZI
    U5850I
    U585AI
    U585CI
    U585OI
    U585QI
    U585RI
    U585VI
    U585ZI
    U595AI
    U595AJ
    U595QI
    U595QJ
    U595RI
    U595RJ
    U595VI
    U595VJ
    U595ZI
    U595ZJ
    U599BJ
    U599NI
    U599NJ
    U599VI
    U599VJ
    U599ZI
    U599ZJ
    U5A5AJ
    U5A5QI
    U5A5QJ
    U5A5RJ
    U5A5VJ
    U5A5ZJ
    U5A9BJ
    U5A9NJ
    U5A9VJ
    U5A9ZJ
    U5F7VJ
    U5F9BJ
    U5F9NJ
    U5F9VJ
    U5F9ZJ
    U5G7VJ
    U5G9BJ
    U5G9NJ
    U5G9VJ
    U5G9ZJ
)

list(APPEND STM32_SUPPORTED_FAMILIES_LONG_NAME
    STM32U5
)

list(APPEND STM32_FETCH_FAMILIES U5)

set(CUBE_U5_VERSION  v1.5.0)
set(CMSIS_U5_VERSION v1.4.0)
set(HAL_U5_VERSION   v1.5.0)
