#include <stdio.h>
#include <stdint.h>
#include <ctime>
#include <cstring>
#include <vector>
using namespace std;

extern "C" void sort_func(double* [], long int);

void sort_func(double* plist[], long int size) {

	int o_count, i_count;
   bool swp;
   for (o_count = 0; o_count < size-1; o_count++) {
     swp = false;
     for (i_count = 0; i_count < size-o_count-1; i_count++) {
        if ((*plist[i_count]) > (*plist[i_count + 1])) {
           swap(plist[i_count], plist[i_count + 1]);
           swp = true;
        }
     }
     // If no two elements swapped by inner loop => break
     if (swp == false)
        break;
   }
}
