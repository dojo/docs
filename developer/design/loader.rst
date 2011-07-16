#format dojo_rst

The Dojo Loader
===============

:Status: Draft
:Version: 1.7+
:Author: Rawld Gill

.. contents::
   :depth: 3

The Dojo Loader

============
Introduction
============

Dojo v1.7 includes a new loader that fully implements the `CommonJS`_ `Modules/AsynchronousDefinition`_ (AMD)
specification. This is an exciting new standard for writing and loading modules that dramatically improves code
portability and interoperability. Equally important, it allows modules to be loaded asynchronously by injecting script
elements which has two key benefits:

  * Modules can be downloaded asynchronously and concurrently, thereby decreasing page load times by as much as
    10x.

  * Since all Javascript code is contained within a script element, the code is much more debugger-friendly compared to
    eval'd code.

Both of these features are missing from the v1.6- dojo loader which downloads Javascript resources with synchronous XHR
and uses Javascript eval to execute the code.

The loader is fully backward compatible and includes the complete dojo synchronous loader API (dojo.provide,
dojo.require et al) and the loader can be operated in synchronous mode or cross-domain mode just as in v1.6-.

In addition to these core APIs, the loader includes other important features:

  * High configurability: the release includes configurations for the browser, `node.js`_, and
    `rhino`_. Environment-dependent configuration files are typically less than 100 lines of code; writing the
    configuration file for a new environment is trivial (see xxx).

  * has.js API: The loader implements the has.js API and then uses that API to bracket several loader features so that a
    focused, small loader can be built by the dojo build tool. In fact, loaders approaching 3K (minimized and gzipped)
    are possible. Currently, we believe the dojo loader to be the smallest AMD loader available.

  * Configuration API: The loader includes a configuration API that may be leveraged by client applications,
    allowing program designs that have exactly one entry vector for user configuration.

How much the new loader affects your application depends on your use case. The entire Dojo team has worked hard to weave
all of these new features into a release that, with a couple of small exceptions, is completely backwards compatible
with v1.6. In many cases, you'll be able to download the new release and see things "just work". But to get the full
benefit of these new features, you must make some small modifications to your modules. Rest assured, most of these
changes are simple once you understand the AMD API.

This tutorial explains the new loader "head to toe". If you're writing a new application, you can safely skip the parts about
backcompat.

=======
dojo.js
=======

For the version 1.x line, the Dojo Toolkit is comprised of five source trees:

dojo 
  The dojo Javascript library: the loader, has.js, browser sniffing, language extensions, class system, various
  asynchronous/event programming APIs, document and window load and unload detection, DOM functions including effects,
  XHR/script/iFrame, data, store, i18n, RPC, drag-and-drop, i18n, and a few other miscellaneous APIs.

dijit
  The Dojo Toolkit widget system and many widgets. dijit depends on dojo.

dojox
  Various extentions (dojox==="dojo extensions") to dojo and dijit.

util
  Tools supporting the the Dojo Toolkit ecosystem, in particular DOH ("dojo objective harness", a testing framework),
  the dojo build system, and the dojo documentation parser.

demos
  Several demonstrations of the toolkit. (Note: the demos tree is never included in any packaged distributions; you must pull
  it from the project repository.)

Releases of the Dojo Toolkit are available in two different kinds of packages:

  * Compressed and optimized for immediate deployment: each Javascript resource has been processed by a minifier that
    makes the resource size smaller. The minifier removes whitespace and comments, and applies certain other code
    transformations (for example, local variables are renamed to use short names) that makes the resource size smaller
    yet functionally equivalent. Also some resources are actually aggregates of several resources. For example dojo.js
    contains the dojo.js resource concatenated with several other resources that define the so-called dojo "base" API
    (the base API is defined by the the tree of resources implied by the resource dojo/main.js). Notice that
    "compressed" does not mean data compression (e.g. zipped); in this context, it means minified.

  * Source package: the Javascript resources appear exactly as they do in the code repository.

Current releases are always available from http://dojotoolkit.org/download. If you are doing any significant
development, you should download a copy of the source version to your local machine and reference that resource
tree. Unless specifically stated, this tutorial assumes the source package.

