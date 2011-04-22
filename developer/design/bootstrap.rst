#format dojo_rst

dojo loader and bootstrap
=========================

:Status: Draft
:Version: 1.7+
:Author: Rawld Gill

.. contents::
   :depth: 2

Design Description of the Dojo Loader and Bootstrap

============
Introduction
============

Dojo may used in a variety of environments, loaded with any of several AMD-compliant loaders, configured through three
mechanisms, and optimized with the Dojo build system. All of these features are implemented in the Dojo loader and
bootstrap. This document describes the design and rational of these two foundational subsystems.

This document is not necessary material for normal Dojo users. It is intended for expert Javascript programmers and Dojo
developers (that is, developers working on Dojo proper) that need to quickly understand the internal design of the the
loader and bootstrap subsystems. Advanced users will also find this information useful in pushing the toolkit in
atypical applications.

===================
External References
===================

TODOC

==============
Overall Design
==============

The dojo loader is contained in the resource dojo/dojo.js. Although the loader includes several extensions, at its core
it is simply a CommonJS AMD-compliant loader. When the loader is operating in a non-browser environment, it loads a
single environment-dependent resource that provides machinery and configuration switch settings necessary for the loader
to operate in that environment. These resources are located at dojo/_base/config<environment>.js; currently there
are two such resources:

  * dojo/_base/configNode.js: contains machinery necessary to bootstrap into node.js

  * dojo/_base/configRhino.js: contains machinery necessary to bootstrap into Rhino

The dojo bootstrap proceeds as follows:

  1. The has.js API implementation is defined. This is contained in the loader and the module dojo/has (this module
  does not depend on any other modules).

  2. The user configuration is sniffed and aggregated as required; this machinery is contained in the loader and the
  module dojo/_base/config (this module depends on dojo/has).

  3. The dojo object is created and popluated with the absolute minimum API as controlled by has.js feature settings and
  any user configuration provided by Items 1 and 2, above. This machinery is contained in the module dojo/_base/kernel
  (this module depends on dojo/has and dojo/_base/config).

  4. The dojo object is populated by various APIs defined in the so-called "dojo base" modules.

The bootstrap sequence can be initiated be either the dojo loader (dojo/dojo.js) or a foreign AMD loader. In either
case, the bootstrap sequence is controlled by the module "dojo" which maps to dojo/main.js. In it's standard
configuration, the dojo loader automatically loads the dojo module.

As indicated above, the has.js and configuration machinery is defined in both the loader and individual modules, with
some overlapping implementation existing. Since the dojo loader requires both the has.js API and configuration in order
to define itself, these features must be implemented in the loader. On the other hand, when dojo is loaded by a
foreign loader, the dojo loader's has.js and configuration machinery is not available and therefore must be defined by
other means.

Futher, the configuration machinery is has-bracketed in the loader and may be completely discarded in a build by
providing a static configuration object to the loader define function (see xxx, below). This allows stripping *both* the
loader configuration machinery and the configuration module from an optimized build, saving approximately xxx bytes.

There are two alternate designs to solve the problem of duplicate code. One would force foreign loaders to load the dojo
loader and then include code in the dojo loader that detects when another AMD loader is already on the page, and if so
detected, skip the dojo loader definition leaving only the has.js and config machinery to be executed. Since there is
only about 40 lines of duplicated code in the selected design and this code is has-bracketed so that it can be discarded
during a build, this alternate design was adjudicated as sloppy and ineffecient and therefore not exployed.

The other alternative is to include some kind of micro loader in the loader that loads the has.js and config modules
and, if the dojo loader was the first AMD loader on the page, loads its own definition. Since the AMD loader API is
expected to be defined after the loader is injected into the page (or application), some kind of delay proxy API would
also have to be implemented while the loader was waiting to be fully defined. Clearly, this adds complexity, would
likely require many more than 40 lines of code, and would therefore be an irrational design choice for the sole purpose
of saving 40 lines of duplicate code.

When the module "dojo" is demanded, all standard dojo distributions provide much more machinery than described
so-far. However, the bootstrap is designed so that users could conceivably configure the system to provide nothing more
than the three modules listed above. Indeed, even the dojo/has and dojo/_base/config modules could be replaced (and
often are, in custom builds) with tiny, focused, application-dependent modules.

The idea that dojo can be configured to contain exactly and only the machinery required for a particular application is
one of the key goals of the v1.7+ bootstrap design. This feature allows application-specific built versions of dojo to
be constructed that are optimized with respect to size. Accordingly, all bootstrap modules are designed to be highly
orthogonal.

