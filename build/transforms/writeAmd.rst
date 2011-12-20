.. _build/transforms/writeAmd:

========================
Build Transform writeAmd
========================

:Author: Rawld Gill

.. contents ::
   :depth: 2

Summary
=======

Writes a transformed AMD module to a destination location.

Description
===========

This transform writes AMD modules to a destination location, optionally bundling dependencies and other decorations. Any
module that has been previously processed with the depsScan transform may be submitted to the writeAmd transform:

* AMD code modules

* AMD NLS modules

* legacy code modules, since depsScan transforms the module text to a valid AMD code module

* legacy NLS modules, since depsScan transforms the module text to a valid AMD NLS module

A module may be designated as a "layer" module by including the module identifier in the profile property ``layers``, a
map from module identifier to a set of include and/or exclude modules identifiers that indicate modules to explicitly
include and/or exclude when the module is written. The idea of a layer is to bundle a bunch of modules in a single
resource to decrease the number of transactions required to load a set of modules.  An item in the ``layers`` map has
the following properties:

``include``
  An array of module identifiers giving a set of modules to explicitly include when the layer is written.

``exclude``
  An array of module identifiers giving a set of modules to explicitly exclude when the layer is written.

``discard``
  Optional. If present, should be truthy to indicate the layer is a synthetic layer used only to compute another layer's
  contents. Deprecated as of 1.7; use ``exclude`` to explicitly exclude modules from layers instead.

``boot``
  Optional. If present, should be truthy to indicate the layer should be written with the dojo loader to form a kind of
  bootstrap module.

``copyright``
  Optional. If present, gives a copywrite message to include when the layer is written. Either a string or a filename
  of a resource containing the copyright text can be provided.

The modules to include in a particular layer are computed as follows:

1. The layer module itself.

2. Plus the dependency graph implied by the AMD dependencies of the layer module. This is given by the dependency vector
   found in the define application associated with the target module, the modules found in the dependency vectors of
   those modules, and so on until all modules in the graph have been found (remember, though not desirable, there may
   be cycles, so the graph is not necessarily a tree).

3. Plus all modules given in the include array, along with all of those modules' dependency graphs.

4. Less all modules given in the exclude array, along with all of those modules' dependency graphs.

The layer module is termed the "layer module", all other modules that are computed by the algorithm are termed "layer
member modules". Heuristically, the idea is to bundle all the modules required to load the layer module as well as all
modules in the include array, assuming all modules in the exclude array have already been loaded.

If the module is not a layer, then the transformed module text is written. Any interned strings computed by the
depsScan transform are also written. If the owning package configuration for the module includes the property
``copywrite``, a copyright message, then the value of that property is included in the written resource.

If the module is a layer and either of the layer properties ``discard`` or ``boot`` are truthy, then the transform
computes and memorizes the contents of the module resource but does not write it. If the layer property ``boot`` is
truthy, the resource should be processed by the writeDojo transform which will recall the memorized contents and write
the layer along with the dojo loader so that the layer may serve as a boot module. See xxx.

Otherwise, the layer module's transformed text is written together with the transformed text or all the layer member
modules. Member module layer text is written by providing a hash of module values for the dojo loader ``cache``
configuration property which gives a map from absolute module identifier to a function that causes the equivalent of the
module resource to be evaluated. For example, if the resource text for the module "x/y/z" is given as....

.. js ::

  // some code outside the AMD define application
  console.log("hello, world; you shouldn't do this, but you can");
  
  define([/* x/y/x dependencies */], function(/* dependency lexical variables */){
    console.log("in x/y/z's factory");
  });
  
  
  // some more code outside the AMD define application
  console.log("don't do this either...but you can");

And x/y/z is a member module of a layer, then that layer will inject a loader cache configuration value as follows:

.. js ::

  require({cache:{
    "x/y/z":function(){
      // some code outside the AMD define application
      console.log("hello, world; you shouldn't do this, but you can");
      
      define([/* x/y/x dependencies */], function(/* dependency lexical variables */){
        console.log("in x/y/z's factory");
      });
      
      
      // some more code outside the AMD define application
      console.log("don't do this either...but you can");
    }
    
    // other member modules as required
  }});

This causes the module to be available to the loader upon demand, but the contents of the module's resource are *not*
evaluated unless and until the module is actually demanded by the run-time execution path. At that point the function is
evaluated which results in the same effect as if the module has been script injected.

Similar to a non-layer, if the layer property ``copyright`` exists, then the value of that property is included in the
written resource.

Lastly, if the profile property ``insertAbsMids`` is truthy, then the transform will ensure that the define application
that defines each AMD module includes a module identifier argument. This is a backcompat feature that is used to
construct modules that can be loaded with a script tag in the context of the dojo loader operating in a legacy
mode. Normally, this feature should be avoided.

Profile Knobs
=============


``layers`` (default = ``undefined``)
  * [*map from module identifier to layer item*] Indicates the given module should be written as a layer.

  If multiple layer objects are given by multiple profile resources, they are mixed on a per-layer basis, as profile
  items are processed left to right on the command line. For example, if two profile resources define the "x/y/z" layer,
  the layer item that exists in the last profile processed will overwrite the first layer item completely.

``insertAbsMids`` (default = ``undefined``)
  * [*truthy*] Causes the transform to ensure that every AMD define application includes a module identifier argument.

  * [*falsy*] The transform does nothing to the module identifier argument in define applications. In particular, a
    falsy value doe *not* cause the transform to remove a module identifier argument that exists in the source code.

Layer items are Javascript objects with the following properties

``include`` (default = ``[]``)
  The set of module identifiers that, together with their dependency graphs, should be included in the layer, exclusive
  of the exclude module graph (see next).

``exclude`` (default = ``[]``)
  The set of module identifiers that, together with their dependency graphs, should be excluded from the layer after all
  include dependencies are computed.

``discard`` (default = ``undefined``)
  If truthy, then the layer is computed and memorized but not written. This feature is used to construct a layer that is
  used in the ``include`` or ``exclude`` arrays of other layers.

``boot`` (default = ``undefined``)
  If truthy, then the layer is computed and memorized but not written. The computed layer is used by the writeDojo
  transform to write the layer along with the dojo loader to form a boot layer.

``copyright`` (default = "")
  If a string that gives an existing filename, the contents of the named file is used as copyright text for the
  module. Relative filenames are computed with respect to the path that holds the profile resource that contains the
  layer item. If a string that does not give an existing filename, the string it interpreted as an explicit copyright
  message. If no string value is given, then no copyright text is output.

Source Location
===============

util/build/transforms/writeAmd.js
