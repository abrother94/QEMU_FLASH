#include<stdio.h>

int main(int argc, char *argv[])
{
	int i = 0;

	char * nameArray[] = 
	{
	"nick_huang","nick_ping","nick_dog","nick_cat"
	};

	sprintf(argv[0],"%s", nameArray[0] );

	for(i = 0; i < argc ; i++)
	{
		printf("arg[%d]=[%s]\r\n",i,  argv[i]);

	}

	int j = 4;

	for(i = 0; i < j ; i++)
	{
		printf("[%s]\r\n", nameArray[i]);

	}
	return 0;
}
