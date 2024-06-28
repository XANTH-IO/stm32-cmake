set(STM32_WB_TYPES 
    WB55xx WB55xx WB35xx WB15xx WB50xx WB30xx WB10xx WB5Mxx
)
set(STM32_WB_TYPE_MATCH 
    "WB10CC" "WB30CE" "WB50CG"
    "WB15CC" "WB35C." "WB55.C" "WB55.[EGY]"
    "WB1MMC" "WB5MMG"
)

# this is not full RAM of the chip but only the part allocated to M4 core (SRAM1 in datasheet)
set(STM32_WB_RAM_SIZES 
     12K  32K  64K
     12K  32K  64K 192K
     12K 192K
)

# WB series need special area for SRAM2 shared with core M0PLUS
set(STM32_WB_RAM_SHARE_SIZES 
     10K  10K  10K
     10K  10K  10K  10K
     10K  10K
)

set(STM32_WB_CCRAM_SIZES 
      0K   0K   0K
      0K   0K   0K   0K
      0K   0K
)

stm32_util_create_family_targets(WB M4)

target_compile_options(STM32::WB::M4 INTERFACE 
    -mcpu=cortex-m4 -mfpu=fpv5-sp-d16 -mfloat-abi=hard
)
target_link_options(STM32::WB::M4 INTERFACE 
    -mcpu=cortex-m4 -mfpu=fpv5-sp-d16 -mfloat-abi=hard
)

function(stm32wb_get_memory_info DEVICE TYPE CORE FLASH_SIZE RAM RAM_ORIGIN TWO_FLASH_BANKS)
    set(${TWO_FLASH_BANKS} TRUE PARENT_SCOPE)
    list(FIND STM32_WB_TYPES ${TYPE} TYPE_INDEX)
    list(GET STM32_WB_RAM_SIZES ${TYPE_INDEX} RAM_VALUE)
    set(${RAM} "${RAM_VALUE}-4" PARENT_SCOPE)
    set(${RAM_ORIGIN} 0x20000004 PARENT_SCOPE)
    if(TYPE STREQUAL "WB1MMC")
        set(${FLASH_SIZE} "320K" PARENT_SCOPE)
    endif()
endfunction()

list(APPEND STM32_ALL_DEVICES
    WB10CC
    WB15CC
    WB1MMC
    WB30CE
    WB35CC
    WB35CE
    WB50CG
    WB55CC
    WB55CE
    WB55CG
    WB55RC
    WB55RE
    WB55RG
    WB55VC
    WB55VE
    WB55VG
    WB55VY
    WB5MMG
)

list(APPEND STM32_SUPPORTED_FAMILIES_LONG_NAME
    STM32WB_M4
)

list(APPEND STM32_FETCH_FAMILIES WB)

set(CUBE_WB_VERSION  v1.19.1)
set(CMSIS_WB_VERSION v1.12.1)
set(HAL_WB_VERSION   v1.14.2)
