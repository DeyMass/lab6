#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <solve.h>

int main()
{
	double a, b, c, x1, x2;
	short int fl;
	printf("Enter a, b, c: ");
	scanf("%lf %lf %lf", &a, &b, &c);
	if (a == 0)
		printf("\n No roots!");
	else
		fl = solve(a, b, c, &x1, &x2);
	if (fl == 0)
		printf("\n No real roots!\n ");
	if (fl == 1)
		printf("Only one root: x = %4.2f\n", x1);
	if (fl == 2)
		printf("Two roots: \n x1 = %4.2f\n x2 = %4.2f\n", x1, x2);
	return 0;
}
