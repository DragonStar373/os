#include <stdio.h>
#include <stdbool.h>
int main()
{
	char foxPut[64];
	bool entrance = true;
	while(entrance){
		printf(">:");
		scanf("%s", foxPut);
		if(foxPut == "exit"){
			printf("Goodbye");
			entrance = false;
		}
	}



}

