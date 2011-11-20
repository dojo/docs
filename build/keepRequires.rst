.. _build/keepRequires:

Dojo build system:  keepRequires
==================================

:Status: Draft
:Version: 1.0
:Project owner: Scott Jenkins
:Available: 1.3

.. contents::
   :depth: 3

============
Introduction
============

This is a very advanced feature, and if you think you need to use it, you should think carefully first.  If after careful consideration, you still want to use this feature, be very, very careful and document it thoroughly for your own understanding.

The very essence of the build system is that when it builds a layer, every Dojo (or custom) module that is in that layer's dependency list are copied into the layer file.  Similarly, every Dojo (or custom) resource that are referenced by ``dojo.require`` within the dependency list are copied into the layer file, and so on recursively, to include all necessary resources.

In almost every case, this is the desired behavior.  

However, in some complex web sites built with multiple layers that have shared dependencies, you may (after careful consideration), wish to change this behavior.  For example, suppose you have:

* **Layer A**, which depends on module M
* **Layer B**, which depends on module M
* **Module M**
* Some set of pages which will load both layers A and B
* Some set of pages which will load either A or B, but not both

In this case, the standard build would include the dependent resources for M in both the A and B layers.  If M were very large, this could be a significant increase in the code size of layers A and B.

In that case, you might wish to tell the build system *not* to include module M in the build for layer A or layer B, or both, so that it is not downloaded to some pages twice.  This is the purpose of the ``keepRequires`` option. 

However, the penalty for doing so is that the module would be downloaded at runtime from a web page, rather than prebuilt into a layer. Most of the time, the size penalty in the layers for having a module twice is less of a performance impairment than the extra round trip to the server, so use this feature with care.

Note:  The builder uses a regular expression to locate ``dojo.require`` statements within the code it is building.  If you specify dojo require using the notation ``dojo["require"]("module name")``, the builder will not try to include that resource, which has the same affect as excluding it your build file via the layer's ``keepRequires`` property.  This technique is obscure and inelegant and may not be obvious later, so use it with caution.

======
Syntax
======

``keepRequires`` is a property that you can add to each ``layers`` member within your profile.  It must be an array of strings, which represent the modules that should not be included in the layer.

TODOC:  Make an example profile, but people who would use this feature shouldn't need !

========
See also
========

* Main page for the :ref:`build system <build/index>`
