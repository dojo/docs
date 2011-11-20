.. _dojox/secure/capability:

dojox.secure.capability
=======================

:Status: Draft
:Version: 1.0
:Authors: Kris Zyp
:Developers: Kris Zyp
:Available: since V1.2

.. contents::
   :depth: 2

Allows you to pass in the text of a script. If it passes and it can be eval'ed, it should be safe. Note that this does not do full syntax checking, it relies on eval to reject invalid scripts. There are also known false rejections:

* Nesting vars inside blocks will not declare the variable for the outer block

* Named functions are not treated as declaration so they are generally not allowed unless the name is declared with a var.	

* Var declaration that involve multiple comma delimited variable assignments are not accepted


DojoX Secure is described in more detail here: http://www.sitepen.com/blog/2008/08/01/secure-mashups-with-dojoxsecure/
