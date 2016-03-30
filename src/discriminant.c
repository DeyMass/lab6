#include <stdio.h>
#include <math.h>
#include "discriminant.h"

double discriminant(double a, double b, double c)
{
	double d;
	d = pow(b, 2) - 4 * a * c;
	return d;
}
