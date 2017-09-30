#include <stdio.h>

/**
 * Зададим две переменных, одна будет short с отрицательным значением,
 * а другая - long
 * Потом присвоим второй перевенной значение первой и посмотрим, что у неё в левых байтах
 * Если будет размножаться левый знаковый бит, то слева будет 0xffff, иначе - 0x0000
 */

int main(int argc, char const *argv[])
{
	signed short int i = 0x8000;
	signed long int k = 0;

	printf("Size of short int: %lu\n", sizeof(i));
	printf("Decimal of i: %d\n", i);
	printf("Hex value of i: %X\n", i);

	k = i;

	printf("Size of long int: %lu\n", sizeof(k));
	printf("Decimal of k: %ld\n", k);
	printf("Hex value of k: %lX\n", k);

	return 0;
}