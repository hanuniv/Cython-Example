#ifndef _SOURCE_H_
#define _SOURCE_H_

//#include<type_traits>

double* cfirst2double(double* a);

template<typename T>  //put template in header file
void cfirst2elements(T* a, T**b) {
    *b = (T*) malloc(2*sizeof(T));
    (*b)[0] = a[0];
    (*b)[1] = a[1];
}

template<typename U, typename V, typename W>
void cadd(U* a, V* b, W* c){
    *c  = *a + *b;
}

#endif