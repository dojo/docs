#format dojo_rst

dojox.lang.docs
===============

:Authors: Kris Zyp
:Project owner: Kris Zyp
:Available: since V1.2

.. contents::
    :depth: 3

**dojox.lang.docs** provides schemas on Dojo's classes based on the API 
documentation. 


============
Introduction
============

**dojox.lang.docs** can used for runtime access to class metadata information
such as descriptions and type information. This can be used in conjunction with
**dojox.lang.typed** to enforce typing on Dojo's classes using the API information.


=====
Usage
=====

dojox.lang.docs should be used with the -src distribution of Dojo, as it must be able to access the util/docscripts/api.xml (util should be at the same level as dojo, dojox, and dijit). To use dojox.lang.docs, load the module prior to loading other Dojo classes, and then call dojox.lang.docs.init() and the API information will then be available on your classes. The API information that is populated on the classes follows the JSON Schema (http://json-schema.org) structure, where the class/constructor is the root object of the schema.

.. code-block :: javascript

 dojo.require("dojox.lang.docs");
 dojo.require("dijit.ColorPalette");
 
 dojox.lang.docs.init();
 
 dijit.ColorPalette.description -> description of ColorPalette
 dijit.ColorPalette.properties.defaultTimeout.description -> description of the defaultTimeout property
 dijit.ColorPalette.properties.defaultTimeout.type -> "number", the type of the defaultTimeout property


========
See also
========

* `dojox.lang.typed <dojox/lang/typed>`_