Prior to v1.7, dojo.js caused both the dojo loader and the dojo library bootstrap to be defined. This design has been
refactored so that dojo.js now holds the loader and nothing else. In fact, it is possible to use dojo's loader and not
load any of the dojo library. When the loader is evaluated in an application, if it is synchronous mode (the default for
v1.x; I'll describe the various modes in xxx), it loads the dojo base API automatically. Also, in synchronous mode,
the Dojo legacy loader API (dojo.require and the rest) is fully defined and available. So, to load dojo, simply
write:

.. code-block :: html

  <script type="text/javascript" src="path/to/dojo/dojo.js"></script>
  <script type="text/javascript">
    // the dojo base API is available here
  </script>

I'll describe how to configure the loader in the next section. For now, it's enough to know that you can
put the loader in asynchronous AMD mode by setting the async configuration variable to truthy like this:

.. code-block :: html

  <script type="text/javascript" data-dojo-config="async:1" src="path/to/dojo/dojo.js"></script>
  <script type="text/javascript">
    // WARNING: nothing but the AMD API is available here
  </script>

Notice that if the loader is put in asynchronous AMD mode by setting the configuration switch `async` truthy, then the
only thing defined is the AMD loader itself. In particular, neither dojo nor any other library is automatically defined,
and it is left up to the application to decide which modules to load via the AMD API. The AMD loader definition consists
of but two global functions, require and define; I'll describe the full AMD API in detail starting in in xxx. If the
global function define is already defined before attempting to load the loader, then the loader will print a message
to the console and refuse to define itself.

This little example also demonstrates a convention I'll use when describing boolean values. I'll use the word "truthy"
to indicate any value that, when converted to a boolean type, would have the value of true; I'll use the work "falsy"
analogously. Lastly, I'll use the work "booleanish" to indicate any type that will be interpretted as a boolean.

==========================
The Loader Micro Event API
==========================

The loader defines a micro event API that it uses to report errors, configuration changes, tracing, and idle state. The
API consists of two function, both members of global require:

.. code-block :: javascript

  require.on = function(
    eventName, // (string) the event name to connect to
    listener   // (function) called upon event
  )

  require.signal = function(
    eventName, // (string) the event name to signal
    args,      // (array) the arguments to apply to each listener
  )

The loader itself uses require.signal to signal its own events. For example, in the next section we'll see that the loader
signals a configuration change like this:

.. code-block :: javascript

  require.signal("config", [
    config,   // the configuration object sent to the loader
    rawConfig // the aggregate of all configuration objects sent to the loader
  ]);

Clients connect to a loader event by supplying a listener function to require.on for the particular event of interest. For
example, a client could connect to the config event to watch for its own configuration changes like this:

.. code-block :: javascript

  var handle = require.on("config", function(config){
	if(config.myApp.myConfigVar){
	  // do something
    }
  });

Notice that require.signal for the config event passed a two-element array. This results in all listeners receiving two
arguments, namely config and rawConfig; note carefully, they do not receive a two-element array. Individual listeners
only need to define the parameters they are interested in accessing. The example above did not care about the rawConfig
parameter, so it did not define it.

require.on returns an opaque object that may be used to disconnect the event by calling the method remove. Here's how to
disconnect the listener connected above.

.. code-block :: javascript

  handle.remove();

Often, event semantics are such that applications will make a single connection and never disconnect. In these cases,
the return value from require.on can be ignored and the handler never diconnected.

The loader reserves the event names "error", "config", "idle", and "trace". Client applications are free to use the
micro event API to signal and connect to their own events otherwise.

=================================
Configuring the Loader (and Dojo)
=================================

As we explore the new loader, we'll see that many features are controlled by configuration. So let's cover the mechanics
of how to set and change the configuration before we get into feature descripts.

Configuration data is passed to the loader in a Javascript object that holds a map from configuration variable name to
value. As mentioned above, the object can be passed by specifying it as the value of the data-dojo-config attribute of
the script element that injects dojo.js. When the object is passed using this method, the opening and closing
curly-brackets must be ommitted from the object expression. The text value of data-dojo-config must be a Javascript
expression that, when surrounded by those missing curly-brackets, has the value of a Javascript object. Here's a simple
example:

.. code-block :: html

  <script 
    type="text/javascript" 
    data-dojo-config="async:true, cacheBust:new Date(), waitSeconds:5" 
    src="path/to/dojo/dojo.js">
  </script>

data-dojo-config is handy for setting a small number of simple configuration variables. However, it becomes cumbersome
when many configuration variables are specified or the values involve computations. To solve this problem, the loader
interprets the global variable dojoConfig as holding a configuration object. Naturally, in order for the loader to
utilize dojoConfig, it must be initialized prior to injecting the loader on the page. For example

.. code-block :: html

  <script type="text/javascript">
    var dojoConfig = {
      async:true, 
      cacheBust:new Date(), 
      waitSeconds:5
    };
  </script>
  <script type="text/javascript" src="path/to/dojo/dojo.js"></script>

For backcompat, the deprecated variable djConfig is also recognized by the loader as holding configuration data. If both
dojoConfig and djConfig are defined, djConfig is ignored. If either dojoConfig or djConfig exist and a data-dojo-config
attribute value is also given, then both configuration objects are consumed, but if a particular configuration variable
exists in both objects, then the value given by data-dojo-config wins.

The loader can also accept configuration after it is defined. The loader-defined global function require takes a
configuration object; require has the following signature:

.. code-block :: javascript

  require(
    configuration, // (object, optional) a configuration object
    dependencies,  // see xxx
    callback       // see xxx
  )

The configuration object is the same kind of object we've been discussing. I'll describe the dependencies and callback
arguments when we get to the AMD API; for now, just assume they are not provided. Here's an example of passing a
configuration through require:

.. code-block :: javascript

  require({
    cacheBust:new Date(), 
    waitSeconds:5
  });

In summary, there are three ways to pass configuration data to the loader:

  1. before the loader is defined via dojoConfig
  2. in the script element that injects the loader via the data-dojo-config attribute
  3. after the loader is defined via the global require function

As far as the loader is concerned, dojo (and dijit and dojox) are just libraries to load, and they have no special
status. Yet, in designing the system, we didn't want to define two configuration APIs, one for the loader and one for
dojo and the rest. Further, since the configuration API had to be designed to serve both the loader and dojo
independently, we decided to design it in a way that client applications could use it for their own
configuration. Assuming we got it right, this allows any dojo-loader-based application to have a single configuration
API that serves the loader, dojo and other Dojo Toolkit libraries, and client applications, which is a nice step in
controlling complexity.

Here's how it works. When a configuration object is passed to the loader through any of the three methods described
above, the loader notices any configuration variables that it understands and applies them to it's own runtime
state. It also copies (via the Javascript assignment operator) all properties in the configuration object into the
property rawConfig (an object), a member of the global require function.

Notice that the copy operation into rawConfig is pretty rough. Each time a configuration object is passed to the loader
that contains a property, say p, the entire contents of rawConfig.p is replaced with the passed config.p. If p is a
non-aggregated type like a boolean, string, number, then there is no problem. However, if p is an aggregate type, for
example a hash of values as represented by a Javascript object, then replacing p wholesale may not be the
intent. Perhaps the second configuration was intended to add or subtract from the current configuration.

In order to solve this problem, the loader includes the event "config" that is signaled via the micro event API whenever
configuration data is received. The config events passes two arguments to listeners:

  * config: the particular config object passed to the loader that triggered the event
  * rawConfig: the aggregate of all config objects sent to the loader

That covers the configuration API. The various configuration variables that apply to the loader will be discussed in the
context of the features they control. See xxx for a reference to all loader and dojo configuration variables. Since the
has.js API is also used for configuration, let's look at that next.

==============
The has.js API
==============

`has.js`_ was originally envisioned as a browser feature-detection API. The idea was to...

  * separate feature detection from feature-dependent code branching
 
  * bracket feature-dependent code to guarantee correct runtime operation and allow the possibility of trimming branches
    with build systems in order to create platform-optimized versions of applications

I'll describe dojo's implementation of has.js in detail, but here's a self explanitory example of adding a test:

.. code-block :: html

  has.add("dom-addeventlistener", !!document.addEventListener);

And then later using that test:

.. code-block :: html

  if(has("dom-addeventlistener")){
    node.addEventListener("click", handler);
  }else{
    node.attachEvent("onclick", handler);
  }

Though trivial, this API controls the complexity of feature detection and feature-dependent code branching. It's
function set is minimal, orthogonal, and nicely self-documenting. But there's more.

Consider how a library like dojo, that must work correctly on both the desktop and various other platforms, might be
optimized for an application targeted at just the iPhone. In such a case, the application developer knows that
addEventListener will always be available. So every occurence of has("dom-addeventlistener") can be replaced with true
and the test for the dom-addeventlistener feature can be removed. In fact, this can be done automatically by a
program. For example, if the dojo build system is given a profile that indicates has("dom-addeventlistener") is
static and true, it will transform the code above as follows:


.. code-block :: html

  0 && has.add("dom-addeventlistener", !!document.addEventListener);

  if(1){
    node.addEventListener("click", handler);
  }else{
    node.attachEvent("onclick", handler);
  }

When this code is passed on to a reasonable minifier, the had.add statement, the if condition, and the else clause will
be removed, resulting in the following code:

.. code-block :: html

  node.addEventListener("click", handler);

When these techniques are applied to significant libraries like dojo (and, large, multi-platform-targeted applications), very
large space savings are possible. These savings are particularly important in the mobile environment where bandwidth
and cache size are more limited than in the typical desktop environment.

Of course there are many reasons other than feature availability that cause code to be used/unused. For example, recall
that configuration can be passed by the data-dojo-config attribute in the script element that loads dojo.js. The
function that sniffs the page for the correct script element and then decodes and evalutes the data-dojo-config
attribute is useless if the configuration for a particular application is set via the dojoConfig global variable. 

In most situations like this, the best design is to factor out such code into a separate module that is then simply not
loaded when not needed. But is some cases, the sniffing code being one of them, this is not possible. Still, by
bracketing the code with a has.js feature test, the code can be eliminated when an application is optimized by dojo's
build system.

Since the loader cannot rely on a module system to bootstrap itself and therefore cannot conditionally include modules,
many of its features are has-bracketed. Consquently, the loader must define the has.js API. The definition included with
the loader is 100% compatible with the API published by the has.js project, but includes a couple of additional
features. It is so trivial, here it is in its entirety:

.. code-block :: html

  var
    global = this, // this points to the global space

    doc = global.document,
    
    element = doc && doc.createElement("DiV"),
    
    has = req.has = function(name){
        return hasCache[name] = isFunction(hasCache[name]) ? hasCache[name](global, doc, element) : hasCache[name];
    },
    
    hasCache = has.cache = {},
    
  has.add = function(name, test, now, force){
    (hasCache[name]===undefined || force) && (hasCache[name] = test);
    return now && has(name);
  };

There are two features the implementation shown above has that the has.js project does not:

  * the cache of tests (has.cache, a map from test name to test or test result) is public

  * the function has.add includes an optional forth parameter, force, that can be used to over-write an existing
    test. This is useful to conditionally override an existing or default configuration.

The loader initializes the has cache with several tests (see xxx for a list of these tests). User configuration can
override any of these and/or add more tests by specifying a has configuration variable (an object just like
has.cache). For example,

.. code-block :: html

  <script type="text/javascript">
    var dojoConfig = {
      has: {
        "config-tlmSiblingOfDojo":0,
        "myApp-someFeature":1
      }
    };
  </script>

Sets the test values for has features config-tlmSiblingOfDojo and myApp-someFeature to 0 and 1, respectively. Later, I'll
describe how the default value of config-tlmSiblingOfDojo is 1 (and what that feature does). The configuration given
above would override that default value. Although the example provides constant values for tests, the tests could just as
well be functions.

Notice that has.js is being used as a kind of "super-configuration" machinery: during run-time, it controls the code
path, but during build-time it can completely eliminate code paths from the program text. 

In any event, since has features can be used very much like configuration variables, the loader configuration API
applies has.add to all configuration variables it receives after prefixing the configuration variable name with
"config-" to turn it into a has feature name. For example, if the configuration variable "myConfigVariable" is set to
someValue through the loader configuration API, then has.add("config-myConfigVariable", someValue) is automatically
executed by the loader. When has.add is called on configuration variables, the now argument is always set to false; the
force argument is also set to false unless the configuration is consequent to dojoConfig or data-dojo-config being
processed when the loader is defining itself.

Let's look at one last example to drive all of this home. Suppose data-dojo-config was given as follows:

.. code-block :: html

  <script 
    type="text/javascript" 
    data-dojo-config="tlmSiblingOfDojo:0"
    src="path/to/my/dtk/dojo/dojo.js">
  </script>

By default, when the loader is defining itself, it will set the has feature config-tlmSiblingOfDojo to 1. But when this
config is processed, the configuration variable "tlmSiblingOfDojo" results in had.add("config-tlmSiblingOfDojo", 0,
false, true) being executed. The fourth argument is true because the configuration was recieved by
data-dojo-config. This will result in has("config-tlmSiblingOfDojo") having the value of 0, which is the desired affect
of the configuration given (and the reason we named the feature as such).

==========
Vocabulary
==========

We need to cover one more prerequisite before describing the AMD API and the dojo legacy loader API: we need to
develop some vocabulary.

A module is embodied as a chunk of Javascript code. The purpose of the loader is deceptively simple:

  * cause the chunk of Javascript code that represents a particular module to be evaluated in such a manner that it
    produces a result defined as the "module value" given by the particular chunk of code

  * associate a name with the module value; naturally, the name is termed the "module identifier"

  * given the module identifier of an existing association, return the module value of that association

Although it is possible for a single resource to contain the code for several modules, to do so is a bad practice and a
single module should be contained in a single addressable (e.g., by URL or filename) resource.

The loader defines a namespace of module values and provides an API to insert and retrieve elements from that
namespace. I'll call this the "module namespace".

Inserting a module value into this namespace usually involves several steps:

  1. [requested] The client application demands a particular module value by providing a module identifier.

  2. The loader resolves the module identifier into an address (typically a URL or filename) suitable for the method
     required to retrieve the Javascript code that embodies the particular module.

  3. [loaded] The loader takes the necessary actions to load the text from the resolved address into the execution
      environment.

  4. [defined] The loader evaluates the code. As we'll see when we discuss the various loader APIs, this may result in the final
     module value or a factory that must be executed to get the final module value.

  5. [executed] If Step 4 provided a factory, then any other module values that the factory may require to execute are resolved and
     the factory is execute resulting in the final module value.

You can see that words like "loaded", "evaluated", and "defined" may apply equally well to different steps. I've marked
each step with the word in square brackets that I'll use in this tutorial. Lastly, I'll use the work "resolve" to
describe the entire process. For example to resolve the module identifier "myProject/myModule" is to execute Steps 2-5 so
that the value of the module indicated by "myProject/myModule" is entered into the module namespace and may be
retrieved. Note that after a module is resolved, the loader remembers the association between module identifier and
module value so that future requests can be answered immediately without having to rerun the process.

Notice also that in some environments, Steps 3 and 4 may or may not be separable. For example, if a module is loaded
with a synchronous XHR and then evaluated with Javascript `eval()`, then they are separate steps. But if a module is injected
into a document by appending a `script` element and setting the `src` attribute as given by Step 2, then the browser will
accomplish Steps 3 and 4 as one action.

There are two loader APIs available:

  * the CommonJS `Modules/Asynchronous Definition`_ (AMD) API; I'll term this the "AMD API".
  * the Dojo loader API which consists of `dojo.require()`, `dojo.provide()`, `dojo.requireIf()`, `dojo.requireAfterIf()`,
    `dojo.platformRequire()`, and `dojo.requireLocalization()`; I'll term this the "legacy loader API".

===========
The AMD API
===========

This is the hot new API that is being adopted by many Javascript libraries. The core API is simple,
containing but two functions, require and define. Both of these functions reside in the global namespace and are
available after the loader itself has been defined.

The global function require causes Javascript resources to be evaluated; it has the following signature:

.. code-block :: javascript

  require(
    configuration, // (object, optional) configuration object
    dependencies,  // (array of strings, optional) module identifiers giving the modules to load before calling callback
    callback       // (function, optional) applied to module values implied by dependencies
  )

If configuration is provided, then it is passed through the loader's configuration API as described above. Next, the
Javascript modules implied by the strings contained in dependencies (if any) are resolved, and finally callback (if any) is
applied those resolved module values. require does not return any useful information.

As far as the AMD API is concerned, require is an asynchronous function, and there is no guarantee that all of the
prescribed processing has completed prior to it's return. However, because Dojo must maintain backcompat for the version
1.x line, require operates either synchronously or asynchronously depending upon the operating mode of the loader. The
loader is put in asynchronous AMD mode by setting the configuration variable async to truthy but not "sync" or
"legacyAsync". For example the values true or 1 will work. Asynchronous AMD mode means the loader is operating as
intended by the AMD specification; for the remainder of the description of the AMD API, I'll assume the loader is in
asynchronous AMD mode. See xxx for a description of how the loader works when in a legacy mode.

In order to understand how require works, we must understand...

  * how a particular module identifier given in dependencies is resolved into some chunk of Javascript code
  
  * how a particular chunk of Javascript code is evaluated and returns a value to the loader which may then be passed to
    callback

Let's answer the second question first.

In the browser environment, Javascript resources are usually loaded by attaching a script element to the document with
its src attribute pointing to the resource. I say "usually" because the dojo loader allows Javascript resources to be
precached (typically arranged by the dojo build system); also, the dojo loader can operate in nonbrowser environments.

In general, the loader has no control about what a script actually does; in some environments, the loader doesn't even
have control over the order of execution of demanded scripts. Further, notice that since a script may be loaded by
attaching a script element to the document, the loader has no way of collecting a result from the script. Instead, the
script must explicitly inform the loader how to create a module value. This is the purpose of the second core function, define.

The global function define informs the loader how to create a module value; it has the following signature:

.. code-block :: javascript

  define(
    moduleId,      // (optional, string) the module identifier naming the module being defined
    dependencies,  // (optional, array of strings) module identifiers giving the modules to load before calling factory
    factory        // (any) describes how to create the value for the module
  )

If factory is a function, then the module value is created by applying the function to the values of the modules implied
by the dependency vector; otherwise, the module value is taken to be the value of factory directly. Though not
prohibited, it would be odd to include a dependencies argument when the factory argument is not a function. However,
whenever such dependencies are included, they will be resolved before the module value is created as given by the factory
argument. Just like require, assuming the AMD API and no Dojo backcompat extensions, define is asynchronous and returns
immediately. Lastly, if just factory is given and it is a function, then some special semantics are implied; I'll
discuss this in xxx.

Note carefully: define does *not* directly create a module value. The purpose of define is to inform the loader how
to create a module value and enter a (module identifier, module value) pair into the module namespare when the given
module is demanded for the first time consequent to resolving the dependencies of a require or another define
application. Consider the following code:

.. code-block :: javascript

  var someValue = 5;
  define("my/module", {value:someValue});
  define("my/otherModule", ["my/module"], function(myModule){
	return 10 * myModule.value;
  });

  // point 1

  require(["my/otherModule"], function(otherModule){
    // prints 50 to the console
    console.log(otherModule);
  });

  someValue = 10;
  require(["my/otherModule"], function(otherModule){
    // prints 50 to the console
    console.log(otherModule);
  });

At point 1, the loader "knows" how to create the module values for my/module and my/otherModule when and if they are
requested. It has *not* created those values and entered their (name, value) pairs into the module namespace because they
have not been demanded. After point 1, when the first require is applied, the loader attempts to resolve my/otherModule. Since
my/otherModule depends on my/module, the loader attempts to resolve my/module. This causes the loader enter the pair
("my/Module", {value:5}) into the module namespace. Accordingly, the factory function for my/otherModule is applied to
the value of myModule, {value:5}, causing the result of the factory to be 50 and the pair ("my/otherModule", 50) to be
entered into the module namespace. Finally, the callback given in the first require call is applied to the value of
my/otherModule, 50, causing 50 to be printed to the console.

When the second require call is applied, the loader notices that my/otherModule has already been entered into the module
namespace and simply applies the callback to the value of my/otherModule, still 50, again causing 50 to be printed to the
console. There are two, very important principles to understand about the AMD loader API.

  * A module value is not created until it is demanded. This further implies that simply presenting a module definition
    to the loader with a define application will not cause the modules given in the dependency vector to be resolved and
    the factory to be executed.,

  * Once a module value has been entered into the module namespace it is not recomputed each time it is demanded.

Notice that the moduleId argument is optional in define. If missing, the loader derives moduleId from the module
identifier in the dependency vector that caused the resource that contained the define application to be loaded. For
example, if the code...

.. code-block :: javascript

  require(["mathLib/arithmetic"]);

...caused the loader to load a script containing the code...

.. code-block :: javascript

  define({
    add: function(x, y) { return x + y; },
    sub: function(x, y) { return x - y; }
  });

...then the loader can derive that the define application has the implied moduleId of "mathLib/arithmetic". Of course
this only works if a particular resource contains at most one define application with a missing moduleId argument. These
observations indicate a best practice (in xxx, I show you how this best practice helps module portability).

  * moduleId should not be provided explicitly in a define application

  * a resource that defines a module should contain a single define application. In particular, multiple define
    applications should be avoided.

We've now answered the first question about require, how the loader becomes aware of module values:

  * The dependency vector in either a require or define application demands modules.

  * define applications contained in resources loaded consequent to those demands cause the loader to associate a module
    value with a module identifier and remember the association.

The dependencies and callback parameters in the require function work exactly like the dependencies and factory
parameters in the define function. The values passed to either the callback argument (in the case of require) or the
factory argument (in the case of define, when factory is a function) are just module values previously associated with
module identifiers. For example,

.. code-block :: javascript

  require(
    ["dijit/layout/TabContainer", "bd/widgets/stateButton"], 
    function(tabContainer, stateButton) {
      // do something with tabContainer and stateButton...
    }
  );

... and ...

.. code-block :: javascript

  define(
    ["dijit/layout/TabContainer", "bd/widgets/stateButton"],
    function(tabContainer, stateButton) {
      // do something with tabContainer and stateButton...
    }
  );

...both gain access to the values of the dijit/layout/TabContainer and bd/widgets/stateButton modules by the loader
two-step:

  * list the module identifier in the dependency vector

  * provide a parameter in the callback function definition (in the case of require) or the factory function definition
    (in the case of define, when factory is a function) that receives the value of the module listed in the dependency
    vector

The items in the dependency vector are matched to parameters in the callback/factory function by position. The parameter
names are not significant to the loader. For example, this is perfectly legal, if not ridiculous, code:

.. code-block :: javascript

  require(
    ["dijit/layout/TabContainer"],
    function(supercalifragilisticexpialidocious) {
      // do something with tabContainer...
    }
  );

The discussion so far assumes that any module identifier specified in a dependency vector always results in loading a
script that includes a define application. But, what if you just want to download and evaluate a chunk of code that
doesn't define a module? That's OK too. The loader machinery will detect when the resource has been evaluated and notice
that a module was not defined. In this case the loader simply notes that the module isn't really a module, but just a
chunk of code. If you happen to demand the value for such a "nonmodule", the loader will return undefined.

There's one last detail about retrieving module values we need to cover. What if some random chunk of code existing
somewhere in your application wants a module, say dijit/layout/TabContainer, and further, that chunk of code is not
part of a callback or factory function or didn't include dijit/layout/TabContainer in the dependency vector, yet that same
random chunk of code happens to know that dijit/layout/TabContainer has been defined? To solve this problem, the loader
defines the alternate require signature:

.. code-block :: javascript

  require(
    moduleId // string
  ); 

When require is provided a single string argument, that argument is interpreted as a module identifier and require
returns the current value associated with that module identifier. If the given module has not been defined, then the
loader throws an exception.

While there are legitimate uses for this form of require, I recommend you avoid it since it tends to open up a potential
program error in your application when the module you think is defined actually is not.

To recap, at its core, the AMD API defines a namespace that may be populated and accessed asynchronously. Names (module
identifiers) are inserted into the namespace with define, and values are retrieved from the namespace through the
dependency vectors of require and define or the alternate require signature mentioned above.

This namespace can be used by application authors to manage the global namespace. This idea is sometimes misconstrued:
it is wrong to say the loader "doesn't allow global variables." The loader has no control over such matters. It is up to
individual programmers to determine whether or not to pollute the global namespace. The loader merely gives machinery
that programmers may use to store their top-level names.

===========================
Relative Module Identifiers
===========================

So far, we've seen module identifiers appear in two locations:

  * in the moduleId argument of the define function
  * in the dependencies argument of both the require and define functions

Module identifiers given in the dependencies vector in a define function application can be relative identifiers. For
example, consider the define application...

.. code-block :: javascript

  define(
    "myPackage/myModule",
    ["myPackage/utils", "myPackage/myModule/mySubModule"],
    function(utils, submodule) {
      // do something spectacular
    }
  );

When the loader is processing this define application, it understands it is defining the module myPackage/myModule; this
is termed the "reference module" with respect to this define application. The loader allows module identifiers to be
relative to the reference module. Therefore, you can rewrite the define application above as follows:

.. code-block :: javascript

  define(
    "myPackage/myModule", 
    ["./utils", "./myModule/mySubModule"], 
    function(utils, submodule) {
    // do something spectacular
    }
  );

The relative module identifiers "./utils" and "./myModule/mySubModule" are relative to the reference module
myPackage/myModule, where "./" ⇒ "myPackage/". You can loosely think of "." as the "directory" of the current
module. So we have

"./utils" ⇒ "myPackage/utils

and

"./myModule/mySubmodule" ⇒ "myPackage/myModule/mySubmodule

Recall that the moduleId argument can be implied. So, we can write...

.. code-block :: javascript

  require("myPackage/myModule");

...and then, in the Javascript resource implied by myPackage/myModule, write...

.. code-block :: javascript

  define(
    ["./utils", "./myModule/mySubModule"],
    function(utils, submodule) {
      // do something spectacular
    }
  );

Once again, ./utils and ./myModule/mySubModule are relative to the reference module, which in this case is implied. This
is the best practice for defining modules:

  * The module name should never be specified explicitly.

  * Any module identifiers that are members of the same package as the module being defined should be specified as
    relative identifiers.

If these rules are followed, then the loader can provide a very powerful feature to package consumers: the top-level
namespace can be fully controlled to load two different packages with the same name and/or two different versions of the
same package. We'll explore this in detail in xxx.

Let's finish up one last detail about reference modules. Suppose I have a factory function that, depending on program
flow, needs to conditionally require and execute some code. For example,

.. code-block :: javascript

  // this is the resource for the module "myApp/topLevelHandlers"
  define(
    ["dojo"], 
    function(dojo) {
      dojo.connect(dojo.byId("debugButton"), "click" function() {
        require(
          ["myApp/perspectives/debug"], 
          function(perspective) { perspective.open(); }
        );
      });
  
      // etc.
  
    }
  );
    

The factory function simply hooks up an event handler that loads some code if and when the user clicks a particular
button. This code is perfectly legal code, but it can be better. Notice how the require application uses a
fully-qualified (that is, not relative) module identifier. But, since this code is in the myApp/topLevelHandlers module,
we ought to be able to write "./perspectives/debug" instead of "myApp/perspectives/debug". Unfortunately, the global
require function doesn't know anything about reference modules. What we need is a way to remember the reference module
for later use.

You can get this effect by specifying the module identifier "require" in the dependency vector:

.. code-block :: javascript

  // this is the resource for the module "myApp/topLevelHandlers"
  
  define(["dojo", "require"], function(dojo, require) {
    dojo.connect("debugButton", "click" function() {
      require(
        ["./perspectives/debug"], 
        function(perspective) { perspective.open(); }
      );
    });
  
    // etc.
  }); 

The require application is now executed on the lexical variable require--not the global require function. The loader
arranges for this require to resolve module identifiers with respect to the reference module in which it was
provided. This context-sensitive require function is termed a "context require". The resulting code now abides by the
best practice of always using relative module identifiers when defining a module.

=============
Alias Modules
=============

Consider the following module definition:

.. code-block :: javascript

  // this is the resource for the module "my/text"
  define(["your/text"], function(yourText) {
	return yourText;
  });

Now, ask yourself, are the values of the two text lexical variables in the following two require applications equivalent?

.. code-block :: javascript

  require(["my/text"], function(text){
    // do something
  });

  require(["your/text"], function(text){
    // do something
  });

Answer: yes, they are equivalent. And it would not matter if your/text was demanded before my/text.

This is what I call the "alias module pattern". It is useful when an application uses multiple libraries that reference
then same logical module with different names. 

An example of this problem is found in the common text module, which loads a text resource through the plugin API (see
xxx). RequireJS defined this module early on, and several libraries depend on the module as defined by RequireJS. Dojo
also defines the module. However, Dojo's implementation, while 100% compatible with RequireJs's implementation, is both
smaller (because it can leverage dojo.xhr) and contains more features (it includes dojo.cache for backcompat). If you
are building an application that includes both dojo and some other library that relies on RequireJS's text module, it
would be ineffecient to include both Dojo's and RequireJS's text module. This problem can be solved by aliasing
RequireJS's text module to Dojo's text module like this:

.. code-block :: javascript

  define("text" , ["dojo/text"], function(text) {
	return text;
  });

While this code is perfectly legal, there are better ways to express this alias. For one thing, the module provides a
moduleId argument which breaks a best practice we established. In order to avoid that, you could simply replace the
"text" module resource with the content given above. But that's not a great option for a couple of reasons. First, to
edit another module's resource contents it to take ownership of that module, which utterly defeats the idea of
leveraging modules authored by external sources. Second, such a "hard" replacement would cause every library that
depended on the text to depend on dojo/text. Maybe that's not desireable.


There's another problem as well. The alias module given above will only work if it is consumed by the loader before the
text module is demanded. Consider the following example:

.. code-block :: javascript

  require(["text"], function(text){
    // do something with text
  });

  define("text" , ["dojo/text"], function(text) {
	return text;
  });

In this case, the whole idea fails. The require application resolves the original text module and the define
application attempts to redefine that module, which results in an error. For the most part, when expressing modules with
AMD define, the order in which modules are defined is unimportant. In this case, order is relevant. While this is fairly
easy to solve by taking care in the way your program is expressed, that fact that there is one more detail to worry
about is unpleasant.

Fortunately, the dojo loader has a solution to this problem that I'll describe in the next section.

===========================================
Resolving Module Identifiers into Addresses
===========================================

Module identifiers look like file system paths, for example, dijit/form/Button. They are given by a sequence of names
separated by forward-slashes. Each individual name is termed a segment, with the "first" or "top-level" segment being
the left-most segment. Given two segments, the left segment is said to be more significant than the right segment (kind
of like significant dijits in numbers). Similarly, given a segment x1/x2/.../xn, x1/x2/.../xi is said to be the parent
segment of x1/x2/.../xi/xi+1/.../xn. I'll use this language when describing path matching.

According to the AMD specification, the segments may be any legal Javascript identifier, and, by convention, are
camel-case. Most AMD loaders, including dojo's, are more relaxed than this and accept characters outside the Javascript
identifier alphabet. That said, I strongly recommend using only the characters in [A-Za-z0-9_-]. Whatever you do, do not
use the characters !, *, ?, /, or \ in module names; these will only lead to problems.

Our goal in this section is to transform a module identifier into an addess that points to the resource indicated by the
module identifier. In the browser, the address is a URL that can be used to inject a script element or execute an XHR
transaction. In non-browser environments like Rhino or node.js, the address is a filename. In either case, I'll term the
address (or fragment of the addess) a "path" in the descriptions that follow. From now on, I'll term the process of
resolving a module identifier into a path as the "moduleIdToPath" process.

Given the nature of module identifiers, the loader effectively maintains a hierarchical namespace. Naturally, this
namespace tends to map onto a file system hierarchy that's tyically made available through an HTTP server. I say "tends"
because we'll see there are lots of ways to affect the mapping of a module name. The various methods of mapping module
identifiers to resource URLs are a two-edged sword. It allows client code to remap individual modules, branches in
module trees, and/or entire trees. But for the newcomer, all of these options can be bewildering. I'll give several
examples that should cover all the common use cases.

The following configuration variables control how module identifiers are mapped to URLs:

  * baseUrl: (string, a path) a path to prepend to a computed path if the computed path is relative as described by the
    process below.

  * paths: (object) a map from a module identifier fragment to path. When matching paths,
    the most-specific match wins. For example, a/x is more specific than a.

  * aliases: (object) a map from a module identifier to another module identifier.

  * the has.js feature config-tlmSiblingOfDojo: if truthy, then non-package top-level modules not mentioned in paths
    are assumed to be siblings of dojo.

  * package configuration: described next

A package, among other things, is a hierarchy of inter-dependent modules that, hopefully, publish a cohesive API. dojo
(that is, the dojo tree) and dijit (the dijit tree) are examples of packages. Packages can have extensive configuration
variables, and the CommonJS Package specification describes many of these. However, as far as the dojo loader is
concerned, only three are important:

  * location: the path to the root of the hierarchy at which the package resides

  * main: the module identifier implied when a module identifier that is equivalent to just the package
    name is given; if not specified, then the default value of "main" is assumed.

  * packageMap: an optional configuration variable that maps package names given inside a package to different names
    know to the loader. This mapping allows packages to be relocated under different names. We'll see this is a very
    powerful way to handle the problem of an application that needs to load two different packages with the same name
    and/or two different versions of the same package. (note: packageMap is only useful to the dojo loader; currently other
    loaders do not support this feature).

We now have enough to describe the moduleIdToPath process. The entering arguments to the algorithm are the module identifier
(denoted "moduleId") to be mapped, and, optionally, a reference module (denoted "rm").

  1. If moduleId is relative and rm is not provided, an exception is thrown--the moduleId is not rational.

  2. If moduleId is relative and rm is provided, then set moduleId to the module identifier given by rm + "/../" + moduleId and collapse
     any relative segments. Relative segments are collapsed by removing all /./ and x/.. segments (where
     x is not ..). For example a/b/c/../../d would be resolved to a/d by collapsing c/.. then b/.. At this
     point moduleId must be an absolute module identifier and contain no relative segments; if it does not meet this
     criteria, an exception is thrown--the moduleId is not rational.
  
  3. If rm is given, and rm is a member of a package, and that package has a package map, then apply that package map to
     map the top-level segment. This application will either map that segment to another top-level name or default to the
     identify map (x implies x). I'll describe the implications of this step in xxx; for the remainder of this section,
     assume that, if a packageMap exists, it always maps x to x.

  4. Look up the moduleId computed in Step 3 in the aliases map. If the moduleId is mapped, then restart the process at Step 3
     with the mapped moduleId.

  5. If the first segment of moduleId is identical to a package name, then note that moduleId indicates a module in the given
     package; call this package package-of-moduleId; further, if moduleId consists of exactly one segment, then append "/" and the
     value of the main configuration variable for package-of-moduleId to moduleId. Otherwise, when the first segment of moduleId does not
     name a known package, note that moduleId is not a member of a package.

  6. Attempt to apply paths: find the longest module identifier fragment, always starting with the first segment, in
     paths that matches moduleId after Step 5 (if any). If such a fragment is found, set the result to moduleId after replacing the
     matched fragment of moduleId with the mapped path.

  7. If no paths were found in Step 6 and moduleId references a module in a package, set the result to moduleId after replacing the first
     segment (the package name) with the location configuration variable for the given package.

  8. If neither Step 6 or 7 were applied and has("config-tlmSiblingOfDojo") is truthy, then set the result to "../" + moduleId.

  9. If none of Steps 6, 7, or 8 were applied then set the result to moduleId.

  10. If result is not absolute, then prefix result with the configuration variable baseUrl.

  11. Append the suffix ".js" to result.

result now holds the path implied by (moduleId, rm).

Yes, when viewed in toto, it's complicated. And probably more time has been spent on various mailing lists debating this
algorithm than any other part of the AMD loader specification. Fortunately, there are just a few common patterns that
are actually quite straightforward to understand. Let's look at some examples to get comfortable with all of this.

To begin, assume that the user-provided configuration contains no packages, no paths, no baseUrl, and no value for
has("config-tlmSiblingOfDojo"). In this case, the loader sets the default value of has("config-tlmSiblingOfDojo") to
true, provides no paths mappings, and automatically sets baseUrl to point to the dojo tree (that is, the path
that contains dojo.js). The loader also provides a default configuration for several packages. The source release of
dojo configures the dojo, dijit, dojox, demos, doh, and build packages; the built release configures the dojo, dijit,
and dojox packages. Here's the package configuration for the source release.

.. code-block :: javascript

  packages:[{
    name:'dojo',
    location:'.'
  },{
    name:'dijit',
    location:'../dijit'
  },{
    name:'build',
    location:'../util/build'
  },{
    name:'doh',
    location:'../util/doh'
  },{
    name:'dojox',
    location:'../dojox'
  },{
    name:'demos',
    location:'../demos'
  }]

Given this configuration and further assuming that baseUrl is automatically calculated by the loader to be
path/to/dtk/dojo, here are some examples of how a module identifier is mapped to a path:

dojo
  dojo => dojo/main (Step 3)
  dojo/main => ./main (Step 5)
  ./main => path/to/dtk/dojo/ + ./main => path/to/dtk/dojo/main (Step 8)
  path/to/dtk/dojo/main.js (Step 9)

dojo/behavior
  dojo/behavior => ./behavior (Step 5)
  ./behavior => path/to/dtk/dojo/ + ./behavior => path/to/dtk/dojo/behavior (Step 8)
  path/to/dtk/dojo/behavior.js (Step 9)
  
dojo/store/api/Store
  dojo/store/api/Store => ./store/api/Store (Step 5)
  ./store/api/Store => path/to/dtk/dojo/ + ./store/api/Store => path/to/dtk/dojo/store/api/Store (Step 8)
  path/to/dtk/dojo/store/api/Store.js (Step 9)
  
../../_base/Deferred with reference module dojo/store/util/QueryResults
  ../../_base/Deferred => dojo/store/util/QueryResults + /../ + ../../_base/Deferred =>
  dojo/store/util/QueryResults/../../../_base/Deferred => dojo/_base/Deferred (Step 2)
  dojo/_base/Deferred => ./_base/Deferred (Step 5)
  ./_base/Deferred => path/to/dtk/dojo/ + ./_base/Deferred => path/to/dtk/dojo/_base/Deferred (Step 8)
  path/to/dtk/dojo/_base/Deferred.js (Step 9)

myApp
  myApp => ../myApp (Step 6)
  ../myApp => path/to/dtk + ../myApp => path/to/dtk/myApp (Step 8)
  path/to/dtk/myApp.js (Step 9)
  
myApp/someSubModule
  myApp/someSubModule => ../myApp/someSubModule (Step 6)
  ../myApp/someSubModule => path/to/dtk + ../myApp/someSubModule => path/to/dtk/myApp/someSubModule (Step 8)
  path/to/dtk/myApp/someSubModule.js (Step 9)

Notice how, assuming baseUrl points to the dojo tree as per the default, the top-level module identifier "myApp" is now
a sibling of the dojo tree--just like has("config-tlmSiblingOfDojo") suggests. This is how the dojo v1.x line has always
treated top-level modules (absent a paths mapping). So, if you have applications designed and deployed with this
assumption, the new loader won't hurt you.

Maybe that's not what you want. Let's say the myApp tree resides at /path/to/myApp. This can be achieved by providing a
paths configuration like this:

.. code-block :: javascript

  var dojoConfig = {
    paths:{
      "myApp":"/path/to/myApp"
    }
  }

Since /path/to/my/App is absolute, Step 8 does not add baseUrl to the mix:

myApp
  myApp => /path/to/myApp (Step 4)
  /path/to/myApp.js (Step 9)
  
myApp/someSubModule
  myApp/someSubModule => /path/to/myApp/someSubModule (Step 4)
  /path/to/myApp/someSubModule.js (Step 9)

Paths can also give a path segment that's relative. For example, assume you have the following tree of modules:

.. code-block :: javascript

  scripts/
    dtk/
      dojo/
      dijit/
      dojox/
    myApp/
    experimental/

In this case myApp is not a sibling of dojo. Since myApp is reachable from the automatically-computed baseUrl
that points to script/dtk/dojo, a paths entry that gives the path for myApp relative to baseUrl will do the job:

.. code-block :: javascript

  var dojoConfig = {
    paths:{
      "myApp":"../../myApp"
    }
  }

Resulting in...

myApp
  myApp => ../../myApp (Step 4)
  ../../myApp => path/to/dtk/dojo/ + ../../myApp => path/to/myApp (Step 8)
  path/to/myApp => path/to/myApp.js (Step 9)
  
myApp/someSubModule
  myApp => ../../myApp/someSubModule (Step 4)
  ../../myApp/someSubModule => path/to/dtk/dojo/ + ../../myApp => path/to/myApp/someSubModule (Step 8)
  path/to/myApp/someSubModule => path/to/myApp/someSubModule.js (Step 9)

This is one way to solve the problem of has("config-tlmSiblingOfDojo") forcing top-level modules to reside as sibling of
dojo. Another way is to set has("config-tlmSiblingOfDojo") to falsy and/or explicitly set baseUrl. Often you'll do
both. Assuming the tree of modules given above, consider this configuration:

.. code-block :: javascript

  var dojoConfig = {
    tlmSiblingOfDojo:0,
    baseUrl:"scripts"
    packages:[{
      name:'dojo',
      location:'dtk/dojo'
    },{
      name:'dijit',
      location:'dtk/dijit'
    }]
  }

Notice there is no paths mapping; we don't need one:

myApp
  myApp => scripts/ + myApp => script/myApp (Step 8)
  scripts/myApp => scripts/myApp.js (Step 9)

myApp/someSubModule
  myApp => scripts/ + myApp/someSubModule => script/myApp/someSubModule (Step 8)
  scripts/myApp/someSubModule => scripts/myApp/someSubModule.js (Step 9)

dojo
  dojo => dojo/main (Step 3)
  dojo/main => dtk/dojo/main (Step 5)
  dtk/dojo/main => scripts/dtk/dojo/ + ./main => scripts/dtk/dojo/main (Step 8)
  scripts/dtk/dojo/main.js (Step 9)

dojo/behavior
  dojo/behavior => dtk/dojo/behavior (Step 5)
  dtk/dojo/behavior => scripts/dtk/dojo/ + ./behavior => scripts/dtk/dojo/behavior (Step 8)
  scripts/dojo/behavior.js (Step 9)

Let's go ahead and make myApp a proper package:

.. code-block :: javascript

  var dojoConfig = {
    tlmSiblingOfDojo:0,
    baseUrl:"scripts"
    packages:[{
      name:'myApp',
      location:'myApp'
    },{
      name:'dijit',
      location:'dtk/dijit'
    },{
      name:'dijit',
      location:'dtk/dijit'
    }]
  }

myApp/someSubModule maps the same, but myApp does not:

myApp
  myApp => myApp/main (Step 3)
  myApp/main => myApp/main (Step 5)
  myApp/main => scripts/ + myApp/main => scripts/myApp/main (Step 8)
  scripts/myApp/main.js (Step 9)

This is probably a better design compared to cluttering the scripts directory with a bunch of top-level modules. But, it
that's what you really want, your can do it be adding the path myApp/main:"./myApp" to the paths map:

myApp
  myApp => myApp/main (Step 3)
  myApp/main => ./myApp (Step 4)
  ./myApp => scripts/ + ./myApp => scripts/myApp (Step 8)
  scripts/myApp.js (Step 9)

As long as a given module identifier is not also a parent segment of another module identifier, you can map that module
identifier anywhere. For example, maybe you are experimenting with a new module that replaces dojo/cookie. In this case,
you want all dojo modules to map as usual, but you want dojo/cookie to map to scripts/experimental/dojo/cookie. All
that's needed to achieve this is add an entry into paths.

.. code-block :: javascript

  var dojoConfig = {
    paths:{
      "dojo/cookie":"../../experimental/dojo/cookie
    }
  }

Now, Step 4 will treat dojo/cookie differently than any other module indentifier and map it to
scripts/experimental/dojo/cookie.

But consider what happens when the module identifier you want to map is the parent segment of a tree of modules. For
example, consider this tree of modules:

.. code-block :: javascript

  scripts/
    myApp/
      myApi.js
      myApi/
        helper1.js
        helper2.js

On one hand, myApp/myApi is a module, but it's also a parent segment for the modules identifiers myApp/myApi/helper1 and
myApp/myApi/helper2. So the entry myApp/myApi:"path/to/another/myApi" in the paths map would also result in mapping the
two helper modules. More often than not, this is exactly what you'll want. If it's not, then you can add additional path
entries to get the original helpers. Here's what that would look like:

.. code-block :: javascript

  var dojoConfig = {
    paths:{
      "myApp/myApi":"path/to/another/myApi",
      "myApp/myApi/helper1":"path/to/original/myApi/helper1",
      "myApp/myApi/helper2":"path/to/original/myApi/helper2"
    }
  }

That's pretty verbose and not very convenient. But this is also a highly unusal configuration that you'll rarely, if
ever, need.

Lastly, let's readdress module aliases. Recall at the end of the section that described module aliases, I gave an
example of how to alias the module text to dojo/text. Here's that code again:

.. code-block :: javascript

  define("text" , ["dojo/text"], function(text) {
	return text;
  });

Now that we know about the power of mapping module identifiers to paths, we could improve this by eliminating the
moduleId argument. First, locate the module within your application tree, say at myApp/text

.. code-block :: javascript

  // resource resides at myApp/text
  define(["dojo/text"], function(text) {
	return text;
  });

Next, add a paths configuration:

.. code-block :: javascript

    require({
      paths:{
        text:"path/to/myApp/text"
      }
    });

Now, when the module text is demanded, the algorithm will load the resource located at path/to/myApp/text. This is much
better than replacing the text module with the alias module since we're now maintaining our own code rather than another
library's code. But, there's an even-better solution.

Notice that Step 4 in the algorithm, completely eliminates the need for explicit alias modules. In fact, all that's
needed is a little configuration like this:

.. code-block :: javascript

    require({
      aliases:[
        ["text","dojo/text"
      ]
    });

With this, whenever text is seen in a dependency argument to require or define, value of the dojo/text module will be
returned--exactly the desired result! So far, once again, the dojo loader is the only loader that has this feature.

=================
Utility Functions
=================

The AMD API includes a few utility functions:

.. code-block :: javascript

  require.toUrl(
    id // (string) a resource identifier that is prefixed by a module identifier
  )

  require.toAbsMid(
    moduleId // (string) a module identifier
  )

  require.undef(
    moduleId // (string) a module identifier
  )

require.toUrl converts a name that is prefixed by a module identifer to a URL by replacing the module identifier prefix
with the path resolved by the moduleIdToPath process. For example, let's say you've defined a
configuration that will cause the module identifier "myApp/widgets/button" to point to the resource
http://acmeCopy.com/myApp/widgets/button.js. In such a case, require.toUrl("myApp/widgets/templates/button.html") would return
"http://acmeCopy.com/myApp/widgets/templates/button.html". This also works with relative ids when require is a context
require as described in xxx and yyy.

require.toAbsMid simply returns the absolute module identifier implied by the moduleId argument. In the case of global
require, moduleId must be an absolute module identifier, so the moduleId argument is simply returned without
modification. However, in the case of a context require, moduleId may be relative, and is such cases, the module
identifier is resolved with respect to the reference module as given by the context require.

Not surprisingly, require.undef removes a (module identifier, module value) from the module namespace. If require is
global require, then moduleId must be an absolute module identifier; otherwise moduleId can be either an absolute or relative
module identifier, where relative module identifiers are resolved with repsect to the reference module module given by
the context require. require.undef is primarily interesting for test frameworks that desire to load and unload the
module under test without having to reload the entire application.

Neither require.toAbsMid nor require.undef are described in the CommonJS AMD specification; they are extensions
available only on certain loaders, dojo being one of them.

============================
Relocating Module Namespaces
============================

We now turn to the problem of package name clashes, in particular how two different packages with the same name or
two different versions of the same package can be loaded into the same application.

Suppose two brilliant but independent programmers publish packages of utility functions. Because they are so brilliant
neither programmer can imagine the need for yet another util package and therefore both decide to name their packages
"util". You and I are just lowly developers trying to please our clients. So naturally we want to leverage brilliance
and use one of these util packages. Unfortunately, we quickly discover that neither util author is quite as brilliant as
they assumed and neither package contains all of the utils we need; instead, we need both packages. Now, we're in a jam
because we have two different packages with the same name.

Fortunately, the solution is trivial. Simply install the two util packages in two different directory trees and then
identify the two trees as two different packages to the loader. For example:

.. code-block :: javascript

  var dojoConfig = {
    baseUrl: "./",
    packages: [{
        name: "util1",
        location: "packages/util1"
      }, {
        name: "util2",
        location: "packages/util2"
      }]
  };

You can access the packages through require:


.. code-block :: javascript

  require(["util1", "util2"], function(util1, util2) {
    // make client happy
  });

Or in your own module definitions through define:

.. code-block :: javascript

  define(["util1", "util2"], function(util1, util2) {
    // make client happy
  });

The loader maps "util1" and "util2" into the paths ./packages/util1/lib/main.js and ./packages/util2/lib/main.js,
respectively. Assuming the util package authors followed best practice and did not explicitly provide a moduleId
argument in the define applications that create their modules, the loader provides the names "util1" and "util2" as
derived from the module identifiers that caused the respective scripts to be evaluated.

Next, let's see what happens to the names in the dependency vector given when a module from one of the packages is
defined. Suppose ./packages/util1/lib/main.js contains the following code:

.. code-block :: javascript
  
  // this is the definition of the first util package main module  
  define(["./strings", "./collections"], function(strings, collections) {
    var core= {}, p;
    for (p in strings) core[p]= strings[p];
    for (p in collections) core[p]= collections[p];
    return core;
  });

Since the reference module for the definition above is util1/main. Consequently, "./strings" ⇒ "util1/strings" and
"./collections" ⇒ "util1/collections", which is exactly what we want.

Notice what has happened. We renamed the util packages on our system by specifying but two lines in a configuration, yet
the packages behave perfectly without any alteration whatsoever. The key point is this: so long as the util authors used
relative module identifiers to refer to modules within their own packages, we, as util package consumers, can use two
different util packages, both named "util" by their authors, in the same program by providing an appropriate
configuration. Pretty awesome! It gets better.

Suppose the author of the first util package used yet another package in his implementation. Maybe the definition of the
collections module within the first util package looks like this:

.. code-block :: javascript

  define(["dojox/collections"], function(collections) {
    // do something with collections and return a 
    // collections API for the util package
  });

So far, so good. All the author needs to do is explain that his package depends on the dojox package. We, as the package
consumer, simply download the dojox package, install it in our local package tree, inform the loader where to find it
through the packages configuration variable and everything will work perfectly.

Not to be outdone, the second util author also depends on the dojox package. But, as luck would have it, the second util
package depends on a different version of the dojox package. The loader can easily accommodate two different versions of
the same package just as it can accommodate two different libraries with the same name. The problem occurs when both of
the util libraries refer to the same name–"dojox"–yet expect this name to resolve to different packages.

The first thing to do is install the two different dojox packages just like we installed the two different util
packages:

.. code-block :: javascript

  var dojoConfig = {
    packages: [{
      name: "util1",
      location: "packages/util1"
    }, {
      name: "util2",
      location: "packages/util2",
    }, {
      name: "dojox1",
      location: "packages/dojox-version-1-6"
    }, {
      name: "dojox2",
      location: "packages/dojox-version-1-4"
    }]
  };

Recall that when the first utility package demands a dojox module by writing define(["dojox/collection"], //... , the
loader will resolve that name with respect to the reference module–which is a util1 module. So, by providing a map that
instructs the loader how to resolve package names with respect to a particular package, we can solve this
problem. Here's the configuration that solves the dojox name clash:

.. code-block :: javascript

  var dojoConfig = {
    packages: [{
      name: "util1",
      location: "packages/util1"
	  packageMap: {dojox:"dojox1}
    }, {
      name: "util2",
      location: "packages/util2",
	  packageMap: {dojox:"dojox2}
    }, {
      name: "dojox1",
      location: "packages/dojox-version-1-6"
    }, {
      name: "dojox2",
      location: "packages/dojox-version-1-4"
    }]
  };

Anytime the "dojox" package identifier is seen in a module from the first util package (configured as the util1
package), the loader will inspect the packageMap configuration variable of the util1 package and see that "dojox" maps
to "dojox1". This happens in Step 2 of the algorithm that maps module identifiers to URLs described in the previous
section. Similarly, the loader will resolve the package identifier "dojox" in the second util package to "dojox2". From
there, the standard URL resolution algorithm proceeds as usual.

This design replaces the so-called "multi-version" design in dojo v1.6- and eliminates the need for contexts as
implemented in RequireJS. Notice that, unlike the multi-version design, no build is required to deploy a relocated
package. It's all a matter of simple configuration. This is a quite powerful feature and only dojo has it.

=====================================
CommonJS require, exports, and module
=====================================

The AMD specification reserves three top-level module identifiers: require, exports, and module. These are only relevant
in the context of a dependency vector given as an argument to the global AMD define function. In the descriptions below,
the module being defined is termed the "reference module".

We've already described require in xxx where we termed such a require a "context require". Recall it works just like global
require except that it resolves relative module identifiers with respect to its reference module (also termed its
context). Note carefuly, saying that context require has all the capabilities of global require, means just that: it
holds all the methods and properties of global require. For example, the micro event API, require.on and require.signal,
is also defined on any particular context require. The only differences are:

  * Relative module identifiers in the dependencies argument are resolved with respect to its reference module as
    described above.

  * require.toUrl, require.toAbsMid, and require.undef, when given a relative name, likewise resolve that name with
    respect to its context.

The module identifier "module" implies an object that contains the following properties:

  * id: a unique identifier (a string) that has the property require(module.id) returns the value given by its reference
    module

  * uri: the uri from which the module resource was loaded; this may not always be available.

  * exports: identical (as in ===) to exports described below

Be careful with your assumptions about the actual value of module.id. Suppose the module someLib/someModule is a member
of the package someLib and further that someLib was relocated to someLib1 (maybe there was another library also named
someLib that needed to be used in the same application). In this case module.id would actually have the value
someLib1/someModule.

The module identifier "exports" implies an alternate method to return the module value. Instead of returning the value
explicitly by a return statement in the factory function, exports provides a Javascript object that may be used as a
hash to return a set of values. For example, the following two module definitions accomplish the same semantics:

.. code-block :: javascript

  define([], function(){
    return {
      someProperty:"hello",
      someOtherProperty:"world"
    };
  });


  define([exports], function(exports){
    exports.someProperty:"hello";
    exports.someOtherProperty:"world";
  });

Notice in particular that the factory in the second define application did not explicitly return a value. If it did,
exports would have been ignored.

exports can also be replaced wholesale via module:

.. code-block :: javascript

  define(["module"], function(module){
    module.exports = dojo.declare(// etc.
  });

Lastly, the AMD specification states that when define is provided a single function argument, the loader must
automatically provide the arguments require, exports, and module as if the dependencies ["require", "exports", "module"]
has been stated. The following two define applications are equivalent:

.. code-block :: javascript

  define(["require", "exports", "module"], function(require, exports, module){
    // define a module
  });

  // ...is exactly the same as...

  define(function(require, exports, module){
    // define a module
  });
  
module and exports are used for compatibility with other CommonJS modules, primarily modules written for node.js. I see not
any advantage to using them and recommend you avoid it.

=======
Plugins
=======

The loader loads AMD modules. But there are other kinds of resources, for example templates and internationalization
("i18n") bundles that an application may need to load. Your particular application may define yet other specialized
kinds of loadable resources that the loader does not know how to load. In order to accommodate this problem, the loader
provides an extension point termed a "plugin" that allows a module identifier to be specified that delegates the loading
of that module to additional machinery that is "plugged in" to the loader.

Here's how it works. When a module identifier contains an exclamation point, the loader splits the name into two module
identifiers at the "!". The module identifier to the left of the "!" gives the name of a plugin (which must be an
regular AMD a module); the identifier to the right gives the identifier to delegate to the that plugin for loading. The
loader loads the plugin (once) which must return a value that is an object that contains the function load:

.. code-block :: javascript

  load(
    moduleId,  // the identifier to the right of the !
    require,   // AMD require; usually a context require
 	callback   // a function to apply to the plugin-loaded resource
  );

Once the plugin has been loaded, the loader sends the module identifier to the right of the "!" to the load function:

    * The module identifier to the right of the "!" is passed in the moduleId argument.

    * If the request to load the module is consequent to a dependency vector in an AMD define applicaiton, then a
      context-require is manufactured with respect to the reference module that is demanding the plugin module and is
      passed in the require argument; otherwise, the request must be consquent to a dependency vector in a require
      application (either global require or another context-require); in either case, the require function that is
      making the request is passed in the require argument.

    * A a single-argument function that receives the value that the plugin computes for the module moduleId is
      manufactured and passed in the callback argument.

The plugin "loads/computes" (whatever that means to the plugin) the module implied by the moduleId argument and reports
the value of that module to the loader through the callback function. This system is incredibly elegant and
powerful. Here is an example of loading some raw text with the a "text" plugin:

.. code-block :: javascript

  // the module definition for myApp/myModule
  define(["text!./templates/myModule.html"], function(template) {
    // template is a string loaded from the resource implied by myApp/templates/myModule.html
  });

Here is a simple text plugin implementation.

.. code-block :: javascript

  define(["dojo"], function(dojo) {
    return {
      load: function(require, id, loaded) {
        dojo.xhrGet({
          url: require.toUrl(id),
          load: function(text) {
            loaded(text);
          }
        });
     }
    };
  })

To my eye, this is just about as beautiful as code can get!

The loader decorates all require functions (global AMD require and all context-requires) with the method toUrl. toUrl
essentially executes the module identifier mapping algorithm given in xxx and returns the result, the only difference
being that toUrl expects the last segment to include a file type and Step 10 (adding the .js suffix) is not
executed. The toUrl method allows the plugin to map a module identifier without having to concern itself with the
various configuration variables that affect this mapping as discussed in xxx.

The loader does not "remember" ther value of the loader plugin since the loader can't know the semantics of the plugin
(maybe the value changes over time). (Note: ther is some disagreement about this design among loader vendors). A
plugin can maintain its own cache values if this is reasonable for a particular plugin's semantics; this functionality
take five extra lines:

.. code-block :: javascript

  define(["dojo"], function(dojo) {
    var cache = {};
    return {
      load: function(require, id, loaded) {
        var url= require.toUrl(id);
        if(url in cache){
          return cache[url];
        } else {
          dojo.xhrGet({
            url: url,
            load: function(text) {
              loaded(cache[url] = text);
            }
          });
        }
     }
    };
  })

Dojo v1.7 includes several key plugins:

  * dojo/text: loads test resources and subsumes dojo.cache; it is a superset of RequireJS's text plugin.

  * dojo/i18n: loads i18n bundles--either expresed in legacy format (v1.6-) or as AMD modules. It contains the
    v1.6- i18n API and is a superset of RequireJS's i18n plugin.

  * dojo/has: allows has.js expressions to be used to conditionally include/exclude modules in dependency lists found in
    AMD define and require applications.

  * dojo/require: downloads but does not evaluate a legacy module. This allows the legacy codepath to be guaranteed (see xxx)

  * dojo/loadInit: causes dojo.loadInit callbacks then other legacy API functions to be executed--in particular
    dojo.require[After]If--that are associated with a module (see xxx)

=====================
The Legacy Loader API
=====================

In order to maintain backcompat with the v1.x line, the v1.7 loader includes the complete synchronous loader API
consisting of dojo.provide, dojo.require, dojo.requireLocalization, dojo.requireIf, dojo.requireAfterIf,
dojo.platformRequire, and dojo.loadInit. This API is termed the "legacy loader API"; sometimes I'll just write "legacy
API". Modules that use the legacy API are termed "legacy modules". This section reviews the legacy API; the next section
describes how the v1.7 loader emulates this API.

Although the API has not changed, the entire legacy loader implementation has been rewritten to leverage the new AMD
loader. Most of the legacy implementation resides in dojo/_kernel/loader. What little of the legacy API there is that
bleeds into the AMD loader in dojo.js is carefully has-bracketed so it can be stripped in builds of applications that
don't need it.

The functions dojo.require and dojo.provide define the core of the legacy API. Each of these take a module identifier
that is identical to an absolute AMD module identifier except that dots are used instead of forward slashes; the legacy
API does not support relative module identifiers. dojo.provide's implementation is trivial, but it does include a subtle
feature that's important to understand. Here is the v1.6- implementation of dojo.provide in its entirety:

.. code-block :: javascript

  dojo.provide = function(moduleId){
    return (dojo._loadedModules[moduleId] = dojo.getObject(moduleId, true));
  }

Notice that the loader possibly creates and always memorizes the object dojo.provide returns. This is the object
returned by dojo.require for a module after it has been resolved. Here are the first few lines of dojo.require (slightly
sythesized):

.. code-block :: javascript

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

.. code-block :: javascript

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

dojo.require has a few idiosyncracies as well. Owing to the way dojo.eval is defined in v1.6- and the way some browser's eval
works, sometimes a module's code text would be eval'd in the global scope and sometimes it would be eval'd in a function
scope. Consider the module text:

.. code-block :: javascript

  dojo.provide("module.that.defines.a.global");
  var someVariable = anAwesomeCalculation();

If the code above is evaluted in the global scope, then someVariable is entered into the global namespace; however, if
it's evaluated in a function scope, then someVariable is a lexical variable and disappears when the function returns.

In version 1.7+, all code that is downloaded as text and evaluated with Javascript eval is evaluated in a function
scope. If you've got code like above and expect someVariable be defined in the global space, it will not work in v1.7
(it only worked sometimes anyway--even if you didn't know it). Here's how to get the effect you want:

.. code-block :: javascript

  dojo.provide("module.that.defines.a.global");
  dojo.global.someVariable = anAwesomeCalculation();

Let's review how dojo.require normally operates. dojo.require executes a synchronous XHR to get the resource text and
then applies Javascript eval to that text. If a dojo.require application is encountered during the evaluation of the
text, then another synchronous XHR retrieves the demanded resource's text and that text is eval'd, and so on util the
entire dependency tree is evaluated. This guarantees a particular code path. Consider the following module:

.. code-block :: javascript

  dojo.provide("my.module");
  doSomeStuff(1);
  dojo.require("my.other.module");
  doSomeStuff(2);
  dojo.require("no.my.other.module");
  doSomeStuff(3)

The code path guaranteed by the legacy API is exactly as it is written. In particular, the "AMD equivalent"...

.. code-block :: javascript

  define("my/module", ["my/other/module", "no/my/other/module"], function(){
    doSomeStuff(1);
    doSomeStuff(2);
    doSomeStuff(3);
  });

...is not equivalent at all since it will cause both */my/other/* modules to be resolved (executed) before any of the
doSomeStuff applications.

The v1.6- build system rewrites module text so that it can be injected into a script element yet honor the code path
described above. Here's a sketch (this isn't exactly how the v1.6- build system packages modules, but it's enough to get
the idea). Given the following legacy module:

.. code-block :: javascript

  dojo.provide("my.module");
  dojo.require("your.module");
  doSomethingSpectaculor();

The v1.6- build system rewrites the module like this:

.. code-block :: javascript

  dojo.loader.define(
    // [1] the provide(s) included in this module
    ["my.module"],  

    // [2] the require(s) included in this module
    ["your.module"], 

	// [3] the module's code
    function(){     
      dojo.provide("my.module");
      dojo.require("your.module");
      doSomethingSpectaculor();
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
the rest. But, owing to Javascript's regular expression lexical rules, it is impossible to remove comments and strings
from Javascript text without fully parsing the text! And without removing comments and strings, it is possible
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

.. code-block :: javascript

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

.. code-block :: javascript

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

.. code-block :: javascript

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

.. code-block :: javascript

  [["dojo", "acmeUtils"]]

Notice that a build is required to make this all work, and scopeMap is a configuration variable set up by the build
application.

As we said in xxx, this complexity is not needed when loading multiple instances of AMD packages. If fact, the new
loader can relocate trees of modules by simply setting a configuration variable, and the trees can be built, unbuilt, or
mixed. This feature solves many interoperability problems when mixing and matching several libraries. No other loader
can do this and we're quite proud of this feature.

That concludes a fast and furious review of legacy mode. I devoted more than a chapter to this system in `my book`_ if
you want a more-gentle presentation.

==================
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
    in xxx.

  * legacy: modules are loaded synchronously just like the v1.6- loader. The loader is put in legacy mode by setting the
    configuration variable asycn to "sync" or "legacyAsync" or falsy; falsy has the same effect as "sync".

The legacy mode has two submodes:

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

.. code-block :: javascript

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

Right about now, you're probably asking why this matters. Here's why: you can now write...

.. code-block :: javascript

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

This behavior allows AMD modules to be expliticly injected in an HTML document with <script> elements (that is, <script>
elements written by the programmer, not dynamically injected by the loader). This practice should be avoided, and you
should use the loader to inject modules. Unfortuneately enforcing this rule for the v1.x line would break too much code,
hence the behavior when in legacy mode.

The loader also provides for interoperability with synchronous modules. When a synchronous module dojo.require's a
module that happens to be an AMD module, the AMD module is resolved as described above. Of course, synchronous modules
typically don't include code to retrieve AMD module values; further, well-designed AMD modules don't pollute the global
namespace. So, we're in a bit of a bind: the dependent module was defined, but the depending module can't get access to
that dependent module value.

The loader solves this problem by noticing within the `dojo.require` implementation that a module has a value yet the
object associated with the module is undefined. This sounds better in code:

.. code-block :: javascript

  var result = dojoRequire(moduleName);
  if(has("config-publishRequireResult") && !dojo.exists(moduleName) && result!==undefined){
    dojo.setObject(moduleName, result);
  }

The `dojoRequire(modulename)` application causes the loader to resolved the module `moduleName`. Upon return it pushes
the value of the module into the Javascript object given by module name if and only if that object is undefined. This
algorithm my be suppressed by setting the has feature "config-publishRequireResult" to falsy; this feature is true by
default.

Legacy Cross Domain Mode
------------------------

This mode is tricky. Indeed, cross-domain loading has been the subject of much head-banging over the years. I'm not sure
I completely buy into it's utility. If you're doing development, you're going to need to download the source version of
the Dojo Toolkit and work off a local environment; ergo, no cross domain problems. Once you're ready to deploy, do a
build which results in converting the application to a 100% AMD-compliant set of modules that can be loaded
asynchronously. Then you can and use one of the CDN's to load the dojo and dijit libraries leaving just your application
code for your own server. Everything is loaded asynchronously via script injection so there's no cross-domain XHR
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
     expression has been in place for many versions, but is far from perfect and can be fooled (e.g., when Javascript
     comment delimiters are contained in strings). For the record, the regular expression used to find comments is
     ```/(\/\*([\s\S]*?)\*\/|\/\/(.*)$)/mg```. The comment-filtered text is then scanned for the legacy loader
     functions. When found, the text of each loadInit application is aggregated to a single string and the text to all
     other legacy API applications is aggregated to another string.

  2. A dojo/loadInit plugin resouce is constructed on-the-fly; I'll describe how dojo/loadInit works below. The resource
     is itself a module that defines an object with two properties:

       * names: the list of names given by the scope map associated with the particular instance of dojo that is
         referenced by the module.

       * def: a function that defines a parameter list with parameter names given by names (as described above) and
         consists of code defined by the aggregated loadInit applications concatenated with the aggregated other
         applications.

  3. An AMD module is constructed on-the-fly as shown below. <names> is the list of names given by the scope map;
     <names-mapped-to-proper-module-names> is the list of module identifiers indicated by names, computed with respect
     to the reference module; <uid> references the dojo/loadInit plugin module resource constructed in Step 2.

.. code-block :: javascript

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

.. code-block :: javascript

  define(/*<uid>*/, {
    names:
      // (array of strings) the list of names given by the scope map associated with the
      // particular instance of dojo referenced by the reference module

    def:
	  function(/* names as described above */) {
        // aggregated loadInit applications concatenated with the aggregated other applications
	  }
  });

When the dojo/loadInit is given an identifier (the text to the right of the !), it retreives (via AMD require) that
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
reference module. Also, dojo.provided'd sniffed module identifiers are noted to "have arrived" to prevent any attempt at
downloading such modules. This is particularly important when a legacy module dojo.provide's several modules.

Notice what has happened, dojo/loadInit has arranged to execute all of the legacy loader API appplications found in the
reference module. But, instead of actually loading and executing any dojo.require'd modules, the dojo/loadInit simply
recorded the module identifiers the reference module would have loaded had the real legacy API not been hijacked. Now,
dojo/load init can use this information to arrange for the necessary modules to be downloaded.

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
executing a legacy synchronous code path, it must be able to complete that code path without interuption.

After dojo/require signals dojo/loadInit that all requested modules are on board, dojo/loadInit signals the reference
module. The reference module can now execute its factory function which contains the original legacy module's code with
the execption that all dojo.loadInit applications (if any) will be passed over since they have all be prefixed with 0
&&. Since dojo/loadInit and dojo/require have worked together to guarantee all modules dojo.require'd in that code are
already on board, the code will execute without interuption--just as if the whole process had occured synchronously and
nothing was cross-domain.

This design has so much indirection and recursion, it's instructive to trace through an example to get the idea. Let's
assume a scope mape of [["dojo", "myDojo"]] and the legacy module "my.module" looks like this:

.. code-block :: javascript

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
  doSomethingAwesome();

The conversion process would construct a loadInit module and rewrite my.module into one evaluable string that looks like
this:

.. code-block :: javascript

  define('*loadInit_8',{
    names:["dojo",],
    def:function(dojo){
      dojo.provide("my.module");
      dojo.require("your.module");
      dojo.loadInit(function(){
      ojo.getObject("my.module", true);
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
function. This causes dojo/loadInit to resolve "*loadInit_8" (the loader guarantees this is a unique synthetic module
identifier). In doing so, dojo/loadInit causes the def function to be executed, passing the value of the global myDojo
object. This causes the dojo.loadInit function contained in the def function to be executed. Let's assume
document.someMagicSomething has a value of 1. This will cause the loadInit callback to set my.module.switch to 1. As the
def function continues executing, it notes:

  * the module dojo.provide's "my.module"

  * the module dojo.require's "your.module" and "my.module1" (via the dojo.requireIf)

The loadInit function then AMD requires...

.. code-block :: javascript

  require(["dojo/require!your/module,my/module"], function(){
    loaded(1); //this is the loaded for the original call to dojo/loadInit!*loadInit_8
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

=====================
Window load Detection
=====================

Typically, the loader is the first and often only script explicitly contained within an HTML document. Usually, all
other scripts are loaded by the loader. I'll stop short of calling this a best practice, but you should think long and
hard before hard-coding additional script elements within a particular HTML resource.

This being the case, the loader holds a special status among all scripts executed by a particular HTML document in that
it's often the only script that can be guaranteed to catch the document.DOMContentLoaded and window.load signals. Put
another way, it's impossible to guarantee catching these events on all popular browsers within a normal AMD module
without support from the loader.

In order to solve this problem, the dojo loader connects to the window.load event with a listener that sets
document.readyState to "complete" if it's not already set as such. This allows a normal AMD module to rely on
document.readyState even in browsers that do not properly support this property. An example use case is found in the
dojo/domReady plugin that calls loaded upon achieving DOMContentLoaded or better.

===============
Error Reporting
===============

When things go wrong, the loader signals the "error" event on the micro even API. So, in order to monitor loader errors,
simply connect via require.on like this:

.. code-block :: html

  function handleError(error){
    console.log(error.src, error.id);
  }
  
  require.on("error", handleError);

The first argument sent to listeners is always a loader error object that contains the properties src, which is always
set to "dojoLoader" and id, which gives a string identifier indicating the particular error. The loader defines the
following error identifiers:

factoryThrew
  A module factory function threw an exception.

xhrFailed 
  An XHR failed to retrieve a module resource. Typically, this indicates an HTML 404 error, that is often caused
  by a configuration problem with paths, aliases, packages, and/or baseUrl.

multipleDefine
  AMD define was applied referencing a module that is already defined. The number one cause if this problem is
  explicitly injecting modules with a script element in the HTML document. Use the loader; don't use script
  elements. Also, providing explicit module identifier arguments tends to increase the likelyhood of this error.

timeout
  The period prescribed by the configuration variable waitSeconds expired since the last module was requested yet all
  modules have not arrived. Typically, this indicates an HTML 404 error, that is often caused
  by a configuration problem with paths, aliases, packages, and/or baseUrl.

defineIe
  An anonymous define application was executed in an Internet Explorer environment, yet it was impossible to determine
  the implied module identifier. defineIe errors are usually the same kinds of problems indicated by multipleDefine.

Loader errors are often impossible to recover from. If you application demands a module that maps to a path that
does not exist, there's nothing the loader can do to fix that situation. However, some kinds of applications may
attempt to load modules that are unreliable. Further, those applications may have a strategy to deal with such
occurences. Those applications can use the error reporting API to apply such strategies.

=========
Debugging
=========

Debugging highly asynchronous processes like loading a tree of AMD modules can be tricky. Frankly, debugging a problem
deep in a dependency tree of synchronous modules is no less vexing. Here are a few pointers to make this task
manageable.

  * The most common error for programmers used to the legacy loader API is to express a module indentifier using dots
    instead of slashes. If you have to bounce back and forth between both APIs, you'll be makeing the opposite error
    too.

  * A common syntax error that's not well reported in some browsers it to miss a comma in a dependencies argument.

  * A common programming error is to mix up the module identifiers in the dependencies argument compared to the
    parameter names in the callback (in the case of require) or factory (in the case of define) functions.

  * In some browsers, in some circumstances, inserting breakpoints will change then asynchronous flow. This can be
    frustrating when your application fails without breakpoints but succeeds otherwise. It generally indicates the
    program is depending on the modules being defined in a certain order. Well-designed AMD modules will contain no such
    requirement.

  * Sometimes one browser's debugger just works better than anothers. And it's not always the same debugger that's
    best. If I'm working a really hard problem, I'll try it in Firefox/Firebug, Chrome, and, believe-it-or-not, IE. As
    much as we all complain about IE, it can sometimes point the way to a problem earlier in the execution sequence
    which can sometimes point to the solution. Also, recent Firefox/Firebug releases have been flakey. I keep a Firefox
    3.6.x, Firebug 1.6.x virtual machine around...which brings up another point. If you're doing professional
    development, you must have several virtual machines available.

Unlike other loaders, the dojo loader exposes its internal state for inspection during debugging. You'll find this
extremely valuable when tackling hard problems. Inspect the global require function. You'll see all of the important
loader internal variables:

async
  Boolean, describing the mode of the loader.

legacyMode
  String, describing the legacy mode of the loader (if in a legacy mode at all).

baseUrl
  The baseUrl configuration variable.

paths
  The paths configuration variable.

packs
  The package configuration. This is synthesized from any passed package configuration.

waiting
  The set of modules resources the loader has requested but have not yet arrived. If the loader seems to stall look here
  second; look in your debugger network panel for 404 errors first.

execQ
  The queue of modules scheduled to execute. If this queue seems stalled, then there is almost certainly another
  problem, probably 404 errors, syntax errors, or naming errors elsewhere.

modules
  The module namespace. Each entry holds all information about each module known to the loader:

    * result holds the module value

    * injected holds the loaded state (one of 0, "requested", "arrived")

    * executed holds the executed state of a factory (one of 0, "executing", "executed")

    * pid holds the owning package (if any)

    * url holds the address the loader has computed for the resource that defines the module

    * def holds the factory

Warning: these internal definition are exposed and discussed here to help with debugging chores. Do not use it in your
own code. These structure may change!

=======
Tracing
=======

Owing to the asynchronous nature of the loader, sometimes the best technique to solve a loading problem is to let the
loader proceed normally without any breakpoints and analyze the order of certain loader events like injecting, defining,
or executing a module. The source version of the loader contains a tracing API to facilitate this debugging
technique. What's more, the tracing API is public, so you can use it with your own code when circumstances warrant.

The tracing API resides at require.trace for global require or any context require:

.. code-block :: javascript

  require.trace = function(
    groupId, (string)
    args (array of any)
  )

  require.trace.set(
    groupId, (string)
    value (booleanish)
  )

  require.trace.on (booleanish)

  require.trace.group (object) a map from trace group id to booleanish

Code that desires to emmit trace messages applies require.trace to a groupId and an array of information to be output with
a particular trace message. require.trace(groupId, args) implements the following process.

  1. If trace.on is falsy, then do nothing and return.

  2. If trace.group[groupId] is falsy, then do nothing and return.

  3. Signal the trace event via the micro event API with the argument [groupId, args].

  4. Concatenate groupId and the string value of each item in args into a comma-separated list and apply require.log to
     the resulting string.

  5. Apply require.log to each item in args.

Tracing can be turned on for a group by providing a value for the configuration variable trace, a map from trace group
name to boolean. For example,

.. code-block :: html

  require({trace:{"loader-inject":1}});

Turns tracing on for the loader-inject trace event.

TODO: finish tracing description

=======================
Nonbrowser Environments
=======================

As of v1.7, the dojo loader supports Rhino and node.js. In the browser environment, then moduleIdToPath process returns
a path that is a URL, and that URL is used to either script inject the module or retrieve the module via synchronous or
asynchronous XHR (depending on the loader operating mode).

In non-browser environments, the path is a filename and the particular environment's file system library is used to
retrieve the module synchronously. This essentially results in the loader operating in synchronous AMD mode. However,
this is just an implemenation detail; from the loader client perspective, it "just works".

.. _CommonJS: http://www.commonjs.org/
.. _Modules/AsynchronousDefinition: http://wiki.commonjs.org/wiki/Modules/AsynchronousDefinition
