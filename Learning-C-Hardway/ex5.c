#include<stdio.h>

int main(int argc, char *argv[])
{
	int age=10;
	float heigh=50.01;
	char A = 'A';
	char * name = "Nick_huang";
	printf("My age is %d\r\n", age);
	printf("My heigh is %f\r\n", heigh);
	printf("Char = [%c] string[%s]\r\n", A, name);
	printf("empty string[%s]\r\n", "");
	printf("&name [%p]\r\n", name);
	char * address = NULL;
	*address = 1;
	return 0;
}
