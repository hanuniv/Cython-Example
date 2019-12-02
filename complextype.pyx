# -*- coding: utf-8 -*-
"""
Created on Tue Aug 18 17:18:14 2015

@author: Han

compare complex type
"""

cimport cython

cdef extern from 'declarations.h':
    void cadd[U,V,W](U* a, V* b, W*c);

ctypedef double complex complex128
ctypedef fused T:
    double
    complex
    #cython.complex    #following all the same as complex
    #complex128
    #cython.doublecomplex

ctypedef fused U:
    double
    complex

ctypedef fused V:
    double
    complex

cdef f(T x):
    print('------------------')
    if T is double:
        print('double')
    if T is complex:
        print('complex')
    if T is complex128:
        print('complex128')
    if T is cython.doublecomplex:
        print('cython.doublecomplex')
    if T is cython.complex:
        print('cython.complex')

cdef add(U a,V b):
    if U is double:
        print('complex')
    if V is complex:
        print('double')
    cdef complex c;
    cadd(&a, &b, &c)
    return c


def Test():
    cdef:
        double a = 1
        complex b = 1 + 1j
        double complex c = 1+1j
        cython.doublecomplex d = 1+1j
        cython.complex e = 1+1j
    f(a)
    f(b)
    f(c)
    f(d)
    f(e)

def Test2():
    cdef:
        double a = 1
        complex b = 2 + 3j
    print(add(a,b))

#Output:
#------------------
#double
#------------------
#complex
#complex128
#cython.doublecomplex
#cython.complex
#------------------
#complex
#complex128
#cython.doublecomplex
#cython.complex
#------------------
#complex
#complex128
#cython.doublecomplex
#cython.complex
#------------------
#complex
#complex128
#cython.doublecomplex
#cython.complex
