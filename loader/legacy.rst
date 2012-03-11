.. _loader/legacy:

============================
The Dojo Loader Legacy Modes
============================

:Author: Rawld Gill

.. contents ::
   :depth: 3

Introduction
============

As of v1.7.0, the Dojo loader implements the AMD API, and this is the API that should be used going forward. However, as
is customary with Dojo, support for existing v1.x APIs, including the legacy loader API (``dojo.require``,
``dojo.provide``, and the rest) is fully supported until version 2.0. This document describes the legacy API and how it
coexists with the AMD API.

The Legacy API
==============

In order to maintain backcompat with the v1.x line, the v1.7 loader includes the complete synchronous loader API
consisting of dojo.provide, dojo.require, dojo.requireLocalization, dojo.requireIf, dojo.requireAfterIf,
dojo.platformRequire, and dojo.loadInit. This API is termed the "legacy loader API"; sometimes I'll just write "legacy
API". Modules that use the legacy API are termed "legacy modules". This section reviews the legacy API; the next section
describes how the v1.7 loader emulates this API.

Although the API has not changed, the entire legacy loader implementation has been rewritten to leverage the new AMD
loader. Most of the legacy implementation resides in dojo/_kernel/loader. What little of the legacy API there is that
bleeds into the AMD loader in dojo.js is carefully has-bracketed so it can be stripped in builds of applications that
don't need it.

The functions dojo.require and dojo.provide define the core of the legacy API. Each of these takes a module identifier
that is identical to an absolute AMD module identifier except that dots are used instead of forward slashes; the legacy
API does not support relative module identifiers. dojo.provide's implementation is trivial, but it does include a subtle
feature that's important to understand. Here is the v1.6- implementation of dojo.provide in its entirety:

.. js ::

  dojo.provide = function(moduleId){
    return (dojo._loadedModules[moduleId] = dojo.getObject(moduleId, true));
  }

Notice that the loader possibly creates and always memorizes the object dojo.provide returns. This is the object
returned by dojo.require for a module after it has been resolved. Here are the first few lines of dojo.require (slightly
synthesized):

.. js ::

  dojo.require = function(moduleId, omitModuleCheck){
    if(dojo._loadedModules[moduleId]){
      return dojo._loadedModules[moduleId];
    }

    // do work to load the module
  }

So far, it looks like the legacy API works a lot like AMD. dojo.provide publishes a module value to the loader (just
like AMD define), and dojo.require retrieves a previously published value (just like the dependency vectors in AMD require
and define). Unfortunately, this isn't how the legacy API has been used in practice. For example, here is dijit/Calendar
from v1.5:

