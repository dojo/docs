.. _loader/amd:

===============
The Dojo Loader
===============

:Author: Rawld Gill
:Editors: Colin Snover, Kenneth G. Franqueiro
:Project owner: Rawld Gill
:since: 1.7.0

.. contents ::
   :depth: 2

Introduction
============

The Dojo loader includes two APIs:

  * `The Asynchronous Module Definition (AMD) API <https://github.com/amdjs/amdjs-api/wiki/AMD>`_ ("AMD API")

  * The legacy dojo API which consists of ``dojo.require()``, ``dojo.provide()``, ``dojo.requireIf()``,
    ``dojo.requireAfterIf()``, ``dojo.platformRequire()``, and ``dojo.requireLocalization()`` ("legacy loader API")

The AMD API is new for Dojo 1.7. It is the same API implemented by `RequireJS <http://requirejs.org>`_, `curl
<https://github.com/unscriptable/curl>`_, and `bdLoad <http://bdframework.org/bdLoad/>`_ (the dojo implementation is an
adoption of bdLoad). This exciting new standard for writing and loading modules dramatically improves code
portability and interoperability. Equally important, it allows modules to be loaded asynchronously, which provides two
key benefits versus the old synchronous API:

  * Modules can be downloaded asynchronously and concurrently, thereby decreasing page load times up to 10x.

  * Hacks such as ``debugAtAllCosts`` are no longer needed in order to provide informative debugging (e.g. stack traces)
    in all browsers.

While each loader offers a different set of extra features, the core API of all of these loaders is compatible and most
of the tutorial material for any one loader is applicable to the others.

In addition to the core loader APIs, the new Dojo loader includes several other useful features:

  * Multiple platform support: By default, the Dojo loader includes configurations for the browser, `node.js
    <http://nodejs.org>`_, and `Rhino <http://www.mozilla.org/rhino/>`_. Environment-specific configuration files are
    typically less than 100 lines of code and can be easily written to extend Dojo support to other JavaScript
    environments (see `Non-browser Environments`_).

  * `has.js <http://github.com/phiggins42/has.js>`_ API: The Dojo loader implements the has.js API, and uses that API to bracket several loader features. In
    conjunction with the Dojo build system, this allows for loader code to be reduced to about 3K (minimized and
    gzipped). This makes the Dojo loader the smallest fully-compatible AMD loader currently available.

  * Configuration API: The loader includes a configuration API that may be leveraged by client applications, allowing
    program designs that have exactly one entry vector for user configuration.

dojo.js
=======

Prior to v1.7, dojo.js caused both the Dojo loader and the Dojo library bootstrap to be defined. This design has been
improved so that dojo.js now holds the loader and nothing else. In fact, it is now possible to use Dojo's loader
without any of the Dojo library. For backwards-compatibility, the loader starts up in synchronous mode by default,
which loads the Dojo base API automatically:

.. html ::

  <script src="path/to/dojo/dojo.js"></script>
  <script>
    // the dojo base API is available here
  </script>

To put the loader in the AMD mode, set the ``async`` configuration variable to truthy:

.. html ::

  <script data-dojo-config="async:1" src="path/to/dojo/dojo.js"></script>
  <script>
    // ATTENTION: nothing but the AMD API is available here
  </script>

Note that you can only set the ``async`` flag *before* dojo.js is loaded, and that in AMD mode, **neither Dojo nor any
other library is automatically loaded** - it is entirely up to the application to decide which modules/libraries to
load.

.. _loader/amd#configuration:

Configuration/Feature Detection
===============================

Configuration
-------------

There are three ways to pass configuration data to the loader:

  1. Before the loader is defined, via the global ``dojoConfig`` object (See also :ref:`dojo/config <dojo/config>`)

  2. On the ``<script>`` element for the loader, via the ``data-dojo-config`` attribute

  3. After the loader is defined, via the global ``require`` function

Configuration data is always provided as a standard JavaScript object. When the object is passed as a
``data-dojo-config`` attribute, the opening and closing curly-brackets should be omitted from the object expression
(just as with ``data-dojo-props``). Using ``data-dojo-config`` looks like this:

.. html ::

  <script
    data-dojo-config="async:true, cacheBust:new Date(), waitSeconds:5"
    src="path/to/dojo/dojo.js">
  </script>

Using ``dojoConfig`` looks like this:

.. html ::

  <script>
    var dojoConfig = {
      async:true,
      cacheBust:new Date(),
      waitSeconds:5
    };
  </script>
  <script src="path/to/dojo/dojo.js"></script>

Using the ``require`` function looks like this:

.. js ::

  require({
    cacheBust:new Date(),
    waitSeconds:5
  });

Note that the ``async`` flag and any has.js tests that are defined or required by the loader at startup **cannot** be
set using the ``require`` function, and must go in a ``dojoConfig`` or ``data-dojo-config`` object.

For backwards compatibility, the deprecated variable ``djConfig`` can be used instead of ``dojoConfig``. Note, however,
that if both ``dojoConfig`` and ``djConfig`` are defined, ``djConfig`` is ignored. Also note that if either
``dojoConfig`` or ``djConfig`` exist *and* the ``data-dojo-config`` attribute is defined, both ``dojoConfig`` and
``data-dojo-config`` are consumed, with values in ``data-dojo-config`` taking precedence over those in ``dojoConfig``.

The configuration object can also be used to set arbitrary, application-specific configuration data. All properties of a
configuration object are shallow copied to ``require.rawConfig``; values that the loader recognizes are also added to
``require.config``. Because these are shallow copies, if you need to mix-in properties of a sub-object instead of having
that object replaced completely, the loader includes a "config" event that is signaled via `the micro event API`_
whenever configuration data is received.

The "config" event passes two arguments to any listeners:

  * config: the configuration object passed to the loader that triggered the "config" event

  * rawConfig: the value of ``require.rawConfig``

The various configuration variables that apply to the loader are discussed in detail in their relevant sections. The
section `Configuration Reference`_ includes a list of all reserved configuration variables.

Feature Detection
-----------------

:ref:`has.js <dojo/has>` is a standard API that allows feature detection to be separated from feature-dependent code
branching and enables the build system to create platform-optimized versions of applications.

Here's an example of adding a test, and then later using that test:

.. js ::

  has.add("dom-addeventlistener", !!document.addEventListener);

  if(has("dom-addeventlistener")){
    node.addEventListener("click", handler);
  }else{
    node.attachEvent("onclick", handler);
  }

At build time, with an appropriate build profile, this code is transformed to:

.. js ::

  0 && has.add("dom-addeventlistener", !!document.addEventListener);

  if(1){
    node.addEventListener("click", handler);
  }else{
    node.attachEvent("onclick", handler);
  }

When transformed code is then passed to a minifier with dead code removal, the final output becomes:

.. js ::

  node.addEventListener("click", handler);

When these techniques are applied to heavily branched code, very large space savings are possible. These savings are
particularly important in mobile environments where bandwidth and cache size are more limited.

