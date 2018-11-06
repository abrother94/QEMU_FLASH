#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>

#define MAX_DATA 512
#define MAX_ROWS  3 

struct Address
{
	int id;
	int is_set;
	char name[MAX_DATA];
	char email[MAX_DATA];
};

struct Database
{
	struct Address rows[MAX_ROWS];
}; 

struct Connection
{
	FILE *pfile;
	struct Database *pdata;
};


void Database_print(struct Address *paddr);

void Database_Load(struct Connection *pCon)
{
	fread(pCon->pdata, sizeof(struct Database), 1,  pCon->pfile);
}

void Database_Create(struct Connection *pCon)
{
	int i = 0;

	//init all data
	for(i = 0; i < MAX_ROWS; i++)
	{
		struct Address address = {.id=i, .is_set=0, .name="xxxx", .email="oooo"};
		pCon->pdata->rows[i] = address;
	}
}

void Database_Write(struct Connection *pCon)
{
	rewind(pCon->pfile);
	fwrite(pCon->pdata, sizeof(struct Database), 1,  pCon->pfile);
	fflush(pCon->pfile);
}

void Database_Set(struct Connection *pCon, int id, char * name, char * email)
{
	struct Address *paddr = &pCon->pdata->rows[id];
	paddr->is_set = 1;
	strncpy(paddr->name, name, MAX_DATA );
	strncpy(paddr->email, email, MAX_DATA);
}


void Database_del(struct Connection *pCon, int id)
{
	struct Address addr = {.id=id, .is_set=0}; 
	pCon->pdata->rows[id] = addr;
}

void Database_Get(struct Connection *pCon, int id)
{
	struct Address addr =  pCon->pdata->rows[id];
	Database_print(&addr);
}

struct Connection * Database_Open(char * pfilename, char mode)
{
	struct Connection * pCon = malloc(sizeof(struct Connection));
	assert(pCon != NULL);

	pCon->pdata = malloc(sizeof(struct Database));

	if(mode == 'c')
	{
		pCon->pfile = fopen(pfilename, "w"); 
	} 
	else
	{
		pCon->pfile = fopen(pfilename, "r+"); 
		Database_Load(pCon);
	}
	return pCon;
}


void Database_print(struct Address *paddr)
{
	printf("id[%d] name[%s] email[%s]\r\n", paddr->id, paddr->name, paddr->email);
}

void Database_List(struct Connection *pCon)
{
	int i = 0;
	struct Address *paddr = NULL;

	for(i = 0; i < MAX_ROWS; i++)
	{
		paddr = &pCon->pdata->rows[i];

		if( paddr->is_set)
			Database_print(paddr);

	}

	return;
}

void Database_close(struct Connection *pCon)
{
	if(pCon != NULL)
		if(pCon->pdata !=0)
			free(pCon->pdata);
	fclose(pCon->pfile);
	free(pCon);
	return;
}



int main(int argc, char * argv[])
{
	struct Connection *pCon = NULL;
	char mode = argv[2][0]; 

	char *pfname = argv[1];
	pCon = Database_Open(pfname, mode);

	switch(mode)
	{
		case 'c':
			Database_Create(pCon);
			Database_Write(pCon);
			break;

		case 'l':
			Database_List(pCon);	
			break;
		case 's':
			printf("id[%d]name[%s]emai[%s]\r\n",atoi(argv[3]), argv[4], argv[5]);
			Database_Set(pCon,atoi(argv[3]), argv[4], argv[5]);	
			Database_Write(pCon);
			break;
		case 'd':
			Database_del(pCon, atoi(argv[3]));
			Database_Write(pCon);
		break;

		case 'g':
			Database_Get(pCon, atoi(argv[3]));
		break;

		default :
			break;
	}
	Database_close(pCon);
	return 1;
}