.. js ::

  dojo.provide("dijit.Calendar");
  //
  // dojo.requires omitted
  //
  dojo.declare("dijit.Calendar", //...

dojo.declare creates a new object and stores it at dijit.Calendar. So dojo.require("dijit.Calendar") returns a
useless, empty object. Take note of these two key points regarding dojo.provide and dojo.require in v1.6-:

1. The purpose of dojo.provide is to manufacture an object so that the module can assume the object exists and add
   properties to it. Entering the manufactured object in the loader namespace (at dojo._loaderModules) often has no
   real benefit.

2. The return value of dojo.require is often useless.

Another anti-pattern seen in legacy modules is including multiple dojo.provide applications in a single module. Though
not illegal, this technique creates challenges when a legacy module is loaded by the new loader since, although a single
module was demanded, several are defined.

dojo.require has a few idiosyncrasies as well. Owing to the way dojo.eval is defined in v1.6- and the way some browser's eval
works, sometimes a module's code text would be eval'd in the global scope and sometimes it would be eval'd in a function
scope. Consider the module text:

.. js ::

  dojo.provide("module.that.defines.a.global");
  var someVariable = anAwesomeCalculation();

If the code above is evaluated in the global scope, then someVariable is entered into the global namespace; however, if
it's evaluated in a function scope, then someVariable is a lexical variable and disappears when the function returns.

In version 1.7+, all code that is downloaded as text and evaluated with JavaScript eval is evaluated in a function
scope. If you've got code like above and expect someVariable be defined in the global space, it will not work in v1.7
(it only worked sometimes anyway--even if you didn't know it). Here's how to get the effect you want:

.. js ::

  dojo.provide("module.that.defines.a.global");
  dojo.global.someVariable = anAwesomeCalculation();

Let's review how dojo.require normally operates. dojo.require executes a synchronous XHR to get the resource text and
then applies JavaScript eval to that text. If a dojo.require application is encountered during the evaluation of the
text, then another synchronous XHR retrieves the demanded resource's text and that text is eval'd, and so on util the
entire dependency tree is evaluated. This guarantees a particular code path. Consider the following module:

.. js ::

  dojo.provide("my.module");
  doSomeStuff(1);
  dojo.require("my.other.module");
  doSomeStuff(2);
  dojo.require("no.my.other.module");
  doSomeStuff(3)

The code path guaranteed by the legacy API is exactly as it is written. In particular, the "AMD equivalent"...

.. js ::

  define("my/module", ["my/other/module", "no/my/other/module"], function(){
    doSomeStuff(1);
    doSomeStuff(2);
    doSomeStuff(3);
  });

...is not equivalent at all since it will cause both */ my/other/* modules to be resolved (executed) before any of the
doSomeStuff applications.

The v1.6- build system rewrites module text so that it can be injected into a script element yet honor the code path
described above. Here's a sketch (this isn't exactly how the v1.6- build system packages modules, but it's enough to get
the idea). Given the following legacy module:

.. js ::

  dojo.provide("my.module");
  dojo.require("your.module");
  doSomethingSpectacular();

The v1.6- build system rewrites the module like this:

.. js ::

  dojo.loader.define(
    // [1] the provide(s) included in this module
    ["my.module"],

    // [2] the require(s) included in this module
    ["your.module"],

    // [3] the module's code
    function(){
      dojo.provide("my.module");
      dojo.require("your.module");
      doSomethingSpectacular();
    }
  );

The v1.6- cross-domain loader injects such modules with a script element--just like the AMD loader. The v1.6- loader
keeps injecting dojo.require'd modules as indicated ([2] in the example above) until the complete dependency tree of the
current request is downloaded. Then individual modules can be executed just as if they were being downloaded by
synchronous XHR by simply executing their factory functions ([3] above). When a dojo.require is applied within one of
those factory functions, the loader already has the module available and simply executes the factory function for the
demanded module.

Now comes the really crazy part of the cross-domain loader: loading not-cross-domain, not-built modules while also
loading cross-domain, built modules. And yes, this happens all the time--whenever an unbuilt application references dojo
on a CDN. In this case, the not-cross-domain, not-built modules are downloaded by synchronous XHR and converted to built
modules on-the-fly. Of course the only way to do this is to scan the module's text for dojo.provide, dojo.require, and
the rest. But, owing to JavaScript's regular expression lexical rules, it is impossible to remove comments and strings
from JavaScript text without fully parsing the text! And without removing comments and strings, it is possible
"discover" loader API applications that aren't really there and/or miss others.

Be that as it may, the v1.6- cross-domain loader removes comments with a regular expression, sniffs for legacy loader
API applications, and constructs a "built" module on-the-fly.

Note that the cross-domain loader goes in and out of cross-domain mode. As long as only local modules are being loaded,
it operates just like the normal synchronous loader. But once a single resource is dojo.require'd that exists
cross-domain, the loader immediately gives up on loading any other modules synchronously (all currently executing
modules are guaranteed to have any subsequent dojo.require applications *not* execute synchronously) and loads everything
as if it had been built.

The legacy loader also includes the functions dojo.platformRequire, dojo.loadInit, dojo.requireIf, and
dojo.requireAfterIf. This set of functions work together to conditionally dojo.require modules based on the runtime
state of an application. dojo.platformRequire causes zero to many modules to be dojo.require'd based upon the current
platform (browser, Rhino, and so on).  dojo.loadInit is intended to sniff the environment and set some global variables
that the condition in dojo.requireIf then references to decide whether or not to load a particular
module. dojo.requireIf and dojo.requireAfterIf are identical--they reference the same function. The canonical use case
is dojox.gfx in v1.6-:

.. js ::

  dojo.provide("dojox.gfx");
  dojo.require("dojox.gfx.matrix");
  dojo.require("dojox.gfx._base");
  dojo.loadInit(function(){
      // code that sets dojox.gfx.renderer
  });
  
  // include a renderer conditionally
  dojo.requireIf(dojox.gfx.renderer == "svg", "dojox.gfx.svg");
  dojo.requireIf(dojox.gfx.renderer == "vml", "dojox.gfx.vml");
  dojo.requireIf(dojox.gfx.renderer == "silverlight", "dojox.gfx.silverlight");
  dojo.requireIf(dojox.gfx.renderer == "canvas", "dojox.gfx.canvas");

A sketch of the v1.6- built version of this module suitable for cross-domain loading looks like this:

.. js ::

  dojo.loadInit(function(){
    // code that sets dojox.gfx.renderer
  });

  dojo.loader.define(
    // [1] the dojo.provide(s) included in this module
    ["dojox.gfx"],
  
    // [2] the dojo.require(s) included in this module
    [
      "dojox.gfx.matrix",
      "dojox.gfx._base",
      [dojox.gfx.renderer == "svg", "dojox.gfx.svg"],
      [dojox.gfx.renderer == "vml", "dojox.gfx.vml"],
      [dojox.gfx.renderer == "silverlight", "dojox.gfx.silverlight"],
      [dojox.gfx.renderer == "canvas", "dojox.gfx.canvas"]
    ],

    // [3] the module's code
    function(){
    }
  );

The cross-domain loader causes the dojo.loadInit argument to be executed before traversing the array that gives the
dojo.requires. Notice that some of the elements in this array are pairs: these represent the dojo.requireIf applications
in the unbuilt module. The cross-domain loader loads the module given by the second item in a pair if the first item is
true.

This kind of built module is also constructed on-the-fly when loading a not-cross-domain, not-built module that includes
dojo.loadInit and/or dojo.require[After]If applications while in cross-domain mode.

There is one last, obscure API contained in the legacy loader to discuss: so-called "multi-version" support. The key
capability of the multi-version machinery is the ability to load two or more independent instances of dojo, dijit,
dojox, or other library(s) expressed in the legacy API on the same page.

Here's how it works. Notice that the legacy API depends on top-level objects (like dojo, dijit, and dojox) existing in
the global namespace. So the machinery must have the ability to "relocate" new instances of a particular top-level
object (say "dojo") to another global name (say "myDojo"). In order for the v1.6- multi-version machinery to work, a
build was required, so each module's text is wrapped by a function ([3] in the previous examples of built
modules). If that function defines parameters with the same name as the top-level object that's been relocated and then
passes the actual renamed object as an argument for that parameter, then the desired effect is achieved. Let's look at
that in code.

Say a client application wants to load a private instance of dojo into the global variable "acmeUtils". Assume for
the moment that dojo magically loads dojo base into the global variable acmeUtils. Here's how the dojo/behavior module
could be rewritten by the build system to relocate it into acmeUtils:

.. js ::

  dojo.loader.define(
    // [1] the dojo.provide(s) included in this module
    ["acmeUtils.behavior"],
  
    // [2] the dojo.require(s) included in this module
    [],

    // [3] the module's code
    function(dojo){
      // the dojo/behavior module, completely unedited
      dojo.behavior = new function(){
        //...
      };
    }
  );

Notice the parameter dojo in the factory function ([3]). So long as the loader applies this factory function to the
global object acmeUtils (remember our opening assumption that dojo was magically relocated from the global object dojo
to the global object acmeUtils), every reference to dojo in the dojo/behavior code will not point to global dojo, but
rather will point to global acmeUtils. And this is precisely how dojo magically relocates dojo into the global
acmeUtils. First the global object acmeUtils is created and then each of the base modules is defined in exactly this
manner.

So, in order to get a new, independent instance of dojo (or dijit or any other top-level object), the client application
must provide a map from top-level reference name (for example, "dojo") to relocated name (for example, "acmeUtils"). The
build system and the loader then work together to relocate the mapped name. The map is called a scope map, and is given
in the configuration variable scopeMap, an array of pairs of (not-relocated-name, relocated-name), that maps a
non-relocated name to a relocated name. scopeMap exists in both version 1.6- and version 1.7+. In the example above,
scopeMap would look like this:

.. js ::

  [["dojo", "acmeUtils"]]

Notice that a build is required to make this all work, and scopeMap is a configuration variable set up by the build
application.

As we said in `Relocating Module Namespaces`_, this complexity is not needed when loading multiple instances of AMD packages. If fact, the new
loader can relocate trees of modules by simply setting a configuration variable, and the trees can be built, unbuilt, or
mixed. This feature solves many interoperability problems when mixing and matching several libraries. No other loader
can do this and we're quite proud of this feature.

That concludes a fast and furious review of legacy mode. I devoted more than a chapter to this system in :ref:`my book` if
you want a more-gentle presentation.

Modes of Operation
==================

The v1.7 loader is able to load both legacy modules and AMD modules in the same application. This allows client
applications expressed with the legacy API to use dojo, dijit, and other libraries that have been expressed with the AMD
API. In such cases, the loader must operate synchronously since modules written with the legacy API cannot be loaded
asynchronously. Further, when some or all of the modules are cross domain, the loader can emulate the legacy
cross-domain mode--which is actually asynchronous. Finally, the loader must provide support for injecting legacy
elements with a script element to facilitate cross-domain loading.

The v1.7+ loader has two basic modes of operation:

* asynchronous: modules are loaded asynchronously as per the AMD specification. The loader is put in the asynchronous
  mode by setting the configuration variable async to truthy but not "sync" or "legacyAsync". This mode was described
  in :ref:`The AMD API <loader/amd>`.

* legacy: modules are loaded synchronously just like the v1.6- loader. The loader is put in legacy mode by setting the
  configuration variable async to "sync" or "legacyAsync" or falsy; falsy has the same effect as "sync".

The legacy mode has two sub-modes:

* synchronous: none of the modules reside cross domain so that all of the modules can be retrieved with a
  synchronous XHR transaction

* cross-domain: some or all of the modules reside cross domain so that some or all of the modules must be
  script injected; remember, the loader must load any modules residing cross domain asynchronously because XHR does
  not work for cross domain addresses.

Lastly, the dojo loader is unique and powerful in that it can:

* load either AMD or legacy modules synchronously

* asynchronously load not-cross-domain, not-built, legacy modules (via asynchronous XHR) while in cross-domain mode

* load both AMD modules and legacy modules that have been prepared by the dojo build system while operating in any
  mode.

Yes, that's a lot of combinations. I get tired just writing it down. Let's explore how each mode operates in detail.

Legacy Synchronous Mode
-----------------------

In this mode, everything is loaded synchronously. For synchronous modules there's not much mystery. The module resource
is retrieved with a synchronous XHR transaction and evaluated. The only real different between the v1.7 loader and
previous dojo loaders is how the loader treats the module value.

When dojo.provide is applied to a module identifier, the loader ensures that the named module is created and initialized
with the value given by dojo.getObject(moduleId, true), where moduleId is the module identifier of the given module. Further,
after the module that contained the dojo.provide has completed executing, the loader updates the module value to that
given by dojo.getObject(moduleId). Let's look again at the v1.5 implementation of dijit.Calendar:

.. js ::

  dojo.provide("dijit.Calendar");
  //
  // dojo.requires omitted
  //
  dojo.declare("dijit.Calendar", //...
   
When the dojo.provide is applied, the loader will set the value of the module "dijit/Calendar" to
`dojo.getObject("dijit.Calendar", true)`. It is likely that the object does not exist prior to the `dojo.getObject`
application and a new object is manufactured. As discussed previously, the dojo.declare in the module renders this value
useless, and the loader is left holding that useless object. But, when control returns to the loader, it will update the
value of the module "dijit/Calendar" to `dojo.getObject("dijit.Calendar")` which is the correct value. Notice that the
value of the module "dijit/Calendar" is incorrect until the last statement of the module. Fortunately, this should not
be a problem because, semantically, there is no value for the module until that last statement of a module's factory has
been executed.

This same algorithm is applied if a single legacy module contains multiple dojo.provide applications:

.. js ::

   dojo.provide("myProject.Button");
   dojo.provide("myProject.CheckButton");
   dojo.provide("myProject.RadioButton");

   dojo.declare("myProject.Button", //...

   dojo.declare("myProject.CheckButton", //...

   dojo.declare("myProject.RadioButton", //...

This resource breaks a lot of rules. It actually describes three modules. And, as is typical, the objects created with
`dojo.provide` are useless. Still, the algorithm described above works. Upon return from evaluating this resource, the
loader will ensure that three modules are entered into the loader namespace ("myProject/Button", "myProject/CheckButton",
and "myProject/RadioButton") and that the value of these three modules is as given by the `dojo.declare` applications, not
the `dojo.provide` applications.

Right about now, you're probably asking why this matters. Here's why: you can now write...

.. js ::

  define(
    ["myProject/Button", "myProject/CheckButton", "myProject/RadioButton"],
    function(button, checkButton, radioButton){
  
    // do something spectacular in an AMD module given objects from a synchronous module
  });

So by taking care to ensure synchronous modules are defined in the module space correctly, synchronous modules can
interoperate with AMD modules.

For the most part, implementing the AMD API in synchronous mode is trivial. Just like a synchronous module, the AMD
module resource is resolved by retrieving the resource text via a synchronous XHR transaction. Then the resource text is
evaluated which publishes the (module identifier, dependencies, factory) to the loader. Recall the standard AMD loader
will not attempt to resolve a module by resolving its dependencies and then executing its factory until that module is
demanded. Legacy synchronous mode is not so conservative: the moment the loader is made aware of a module via AMD
define, it will unconditionally recursively resolves the dependency array (left to right, if any) and execute the
factory. require() is handled the same way when it's encountered.

This behavior allows AMD modules to be explicitly injected in an HTML document with <script> elements (that is, <script>
elements written by the programmer, not dynamically injected by the loader). This practice should be avoided, and you
should use the loader to inject modules. Unfortunately enforcing this rule for the v1.x line would break too much code,
hence the behavior when in legacy mode.

The loader also provides for interoperability with synchronous modules. When a synchronous module dojo.require's a
module that happens to be an AMD module, the AMD module is resolved as described above. Of course, synchronous modules
typically don't include code to retrieve AMD module values; further, well-designed AMD modules don't pollute the global
namespace. So, we're in a bit of a bind: the dependent module was defined, but the depending module can't get access to
that dependent module value.

The loader solves this problem by noticing within the `dojo.require` implementation that a module has a value yet the
object associated with the module is undefined. This sounds better in code:

.. js ::

  var result = dojoRequire(moduleName);
  if(has("config-publishRequireResult") && !dojo.exists(moduleName) && result!==undefined){
    dojo.setObject(moduleName, result);
  }

The `dojoRequire(modulename)` application causes the loader to resolved the module `moduleName`. Upon return it pushes
the value of the module into the JavaScript object given by module name if and only if that object is undefined. This
algorithm my be suppressed by setting the has feature "config-publishRequireResult" to falsy; this feature is true by
default.

Legacy Cross Domain Mode
------------------------

This mode is tricky. Indeed, cross-domain loading has been the subject of much head-banging over the years. I'm not sure
I completely buy into it's utility. If you're doing development, you're going to need to download the source version of
the Dojo Toolkit and work off a local environment; ergo, no cross domain problems. Once you're ready to deploy, do a
build which results in converting the application to a 100% AMD-compliant set of modules that can be loaded
asynchronously. Then you can and use one of the CDNs to load the dojo and dijit libraries leaving just your application
code for your own server. Everything is loaded asynchronously via script injection so there are no cross-domain XHR
limitations.

But, if you have a use case that you just can't do without (or are curious), take a deep breath, here we go.

The loader enters cross-domain mode when it's in synchronous mode and a module is requested that resides cross domain and
therefore can't be loaded by XHR. When the loader shifts into cross-domain mode, the follow processes are put in place:

* any module resource that can be downloaded via XHR is downloaded as such (asynchronously), then the source code is
  converted to an AMD module resource on the fly and the newly converted resource is evaluated. This publishes a
  (module-identifier, dependencies, factory) to the loader for the given module just as if it had been an AMD module
  all along.

* any module resource that resides cross-domain is script injected. Such resources are expected to be AMD modules. Of
  course there is no way for the loader to enforce this, and some synchronous modules will load correctly--depending
  upon how they are expressed.

* once all requested modules have been downloaded, then and only then is the dependency tree of the whole batch
  traced, causing all modules to be resolved. Notice this process is different than AMD asynchronous mode which
  executes modules as soon a possible. However, this is the algorithm that's been in place with the dojo cross domain
  loader for v1.x line and it's not going to change.

One thing to notice is that the moment the loader enters cross-domain mode, even legacy modules start executing
asynchronously. So, if the loader happens to be in the middle of tracing the dependency tree implied by several
inter-dependent legacy modules, any further dojo.require applications will cause a module to be downloaded (if it's not
already on board), but will return immediately without executing the module. Version 1.6- also exhibited this behavior.

The conversion process used to convert an unbuilt legacy module to an AMD module is given as follows (the module being
converted is termed the "reference module" in the description that follows):

1. The text of the reference module is analyzed by first removing all comments with a regular expression. The regular
   expression has been in place for many versions, but is far from perfect and can be fooled (e.g., when JavaScript
   comment delimiters are contained in strings). For the record, the regular expression used to find comments is
   ```/(\/\*([\s\S]*?)\*\/|\/\/(.*)$)/mg```. The comment-filtered text is then scanned for the legacy loader
   functions. When found, the text of each loadInit application is aggregated to a single string and the text to all
   other legacy API applications is aggregated to another string.

2. A dojo/loadInit plugin resource is constructed on-the-fly; I'll describe how dojo/loadInit works below. The resource
   is itself a module that defines an object with two properties:

     * names: the list of names given by the scope map associated with the particular instance of dojo that is
       referenced by the module.

     * def: a function that defines a parameter list with parameter names given by names (as described above) and
       consists of code defined by the aggregated loadInit applications concatenated with the aggregated other
       applications.

3. An AMD module is constructed on-the-fly as shown below. <names> is the list of names given by the scope map;
   <names-mapped-to-proper-module-names> is the list of module identifiers indicated by names, computed with respect
   to the reference module; <uid> references the dojo/loadInit plugin module resource constructed in Step 2.

.. js ::

  define([/*<names-mapped-to-proper-module-names>*/, "dojo/loadInit!/*<uid>*/"], function(/*<names>*/){
    //
    // original module text goes here...
    //
    // however, each dojo.loadInit application is prefixed with "0 &&"; this prevents dojo.loadInit from executing
    // for example...
    0 && dojo.loadInit(function(){
      //...
    });
  })

