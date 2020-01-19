#include <stdio.h>
#include <stdint.h>
#include <ctime>
#include <cstring>
using namespace std;

extern "C" double main_asm();

int main(int argc, const char* argv[]) {
	printf("Driver program starts main asm function.\n");
	double return_code = -99;
	return_code = main_asm();
	printf("\n%s %lf", "Driver received number:", return_code);
	printf("\n\nDriver return 0 to the OS.  Bye.\n");

	return 0;
}
