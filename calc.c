#include <stdio.h>

void addl()
{
    float numf,nums;
    printf("enter first number: ");
    scanf("%f",&numf);
    printf("enter second number: ");
    scanf("%f",&nums);
    printf("%f",numf+nums);
}

void subl()
{
    float numf,nums;
    printf("enter first number: ");
    scanf("%f",&numf);
    printf("enter second number: ");
    scanf("%f",&nums);
    printf("%f",numf-nums);
}

void mull()
{
    float numf,nums;
    printf("enter first number: ");
    scanf("%f",&numf);
    printf("enter second number: ");
    scanf("%f",&nums);
    printf("%f",numf*nums);
}

void divl()
{
    float numf,nums;
    printf("enter first number: ");
    scanf("%f",&numf);
    printf("enter second number: ");
    scanf("%f",&nums);
    printf("%f",numf/nums);
}

int main()
{
    char choice[1];
    printf("choose your option:\nadd >> +\nsubtract >> -\nmultiply >> *\ndivide >> /\n>");
    scanf("%c",&choice);
    
    switch (choice[0])
    {
        case '+':
            addl();
            break;
        case '-':
            subl();
            break;
        case '*':
            mull();
            break;
        case '/':
            divl();
            break;
        default:
            printf("wrong option");
            break;
    }
    return 0;
}