The key to this algorithm is the magical dojo/loadInit plugin. Recall how plugins work. When a plugin resource is found
in a dependency vector, the plugin module is loaded and passed the text to the right of the !. The plugin module then
reports back to the loader when the work implied by the text to the right of the ! has been completed. In our case, the
text to the right points to a module that was constructed in Step 2 the looks like this:

.. js ::

  define(/*<uid>*/, {
    names:
      // (array of strings) the list of names given by the scope map associated with the
      // particular instance of dojo referenced by the reference module

    def:
      function(/* names as described above */){
        // aggregated loadInit applications concatenated with the aggregated other applications
      }
  });

When the dojo/loadInit is given an identifier (the text to the right of the !), it retrieves (via AMD require) that
module definition given by that identifier. Next, dojo/loadInit hijacks the methods dojo.require, dojo.provide, and
dojo.requireLocalization with temporary versions of those methods that allow the dojo/loadInit plugin to sniff and
remember the dojo.required/provided module identifiers. If multiple instances of dojo are defined, the instance of dojo
referenced by the reference module is hijacked. It's not necessary to hijack dojo.require[After]If or dojo.platform
require since these functions are nothing more than syntax sugar for dojo.require and ultimately result in dojo.require
being called.

Next, dojo/loadInit evaluates the code given by def, passing the proper objects to match the parameters given by
names. This causes dojo.loadInit to execute all callbacks (if any), and all dojo.require[After]If applications to
evaluate their conditions and possibly demand additional modules. Upon return from the evaluation, dojo/loadInit is left
with a set of dojo.require'd module identifiers that it sniffed which indicate the modules dojo.require'd by the
reference module. Also, dojo.provide'd sniffed module identifiers are noted to "have arrived" to prevent any attempt at
downloading such modules. This is particularly important when a legacy module dojo.provide's several modules.

