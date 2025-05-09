set(STM32_MP1_TYPES 
    MP151Axx MP151Cxx
    MP153Axx MP153Cxx 
    MP157Axx MP157Cxx)

set(STM32_MP1_TYPE_MATCH
    "MP151[AD](A.?)?" "MP151[CF](A.?)?"  
    "MP153[AD](A.?)?" "MP153[CF](A.?)?"
    "MP157[AD](A.?)?" "MP157[CF](A.?)?")

set(STM32_MP1_RAM_SIZES
    384K 384K
    384K 384K
    384K 384K)

set(STM32_MP1_CCRAM_SIZES
    0K 0K
    0K 0K
    0K 0K)

stm32_util_create_family_targets(MP1 M4)

target_compile_options(STM32::MP1::M4 INTERFACE -mcpu=cortex-m4 -mfpu=fpv4-sp-d16 -mfloat-abi=hard)
target_link_options(STM32::MP1::M4 INTERFACE -mcpu=cortex-m4 -mfpu=fpv4-sp-d16 -mfloat-abi=hard)
target_compile_definitions(STM32::MP1::M4 INTERFACE CORE_CM4)

function(stm32mp1_get_device_cores CORES)
    set(${CORES} "M4" PARENT_SCOPE)
endfunction()

function(stm32mp1_get_memory_info DEVICE TYPE FLASH_SIZE RAM_SIZE)
    if(FLASH_SIZE)
        set(${FLASH_SIZE} "0KB" PARENT_SCOPE)
    endif()
endfunction()

function(stm32mp1_get_ld_filename DEVICE FILENAME)
    if(FILENAME)
        set(${FILENAME} "stm32mp15xx_m4.ld" PARENT_SCOPE)
    endif()
endfunction()

set(STM32MP1_FIND_REMOVE_ITEM STM32MP1)
set(STM32MP1_FIND_APPENDS STM32MP1_M4)

set(STM32_MP1_DEVICES
    # MP131A this devices has not cortex M core
    # MP131C this devices has not cortex M core
    # MP131D this devices has not cortex M core
    # MP131F this devices has not cortex M core
    # MP133A this devices has not cortex M core
    # MP133C this devices has not cortex M core
    # MP133D this devices has not cortex M core
    # MP133F this devices has not cortex M core
    # MP135A this devices has not cortex M core
    # MP135C this devices has not cortex M core
    # MP135D this devices has not cortex M core
    # MP135F this devices has not cortex M core
    MP151A
    MP151C
    MP151D
    MP151F
    MP153A
    MP153C
    MP153D
    MP153F
    MP157A
    MP157C
    MP157D
    MP157F
)
list(APPEND STM32_ALL_DEVICES STM32_MP1_DEVICES)

list(APPEND STM32_SUPPORTED_FAMILIES_LONG_NAME
    STM32MP1_M4
)

list(APPEND STM32_FETCH_FAMILIES MP1)

set(STM32MP1_M4_FREERTOS_PORT ARM_CM4F)

# SERIE SS2003

set(CUBE_MP1_VERSION  1.7.0)
set(CMSIS_MP1_VERSION cube)
set(HAL_MP1_VERSION   cube)
