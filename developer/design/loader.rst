#format dojo_rst

The Dojo Loader
===============

:Status: Draft
:Version: 1.7+
:Author: Rawld Gill

.. contents::
   :depth: 3

Introduction to the Dojo Loader

============
Introduction
============

TODO

===================
New Loader Overview
===================

Dojo v1.7 includes a new loader that adds several exciting new features. To begin, the new loader fully implements the
`CommonJS`_ `Modules/Asynchronous Definition`_ (AMD) specification. This is an exciting new standard for writing and loading
modules that dramatically improves code portability and interoperability. Equally important, it allows modules to be
loaded asynchronously by injecting script elements which has two key benefits:

  * Many modules can be downloaded in parallel, thereby decreasing overall page load times by as much as 10x.
  * Since all Javascript code is contained within a script elements, the code much more debugger-friendly than eval's
    code.

The new loader includes the complete dojo synchronous loader API (dojo.provide, dojo.require et al) and the loader can
be operated in synchronous mode or xdomain mode just as in v1.6-.

The v1.7 loader is highly configurable, and the release includes configurations for the browser, `node.js`_, and
`rhino`_. Environment-dependent configuration files are typically less than 100 lines of code, and writing the
configuration file for a new environment is trivial. 

Lastly, the v1.7+ loader uses the has.js API to bracket several loader features so that a focused, small loader can be
built by the dojo build tool. In fact, loaders approaching 3K (minimized and gzipped) are possible).

=======
dojo.js
=======

Traditionally, the entry point to the dojo library has been the dojo.js resource. That changes a bit in v1.7
since dojo.js now holds the loader and nothing else. In fact, it is possible to use dojo's loader and not actually load
any of the dojo library. When the loader is evaluated in an application, if it is synchronous mode (the default), it
loads the base dojo library automatically; this can be changed by building a custom version of the loader. On the other
hand, if the loader is put in asynchronous mode by setting the configuration switch `async` to truthy, then nothing is
automatically loaded and it is left up to the application to decide which modules to load via the AMD `require()`
function.

==========
Vocabulary
==========

In a moment, I'm going to start describing the loader API and operation. But before I do, we need to settle on a
vocabulary describing what it means to "load a module".

A module is embodied as a chunk of Javascript code. Usually a single module is contained in a single addressable (e.g., by URL or
filename) resource though it is possible for a single resource to contain the code for several modules. The purpose of
the loader is deceptively simple: 

  * cause a chunk of Javascript code that represents a module to be evaluated in such a manner that it produces a result
    defined as the "module value" given by the particular chunk of code
  * associate a name with the module value; naturally, the name is termed the "module identifier" of MID
  * given the MID of an existing association, return the module value of that association

In short, the loader defines a namespace of module values and provides an API to insert and retrieve elements from that
namespace. I'll call this the "module namespace"

Inserting a module value into this namespace usually involves several steps:

  1. [requested] The client application demands a particular module identifier.
  2. The loader resolves the module identifier into an address (typically a URL or filename) suitable for the method
     required to retrieve the Javascript code that embodies the particular module
  3. [loaded] The loader takes the necessary actions to load the text from the resolved address into the execution environment.
  4. [defined] The loader evaluates the code. As we'll see when we discuss the various loader APIs, this may result in the final
     module value or a factory that must be executed to get the final module value.
  5. [executed] If Step 4 provided a factory, then any other module values that the factory may require to execute are resolved and
     the factory is execute resulting in the final module value.

You can see that words like "loaded", "evaluated", and "defined" may apply equally well to any of Steps 3-5. I've marked
each step with the word in square brackets that I'll use in this document. Lastly, I'll use the work "resolve" to
describe the entire process. For example to resolve the module identifier "myProject/myModule" is to execute Step 2-5 to
that the value of the module indicated by "myProject/myModule" is entered into the module namespace and my may be retrieved.

Notice also that in some environments, Steps 3 and 4 may or may not be separable. For example, if a module is loaded
with a synchronous XHR and then evaluated with Javascript `eval()`, they are separate steps. But if a module is injected
into a document by appending a `script` element and setting the `src` attribute as given by Step 2, then the browser will
accomplish Steps 3 and 4 as one action.

