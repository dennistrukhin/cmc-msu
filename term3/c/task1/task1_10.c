#include <stdio.h>

int main()
{
	int c_or = 0;
	int c_and = 0;

	if (1 == 1 || c_or++);
	if (c_or) {
		printf("Lazy OR: Right side evaluated\n");
	} else {
		printf("Lazy OR: Right side NOT evaluated\n");
	}

	if (1 != 1 && c_and++);
	if (c_and) {
		printf("Lazy AND: Right side evaluated\n");
	} else {
		printf("Lazy AND: Right side NOT evaluated\n");
	}
	
	return 0;
}