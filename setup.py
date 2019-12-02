# -*- coding: utf-8 -*-
"""
Created on Wed Aug 12 02:54:31 2015

@author: Han
"""

from distutils.core import setup,Extension
from Cython.Build import cythonize
from numpy import get_include

ext = Extension(name = 'wrapper',
                sources = ['source.cpp','wrapper.pyx'],
                include_dirs=['.',get_include()],
                language='c++')

setup(
    name = "pyname", #it is optional, does not affect package name
    ext_modules = cythonize([ext])
)

setup(
    name = "pyname", #it is optional, does not affect package name
    ext_modules = cythonize(['complextype.pyx'], language = 'c++')
)
'''
in console use 
 %%cmd
python setup.py build_ext --inplace [--compiler=mingw32 /or msvc ]

or

%%cmd 
python setup.py build_ext -i [--compiler=mingw32 /or msvc ]

then there would generate a .pyd file, which is ready for import



Note: 
compile on-the-fly way

>>>import pyximport
>>>pyximport.install()
and use module wrapper the same as a python module

is not applicable for modules that include additional c-files.
The methos is useful for pure .pyx module written in cython
'''