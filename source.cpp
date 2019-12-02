#include <stdio.h>
#include <stdlib.h>
#include "declarations.h"

double* cfirst2double(double* a) {
    double * s = (double*) malloc(2*sizeof(double));
    s[0] = a[0];
    s[1] = a[1];
    return s;
}

