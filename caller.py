# -*- coding: utf-8 -*-
"""
Created on Mon Aug 10 12:12:23 2015

@author: Han
"""

import numpy as np

from wrapper import first2double, first2elements,first2elements_contiguous,first2elements_contiguous_2d

a = np.array([1+1j,2+2j,3+3j, 4+4j], dtype = np.complex128)
b = np.array([-1,-2,-3,-4], dtype = np.double)

first2double(a)      #actually the real and image part of first element
first2double(a[::2]) #same as above, because no contiguity check
first2double(b)      #correct
first2double(b[::2]) #same as above, because no contiguity check

print('--------------------')

first2elements(a)      #correct
first2elements(a[::2]) #same as above, because no contiguity check
first2elements(b)      #correct
first2elements(b[::2]) #same as above, because no contiguity check

print('--------------------')

first2elements_contiguous(a)      #correct
first2elements_contiguous(a[::2]) #correct
first2elements_contiguous(b)      #correct
first2elements_contiguous(b[::2]) #correct

print('----------------------')

a = np.array([[1+1j,2+2j],[3+3j, 4+4j],[5+5j,6+6j]], dtype = np.complex128)
b = np.array([[-1,-2],[-3,-4],[-5,-6]], dtype = np.double)

first2elements_contiguous_2d(a)      #correct
first2elements_contiguous_2d(a[::2]) #correct
first2elements_contiguous(a[:,0])    #correct
first2elements_contiguous_2d(a[:,0:1])#correct
first2elements_contiguous_2d(a[::2,0:1])#correct

first2elements_contiguous_2d(b)      #correct
first2elements_contiguous_2d(b[::2]) #correct
first2elements_contiguous(b[:,0])    #correct
first2elements_contiguous_2d(b[:,0:1])#correct
first2elements_contiguous_2d(b[::2,0:1])#correct