Once dojo/_base/kernel has been defined, typically the remainder of so-called "dojo base" is defined. Historically, the
contents of dojo base have been defined by the resource dojo/_base. As of 1.7, dojo is constructed as a CommonJs package
and the contents of the dojo package is given by the module "dojo" which maps to dojo/main. The standard dojo
distribution defines the dojo package to contain the following modules:

  * dojo/_base/load - contains the dojo.ready/dojo.addOnLoad API

  * dojo/_base/loader.js - contains the v1.x synchronously loader API (dojo.provide, dojo.require, et al)

  * dojo/_base/sniff.js - contains browser sniffing machinery (this was contained in
    dojo/_base/_loader/hostenv_browser.js in v1.6-)

  * dojo/_base/unload:: contains window unload detection and signalling (this was contained in
    dojo/_base/_loader/hostenv_browser.js in v1.6-)

  * dojo/_base/url:: contains the dojo._Url (this was contains in dojo/_base/_loader/loader.js in v1.6-)

  * dojo/_base/lang, dojo/_base/array, dojo/_base/declare, dojo/_base/connect, dojo/_base/Deferred, dojo/_base/json, and
    dojo/_base/Color - contains standard dojo base machinery as per the v1.x line

  * dojo/_firebug/firebug - conditionally loaded as part of dojo base if the configuration flag isDebug is true

  * dojo/_base/browser - causes the browser-dependent base modules to be loaded. This module is conditionally loaded
    if the browser environment is detected in dojo/main via the has! plugin.

  * dojo/_base/window, dojo/_base/event, dojo/_base/html, dojo/_base/NodeList, dojo/_base/query, dojo/_base/xhr,
    dojo/_base/fx - contains standard dojo base machinery included in browser environments as per the v1.x line. This are
    the modules listed in dojo/_base/browser

The module dojo (which resolve to the module dojo/main) causes all of the module listed above to be loaded. Put another
way, writing...

.. code-block :: javascript

  define(["dojo"], function(dojo) {
    // do something spectacular...
  });

...causes the factory function given above to have access to the dojo base API.

However, it's important to note that all modules that are defined prior to "dojo" (e.g., all of the modules in
dojo/_base) *cannot* depend on the module dojo. Instead they must depend on the module dojo/kernel in order to gain
access to the dojo object. Further, if they depend on other modules than dojo/_base/kernel or dojo/has, then they must
explicitly include those modules (note: dojo/_base/kernel processes all configuration information and initializes
dojo.config, so there is no need to explicitly include dojo/_base/config). For example, dojo/_base/array requires some
functions defined in dojo/_base/lang; therefore, the AMD dependency vector found in dojo/_base/array explicitly includes
dojo/_base/lang.

===============
The Dojo Loader
===============

The Dojo loader is contained in the resource dojo/dojo.js. It is a CommonJS Modules/AsynchronousDefinition-compliant
loader the operates in the browser, node.js, and Rhino environments, and includes CommonJS Modules/LoaderPlugin
support and the following extentions:

  * has.js API.

  * Static configuration, thereby allowing all configuration machinery to be discarded in built versions.

  * Sniffing of the script node that injected dojo.js and then sniffing the attribute data-dojo-config on
    that node for of configuration data.

  * try-catch protection around all factory/callback/ready functions.

  * Priority ready queue which allows ordered execution of callbacks inserted into the ready queue.

  * XHR factory API.

  * getText API which allows retreiving the result of an HTTP GET transaction either synchronously or
    asynchronously.

  * Timeout API which signals an error after a prescribed time has expired and one or more requested modules
    have failed to arrive.

  * Optional module injection, which allows building loaders *without* script injection machinery (the modules are
    included statically or by other means).

  * Optional and configurable script injection API, which allows configuring the loader for environments other than the
    browser and/or bulding a loader without injection machinery (see previous item);

  * Sniffing for DOH-provided configuration data,

  * Aggregating and applying configuration data from various sources,

  * DOM content loaded detection and signalling machinery,

  * Minimal console logging machinery,

  * Tracing API, including extensive debugging information available through the AMD require function.

  * Error signally and resolution control API.

  * Machinery to allow implementing the dojo v1.x synchronous loader as an extension to the loader,

  * Module deleting API.

The has.js API is used throughout the loader definition and any feature that may not be needed by a class of applications
is bracketed by a has.js feature test. This design has many advantages:

  * Features can be included in the loader without causing any additional cost to built/optimized programs that do not use
    the feature.

  * Feature inclusion/exclusion can be tested without executing a build; this is not possible using build pragmas.

  * The design uses no extra-lingual constructs (e.g., build pragmas), and is therefore less complex and more familiar.

Of the extentions listed above, only the has.js is non-optional, and any or all of the remaining extensions can be
discarded as part of an build/optimized program. The has.js API comes in at less than 10 lines of code, so its cost is
trivial.

Defining the loader implies defining the two global functions require and define. The dojo loader considers the require
function to "be the loader" and hangs all loader machinery off of this function object.

Configuration
-------------

The loader is configured by three mechanisms:

  * the default configuration provided by dojo.js (this may be changed in built versions) configuration provided by one
  * of the global variables dojoConfig, djConfig, or require before loader definition for the browser, configuration
  * switches contained in the attribute data-dojo-config or djConfig in the script element that injects dojo.js

