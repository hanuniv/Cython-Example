# -*- coding: utf-8 -*-
"""
Created on Mon Aug 17 12:10:25 2015

@author: Han
"""

import numpy as np
cimport cython
from libc.stdlib cimport free


ctypedef double complex _complex128_  #give type alias because type with two word can cause error in the code
#As the test shows, using 'complex', 'cython.complex', 'cython.doublecopmlex' are the same

ctypedef fused T:
    double
    _complex128_

cdef cython.numeric[:] make_contiguous_1d(cython.numeric[:] a):
    if a.strides[0] != a.itemsize:
        print('change to contiguous')
        return a.copy()
    else:
        return a

cdef cython.numeric[:,:] make_contiguous_2d(cython.numeric[:,:] a):
    if a.strides[1] != a.itemsize or a.strides[0] != a.shape[1] * a.strides[1]:
        print('change to contiguous')
        return a.copy()
    else:
        return a

#Cython does not support function overloading, so cannot make 1d and 2d have the same name

#The following is also valid, Note that cython.numeric[...] cannot be used
#So one has to specify dimension and data type in fused type
#fused type cannot contain other fuesd type
ctypedef fused MatricesView:
    double[:]
    complex[:]
    double[:,:]
    complex[:,:]

cdef inline MatricesView make_contiguous(MatricesView a) except *:
    if a.ndim == 1:
        if a.strides[0] != a.itemsize:
            print('change to contiguous')
            return a.copy()
        else:
            return a
    elif a.ndim == 2:
        if a.strides[1] != a.itemsize or a.strides[0] != a.shape[1] * a.strides[1]:
            print('change to contiguous')
            return a.copy()
        else:
            return a
    else:
        raise NotImplementedError("make_contiguous does not support memory view with dimensions larger than 2.")


def first2double(T[:] a):
    'print first 2 elements of an double array'
    cdef:
        double[:] r = np.real(a)
        double * t = cfirst2double(&r[0])
        double[:] b = <double[:2]> t
#    print(np.asarray(r[:2])) This produces runtime error
#    t = <double*> &a[0] #this has the same effect as np.real, which gives a memory view
#    print((t[0],t[1]))
    if T is _complex128_:
        print('complex')
        print(np.asarray(b))
    if T is double:
        print(np.asarray(b))
    free(t)
    print('')

def first2elements(T[:] a):
    'print first 2 elements of an double array'
    cdef T* t
    cfirst2elements(&a[0], &t)
    cdef T[:] b = <T[:2]> t
    if T is _complex128_:
        print('complex')
        print(np.asarray(b))
    if T is double:
        print(np.asarray(b))
    free(t)
    print('')

def first2elements_contiguous(T[:] a):
    'with contiguous check'
#    if a.strides[0] != sizeof(T):
#        print('change to contiguous')
#        a = a.copy()
    #a = make_contiguous_1d(a)
    a = make_contiguous(a)
    cdef T* t
    cfirst2elements(&a[0], &t)
    cdef T[:] b = <T[:2]> t
    if T is _complex128_:
        print('complex')
        print(np.asarray(b))
    if T is double:
        print(np.asarray(b))
    free(t)
    print('')

def first2elements_contiguous_2d(T[:,:] a):
    'with contiguous check'
#    if a.strides[1] != sizeof(T) or a.strides[0] != a.shape[1] * a.strides[1]:
#        print('change to contiguous')
#        a = a.copy()
    #a = make_contiguous_2d(a)
    a = make_contiguous(a)
    cdef T* t
    cfirst2elements(&a[0,0], &t)
    cdef T[:] b = <T[:2]> t
    if T is _complex128_:
        print('complex')
        print(np.asarray(b))
    if T is double:
        print(np.asarray(b))
    free(t)
    print('')
