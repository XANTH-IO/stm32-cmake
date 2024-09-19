set(STM32_MP2_TYPES 
    MP251Axx MP251Cxx MP251Dxx MP251Fxx
    MP253Axx MP253Cxx MP253Dxx MP253Fxx
    MP255Axx MP255Cxx MP255Dxx MP255Fxx
    MP257Axx MP257Cxx MP257Dxx MP257Fxx
)

set(STM32_MP2_TYPE_MATCH
    "MP251A" "MP251C" "MP251D" "MP251F"  
    "MP253A" "MP253C" "MP253D" "MP253F"
    "MP255A" "MP255C" "MP255D" "MP255F"
    "MP257A" "MP257C" "MP257D" "MP257F"
)

set(STM32_MP2_RAM_SIZES
    0K       0K       0K       0K
    0K       0K       0K       0K
    0K       0K       0K       0K
    0K       0K       0K       0K
)

set(STM32_MP2_CCRAM_SIZES
    0K       0K       0K       0K
    0K       0K       0K       0K
    0K       0K       0K       0K
    0K       0K       0K       0K
)

stm32_util_create_family_targets(MP2 M33)

target_compile_options(STM32::MP2::M33 INTERFACE -mcpu=cortex-m33 -mfpu=fpv5-sp-d16 -mfloat-abi=hard)
target_link_options(STM32::MP2::M33 INTERFACE -mcpu=cortex-m33 -mfpu=fpv5-sp-d16 -mfloat-abi=hard)
target_compile_definitions(STM32::MP2::M33 INTERFACE CORE_CM33)

function(stm32mp2_get_device_cores CORES)
    set(${CORES} "M33" PARENT_SCOPE)
endfunction()

function(stm32mp2_get_memory_info DEVICE TYPE FLASH_SIZE RAM_SIZE)
    if(FLASH_SIZE)
        set(${FLASH_SIZE} "0KB" PARENT_SCOPE)
    endif()
endfunction()

function(stm32mp2_get_ld_filename DEVICE FILENAME)
    if(FILENAME)
        set(${FILENAME} "stm32mp2xx_DDR_m33_ns.ld" PARENT_SCOPE)
    endif()
endfunction()

set(STM32MP2_FIND_REMOVE_ITEM STM32MP2)
set(STM32MP2_FIND_APPENDS STM32MP2_M33)

set(STM32_MP2_DEVICES
    MP251A
    MP251C
    MP251D
    MP251F
    MP253A
    MP253C
    MP253D
    MP253F
    MP255A
    MP255C
    MP255D
    MP255F
    MP257A
    MP257C
    MP257D
    MP257F
)
list(APPEND STM32_ALL_DEVICES STM32MP2_DEVICES)

list(APPEND STM32_SUPPORTED_FAMILIES_LONG_NAME
    STM32MP2_M33
)

list(APPEND STM32_FETCH_FAMILIES MP2)

set(STM32MP2_HAL_TEST_DEVICE MP257C)

set(STM32MP2_M4_FREERTOS_PORT ARM_CM33)

# SERIE SS2315

set(CUBE_MP2_VERSION  v1.0.0)
set(CMSIS_MP2_VERSION cube)
set(HAL_MP2_VERSION   cube)
