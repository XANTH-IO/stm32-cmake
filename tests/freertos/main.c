#include <FreeRTOS.h>
#include <task.h>

static void task(void *arg)
{
    for(;;)
    {
        vTaskDelay(500);
    }
}

int main(void)
{
    
    xTaskCreate(task, "blinky", configMINIMAL_STACK_SIZE, NULL, tskIDLE_PRIORITY + 1, NULL);
    
    vTaskStartScheduler();
    for (;;);
    
    return 0;
}


void vApplicationTickHook(void)
{
}

void vApplicationIdleHook(void)
{
}

void vApplicationMallocFailedHook(void)
{
    taskDISABLE_INTERRUPTS();
    for(;;);
}

void vApplicationStackOverflowHook(TaskHandle_t pxTask, char *pcTaskName)
{
    (void) pcTaskName;
    (void) pxTask;

    taskDISABLE_INTERRUPTS();
    for(;;);
}