Notice what has happened, dojo/loadInit has arranged to execute all of the legacy loader API applications found in the
reference module. But, instead of actually loading and executing any dojo.require'd modules, the dojo/loadInit simply
recorded the module identifiers the reference module would have loaded had the real legacy API not been hijacked. Now,
dojo/loadInit can use this information to arrange for the necessary modules to be downloaded.

After restoring the hijacked methods to their original state, dojo/loadInit downloads the set of modules that the
reference module will dojo.require when it is finally evaluated. Remember, we're dealing with a legacy module here, so
these modules must be downloaded, but not executed, before attempting to execute the reference module. For this task, we
turn to another specialized plugin, dojo/require.

dojo/require expects a comma-separated list of module identifiers to be passed in its id argument. It then downloads all
of the indicated modules. If the modules are cross-domain, then they must be built and therefore in the AMD
format. Downloading AMD modules does not imply executing them so all is good. However, if they are not-cross-domain,
then they may be unbuilt and are therefore downloaded by asynchronous XHR as text and converted to an AMD module
on-the-fly (if necessary) just like the reference module. Once dojo/require detects that all requested modules have
arrived for any self-contained module tree, it signals the requesting module by calling the loaded function. Notice
carefully, that dojo/require does not signal until an entire tree of modules is on board because once the loader starts
executing a legacy synchronous code path, it must be able to complete that code path without interruption.

