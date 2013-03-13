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

``includeLocales``
  An array of locales that will be included in the layer. This can be defined at the profile or layer level.

``noref``
  Optional. If present and truthy, instructs the loader to consume the cache of layer member modules (see below)
  immediately; otherwise, the cache is not consumed until the layer module is defined or another cache of modules is
  presented to the loader.

``compat``
  Optional. If set to the value of "1.6", then all layer member modules are immediately defined.

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
``copyright``, a copyright message, then the value of that property is included in the written resource.

If the module is a layer and either of the layer properties ``discard`` or ``boot`` are truthy, then the transform
computes and memorizes the contents of the module resource but does not write it. If the layer property ``boot`` is
truthy, the resource should be processed by the writeDojo transform which will recall the memorized contents and write
the layer along with the dojo loader so that the layer may serve as a boot module.

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

Backcompat
==========

The insertAbsMids Switch
------------------------

If the profile property ``insertAbsMids`` is truthy, then the transform will ensure that the define application
that defines each AMD module includes a module identifier argument. This is a backcompat feature that is used to
construct modules that can be loaded with a script tag in the context of the dojo loader operating in a legacy
mode. Normally, this feature should be avoided.

The noref Switch
----------------

In a non-legacy, pure AMD-style build, a layer includes a loader cache configuration value as described above that
includes all of the layer member modules followed by a single ``define`` application that defines the layer module. When the layer is evaluated in the browser, the loader delays consuming the cache until the ``define`` application is
processed. This allows the loader to map the layer member modules in the same way as the layer module in cases where the layer module is mapped to a different namespace by the ``packageMap`` loader configuration.

General namespace mapping was not available in v1.6, and this particular optimization causes the layer to be consumed in a slightly different way compared to v1.6. Since some Dojo users have leveraged v1.6- build system internals to build additional optimizations, the new behavior breaks these optimizations. The common example is server-side machinery that predicts dependencies and bundles several layers into a single script injects.

In order to accommodate these kinds of optimizations, a cache value may include the pseudo-module ``"*noref"``, which
instructs the loader to consume the cache immediately, thereby making all layer member modules available without an
additional server transaction. Of course it is impossible to use both the package mapping and noref feature.

Individual layers may be designated as noref layers by setting the layer property ``noref`` to a truthy value in a
particular layer config. All layers may be designated as noref by setting the property ``noref`` to a truthy value in
the profile. If the config variable is set in both places, the layer setting overrides the global profile setting for any particular layer.

The compat Switch
-----------------

In v1.6-, a built layer immediately defined all member modules and contained other behaviors that caused built versions to follow slightly different code paths than unbuilt versions. In contrast, the v1.7+ builder/loader attempts to execute the exact same code path for built and unbuilt versions of a particular application. In particular, layer member modules are not defined until demanded consequent to requiring some other module. As described above, some Dojo users have constructed optimizations that depend on the old behavior.

In order to accommodate these kinds of optimizations, the switch ``"compat"`` may be set to ``"1.6"``, in which case all layer member modules will be immediately ``require``d. Naturally, the ``noref`` switch should be set truthy if the ``compat`` switch is set to ``"1.6"`` (this is not automatic in 1.7.2, but will be in 1.8).


NLS Bundles
-----------

Recall that NLS bundles work differently in AMD compared to the legacy algorithms. The legacy algorithms loaded a root
bundle and then attempted to load progressively specialized bundles according to the runtime locale until a 404 error
occurred. The AMD algorithm specifies which localized bundles are available in the root bundle, so it can load exactly
the available/appropriate bundles given a runtime locale value.

Notice that the AMD algorithm requires two transaction slices in order to fully load localized bundles:

  1. Load the root bundle.
  2. Load all of the available/appropriate localized bundles.

Although Step 2 may result in multiple (almost-never more than two) script injections, those server transactions are
typically concurrent. Therefore, layers that have NLS dependencies include the root bundle and the normal loader
machinery loads available localizations as required during runtime. In the typical case, this is just as fast as the old bundle flattening algorithms that were available in v1.6-.

In order to accommodate some legacy usages, the v1.7 build program outputs flattened NLS bundles for any locale specified by the ``localeList`` profile knob.

NLS bundle loading can be avoided for specific locales by including locales in a layer, using the includeLocales setting. For example, if you set includeLocales: ['en-us'], the layer will not need to make a separate request for the NLS bundle for en-us users.


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

``noref`` (default = ``undefined``)
  Optional. If present and truthy, instructs the loader to consume the cache of layer member modules immediately;
  otherwise, the cache is not consumed until the layer module is defined or another cache of modules is presented to the
  loader. When set on the profile level, applies to all layers that do not specifically override.

``compat`` (default = ``undefined``)
  Optional. If set to the value of "1.6", then all layer member modules are immediately ``require``d. For example, if
  the cache presented with a layer includes the modules "my/a", "my/b", and "my/c", then setting ``compat`` to "1.6"
  results in the statement ``require(["my/a", "my/b", "my/c"])`` to be inserted in the layer resource immediately
  following the cache. When set on the profile level, applies to all layers that do not specifically override.

``localeList`` (default = ``undefined``)

  Optional. A comma-separated list of locale identifiers (a string) that specifies the list of locales to output as
  flattened bundles for each layer that includes NLS bundle dependencies.

Layer items are JavaScript objects with the following properties

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

``includeLocales``
  An array of locales that will be included in the layer. The NLS bundle for each listed locale will be included in the layer, so that these locales will not need a separate request(s) to access their NLS bundle. Note, that using included locales adds extra bytes to the layer, and users that don't match the included locales will be loading unnecessary bundles. Using this option is best when the majority of users will match a particular locale (or small set of locales).

``noref`` (default = ``undefined``)
  Optional. If present and truthy, instructs the loader to consume the cache of layer member modules immediately;
  otherwise, the cache is not consumed until the layer module is defined or another cache of modules is presented to the
  loader.

``compat`` (default = ``undefined``)
  Optional. If set to the value of "1.6", then all layer member modules are immediately ``require``d. For example, if
  the cache presented with a layer includes the modules "my/a", "my/b", and "my/c", then setting ``compat`` to "1.6"
  results in the statement ``require(["my/a", "my/b", "my/c"])`` to be inserted in the layer resource immediately
  following the cache.


Source Location
===============

util/build/transforms/writeAmd.js
