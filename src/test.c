#include <stdlib.h>
#include <stdio.h>
#include <string.h>


void B()
{
unsigned long count = 100000000;	
	while(count != 0)
	{
		count--;
		;	
	}
}

void A()
{
	B();
}

int main(int argc, char * argv[])
{
	printf("test\r\n");
	A();
	printf("test over\r\n");
	return 0;
}