There are two loader APIs available:

  * the CommonJS `Modules/Asynchronous Definition`_ (AMD) API; I'll term this the AMD API.
  * the Dojo loader API with consists of `dojo.require()`, `dojo.provide()`, `dojo.requireIf()`, `dojo.requireAfterIf()`,
    `dojo.platformRequire()`, and `dojo.requireLocalization()`; I'll term this the synchronous API.

This document does not discuss these APIs in detail; there are other resources that focus on one of the other. That
said, the next sections give an overview of each API.

===========
The AMD API
===========

This is the hot new API that is being adopted by a wide variety of Javascript libraries. I've devoted a detailed
tutorial to the API here TODO. Ignoring configuration options, the API consists of the two function `require()` and
`define()`.

`require(deps, callback)` requests the loader to resolve all module identifiers given by `deps` (an array of strings
that must be module identifiers),
and then apply the function `callback` to the resulting module values. `callback` is optional. If provided, the module
values are provided to `callback` as arguments in the same order as the matching module identifiers appear in
`deps`. The entire AMD API is intended to be asynchronous. Consequently, the callback may or may not be applied before
require returns. In short, require is how you retrieve module values from the module namespace.

`define(mid, deps, factory)` inserts a potential module identifier, as given by mid (a string), module value, as given
by factory, into the module namespace. It's a potential value because the module value won't actually be computed as
until the application demands the module value. When a demand is made, the factory is evaluated to compute the module
value once and that result is memorized by the loader for future requests. If factory is a function, then it works just
like require(): factory is applied to the results of resolving deps (an array of strings that must be module
identifiers). Otherwise, when factory is not a function, then factory represents the value of the module and deps may be
(should be) omitted.

Typically `define()` is seen by the loader consequent--directly or indirectly--to the application demanding a module via
`require()`. For example, if the application contains the code

.. code-block :: javascript

  require(["myProject/myModule"], function(myModule){
    // do something spectacular
  });

Then, the `define()` will be called for the module "myProject/myModule" during Step 4 in the process above. The since
the loader is controlling the process by which this `define()` is applied, the loader can deduce the module identifier
associated with any particular `define()` application. Consequently, `mid` argument to `define()` is optional. When
writing normal modules it should always be omitted. This is discussed at length in TODO.

There are a few details about module identifiers which I'll discuss below, but they don't affect the mechanics of the
API; believe it or not, that's it!

===================
The Synchronous API
===================

The Dojo synchronous API was one of the first Javascript module loaders. It is no less powerful than the AMD API, it is
somewhat less convenient in that is requires executing a build in order to achieve highly performant asynchronous
loading. I devoted more than a chapter to this system in `my book`_ if you want all of the details.

The core of the API is `dojo.require(mid)` and `dojo.provide(mid)`. Naturally, `dojo.require` is analogous to AMD
`require()`. Instead of allowing an array of module identifiers, `dojo.require` expects a single identifier. So if you
need to depend on several modules, you must write several `dojo.require` applications. `dojo.require` does return the
"value" of the indicated module, just like AMD require() delivers module values to the callback. However, it seems that
not many libraries--including dojo and dijit--actually use the namespace provided by the dojo synchronous
loader. Instead, applications typically depend on passing their results via some global variable. In dojo and dijit, the
variables are, get ready, `dojo` and `dijit`.

`dojo.provide(mid)` informs the loader that a module is defined and retrieves a loader-manufactured object in which to
store the value of the module. Here's what a typical synchronous module looks like.

.. code-block :: javascript

   dojo.provide("myProject.myModule");
   dojo.require("some.other.stuff")

   // do the work to define the myProject.myModule module

   // stuff it into a global variable
   myProject.myModule= //...whatever

Notice that the return value fro dojo.provide was ignored. Again, this is typical. However, one of the niceties of
dojo.provide is that is manufactures the object "myProject.myModule" in the global namespace. This helps when the module
tries to assign to `myProject.myModule`: `myProject` will be defined.

Next notice that module identifiers are expressed with as a so-called dotted Javascript object name in the synchronous
API compared to slash-delimited segments in the AMD API. Getting the two confused is the number one error when
converting synchronous modules to AMD modules.

