#include <stdlib.h>
#include <stdio.h>
#include <string.h>


typedef int bool;
typedef int (*fcmp)(int a, int b, bool type);

int cmp(int a, int b, bool type)
{
//type == 1 from larger to smaller
//type == 0 from smaller to larger 
	if( a < b )
		return type;
	else 
		return !type;		
}



void swap(int a[], int b[])
{
	int tmp;
	tmp = *a;
	*a  = *b;
	*b  = tmp;
	return;
}

void bubble_sort(int * pArray,int count,  fcmp cmp, bool type)
{
	int i=0, j=0; 

	for(i = 0; i < count-1; i++)
	{
		for(j = 0; j < count-1; j++)
		{
			if(cmp(pArray[j], pArray[j+1], type))
				swap(pArray+j, pArray+j+1);
		}
	}
}

int main(int argc, char * argv[])
{
	int count = argc -1, i =0;
	int *pArray = NULL;
	pArray = malloc(count*sizeof(int));

	for(i=0; i < count; i++)
	{
		pArray[i]=atoi(argv[i+1]);
		printf("B [%d]\r\n", pArray[i]);
	}

	bubble_sort(pArray, count,  cmp, 1);

	for(i=0; i < count; i++)
	{
		printf("A [%d]\r\n", pArray[i]);
	}

	bubble_sort(pArray, count,  cmp, 0);

	for(i=0; i < count; i++)
	{
		printf("A2 [%d]\r\n", pArray[i]);
	}

	return 0;
}

