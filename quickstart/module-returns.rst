#format dojo_rst

AMD Module Returns
==================

.. contents::
  :depth: 2

This page documents the new locations for Dojo methods, that have traditionally been accessed through the Dojo base object, which are now available as separate modules. As part of the move to full AMD support, in 1.7 and beyond, Dojo's base modules need to be explicitly given as individually module dependencies.

Each section below corresponds to a single AMD module, listing the methods returned along with their pre-AMD location.

==========
Dojo Base
==========

dojo.forEach 
-------------

 `New Location`: 
   dojo/base/_array
  
 `Method Syntax`: 
   array.forEach

dojo.map 
-------------

 `New Location`: 
   dojo/base/_array
  
 `Module Syntax`: 
   array.map

dojo.filter 
-------------

 `New Location`: 
   dojo/base/_array
  
 `Module Syntax`: 
   array.filter

dojo.every 
-------------

 `New Location`: 
   dojo/base/_array
  
 `Module Syntax`: 
   array.every

dojo.some 
-------------

 `New Location`: 
   dojo/base/_array
  
 `Module Syntax`: 
   array.some