Lastly, notice that there is not intermediate Step 4 where a module is defined but not executed as in AMD. It is this
missing step that causes these modules to be synchronous. Once the loader turns a module's code over to the Javascipt
evaluator, it can't put that evaluation on hold while it resolves a module demanded by a `dojo.require`. Instead, it
must resolve the module synchronously.

The remaining synchronous API functions--`dojo.requireIf`, `dojo.requireAfterIf`, `dojo.platformRequire`,
`dojo.requireLocalization`--are largely convenience functions implemented in terms of `dojo.require`. I recommend you
avoid dojo.platformRequire and, particularly, `dojo.requireIf` and `dojo.requireAfterIf`

===========================================
Resolving Module Identifiers into Addresses
===========================================

TODO

==================
Modes of Operation
==================

The loader has two basic modes of operation: 

  * synchronous: modules are loaded synchronously just like the v1.6- loader

  * asynchronous: modules are loaded asynchronously as per the AMD specification

The synchronous mode has two submodes:

  * [normal] not-cross-domain: none of the modules reside cross domain so that all of the modules can be retrieved with a
    synchronous XHR transaction
  
  * [xdomain] cross-domain: some or all of the modules reside cross domain so that some or all of the modules must be script
    injected; notice that the loader must load (Step 3) any modules residing cross domain s asynchronously because XHR
    does not work for cross domain addresses.

Lastly, the dojo loader is unique and powerful in that it can:

  * load either AMD or synchronous modules synchronously (either synchronous-normal or synchronous-xdomain)

  * asynchronously load synchronous modules that are not cross domain while in synchronous-xdomain mode

  * load both AMD modules and synchronous modules that have been prepared by the dojo build system while operating
    either in either  asynchronous or synchronous-xdomain mode.

Yes, that's a lot of combinations. I get tired just writing it down. Let's explore how each mode operates next; I'll limit
the discussion to the browser environment.

=======================
Synchronous-Normal Mode
=======================

In this mode, everything is loaded synchronously. For synchronous modules there's not much mystery. The module resource
is retrieved with a synchronous XHR transaction and evaluated. The only real different between the v1.7 loader and
previous dojo loaders is how the loader treats the module value.

Whenever a `dojo.provide(mid)` application is encountered, the loader ensures that a module with the given `mid` is
created and initialized to executed (Step 5) with the value given by `dojo.getObject(mid, true)`. Further, after the
module has completed executing, the loader updates the value given by `dojo.getObject(mid)`. Let's look again at
the hypothetical synchronous module we saw above:

.. code-block :: javascript

   dojo.provide("myProject.myModule");
   dojo.require("some.other.stuff")

   // do the work to define the myProject.myModule module

   // stuff it into a global variable
   myProject.myModule= //...whatever
   
When the dojo.provide is applied, the loader will set the value of the module "myProject/myModule" to
`dojo.getObject(mid, true)`. It is likely that the object does not exist prior to the `dojo.getObject` application and a
new object is manufactured. Unfortunately, the last line in the module edits myProject.myModule by assignment which
effectively replaces that property in myProject. Consequently, the loader is left holding a useless object. But, when
control returns to the loader, it will update the value of the module "myProject/myModule: to
`dojo.getObject("myProject.myModule")` which is the correct value. Of course this algorithm isn't perfect, the value of
the module "myProject/myModule" is incorrect until the last statement of the module, including the entire time the
module "some/other/stuff" is executing. Fortunately, this should not be a problem because, in reality, there is no value
for the module until that last statement.

Let's look at another module:

.. code-block :: javascript

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

Right about now, you're probably asking why this matters. Here why: you can now write...

.. code-block :: javascript

  define(
    ["myProject/Button", "myProject/CheckButton", "myProject/RadioButton"],
    function(button, checkButton, radioButton){
  
    // do something spectacular in an AMD module given objects from a synchronous module
  });

So by taking care to ensure synchronous module are defined in the module space correctly, synchronous modules can
interoperate with AMD modules.

For the most part, implementing the AMD API in synchronous mode is trivial. Just like a synchronous module, the AMD
module resource is retrieved via a synchronous XHR transaction. Then the resource is evaluated which publishes the (mid,
deps, factory) to the loader. Finally, the loader resolves the deps arrays (left to right, if any) and the executes the
factory. `require()` is handled the same way when it's encountered.

