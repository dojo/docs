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
single environment-dependent resource that provides machinery necessary for the loader to operate in that
environment. These resources are located at dojo/_base/config<environment>.js; currently there are two such resources:

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

The configuration machinery is has-bracketed in the loader and may be completely discarded in a build by
providing a static configuration object to the loader define function (see xxx, below). This allows stripping *both* the
loader configuration machinery and the configuration module from an optimized build, saving approximately xxx bytes.

There are two alternate designs to solve the problem of duplicate code. One would force foreign loaders to load the dojo
loader and then include code in the dojo loader that detects when another AMD loader is already on the page, and if so
detected, skip the dojo loader definition leaving only the has.js and config machinery to be executed. Since there is
only about 40 lines of duplicated code in the selected design and this code is has-bracketed so that it can be discarded
during a build, this alternate design was adjudicated as sloppy and ineffecient and therefore not employed.

The other alternative is to include a micro loader in the loader that loads the has.js and config modules
and, if the dojo loader was the first AMD loader on the page, loads its own definition. Since the AMD loader API is
expected to be defined after the loader is injected into the page (or application), some kind of delay proxy would
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
contents of dojo base have been defined by the resource dojo/_base.js. As of 1.7, dojo is constructed as a CommonJs package
and the contents of the dojo package is given by the module "dojo" which maps to dojo/main.js. The standard dojo
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

The module dojo (which resolve to the resource dojo/main.js) causes all of the module listed above to be loaded. Put another
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

  * has.js API

  * Static configuration, thereby allowing all configuration machinery to be discarded in built versions

  * Sniffing of the script node that injected dojo.js and then sniffing the attribute data-dojo-config on
    that node for of configuration data

  * try-catch protection around all factory/callback/ready functions

  * Priority ready queue which allows ordered execution of callbacks inserted into the ready queue

  * XHR factory API

  * getText API which allows retreiving the result of an HTTP GET transaction either synchronously or
    asynchronously

  * Timeout API which signals an error after a prescribed time has expired and one or more requested modules
    have failed to arrive

  * Optional module injection, which allows building loaders *without* script injection machinery (the modules are
    included statically or by other means)

  * Optional and configurable script injection API, which allows configuring the loader for environments other than the
    browser and/or bulding a loader without injection machinery (see previous item)

  * Sniffing for DOH-provided configuration data

  * Aggregating and applying configuration data from various sources

  * DOM content loaded detection and signalling machinery

  * Minimal console logging machinery

  * Tracing API, including extensive debugging information available through the AMD require function

  * Error signally and resolution control API

  * Machinery to allow implementing the dojo v1.x synchronous loader as an extension to the loader

  * Module deleting API

The has.js API is used throughout the loader definition and any feature that may not be needed by a particular application
is bracketed by a has.js feature test. This design has many advantages:

  * Features can be included in the loader without causing any additional cost to built/optimized programs that do not use
    the feature.

  * Feature inclusion/exclusion can be tested without executing a build; this is not possible using build pragmas.

  * The design uses no extra-lingual constructs (e.g., build pragmas), and is therefore less complex and more familiar.

Of the extentions listed above, only the has.js is non-optional, and any or all of the remaining extensions can be
discarded as part of an built/optimized program. The has.js API comes in at less than 10 lines of code, so its cost is
trivial.

Defining the loader implies defining the two global functions require and define. The dojo loader considers the require
function to "be the loader" and hangs all loader machinery off of this function object.

Configuration
-------------

The loader is configured by three mechanisms:

  * the default configuration provided by dojo.js; this may be changed in built versions

  * configuration provided by one of the global variables dojoConfig, djConfig, or require before loader definition 

  * for the browser, configuration switches contained in the attribute data-dojo-config or djConfig in the script
    element that injects dojo.js

Among other configuration values, these configuration mechanisms provides provide has.js feature values that
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
the dojo loader and bootstrap as of v1.7). This allows the build program to replace this chunk of code with an
application-specific configuration, possibly allowing all other configuration machinery to be discarded from the build
and saving a substantial amount of unnecessary code.

defaultConfig
~~~~~~~~~~~~~

defaultConfig enjoys a priviledged status with the loader in that its contents are blindly mixed with the loader object
(the global require function). This feature is used to configure the loader for environments other than the browser and
further allows built versions of the loader to provide a highly optimized bootstrap. 

