//#include"filename.h" -- for local headers
//#include<filenaem.h> -- for if its in standard c library
#include<stdio.h>

int func()
{
	printf("func");
	int bob = 4;
	return bob;
}

int main()
{
	int a=2;
	int b=3;
	printf("Hello World!");
	printf("%d",a); // %d/%i is used for decimal integer, %f for float, %s for string, %c for character
	scanf("$d",&a); // store data(<datatype expected>, &<variable to save to>)
	if(a==6 && a==9)
	{
		printf("this cannot be run");
	}
	else
	{
		printf("this will be executed");
	}
	while(a!=b)
	{
		break;
	}
	for(int  i=0;i<=3;i++)
	{
		printf("%d",i);
	}
	int got_from_function = func();

}


