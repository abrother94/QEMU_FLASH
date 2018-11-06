#include<stdio.h>
#include<stdlib.h>

int main(int argc, char *argv[])
{
	int numarray[10] = {1,2,3,4,5,6,7,8,9,0};
	char charray[] = {'a', 'b', 'c', 'd', '\0'};
	printf("charray address[%p]\r\n", charray);
	int GG = (int)charray;
	printf("GG=[%s]\r\n",(char *)GG);

	char name[]     = "efgh";
	char * DD = charray;
	char * pName = NULL;

	pName = realloc(pName, 12);
	if(pName != NULL)
	{
		sprintf(pName,"nick_huang");
		printf("name=[%s]\r\n", pName);
		free(pName);
	}

	

	printf("printf of DD[%s]\r\n", DD);
	printf("sizeof(int)=[%d]\r\n", sizeof(int));
	printf("sizeof(long)=[%d]\r\n", sizeof(long));
	printf("sizeof(char)=[%d]\r\n", sizeof(char));
	printf("sizeof(numarray)=[%d]\r\n", sizeof(numarray));
	printf("number of numarray=[%d]\r\n", sizeof(numarray)/sizeof(int));
	printf("sizeof(charray)=[%d]\r\n", sizeof(charray));
	printf("sizeof(name)=[%d]\r\n", sizeof(name));
	//numarray[12]=100;  //<<=== This will effect following 
	printf("charray[%s]\r\n", charray); 
	printf("name[%s]\r\n", name); 
	name[2]='8';
	printf("name[%s]\r\n", name); 
	numarray[1] = '1';

	charray[0] = 'a';
	charray[1] = 'a';
	charray[2] = 'a';
	charray[3] = '\0';



	return 0;
}