The value provided for defaultConfig in dojo.js assumes the browser environment. The has.js API is used to detect the
environment (thus allowing environment detection to be discarded in built versions), and, if a non-browser environment is
detected, an environment-specific configuration resource is evaluated. Typically, this resource defines a function
that's applied to the defaultConfig object for the purpose of modifying defaultConfig as required by the particular
environment. For example, the node.js configuration (contained in dojo/_base/configNode.js) adds the property injectUrl
to defaultConfig. This causes the injectUrl function provided by dojo.js (which appends a script element to the document) to be
replaced by a function that reads and then compiles a file. 

The task of adding support for a new environment includes three steps:

  1. Add a has.js feature test to detect the new environment.

  2. Add a has-bracketed code fragment to the loader that evaluates an environment-specific configuration resource when
     the target environment is detected.

  3. Construct an environment-specific configuration resource.

Typically, this task is trivial, requiring less than 100 lines of code. See the has features "host-rhino" and
"host-node" in dojo.js and the environment-specific configurations dojo/_base/configRhino.js and
dojo/_base/configNode.js for examples.

As mentioned above, defaultConfig may also be used in built versions of the loader to provide highly optimized
bootstraps. For example, the loader's modules hash could be prepopulated with a set of modules. If this technique were
used to include all the modules that a particular application requires for its lifetime, then all of the injection
machinery can be discarded, saving a substantial amount of code. Notice that the operation of the loader as viewed from
client code does not change in such a configuration: the loader functions require and define still exist and behave in
the standard fashion. In fact, the internal loader code paths remain unchanged. It just so happens that since all
required modules happen to already be in the modules hash, there is never a need to call the loader function
injectModule, and therefore that code can be discarded from the built version. These kind of "super-optimized" builds
are a new feature in v1.7; expect some evolution to this feature as actual use-cases are exploited.

defaultConfig, as provided by dojo.js, includes a package configuration that describes the dojo, dijit, build, doh,
dojox, and demos packages as well as a set of has feature values that enable all extensions. Consult the bottom of
dojo.js for the precise/current value of this object.

userConfig
~~~~~~~~~~

As the loader definition code executes, it consumes any configuration provided by userConfig (one of global dojoConfig,
djConfig, or require, if any). userConfig values always override defaultConfig values except that userConfig is allowed
to affect public configuration variables only (i.e., userConfig cannot affect internal loader variables like
defaultConfig). Finally, any sniffed data-dojo-config or djConfig configuration values are consumed after userConfig
consumed, and sniffed config overrides any values also found in userConfig.

The sniffing and consuming of configuration data is the third task executed in the loader definition (after has.js API
definition and environment detection/configuration), thus allowing the configuration close control over the loader
definition. In particular, has.js feature values can be set in the configuration to control the precise features
available in the loader which allows testing various loader configurations without necesstating a build.

Configuration after Loader Definition
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Configuration data can be set during the lifetime of an application through the loader require function by providing a
single argument of type Object. This signature indicates the object is a configuration and holds a hash of
configuration values to be set. For example...

.. code-block :: javascript

  require({
    paths:{
      "demos/mobile": "../demos/mobile-gallery"
    },
    has:{
      "some-has-feature":1
    }
  });

...sets the value of the has feature "some-has-feature" to 1 (causing has("some-has-feature") to return 1 on subsequent
applications) and causes the equivalent of dojo.registerModulepath("demos.mobile", "../demos/mobile-gallery").

A configuration object may also be sent to the loader as the first argument of a require application that demands a vector
of modules.

How Configuration Data is Consumed by the Loader
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Recall that configuration data can come from any of several sources:

  * defaultConfig
  * optionally, one of global dojoConfig, djConfig, or require
  * optionally, data-dojo-config or djConfig attributes of the script element that injects dojo.js
  * sending configuration values to the loader via the require function.

And configuration data can be targeted to any of several desitinations:

  1. The loader--either the dojo loader of a foreign loader
  2. dojo, dijit, or some other library
  3. The has.js API, specifying static has feature values or has feature tests
  4. Application code

In v1.6-, Item 3 was a non-issue since the has.js API was not part of dojo, Item 4 wasn't provided for, and the loader
was not considered a separable entity. The configuration machinery contained in the dojo loader as of v1.7 has been
generalized so that the management of all configuration data is controlled by one mechanism.

