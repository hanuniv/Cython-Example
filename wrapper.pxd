cdef extern from "declarations.h":  # cannot be source.c, otherwise lead to multiple definition
    double* cfirst2double(double* a)
    void cfirst2elements[T](T* a, T**b)

