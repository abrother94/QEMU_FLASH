#include<stdio.h>
#include<stdlib.h>
#include<assert.h>

struct person 
{
	char * name;
	int age;
	int height;
	int weight;
};


struct  person * create_a_person(char *name, int age, int height, int weight);
void printfPerson(struct person * pPerson);
void freePerson(struct person * pPerson);

struct  person * create_a_person(char *name, int age, int height, int weight)
{
	struct person *pPerson = malloc(sizeof(struct person));
	assert(pPerson != NULL);
	pPerson->name = strdup(name);
	pPerson->age = age;
	pPerson->height = height;
	pPerson->weight = weight;
	return pPerson;
}

void printfPerson(struct person * pPerson)
{
	printf("name[%s]\r\n", pPerson->name);
	printf("age[%d]\r\n", pPerson->age);
	printf("height[%d]\r\n", pPerson->height);
	printf("weight[%d]\r\n", pPerson->weight);
	return;
}

void freePerson(struct person * pPerson)
{
	assert(pPerson != NULL);
	assert(pPerson->name != NULL);	

	free(pPerson->name);
	free(pPerson);
	return;
}


int main(int argc, char *argv[])
{

	struct person * pJone,* pJoe;
	pJone=create_a_person("Jone", 10, 11, 12);
	pJoe=create_a_person("Joe", 13, 14, 15);
	printfPerson(pJone);
	printfPerson(pJoe);
	freePerson(pJone);
	freePerson(pJoe);
	
	return 0;
}
