#include <ctest.h>
#include <discriminant.h>
#include <solve.h>

CTEST(distance_suite, ONE_ROOTS)
{
	int ma;
	const double a = 1;
	const double b = -2;
	const double c = 1;
	const double x1,x2;

	const double distance = solve(a, b, c, &x1, &x2);

	const double expected_d = 1;

	ASSERT_DBL_NEAR(expected_d,distance);
}

CTEST(distance_suite, TWO_ROOTS)
{
	const double a = 2;
	const double b = -3;
	const double c = 1;
	const double x1,x2;

	const double distance = solve(a, b, c, &x1, &x2);

	const double expected_d = 2;

	ASSERT_DBL_NEAR(expected_d,distance);
}
