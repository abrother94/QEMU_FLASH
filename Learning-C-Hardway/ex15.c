#include<stdio.h>
#include<stdlib.h>



int main(int argc, char *argv[])
{
	int i;
	int age[] = { 11, 12, 13, 14, 15};
	int ageA[2][6] = {{1,2,3,4,5,6},{6,7,8,9,0,6}};
	int * ppAgeA = ageA;

	char * broken_str = "aaa" " bbbb " " cccc ";
	int *ptrAge;
	char **ppName;

	char * name[] ={"Huang", "LIU", "Stanley", "KAI", "JAMES"};
	int count = (sizeof(age))/sizeof(int);

	printf("ppAgeA[2][1]=%d\r\n", *(ppAgeA+5));
	printf("sizeof AgeA[1]=%d\r\n", sizeof(ageA[1]));
	printf("broken_str[%s]\r\n", broken_str);

	int iargc = argc;
	while(iargc--)
	{
		printf("[%d] argc[%s]\r\n", iargc, argv[iargc]);

	}


	for(i = 0; i < count; i++)
	{
		printf("name:%s is %d years old\r\n", name[i], age[i]);
	}

	ptrAge = age;
	ppName = name;

	for(i = 0; i < count; i++)
	{
		printf("name:%s is %d years old\r\n", *(ppName++), *(ptrAge++));
	}

	ptrAge = age;
	ppName = name;

	for(i = 0; i < count; i++)
	{
		printf("name:%s is %d years old\r\n", ppName[i], ptrAge[i]);
	}



	return 0;
}