There are two features Dojo's implementation of has.js has that the standard has.js code does not:

  * the cache of tests is publicly exposed at ``has.cache``

  * the function ``has.add`` includes an optional fourth parameter, ``force``, that can be used to overwrite an existing
    test. (Normally, the first defined value is always used, like a constant.)

The Dojo loader initializes the has cache with several tests (see `Default Configuration`_ for a list of these
tests). ``dojoConfig`` and ``data-dojo-config`` can override any of these, and any configuration object can add more
tests by specifying a ``has`` configuration property. For example:

.. html ::

  <script>
    var dojoConfig = {
      has: {
        "config-tlmSiblingOfDojo":0,
        "myApp-someFeature":1
      }
    };
  </script>

A test can also be defined as a function, which will be executed the first time the value of the feature is requested
via a ``has`` call:

.. html ::

  <script>
    var dojoConfig = {
      has: {
        "myApp-someFeature":function(){
          return !!document.addEventListener;
        }
      }
    };
  </script>

Since has tests can be used very much like configuration variables, the loader's configuration API applies ``has.add``
to all configuration variables it receives, prefixing the configuration variable name with "config-". For example:

.. html ::

  <script data-dojo-config="tlmSiblingOfDojo:0" src="path/to/dojo/dojo.js"></script>

This code will result in a has test named "config-tlmSiblingOfDojo" with a value of 0.

Options/Features
----------------

The following table provides a list of options that are leveraged within the loader.  The first column is the Option/Feature as defined within the loader, the second options is whether this is a detected feature (via ``has.add()``) or if it is just an option and its default value.  With "unbuilt" source, all the features and options are available.  If the loader has been built, then some of these features may have been set as ``staticHasFeatures`` and not be configurable anymore.

.. csv-table:: 
  :header: "Feature", "Default Value", "Description"
  :widths: 12, 7, 30

  dojo-trace-api, True
  dojo-sync-loader, True
  dojo-config-api, True
  dojo-cdn, False
  dojo-requirejs-api, False
  dojo-test-sniff, True
  dojo-combo-api, False
  dojo-undef-api, False
  config-tlmSiblingOfDojo, True
  config-dojo-loader-catches, True
  dojo-inject-api, True
  config-stripStrict, False
  dojo-timeout-api, True
  dojo-log-api, True
  dojo-amd-factory-scan, True
  dojo-publish-privates, True
  dojo-built, False
  dojo-loader, True
  host-node, *Detected*, Environment is running on the the NodeJS platform
  host-rhino, *Detected*, Environment is running on the Rhino platform
  dojo-xhr-factory,  *Detected*
  dojo-force-activex-xhr, *Detected*, Force XHR provider to use ActiveX API (MSXMLHTTP).
  native-xhr, *Detected*, "Browser has native XHR API, XMLHttpRequest."
  dojo-gettext-api, *Detected*, Dojo provides API for retrieving text resource contents from a URL.
  dojo-loader-eval-hint-url, *Detected*, Module location should be used as source hint during eval rather than module identifier.
  ie-event-behavior, *Detected*, Browser supports legacy IE event behaviour API (attachEvent versus attachEventListener).

The AMD API
===========

The AMD API is the preferred loader API and is exposed through two global functions, ``require`` and ``define``. Both
functions are normally asynchronous. When running in legacy loader API mode, however, they may operate synchronously in
order to allow AMD modules to be accessed by legacy code.

``require`` is used to configure the loader and load AMD modules. It has the following signature:

.. js ::

  require(
    configuration, // (optional; object) configuration object
    dependencies,  // (optional; array of strings) list of module identifiers to load before calling callback
    callback       // (optional; function) function to call when dependencies are loaded
  ) -> undefined

If a ``configuration`` object is provided, it is passed to the configuration API as described in `Configuration`_. Next,
the dependencies listed in ``dependencies`` (if any) are resolved. Finally, ``callback`` (if any) is executed with the
resolved dependencies passed in as arguments.

Normal use of ``require`` looks like this:

.. js ::

  require([ "my/app", "dojo" ], function(app, dojo){
    // do something with app and dojo...
  });

There is also an alternative ``require`` syntax. It has the following signature:

.. js ::

  require(
    moduleId // (string) a module identifier
  ) -> any

This alternative ``require`` syntax can be used if you are certain the module referenced by ``moduleId`` has already
been defined and loaded. It will return the requested module. If the module is not loaded, it will throw an Error. *This
syntax is not recommended because it can lead to confusing dependency chains.*

``define`` is very similar to ``require`` and is used to define AMD modules. It has the following signature:

.. js ::

  define(
    moduleId,      // (optional; string) an explicit module identifier naming the module being defined
    dependencies,  // (optional; array of strings) list of module identifiers to load before calling factory
    factory        // (function or value) the value of the module, or a function that returns the value of the module
  )

If ``factory`` is a function, the defined module value is the return value of the function; otherwise, the module value
is ``factory``. Regardless of whether or not ``factory`` is a function, dependencies are always fully resolved before
the module is defined.

If only the ``factory`` parameter is given and it is a function, special semantics are implied; these are covered in
`CommonJS require, exports, and module`_.

**moduleId should not be provided.** This parameter is largely a historical artifact of early AMD loaders. So long as
there is **exactly** one module defined by any particular resource, the loader will automatically derive the correct
module identifier from the one given in the dependency list that caused it to be loaded. For example, when calling
``require(["mathLib/arithmetic"])``, the loader knows that the loaded module has a ``moduleId`` of
"mathLib/arithmetic".

It is also possible to load a script as a dependency with no ``define`` calls at all, in which case the resolved value
will be ``undefined``. See `Generic Script Injection`_ for more information.

``define`` has two additional important characteristics that may not be immediately obvious:

  * Module creation is lazy and asynchronous, and does not occur immediately when ``define`` is called. This means that
    ``factory`` is not executed, and any dependencies of the module will not be resolved, until some running code
    actually requires the module.

  * Once a module value has been entered into the module namespace, it is not recomputed each time it is demanded. On a
    practical level, this means that ``factory`` is only invoked once, and the returned value is cached and shared
    among all code that uses a given module. (Note: the dojo loader includes the nonstandard function ``require.undef``,
    which undefines a module value.)

The ``dependencies`` and ``callback`` parameters in the ``require`` function work exactly like the ``dependencies`` and
``factory`` parameters in the ``define`` function. For example:

.. js ::

  require(
    ["dijit/layout/TabContainer", "bd/widgets/stateButton"],
    function(TabContainer, stateButton){
      // do something with TabContainer and stateButton...
    }
  );

...and...

.. js ::

  define(
    ["dijit/layout/TabContainer", "bd/widgets/stateButton"],
    function(TabContainer, stateButton){
      // do something with TabContainer and stateButton...
      return definedValue;
    }
  );

...both gain access to the values of the ``dijit/layout/TabContainer`` and ``bd/widgets/stateButton`` modules. The
difference between these two calls is that the latter is expected to also provide a value of its own, whereas the former
simply loads modules.