When the loader "consumes" configuration data, no matter the time (during loader definition or after) or source, it
filters out items from the configuration hash being consumed that are known to the loader and applies those values. The
loader "knows" the following items:

  async:: (boolean) sets the loaders operation to asynchronous operation if truthy, synchronous otherwise.

  waitSeconds:: (integer) sets the number of seconds to wait for demanded modules to arrive before signaling an error

  urlArgs:: (string) suffix to append to script URLs to bust browser caches

  baseUrl:: (string) the prefix to prepend to all computed URLs that are not absolute

  locale:: (string) sets the value of require.locale which may be used by other code

  has:: (map) map from has feature name to static value of feature test; augments (does not replace) the has cache
  accordingly

  pathTransforms:: (vector of function(string)-->(string | falsy)) vector of transforms to append to the end of the
  pathTransforms vector

  packages:: (vector of packageInfo) CommonJS package information; augments (does not replace in toto) current package
  info; any existing packages mentioned are replaced with new information.

  pacakgePaths:: (hash of packagePathInfo) CommonJS package path information; augments (does not replace in toto) current
  package info; any existing packages mentioned are replaced with new information.

  packageMap:: (map: packageName --> packageName) gives a map of package name mentioned in modules to package name know
  by loader; augments (does not replace in toto) current packageMap

  cache:: (map: package-qualified-name --> function()) gives a map from package-qualified-name to function that causes
  the module named to be defined (not executed).

  deps:: (vector of module identifiers) gives the set of modules to require immediately after the loader defines itself;
  valid only prior to/during loader definition

  callback:: (function) gives the function to call after deps have been loaded; see deps; valid only prior to/during
  loader definition

  ready:: (function) gives a function to call upon meeting the ready condition; valid only prior to/during
  loader definition

  trace:: (map: trace-group --> boolean) give a map from trace group name (string) to boolean to say which trace groups
  are active; valid only prior to/during loader definition; use require.trace.set after loader definition to set trace values.

Notice that most of the historical dojo configuration parameters (e.g., isDebug, modulePaths, etc.) are not
mentioned. Instead, *any* configuration parameter (known or unknown to the loader) is blindly pushed into the loader
property require.rawConfig. This allows *any* library or application (dojo included) to access all configuration
variables, and further allows a single mechanism for setting configuration variables. The dojo boostrap module
dojo/_base/config uses this mechanism to gain access to any configuration data sniffed by the loader.

Configuration data is pushed into require.rawConfig by single-level mixing. Consider the following example:

.. code-block :: javascript

  // assume require.rawConfig is {} at this point
  require({
    someValue:1,
    someOtherValue:2
  });
  // now, require.rawConfig is {someValue:1, someOtherValue:2}

  require({
    someValue:3,    // notice reseting someValue
    yetOtherValue:4 // a new configuration value
  });
  // now, require.rawConfig is {someValue:3, someOtherValue:2, yetOtherValue:4}

This naive mixing causes the full value of complex configuration variables like hashes (e.g., the has configuration
variable) to be improperly aggregated in require.rawConfig. This is not a problem for configuration variables know to
the loader since the loader processes such variables immediately. For client code, the loader includes the function
require.onConfig which allows users to register a listener function that is passed the configuration object specific to
a particular application of configuration data as well as the aggregate configuration contained in require.rawConfig.

Modes of Operation
------------------

By default, the v1.7+ dojo loader operates in synchronous mode in order to maintain backcompat with v1.6-. This implies
that all modules, including AMD modules, are retrived via synchronous XHR.

In order to put the loader in asynchronous mode, set the configuration variable async to truthy via one of the
configuration mechanisms. For example, to set via dojoConig, write:

.. code-block :: javascript

  <script type="text/javascript">
    require = {async:1};
  </script>
  <script type="text/javascript" src="path/to/dojo.js">
  </script>

Or to set via data-dojo-config, write:

.. code-block :: javascript

  <script 
    type="text/javascript" 
    src="path/to/dojo.js">
    data-dojo-config="async:1">
  </script>

The loader must remain in synchronous mode to faithfully implement the v1.x synchronous API (dojo.require, dojo.provide,
et al). However, it is possible to execute the v1.x synchronous API asynchronously, so long as the modules do not relay
on dojo.require'd modules during definition. Consider the following example or the hypothetical module "multiplication":