Among other configuration values, these configuration mechanism provides provide has.js feature values that
include/exclude the extensions listed above.

The loader definition (contained in dojo.js) takes the form of an anonymous function that is applied as follows:

.. code-block :: javascript

  (function(defaultConfig, userConfig){
    // loader definition goes here...
  })
  //>>excludeStart("replaceLoaderConfig", kwArgs.replaceLoaderConfig);
  (
    // the default configuration...
    {
      // default configuration provided by dojo.js goes here...
    },

    // the user configuration...
    this.dojoConfig || this.djConfig || this.require || {},
  });
  //>>excludeEnd("replaceLoaderConfig")


Global djConfig is allowed for backcompat in the v1.x line. The perference of dojoConfig, djConfig, or require (the
RequireJS configuration object) is as given above.

The application of the anonymous function is bracketed by a build pragma (this is the only build pragma that exists in
the dojo loader and bootstrap as of v1.7). This allows the build program to replace this application with an
application-specific configuration, possibly allowing all other configuration machinery to be discarded from the build
and saving a substantial amount of unnecessary code.

defaultConfig enjoys a priviledged status with the loader in that its contents are blindly mixed with the loader object
(the global require function). This allows built versions of the loader to provide a highly optimized bootstrap. For
example, the loader's modules hash could be prepopulated with a set of modules.

defaultConfig, as provided by dojo.js, includes a package configuration that describes the dojo, dijit, build, doh,
dojox, and demos packages as well as a set of has feature values that enable all extensions. Consult the bottom of
dojo.js for the precise/current value of this object.

As the loader definition code executes, it mixes and consumes any configuration provided by userConfig (one of global
dojoConfig, djConfig, or require, if any). userConfig values always override defaultConfig values except that userConfig
is allowed to affect public configuration variables only (for example, userConfig cannot affect internal loader
variables like defaultConfig). Finally, any sniffed data-dojo-config or djConfig configuration values are mixed and
consumed after userConfig is mixed and consumed.

The sniffing, mixing, and consuming of configuration data is the second task executed in the loader definition (the
first being has.js API definition), thus allowing the configuration close control over the loader definition. In
particular, has.js feature values can be set in the configuration to control the precise features available in the
loader which allows testing various loader configurations without necesstating a build.


Modes of Operation
------------------

TODOC


===============
The has.js API
===============

Particular applications may discard some or all of the features listed above by building an optimized version of the
loader with the Dojo build system. Typically, an appplication simply requires the AMD modules that define the machinery
upon which the application depends. This technique is not possible within the loader's definition because module loading
is not available until the loader is defined. Instead, each optional feature is bracketed with a has feature test. For
example, the module deleting API is implemented as follows:

.. code-block :: javascript

  if(has("loader-undefApi")){
  	req.undef = function(moduleId){
  		// In order to reload a module, it must be undefined (this routine) and then re-requested.
  		// This is useful for testing frameworks (at least).
  		var pqn = getModule(moduleId, 0).pqn;
  		setDel(modules, pqn);
  		setDel(waiting, pqn);
  	};
  }

During testing, this feature can be included/excluded by setting the has feature "loader-undefApi" true/false. The dojo
build application can be used to keep the feature run-time selectable as depicted above or unconditionally discard or
include the has-bracketed code fragment by setting a built-time value for the has feature "loader-undefApi". For
example, if this feature is not needed in a particular application, the build-time value for "loader-undefApi" can be
set to false which will cause the build program to emmit the following code:

.. code-block :: javascript

  if(0 && has("loader-undefApi")){
  	req.undef = function(moduleId){
  		// In order to reload a module, it must be undefined (this routine) and then re-requested.
  		// This is useful for testing frameworks (at least).
  		var pqn = getModule(moduleId, 0).pqn;
  		setDel(modules, pqn);
  		setDel(waiting, pqn);
  	};
  }

And this code will be discarded by the Google Closure Compiler. Similarly, setting the build-time value for
"loader-undefApi" to true will cause the build program to emmit the following code:

.. code-block :: javascript

  if(1 || has("loader-undefApi")){
  	req.undef = function(moduleId){
  		// In order to reload a module, it must be undefined (this routine) and then re-requested.
  		// This is useful for testing frameworks (at least).
  		var pqn = getModule(moduleId, 0).pqn;
  		setDel(modules, pqn);
  		setDel(waiting, pqn);
  	};
  }

This code will be optimized by the Closure Compiler to eliminate the outer if-statement.

This design is used throughout the loader definition and any feature that may not be needed by a class of applications
is bracketed by a has.js feature test. This requires the loader to implement the has.js API, and this implementation is
among the very first lines of code in the loader definition.

==================
User Configuration
==================

==============================
Configuration Switch Reference
==============================

========================
has.js Feature Reference
========================

=================
Changes from v1.6
=================
