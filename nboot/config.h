#define CONFIG_ENV_SIZE            8192
#define CONFIG_SYS_MALLOC_LEN      (CONFIG_ENV_SIZE + 128*1024)
#define CONFIG_SYS_GBL_DATA_SIZE   128
#define CONFIG_STACKSIZE           (128*1024)  /* regular stack */
#define CONFIG_STACKSIZE_IRQ       (4*1024)    /* IRQ stack */
#define CONFIG_STACKSIZE_FIQ       (4*1024)    /* FIQ stack */
