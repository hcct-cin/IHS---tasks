
#include <linux/init.h>
#include <linux/module.h>
#include <linux/moduleparam.h>

MODULE_LICENSE("Dual BSD/GPL");
static int i = 1;
module_param(i,int,0);

static int __init hello_init(void)
{
    printk(KERN_ALERT "Hello, world\n");
    return 0;
}
static void0 __exit hello_exit(void)
{
    printk(KERN_ALERT "Goodbye, cruel world\n");
}
module_init(hello_init);
module_exit(hello_exit);