After dojo/require signals dojo/loadInit that all requested modules are on board, dojo/loadInit signals the reference
module. The reference module can now execute its factory function which contains the original legacy module's code with
the exception that all dojo.loadInit applications (if any) will be passed over since they have all be prefixed with 0
&&. Since dojo/loadInit and dojo/require have worked together to guarantee all modules dojo.require'd in that code are
already on board, the code will execute without interruption--just as if the whole process had occurred synchronously and
nothing was cross-domain.

This design has so much indirection and recursion, it's instructive to trace through an example to get the idea. Let's
assume a scope map of [["dojo", "myDojo"]] and the legacy module "my.module" looks like this:

.. js ::

  dojo.provide("my.module");
  dojo.require("your.module");
  dojo.loadInit(function(){
    dojo.getObject("my.module", true);
    if(document.someMagicSomething){
      my.module.switch = 1;
    }else{
      my.module.switch = 2;
    }
  });
  dojo.requireIf(my.module.switch==1, my.module1);
  dojo.requireIf(my.module.switch==2, my.module2);
  doSomethingAwesome();

The conversion process would construct a loadInit module and rewrite my.module into one evaluable string that looks like
this:

.. js ::

  define('*loadInit_8',{
    names:["dojo",],
    def:function(dojo){
      dojo.provide("my.module");
      dojo.require("your.module");
      dojo.loadInit(function(){
      dojo.getObject("my.module", true);
        if(document.someMagicSomthing){
          my.module.switch = 1;
        }else{
          my.module.switch = 2;
        }
      });
      dojo.requireIf(my.module.switch==1, my.module1);
      dojo.requireIf(my.module.switch==2, my.module2);
  });

  // rewritten my.module
  define(["myDojo","dojo/loadInit!*loadInit_8"], function(dojo){
    dojo.provide("my.module");
    dojo.require("your.module");
    0 && dojo.loadInit(function(){
      dojo.getObject("my.module", true);
      if(document.someMagicSomthing){
        my.module.switch = 1;
      }else{
        my.module.switch = 2;
      }
    });
    dojo.requireIf(my.module.switch==1, my.module1);
    dojo.requireIf(my.module.switch==2, my.module2);
    doSomethingAwesome();
  });

Since my.module was demanded, the loader will attempt to resolve its dependency list and then run its factory
function. This causes dojo/loadInit to resolve ``"\*loadInit_8"`` (the loader guarantees this is a unique synthetic module
identifier). In doing so, dojo/loadInit causes the def function to be executed, passing the value of the global myDojo
object. This causes the dojo.loadInit function contained in the def function to be executed. Let's assume
document.someMagicSomething has a value of 1. This will cause the loadInit callback to set my.module.switch to 1. As the
def function continues executing, it notes:

* the module dojo.provide's "my.module"

* the module dojo.require's "your.module" and "my.module1" (via the dojo.requireIf)

The loadInit function then AMD requires...

.. js ::

  require(["dojo/require!your/module,my/module"], function(){
    loaded(1); // this is the loaded for the original call to dojo/loadInit!*loadInit_8
  });

When dojo/require signals it has completed its work, the modules your/module and my/module--and the entire
dependency tree implied by those modules--is guaranteed to be downloaded. dojo/require signals
dojo/loadInit!*loadInit_8, which signal my/module, which releases the loader to execute my/module's factory
function. There the original legacy code is executed normally except that all dojo.loadInit applications are effectively
removed (notice the 0 &&) and all dojo.required modules are already on board.

Did I say it was tricky?

Legacy Asynchronous Mode
------------------------

Notice one awesome feature of the example just given: the unbuilt legacy module my.module used a relocated dojo. This
was possible because the loader was in legacy cross-domain mode which caused not-built, not-cross-domain modules to be
built on-the-fly. If desired, you can put the loader in this mode permanently by setting the configuration variable
async to "legacyAsync". In this mode, the loader is permanently in legacy cross-domain, whether or not it encountered a
module that resided cross-domain. This implies that all not-cross-domain modules are built on-the-fly (if necessary),
which allows accessing relocated module trees from unbuilt legacy modules.