.. _loader/amd#module-identifiers:

Module Identifiers
==================

Module identifiers look like file system paths (for example, "dijit/form/Button"). These identifiers are normalized to
absolute URLs (in browsers) or file paths (in server-side environments) in order to find and load the source code that
defines the module.

The following `Configuration`_ variables control how module identifiers are mapped to URLs:

  * ``baseUrl``: (string) a path to prepend to a computed path if the computed path is relative as described by the
    process below. If defined, the has feature ``config-tlmSiblingOfDojo`` is false; otherwise, it is true.

  * ``paths``: (object) a map from a module identifier fragment to a path fragment. Module fragments are always matched
    starting from the beginning of a module identifier. *When matching paths, the most specific match wins.* For
    example, "a/b/c" is more specific than "a" or "a/b".

  * ``aliases``: (object) a globally applied map from a module identifier to another module identifier.  See `Alias 
    Modules`_ for more information.

  * ``map``: (object) module mapping with the ability to be applied only to specific modules. See `Map Config`_ for more 
    information.

  * the has feature ``config-tlmSiblingOfDojo``: if truthy, then non-package top-level modules not mentioned in
    ``paths`` are assumed to be siblings of the dojo package; otherwise, they are assumed to be relative to ``baseUrl``.

  * ``packages``: (array of package objects) A list of explicitly defined packages. dojo and dijit are both examples of
    packages. A package object contains four properties:

    * ``name``: (string) the name of the package (e.g. "myApp")

    * ``location``: (string) the path to the directory where the package resides (e.g. "path/to/myApp")

    * ``main``: (optional; string) the module identifier implied when a module identifier that is equivalent to just the
      package name is given; defaults to "main". (e.g. "dojo" => "dojo/main")

    * ``packageMap``: (optional; object) a map that allows package names to be aliased to other locations for this
      particular package only. See `Relocating Module Namespaces`_ for more information. (Note: this feature is
      currently exclusive to the Dojo loader.)

Relative Module Identifiers
---------------------------

Module identifiers in the ``dependencies`` array of a module definition can also be relative to the current module. For
example:

.. js ::

  // this is "myPackage/myModule/mySubmodule"
  define(
    ["myPackage/utils", "myPackage/myModule/mySubmodule2"],
    function(utils, submodule){
      // do something spectacular
    }
  );

Could be rewritten as:

.. js ::

  // this is "myPackage/myModule/mySubmodule"
  define(
    ["../utils", "./mySubmodule2"],
    function(utils, submodule){
    // do something spectacular
    }
  );

"." can be thought of as referring to the "directory" of the current module, and ".." as referring to the "parent
directory" of the current module.

**Note that relative module identifiers can only be used to refer to modules within a single package.** That is, "../"
cannot be used to ascend to the top level in the module identifier.  So in the above example,
"../../someOtherPackage/otherModule" would not be valid.

It is highly recommended that relative module IDs be used by all packages to refer to their own modules, since otherwise
it is impossible to load two different packages with the same name (or two different versions of the same package). This
is explored further in `Relocating Module Namespaces`_.

Context-sensitive require
-------------------------

Let's finish up one last detail about reference modules. Suppose we have a function that, depending on program flow,
needs to conditionally require and execute some code. For example:

.. js ::

  // this is "myApp/topLevelHandlers"
  define(["dojo"], function(dojo){
    dojo.connect(dojo.byId("debugButton"), "click", function(){
      require(["myApp/perspectives/debug"], function(perspective){
        perspective.open();
      });
    });
  });

This code is perfectly legal, but it can be better. Since this code is in the "myApp/topLevelHandlers" module, we should
be able to write "./perspectives/debug" instead of "myApp/perspectives/debug". Unfortunately, the global ``require``
function doesn't know anything about reference modules, so if we try just changing the identifier string, it will
fail. What we need is a way to remember the reference module for later use. This is possible by specifying the module
identifier "require" in the dependency vector:

.. js ::

  // this is "myApp/topLevelHandlers"
  define(["dojo", "require"], function(dojo, require){
    dojo.connect(dojo.byId("debugButton"), "click", function(){
      require(["./perspectives/debug"], function(perspective){
        perspective.open();
      });
    });
  });

The ``require`` call is now executed on a local ``require`` function instead of the global one. The loader arranges for
the local ``require`` to resolve module identifiers with respect to the reference module that defines it. This local
``require`` function is called a "context-sensitive require".


Generic Script Injection
========================

An explicit path or URL to a script can be passed as a module identifier. In this case, the script is simply evaluated and the return value of that "module" is ``undefined``. For example:

.. js ::

  require(["http://acmecorp.com/stuff.js"], function(){
    // etc.
  });

The loader interprets any of the following as a generic script identifier:

  * a string that starts with a protocol (e.g. "http:" or "https:")
  * a string that starts with a slash (e.g., "/acmecorp.com/stuff")
  * a string that ends in ".js"


Alias Modules
=============

It is possible to create an alias from one module to another. An example of when module aliasing might be needed is the
common ``text`` plugin, which loads a text resource through the plugin API (see `Plugins`_). RequireJS defined this
module early on, and several libraries depend on the module as defined by RequireJS. Dojo's implementation, while 100%
compatible with RequireJS's implementation, is smaller and contains more features. It is possible to simply alias Dojo's
text module like this:

.. js ::

  require({
    aliases:[
      ["text", "dojo/text"]
    ]
  });

Now, when the module identifier "text" is demanded, the loader will normalize that module identifier to "dojo/text". In
other words, given the configuration above, all of the following statements result in exactly the same module value
being returned:

.. js ::

  require(["text"], function(text){ //...
  require(["dojo/text"], function(text){ //...
  define(["text"], function(text){ //...
  define(["dojo/text"], function(text){ //...

There is one particular scenario where using aliases is not the optimal solution.  Two different absolute module identifiers
as calculated after Step 6 of the `Normalizing Module Identifiers`_ process will always result in two different modules
being instantiated - even if they normalize to the same path. This means you can't solve this problem using
``paths``. For example, assuming ``baseUrl`` points to the dojo directory, you **can't** alias "text" to "dojo/text"
like this:

.. js ::

  require({
    paths:{
      "text":"./text"
    }
  });

In this case, assuming no reference module, "text" is normalized to ("text", "path/to/dojo/text.js"). Although
"path/to/dojo/text.js" has the same path as the module given by "dojo/text", the loader will create two separate
instances of that module, which is probably not what you want. The only way to get two different module identifiers to
resolve to the same module value is to either write a module definition with an explicit module ID (not recommended) or
provide an aliases configuration.


Map Config
==========

The ``map`` loader configuration option is similar to the ``alias`` option in that it allows you to alias module 
identifiers but with more flexibility in terms of context and matching capabilities. The value of the ``map`` option
is an object whose keys define the context of the mapping and the values are the aliases. For example:

.. js ::

  map: {
    "app/ModuleA": {
      "app/Widget": "app/Widget_NEW"
    }
 }

In this example, the request for ``app/Widget`` would load ``app/Widget_NEW`` from within ``app/ModuleA`` only. 
Requests made for ``app/Widget`` from within any other module would continue to load ``app/Widget``. This allows for 
more complex loading scenarios in which you might have multiple concurrent versions of the same module that you need to 
use in different parts of your application. 

If you want to add a mapping that applies to all modules, you just use "*" for the module value like this:

.. js ::

  map: {
    "*": {
      "app/Widget": "app/WidgetB"
    }
  }

In this example all requests for ``app/Widget`` would load ``app/WidgetB`` regardless of which module the request 
originated from. The "*" option can be used in conjunction with other mappings remembering that the most specific 
mappings take precedence.

In most cases, the ``map`` option in combination with ``packages`` is a better solution than ``alias`` because of its 
flexibility. For more information on the ``map`` option, including it's partial matching capabilities, you can check 
out `this SitePen blog post <http://www.sitepen.com/blog/2013/07/03/dojo-faq-what-is-the-map-config-option/>`_.


Normalizing Module Identifiers
==============================

The following steps outline the loader's internal normalization process.  This process involves a module ID
(``moduleId``) and, in the case of context-sensitive require, a reference module (``referenceModule``), and yields a
resulting path or URL (``result``).

  1. If ``moduleId`` begins with a protocol (for example, "http:") or a forward-slash, or ends with a ".js" suffix,
  assume the request is for an arbitrary chunk of JavaScript, not a module.  In this case the rest of these steps are
  effectively skipped.

  2. If ``moduleId`` is relative (i.e. its first character is ".") and no ``referenceModule`` is given, throw an Error:
  ``moduleId`` is not resolvable.

  3. If ``moduleId`` is relative and ``referenceModule`` is given, set ``moduleId`` to the module identifier given by
  ``referenceModule + "/../" + moduleId`` and collapse any relative segments. At this point, ``moduleId`` should contain
  no relative fragments; if it does, throw an Error: ``moduleId`` is not resolvable.

  4. If ``referenceModule`` is given, and it is a member of a package defined in the ``packages`` configuration
  variable, and that package also has an entry in the ``packageMap`` configuration variable, replace the leftmost
  segment of ``moduleId`` (the package name) with the value given in ``packageMap``.

  5. Look up the ``moduleId`` computed in Step 3 in the ``aliases`` configuration variable. If ``moduleId`` is aliased,
  restart the process at Step 3 with the new ``moduleId`` from ``aliases``.  Note that this means ``aliases`` is
  referenced *after* ``packageMap`` has taken effect.

  6. If the ``moduleId`` is only one segment long, and this segment is identical to a package name in the ``packages``
  configuration variable, append "/" and the value of the ``main`` configuration variable for the package to
  ``moduleId``. (For example, "dojo" would be resolved to "dojo/main".)

  At this point, ``moduleId`` has been fully normalized to an absolute module identifier known to the loader (that is, the
  reference module has no further influence on the absolute module identifier).

  7. Find the longest module identifier fragment in ``paths`` that matches from the start of ``moduleId``. If a match is
  found, let ``result`` be equal to ``moduleId`` with the matched section replaced with the corresponding value from
  ``paths``.

  8. If no matching paths were found in Step 7 and ``moduleId`` references a module in a package, let ``result`` be
  equal to ``moduleId`` with its first segment (the package name) replaced with the ``location`` property from the
  relevant package.

  9. If neither Step 7 nor 8 were applied and has("config-tlmSiblingOfDojo") is truthy, then let ``result`` be equal to
  ``"../" + moduleId``.

  10. If ``result`` is not absolute, prefix it with the value of the configuration variable ``baseUrl``.

  11. Append the suffix ".js" to ``result``.

Normalization Examples
----------------------

In these examples, assume that the default configuration is in use.

dojo

::

  dojo ⇒ dojo/main (Step 6)
  dojo/main ⇒ ./main (Step 8)
  ./main ⇒ path/to/dojo/ + ./main ⇒ path/to/dojo/main (Step 10)
  path/to/dojo/main.js (Step 11)

dojo/store/api/Store

::

  dojo/store/api/Store ⇒ ./store/api/Store (Step 8)
  ./store/api/Store ⇒ path/to/dojo/ + ./store/api/Store ⇒ path/to/dojo/store/api/Store (Step 10)
  path/to/dojo/store/api/Store.js (Step 11)
  
../../_base/Deferred with reference module dojo/store/util/QueryResults

::

  ../../_base/Deferred ⇒ dojo/store/util/QueryResults + /../ + ../../_base/Deferred ⇒
  dojo/store/util/QueryResults/../../../_base/Deferred ⇒ dojo/_base/Deferred (Step 3)
  dojo/_base/Deferred ⇒ ./_base/Deferred (Step 8)
  ./_base/Deferred ⇒ path/to/dojo/ + ./_base/Deferred ⇒ path/to/dojo/_base/Deferred (Step 10)
  path/to/dojo/_base/Deferred.js (Step 11)

myApp

::

  myApp ⇒ ../myApp (Step 9)
  ../myApp ⇒ path/to/dtk + ../myApp ⇒ path/to/myApp (Step 10)
  path/to/myApp.js (Step 11)
  
myApp/someSubmodule

::

  myApp/someSubmodule ⇒ ../myApp/someSubmodule (Step 9)
  ../myApp/someSubmodule ⇒ path/to + ../myApp/someSubmodule ⇒ path/to/myApp/someSubmodule (Step 10)
  path/to/myApp/someSubmodule.js (Step 11)

Notice how, assuming baseUrl points to the dojo tree as per the default, the top-level module identifier "myApp" is now a sibling of the dojo tree - just like ``tlmSiblingOfDojo`` suggests. This is how the dojo v1.x line has always treated top-level modules (absent a paths mapping).

If the myApp tree were to reside at "/other/path/to/myApp", this could be achieved by providing a paths configuration like this:

.. js ::

  var dojoConfig = {
    paths:{
      "myApp":"/other/path/to/myApp"
    }
  };

Since "/other/path/to/my/App" is absolute, Step 10 does not add baseUrl to the mix:

myApp

::

  myApp ⇒ /other/path/to/myApp (Step 7)
  /other/path/to/myApp.js (Step 11)
  
myApp/someSubmodule

::

  myApp/someSubmodule ⇒ /other/path/to/myApp/someSubmodule (Step 7)
  /other/path/to/myApp/someSubmodule.js (Step 11)

``paths`` can also map *to* path segments that are relative. For example, assume you have the following tree of modules:

::

  scripts/
    dtk/
      dojo/
      dijit/
      dojox/
    myApp/
    experimental/

In this case, myApp is not a sibling of dojo, but is still reachable from the automatically-computed baseUrl that points to script/dtk/dojo. A paths entry that gives the path for myApp relative to baseUrl will work:

.. js ::

  var dojoConfig = {
    paths:{
      "myApp":"../../myApp"
    }
  };

Resulting in...

myApp

::

  myApp ⇒ ../../myApp (Step 7)
  ../../myApp ⇒ path/to/dtk/dojo/ + ../../myApp ⇒ path/to/myApp (Step 10)
  path/to/myApp ⇒ path/to/myApp.js (Step 11)
  
myApp/someSubmodule

::

  myApp ⇒ ../../myApp/someSubmodule (Step 7)
  ../../myApp/someSubmodule ⇒ path/to/dtk/dojo/ + ../../myApp ⇒ path/to/myApp/someSubmodule (Step 10)
  path/to/myApp/someSubmodule ⇒ path/to/myApp/someSubmodule.js (Step 11)

This is one way to override the behavior of ``tlmSiblingOfDojo``. Another way is to set ``tlmSiblingOfDojo`` to falsy or explicitly set ``baseUrl``. Assuming the same tree of modules given above, consider this configuration:

.. js ::

  var dojoConfig = {
    baseUrl:"scripts",
    packages:[{
      name:'dojo',
      location:'dtk/dojo'
    },{
      name:'dijit',
      location:'dtk/dijit'
    }]
  }

Notice that this time there is no paths mapping; we don't need one, because setting ``baseUrl`` sets ``tlmSiblingOfDojo`` to false, which means identifiers are now simply relative to ``baseUrl``:

myApp

::

  myApp ⇒ scripts/ + myApp ⇒ script/myApp (Step 10)
  scripts/myApp ⇒ scripts/myApp.js (Step 11)

myApp/someSubmodule

::

  myApp ⇒ scripts/ + myApp/someSubmodule ⇒ script/myApp/someSubmodule (Step 10)
  scripts/myApp/someSubmodule ⇒ scripts/myApp/someSubmodule.js (Step 11)

dojo

::

  dojo ⇒ dojo/main (Step 4)
  dojo/main ⇒ dtk/dojo/main (Step 8)
  dtk/dojo/main ⇒ scripts/dtk/dojo/ + ./main ⇒ scripts/dtk/dojo/main (Step 10)
  scripts/dtk/dojo/main.js (Step 11)

dojo/behavior

::

  dojo/behavior ⇒ dtk/dojo/behavior (Step 8)
  dtk/dojo/behavior ⇒ scripts/dtk/dojo/ + ./behavior ⇒ scripts/dtk/dojo/behavior (Step 10)
  scripts/dojo/behavior.js (Step 11)

If we make myApp a proper package, the resolution of "myApp" will change:

.. js ::

  var dojoConfig = {
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
  };

"myApp/someSubmodule" maps the same, but "myApp" does not:

myApp

::

  myApp ⇒ myApp/main (Step 4)
  myApp/main ⇒ myApp/main (Step 8)
  myApp/main ⇒ scripts/ + myApp/main ⇒ scripts/myApp/main (Step 10)
  scripts/myApp/main.js (Step 11)

Configuring packages is usually a much better idea than cluttering the scripts directory with a bunch of top-level
modules.

Usually, you can map a module identifier anywhere. For example, maybe you are experimenting with a new module that
replaces dojo/cookie. In this case, you want all dojo modules to map as usual, but you want dojo/cookie to map to
scripts/experimental/dojo/cookie. All that's needed to achieve this is add an entry into paths:

.. js ::

  var dojoConfig = {
    paths:{
      "dojo/cookie":"../../experimental/dojo/cookie"
    }
  }

Now, Step 7 will treat dojo/cookie differently than any other module identifier and map it to
scripts/experimental/dojo/cookie.

Finally, consider what happens when the module identifier you want to map is the parent segment of a tree of
modules. For example, consider this tree:

::

  scripts/
    myApp/
      myApi.js
      myApi/
        helper1.js
        helper2.js

On one hand, "myApp/myApi" is a module, but it's also a parent segment for the module identifiers "myApp/myApi/helper1"
and "myApp/myApi/helper2". This means that the paths entry ``"myApp/myApi":"path/to/another/myApi"`` will remap the two
helper modules as well. More often than not, this is exactly what you'll want, but if it isn't, you can simply add more
path entries for the original helpers. Here's what that would look like:

.. js ::

  var dojoConfig = {
    paths:{
      "myApp/myApi":"path/to/another/myApi",
      "myApp/myApi/helper1":"path/to/original/myApi/helper1",
      "myApp/myApi/helper2":"path/to/original/myApi/helper2"
    }
  }

That's pretty verbose and not very convenient, but this is also a highly unusual configuration that you'll rarely, if
ever, need.


.. _loader/amd#relocating-module-namespaces:

Relocating Module Namespaces
============================

If you want to use two packages with the same name at the same time, as long as the package authors followed best
practices and did not use an explicit ``moduleId`` in their ``define`` calls, you can simply install the two packages to
two different directories and then define each package with a unique name in the ``packages`` array. For example:

.. js ::

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

You can then access these packages normally through ``require`` or ``define``:

.. js ::

  define(["util1", "util2"], function(util1, util2){
    // well that was easy.
  });

It is also possible to remap packages that are required by another package. For example:

.. js ::

  var dojoConfig = {
    packages: [{
      name: "util1",
      location: "packages/util1",
      packageMap: {dojox:"dojox1"}
    }, {
      name: "util2",
      location: "packages/util2",
      packageMap: {dojox:"dojox2"}
    }, {
      name: "dojox1",
      location: "packages/dojox-version-1-6"
    }, {
      name: "dojox2",
      location: "packages/dojox-version-1-4"
    }]
  };

This code will ensure that all explicit references to the "dojox" package in "util1" are redirected to "dojox1", and all
references to the "dojox" package in "util2" are redirected to "dojox2".

This design replaces the so-called "multi-version" design in dojo v1.6- and eliminates the need for contexts as
implemented in RequireJS. Notice that, unlike the multi-version design, no build is required to deploy a relocated
package. It's all a matter of simple configuration. This is a very powerful feature and only dojo has it.

.. _loader/amd#utility-functions:

Utility Functions
=================

Dojo's AMD API includes a few utility functions:

``require.toUrl`` converts a name that is prefixed by a module identifier to a URL by replacing the module identifier
prefix with the path resolved by the normalization process.

.. js ::

  require.toUrl(
    id // (string) a resource identifier that is prefixed by a module identifier
  ) -> string

For example, let's say you've defined a configuration that will cause the module identifier "myApp/widgets/button" to
point to the resource ``http://acmeCopy.com/myApp/widgets/button.js``. In such a case,
``require.toUrl("myApp/widgets/templates/button.html")`` would return
``http://acmeCopy.com/myApp/widgets/templates/button.html``.

This also works with relative IDs when ``require`` is a `context-sensitive require`_.
For example:

.. js ::

     define(["require", ...], function(require, ...){
          ... require.toUrl("./images/foo.jpg") ...
     }

Note how the URL begins with "./".

``require.toAbsMid`` converts the given module ID to an absolute module ID. This function is only useful when used in
conjunction with a `context-sensitive require`_.

.. js ::

  require.toAbsMid(
    moduleId // (string) a module identifier
  ) -> string

``require.undef`` removes a module from the module namespace. ``require.undef`` is primarily useful for test frameworks that need to load and unload modules without having to reload the entire application.

.. js ::

  require.undef(
    moduleId // (string) a module identifier
  ) -> undefined

``require.log`` is an alias to the current environment's ``console.log`` equivalent. Each passed argument is logged to a separate line.

.. js ::

  require.log(
    // (...rest) one or more messages to log
  ) -> undefined

``require.toAbsMid`` and ``require.undef`` are Dojo-specific extensions to the AMD specification.


CommonJS require, exports, and module
=====================================

The AMD specification defines three special module identifiers: ``require``, ``exports``, and ``module``.

The ``require`` module works as described in `Context-sensitive require`_.

The ``module`` module returns an object that contains the following properties:

  * ``id``: a unique module identifier string that, when passed to ``require``, returns the module's value
  * ``uri``: the fully-qualified URI from which the module resource was loaded (this may not always be available)
  * ``exports``: described below

The ``exports`` module and ``module.exports`` provide an alternative method for defining a module value. Instead of returning the value explicitly by a return statement in the factory function, ``exports`` provides a JavaScript object onto which properties can be attached. For example, the following two module definitions are identical:

.. js ::

  define([], function(){
    return {
      someProperty:"hello",
      someOtherProperty:"world"
    };
  });


  define(["exports"], function(exports){
    exports.someProperty = "hello";
    exports.someOtherProperty = "world";
  });

Attaching properties to the ``exports`` object is the only way to ensure modules are properly defined when they are in a circular dependency.

The ``module.exports`` object can also be replaced entirely if desired:

.. js ::

  define(["module"], function(module){
    module.exports = dojo.declare(/*...*/);
  });

Finally, the AMD specification states that when ``define`` is provided only a factory function, the loader must act as though a dependencies array was passed with the value ``["require", "exports", "module"]``. In other words, the following two ``define`` calls are equivalent:

.. js ::

  define(["require", "exports", "module"], function(require, exports, module){
    // define a module
  });

  define(function(require, exports, module){
    // define a module
  });

In the latter case, calls within the function of the form ``require("foo")`` will be scanned for and resolved as though they were given as dependencies.

All of this functionality is provided primarily for compatibility with other CommonJS modules. You should **not** use it unless you are writing modules specifically for e.g. node.js and do not want to require users to load a fully-compliant AMD loader, or in the case of ``exports``, if you need to resolve a circular dependency.


Plugins
=======

Plugins can be used to extend the loader to support loading resources other than AMD modules (for example, templates or i18n bundles). Dojo v1.7 includes several plugins of its own:

  * :ref:`dojo/domReady <dojo/domReady>`: defers execution of the module's factory function until the DOM is ready.

  * :ref:`dojo/text <dojo/text>`: loads text resources; it is a superset of RequireJS's text plugin, and subsumes ``dojo.cache``.

  * :ref:`dojo/i18n <dojo/i18n>`: loads i18n bundles either in legacy or AMD format. It includes the v1.6- i18n API and is a superset of
    RequireJS's i18n plugin.

  * :ref:`dojo/has <dojo/has>`: allows has.js expressions to be used to conditionally load modules.

  * :ref:`dojo/require <dojo/require>`: downloads a legacy module without loading it. This allows the legacy code path to be guaranteed.

  * `dojo/loadInit`: causes dojo.loadInit callbacks then other legacy API functions to be executed--in particular
    dojo.require[After]If--that are associated with a module


When a module identifier passed to ``require`` or ``define`` contains an "!", the loader splits the string in two at the
exclamation point. The string to the left of "!" is treated like a normal module ID and is used as the identifier for
the desired plugin; the string to the right of "!" is passed to the plugin for processing.

Like all other AMD modules, the plugin module is loaded only once; unlike normal modules, it must return an object
containing a function named "load" with this signature:

.. js ::

  load(
    id,        // the string to the right of the !
    require,   // AMD require; usually a context-sensitive require bound to the module making the plugin request
    callback   // the function the plugin should call with the return value once it is done
  ) -> undefined

Here is an example of loading some raw text with a "text" plugin:

.. js ::

  // this is "myApp/myModule"
  define(["text!./templates/myModule.html"], function(template){
    // template is a string loaded from the resource implied by myApp/templates/myModule.html
  });

And a simple "text" plugin implementation:

.. js ::

  define(["dojo/_base/xhr"], function(xhr){
    return {
      load: function(id, require, callback){
        xhr.get({
          url: require.toUrl(id),
          load: function(text){
            callback(text);
          }
        });
      }
    };
  });

Unlike the value returned by regular modules, the loader does not cache the value passed by a plugin to ``callback``. A plugin can maintain its own internal cache, if desired:

.. js ::

  define(["dojo"], function(dojo){
    var cache = {};
    return {
      load: function(id, require, callback){
        var url = require.toUrl(id);
        if(url in cache){
          callback(cache[url]);
        }else{
          dojo.xhrGet({
            url: url,
            load: function(text){
              callback(cache[url] = text);
            }
          });
        }
      }
    };
  });


Window Load Detection
=====================

The Dojo loader connects to the ``window.onload`` event and sets ``document.readyState`` to "complete" if it's not
already set. This allows a normal AMD module to rely on ``document.readyState``, even in browsers that do not properly
support this property.


The Micro Event API
===================

The loader defines a micro event API that it uses to report errors, configuration changes, tracing, and idle state. The
API consists of two functions:

.. js ::

  require.on = function(
    eventName, // (string) the event name to connect to
    listener   // (function) called upon event
  )

  require.signal = function(
    eventName, // (string) the event name to signal
    args       // (array) the arguments to apply to each listener
  )

The loader itself uses ``require.signal`` to signal its own events. Clients may listen for loader events by passing a
listener function to ``require.on``. For example, a client could connect to the "config" event to watch for
configuration changes like this:

.. js ::

  var handle = require.on("config", function(config, rawConfig){
        if(config.myApp.myConfigVar){
          // do something
    }
  });

Notice that the "config" event provides both a ``config`` and a ``rawConfig`` argument; this is described in more detail
in the `Configuration`_ section.

``require.on`` returns an opaque ``handle`` object that can be used to stop listening by calling ``handle.remove()``.

The loader reserves the event names "error", "config", "idle", and "trace". Client applications that wish to use the
micro event API with custom events are free to use any other event names.


Error Reporting
===============

When things go wrong, the loader raises an "error" event through the micro event API. To monitor loader errors, simply connect via ``require.on`` like this:

.. js ::

  function handleError(error){
    console.log(error.src, error.id);
  }
  
  require.on("error", handleError);

The first argument sent to the listener is a loader error object that contains the property ``src``, which is currently always set to "dojoLoader", and the property ``id``, which gives a string identifier indicating the particular error. The loader defines the following error identifiers:

factoryThrew
  A module factory function threw an Error.

xhrFailed
  An XHR failed to retrieve a module resource. Typically, this indicates an HTTP 404 error, and is often caused by a configuration problem with paths, aliases, packages, and/or baseUrl.

multipleDefine
  AMD ``define`` was called referencing a module that has already been defined. The most common cause of this problem is loading modules via ``<script>`` elements in the HTML document. Use the loader; don't use ``<script>`` elements. The second most common cause is passing explicit module identifiers to ``define``; don't do this either.

timeout
  ``waitSeconds`` has elapsed since the last module was requested, yet all modules have not arrived. Typically, this indicates an HTTP 404 error, and is often caused by a configuration problem with paths, aliases, packages, and/or baseUrl.

defineIe
  An anonymous ``define`` call occurred in an Internet Explorer environment but it was impossible to determine the implied module identifier. defineIe errors are usually caused by the same kinds of problems that cause multipleDefine errors.

Loader errors are often impossible to recover from. If your application demands a module that does not exist, there's nothing the loader can do to fix that situation. However, this API can be used to attempt other strategies (like loading from a backup server) or to provide error messages to improve user experience.


Debugging
=========

Debugging highly asynchronous processes like loading a tree of AMD modules can be tricky. Here are a few pointers to make this task manageable:

  * The most common error for programmers used to the legacy loader API is to express a module identifier using dots
    instead of slashes.

  * A common syntax error that's not well reported in some browsers is to miss a comma in a dependencies argument.

  * A common programming error is to accidentally mismatch module identifiers in the dependencies array with their
    corresponding parameters in the callback/factory function. This will often show up as "object is not a constructor"
    or "method does not exist" or similar.

  * In some browsers, in some circumstances, inserting breakpoints will change the asynchronous flow and cause an
    application to fail only when breakpoints are inserted. This generally indicates the program is depending on modules
    being defined in a certain order; well-designed AMD applications will have no such requirement.

The Dojo loader also exposes its internal state for inspection during debugging on the ``require`` object. These are:

async
  A boolean indicating whether or not the asynchronous loader is in use.

legacyMode
  A string describing the legacy mode of the loader (if async is false).

baseUrl
  The baseUrl configuration variable

paths
  The paths configuration variable

packs
  The package configuration. This is a combination of all passed package configurations.

waiting
  A list of modules the loader has requested that have not yet arrived. If the loader seems to stall, look here second; look in your debugger's network panel for 404 errors first.

execQ
  The queue of modules that is scheduled to execute. If this queue seems stalled, then there is almost certainly another problem, probably 404 errors, syntax errors, or naming errors elsewhere.

modules
  The module namespace. Each entry holds all information about each module known to the loader:

  * ``result`` holds the module value

  * ``injected`` holds the loaded state (one of 0, "requested", "arrived")

  * ``executed`` holds the executed state of a factory (one of 0, "executing", "executed")

  * ``pid`` holds the owning package (if any)

  * ``url`` holds the address the loader has computed for the resource that defines the module

  * ``def`` holds the factory

Warning: these internal definitions are exposed and discussed here to help with debugging **only**. Do **not** use them in your own code. These structures may change!


Tracing
=======

Owing to the asynchronous nature of the loader, sometimes the best technique to solve a loading problem is to let the loader proceed normally without any breakpoints and analyze the order of certain loader events like injecting, defining, or executing a module. The source version of the loader contains a tracing API to facilitate this debugging technique. The tracing API can also be used with your own code if desired.

The tracing API has the following signatures:

.. js ::

  require.trace = function(
    groupId, // (string) the tracing group identifier to which this trace message belongs
    args     // (array of any) additional data to send with trace
  ) -> undefined

  require.trace.set(
    groupId, // (string) a tracing group identifier
    enable   // (boolean) enable or disable tracing of messages from groupId
  ) -> undefined

  require.trace.set(
    groupMap  // (object:groupId --> boolean) a map from trace group identifier to on/off value
  ) -> undefined

  require.trace.on // (boolean) enable/disable all tracing

  require.trace.group // (object) a map from trace group id to boolean

To emit trace messages, call ``require.trace`` with a groupId and an array of information to be sent as part of the trace.

When ``require.trace(groupId, args)`` is called, the following process takes place:

1. If ``trace.on`` is falsy, then do nothing and return.

2. If ``trace.group[groupId]`` is falsy, then do nothing and return.

3. Signal the trace event via `the micro event API`_ with the argument ``[groupId, args]``.

4. Concatenate ``groupId`` and the string value of each item in args into a comma-separated list and apply ``require.log`` to the resulting string.

5. Apply ``require.log`` to each item in args.

Tracing can be turned on or off for one or more trace groups by providing a configuration variable ``trace``. For example:

.. js ::

  require({
    trace:{
      "loader-inject":1, // turn the loader-inject group on
      "loader-define":0 // turn the loader-define group off
    }
  });

Alternatively, require.trace.set can be called directly; there are two forms:

.. js ::

  require.trace.set({
    "loader-inject":1, // turn the loader-inject group on
    "loader-define":0 // turn the loader-define group off
  });

...or, equivalently...

.. js ::

  require.trace.set("loader-inject", 1);
  require.trace.set("loader-define", 0);

All tracing can be suspended by setting ``require.trace.on`` to false; setting ``require.trace.on`` to true only enables the groups that have been individually set to true as described above.

The loader defines the following trace groups:

loader-inject
  Emitted when a module is injected into the application. args[0] will be "cache" if the module was in the loader cache, "xhr" if the module was injected via an XHR transaction, and "script" if the module was script-injected. Args[1] is the module identifier; args[2] is the URL/filename; if args[0] is "xhr", args[3] will be ``true`` if asynchronous XHR was used.

loader-define
  Emitted when ``define`` is called. args[0] is the module identifier. args[1] is the dependencies array. Notice that args give the decoded values of these parameters, not the actual values at arguments[0] and arguments[1]. Often the loader does not actually process the define call until the script that contains the define call has been fully processed; processing of the define call is traced with by "loader-define-module" (see below).

loader-exec-module
  Emitted when the loader attempts or fails to run a module's factory by first tracing the module's dependency tree and running all dependent module factories. Notice that success is not guaranteed: if a dependent module can not be resolved (perhaps it has not arrived yet), then the attempt is aborted and reattempted later. args[0] is "exec" on attempt, "abort" on failure; args[1] is the module identifier.

loader-run-factory
  Emitted when the loader is about to call a module's factory function after all dependencies have been satisfied. args[0] is the module identifier.

loader-finish-exec
  Emitted when the loader is executing final cleanup after having successfully run a module's factory. This includes passing all queued plugin requests to newly instantiated plugin modules and updating module values for legacy modules. Args[0] is the module identifier.

loader-define-module
  Emitted when the loader is about to process a previous ``define`` call. See loader-define, above. args[0] is the module identifier.

loader-circular-dependency
  Emitted when the loader detects a circular dependency, which may or may not indicate a programming error.


Non-browser Environments
========================

As of v1.7, the Dojo loader supports Rhino and node.js out of the box. Loading the Dojo loader from the command-line with node.js looks like this:

.. code-block :: bash

  #!/bin/bash
  node dojo/dojo.js load=config load=main

And like this with Rhino:

.. code-block :: bash

  #!/bin/bash
  java -jar util/shrinksafe/js.jar dojo/dojo.js baseUrl=file:///full/path/to/dojo/dojo load=config load=main

The Legacy API
==============

In order to maintain backwards compatibility with v1.6-, the v1.7 loader includes the complete synchronous loader API
(dojo.provide, dojo.require, dojo.requireLocalization, dojo.requireIf, dojo.requireAfterIf, dojo.platformRequire, and
dojo.loadInit), and should work exactly the same as earlier loaders, with one exception:

Owing to the way ``dojo.eval`` is defined in v1.6- and the way some browsers' ``eval`` functions work, sometimes a
module's code would be evaluated in the global scope and sometimes it would be evaluated in a function scope. Consider
the module text:

.. js ::

  dojo.provide("module.that.defines.a.global");
  var someVariable = anAwesomeCalculation();

If the code above is evaluated in the global scope, then ``someVariable`` is entered into the global namespace; however,
if it's evaluated in a function scope, then ``someVariable`` is a local variable and disappears when the function
returns.

In version 1.7+, all code that is downloaded as text and evaluated with ``eval`` is evaluated in a function scope. If
you've got code like the above and expect ``someVariable`` be defined in the global space, it will not work in v1.7 (it
only worked sometimes anyway, even if you didn't know it). To define global variables, assign them as properties of
``dojo.global``:

.. js ::

  dojo.provide("module.that.defines.a.global");
  dojo.global.someVariable = anAwesomeCalculation();


Modes of Operation
==================

The v1.7 loader is able to load both legacy modules and AMD modules in the same application. This allows client
applications written using the legacy API to use dojo, dijit, and other libraries that have already been rewritten with
the AMD API. In such cases, the loader must operate synchronously, since modules written with the legacy API cannot be
loaded asynchronously.

There are two sub-modes to the legacy mode of the v1.7 loader: synchronous and cross-domain.

Legacy Synchronous Mode
-----------------------

In this mode, the only difference between the v1.7 loader and previous Dojo loaders is how the loader treats the module
value. Unlike in normal AMD API operation, legacy synchronous mode will cause all dependencies to be immediately
resolved and factory functions executed, even if the related module has not been used yet.

The loader will also assign the return value of an AMD module required by ``dojo.require`` to the object name given in
``dojo.require`` so long as that object is ``undefined`` at the time ``dojo.require`` is called. This behavior can be
suppressed completely by setting the has feature ``config-publishRequireResult`` to false.

Legacy Cross Domain Mode
------------------------

The moment the loader enters cross-domain mode, even legacy modules start executing asynchronously. This means that if
the loader happens to be in the middle of tracing a dependency tree generated by several interdependent legacy modules,
any future ``dojo.require`` calls will return immediately without first executing the module. v1.6- also exhibited this
behavior.


Configuration Reference
=======================

Configuration Variables
-----------------------

async (true, false/"sync", "legacyAsync")
  If a truthy value other than "sync" or "legacyAsync", puts the loader in AMD mode. If falsy or "sync", puts the loader in legacy synchronous mode. "legacyAsync" puts the loader permanently in legacy cross-domain mode. Defaults to false.

baseUrl (string)
  The base URL prepended to a module identifier when converting it to a path or URL. Defaults to the path to dojo.js in browser environments, and the current working directory in non-browser environments.

packages (array of package configuration objects)
  Defined in `Module Identifiers`_. Default is shown in the `Default Configuration`_ section. Note: other properties provided by a package object will be copied (via the JavaScript = operator) to the package configuration variable maintained by the loader at ``require.packs[<name>]``. Client applications may specify and use such additional properties as required.

packagePaths (object)
  This is a shorthand notation that can be used to specify package configuration for several packages that have the same root location. A particular package's location configuration variable is computed by concatenating the map key at which the particular package configuration object resides and the package name. The package configuration object may be specified as a string, thereby indicating the package name and default values for main and packageMap. For example:

.. js ::

  packagePaths:{
    "path/to/some/place":[
      "myPackage",
      {
        name:"yourPackage",
        main:"base"
      }
    ]
  }

Is equivalent to:

.. js ::

  packages:[{
    name:"myPackage",
    location:"path/to/some/place/myPackage"
  },{
    name:"yourPackage",
    location:"path/to/some/place/youPackage"
  }]

aliases (array of pairs (arrays of 2 elements))
  Defined in `Module Identifiers`_. The first element may either be a regular expression, indicating a set of module identifiers to alias, or a string, indicating a single module identifier to alias. The second element in the pair is always a string, giving the target, absolute module identifier.

hasCache: (map:has feature name --> (any, typically boolean or function) has feature test or value)
  Provides a set of has feature values. Default is shown in the `Default Configuration`_ section.

waitSeconds (number)
  Indicates the number of seconds the loader will wait for all requested modules to arrive before signaling a timeout error. The timer is restarted after any module is requested. Defaults to 0 (wait forever).

cacheBust (boolean)
  Applicable to the browser environment only. If truthy, this value is appended to each module URL as a query string parameter to break browser caching. Defaults to false.

deps (array of module identifier strings) / callback (function)
  These configuration variables are only applicable before the loader has been loaded. When provided, they cause the loader to execute ``require(deps, callback)`` once it has finished loading.

stripStrict (boolean)
  This flag will strip the "use strict" strict directive out of modules. This can be enabled if you need to access the call stack through arguments.callee.caller, but generally it should be disabled (it is disabled by default). This feature only works in sync mode.

Default Configuration
---------------------

At the time this document was written, this was the default configuration for the Dojo loader. Please consult ``dojo.js`` for the latest and greatest.

.. js ::

    {
        // the default configuration for a browser; this will be modified by other environments
        hasCache:{
            "host-browser":1,
            "dom":1,
            "dojo-amd-factory-scan":1,
            "dojo-loader":1,
            "dojo-has-api":1,
            "dojo-inject-api":1,
            "dojo-timeout-api":1,
            "dojo-trace-api":1,
            "dojo-log-api":1,
            "dojo-dom-ready-api":1,
            "dojo-publish-privates":1,
            "dojo-config-api":1,
            "dojo-sniff":1,
            "dojo-sync-loader":1,
            "dojo-test-sniff":1,
            "config-tlmSiblingOfDojo":1
        },
        packages:[{
            // note: like v1.6-, this bootstrap computes baseUrl to be the dojo directory
            name:'dojo',
            location:'.'
        },{
            name:'tests',
            location:'./tests'
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
        }],
        trace:{
            // these are listed so it's simple to turn them on/off while debugging loading
            "loader-inject":0,
            "loader-define":0,
            "loader-exec-module":0,
            "loader-run-factory":0,
            "loader-finish-exec":0,
            "loader-define-module":0,
            "loader-circular-dependency":0
        },
        async:0
    }