.. code-block :: javascript
  dojo.provide("multiplication");
  dojo.require("addition");
  
  multiplication.mult = function(x, y){
  	for(var result= 0, i= 0; i<y; i++){
  		result= addition.add(result, x);
  	}
  	return result;
  };

Notice that the multiplication module dojo.requires the module "addition", but does not use addition definitions during the
definition of the multiplication module. The only requirement is that both the multiplication and addition modules are
defined before the multiplication API (multiplication.mult) is applied. If code is protected by dojo.ready, as is often
the case, then then the v1.x module can be loaded asynchronously. For example,

.. code-block :: javascript
  dojo.require("multiplication");

  dojo.ready(function() {
    console.log(multiplication.mult(2, 3));
  })

On the other hand, if the code was not protected by dojo.ready, it could *not* be loaded asynchronously. Further, if the
module multiplication used the addition API during it's own definition, for example, ...

.. code-block :: javascript
  dojo.provide("multiplication");
  dojo.require("addition");

  // using addition API during definition of multiplication module...
  multiplication.version.addition= addition.version;

  // the rest of multiplication's definition

...this *cannot* be loaded asynchronously.

There is another problem getting applications contructed for the v1.x synchronous loader to load asynchronouls since
these programs typically depend on dojo being initialized with the dojo synchronous loader and dojo base APIs immediately
upon return from injecting dojo.js. For example, v1.x code often looks like this:

.. code-block :: javascript
  <script type="text/javascript" src="path/to/dojo.js">
  </script>
  <script type="text/javascript">
    dojo.require("some.module");
    // more dojo.requires...

    dojo.ready(function(){
      // use all the required modules to do something spectacular...
    });
  </script>

Simply throwing the loader into async mode by setting the async configuration variable to true will result in an
exception since dojo is not defined immediately after script injecting dojo.js because dojo itself is loaded
asynchronously.

The solution is to use the dojo configuration variable debugAtAllCosts which puts the loader in async mode after the
dojo module has been fully loaded synchronously (i.e., bootstrap and dojo base have been loaded). This ensures that dojo
is fully defined upon return from injecting dojo.js. For example...

.. code-block :: javascript
  <script type="text/javascript" src="path/to/dojo.js", data-dojo-config="debugAtAllCosts:1">
  </script>
  <script type="text/javascript">
    dojo.require("some.module");
    // more dojo.requires...

    dojo.ready(function(){
      // use all the required modules to do something spectacular...
    });
  </script>

Now, assuming all modules in the application using the dojo v1.x synchronous loader API do not use dojo.require'd
modules during their definition, the application will load dojo successfully asynchronously.

There are two key advantages to asynchronous loading:

  * The application loads faster because modules can be downloaded concurrently

  * The modules are instantiated by script-injecting rather than using eval, and this allows for a much improved
    debugging experience in old IE browsers.

The last advantage could be realized by the v1.5- loader option debugAtAllCosts (this option does not work in v1.6). In
v1.5-, setting debugAtAllCosts to true would cause the loader to download any dojo.require'd module via synchronous XHR,
then scan the module for other loader functions (dojo.require, dojo.requireIf, dojo.provide, et al), download any
detected dojo.require'd etc. modules, and so on until the entire dependency tree was downloaded. Then the dependency
tree was loaded via script injection. Because old IE versions do not guarantee injected scripts are executed in the
order they appear in the document, each script injection waited until the script was fully evaluated before injecting
the next script. Clearly, this was particularly complex code, but did solve the problem.

Version 1.7 currently has no plans to re-implement this system. Instead, the answer is to do a build which has the
option of expressing modules--even modules expressed using dojo.require et al--in terms of AMD define. For example,
the hypothetical and problematic multiplication module can be expressed with define as follows:

.. code-block :: javascript
  define("multiplication", ["dojo", "addition"], function(dojo){
    dojo.getObject("multiplication", true);
    //dojo.provide("multiplication");
    //dojo.require("addition");

    // using addition API during definition of multiplication module...
    multiplication.version.addition= addition.version;

    multiplication.mult = function(x, y){
    	for(var result= 0, i= 0; i<y; i++){
    		result= addition.add(result, x);
    	}
    	return result;
    };
  });

Now this module can be loaded with any AMD-compliant loader in full asynchronous mode. Notice that this is a reasonable
method to quickly convert a project based on the v1.x synchronous loader API into an AMD-compliant code base.

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
