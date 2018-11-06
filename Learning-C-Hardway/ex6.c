#include<stdio.h>

int main(int argc, char *argv[])
{
	char NN = '\0';
	int bugs=100;
	float bug_rate=10.01, expected_bugs , part_of_universe;
	expected_bugs = bug_rate * bugs;	
	//long universal_defects = 1L * 1024L * 1024L * 1024L;
	unsigned long universal_defects = 4294967294u; 
	//long ununiversal_defects = 1L * 1024L * 1024L * 1024L;

	printf("long value is [%lu]\r\n", universal_defects);
	printf("sizeof long is [%d]\r\n", sizeof(universal_defects));

	part_of_universe = expected_bugs / universal_defects;

	printf("You have %d bugs, bug rate is %f.\r\n", bugs, bug_rate);
	printf("Universal defects are %ld.\r\n", universal_defects);
	printf("You are expected have bug  %f.\r\n", expected_bugs );
	printf("This is  only portion of %e.\r\n", part_of_universe);
	printf("[%f]\r\n", part_of_universe* NN);


	return 0;
}