The loader also provides for interoperability with synchronous modules. When a synchronous module
`dojo.require`'s a module that happens to be an AMD module, the AMD module is resolved as described
above. Unfortunately, synchronous modules typically don't include code to retrieve AMD module values (otherwise they
would be AMD modules); further, well-designed AMD modules don't pollute the global namespace. So, we're in a bit of a
bind. The dependent module was defined, but the depending module can't get access to that dependent module value.

The loader solves this problem by noticing within the `dojo.require` implementation that a module has value yet the
object associated with the module is undefined. This sounds better in code:

.. code-block :: javascript

  var result = dojoRequire(moduleName);
  if(has("config-publishRequireResult") && !dojo.exists(moduleName) && result!==undefined){
    dojo.setObject(moduleName, result);
  }

The `dojoRequire(modulename)` application causes the loader to resolved the module `moduleName`. Upon return it pushes
the value of the module into the Javascript object given by module name iff that object is undefined. This algorithm my
be suppressed by setting the has feature "config-publishRequireResult" to falsy; this feature is true by default.


========================
Synchronous-xdomain Mode
========================

This mode is tricky. Indeed, cross-domain loading has been the subject of much head-scratching over the years. I'm not
sure I completely buy into it's utility. If you're doing development, you're going to need to download the source version
of the Dojo Toolkit and work off a local environment; ergo, no cross domain problems. Once you're ready to deploy, do a
build which results in converting the application to a 100% AMD-compliant set of modules that can be loaded
asynchronously. Then you can and use one of the CDN's to load the dojo and dijit libraries leaving just your
application code for your own server. Everything is loaded asynchronously via script injection so there's no
cross-domain XHR limitations.

But, if you've got a use case you just can't do without (or are curious), take a deep breath, here we go.

The loader enters synchronous-xdomain mode when it's in synchronous-normal mode and a module is requested that resides
cross domain and therefore can't be loaded by XHR. When the loader shifts into synchronous-xdomain mode, the follow
processes are put in place:

  * any module resource that can be downloaded via synchronous XHR is downloaded as such, then the source code is
    converted to an AMD module on the fly and the newly converted module is evaluated. This publishes a (mid, deps,
    factory) to the loader for the given module just as if it had been an AMD module all along.

  * any module resource that resides cross-domain is script injected. Such resources are expected to be AMD modules. Of
    course there is no way for the loader to enforce this, and some synchronous modules will load correctly--depending
    upon how they are expressed.

  * once all requested modules have been downloaded, then and only then is the dependency graph of the whole batch
    traced, causing all modules to be resolved. Notice this is not the same as a typical AMD loader which executes
    modules as soon a possible. However, this is the algorithm that's been in place with the dojo cross domain loader
    for v1.x and it's not going to change.

One thing to notice is that the moment the loader enters xdomain mode, even synchronous modules start executing
asynchronously. So, if the loader happens to be in the middle of tracing the dependency tree implied by several
inter-dependent synchronous modules, any further `dojo.require` * applications will cause a module to be downloaded (if
it's not already on board), but will return immediately without executing the module. 

The conversion process used to convert a synchronous module to an AMD module is given as follows:

  1. all comments are removed from the module text using a regular express. The expression is good and has been in place
     for many versions. However, it's not perfect and can be fooled (e.g., when Javascript comment delimiters are
     contained in strings.

  2. The module text is scanned for synchronous `dojo.require` * applications; all discovered applications are evaluated
     to determine the set of modules upon which them scanned module depends.

  3. An AMD module is constructed by prefixing the module text with `define(deps, function() {`, where deps the list of
     dependencies discovered in Step 2, and adding the suffix `});`. This effectively transforms the module into an AMD
     module that can be published to the loader.

When the module is finally executed, the algorithm dealing with `dojo.provide()` described in the previous section is
employed.


=================
Asynchronous Mode
=================

In this module, all modules are script-injected and the loader implements the the CommonJS `Modules/Asynchronous
Definition`_ (AMD) specification. See TODO for details.

=========
Debugging
=========

TODO
