.. _releasenotes/migration17:

=====================================
Hints about Migrating from 1.x to 1.7
=====================================

.. contents ::
    :depth: 2
    
This guide aims to serve as the quick-and-dirty/all-you-need-to-know about getting up to speed with Dojo's new AMD-ready module loader and all the goodness that comes along with it. 

**TODOC:** dojo/i18n!, AMD nls bundles

Backwards Compatibility
=======================

First and foremost, all the changes in Dojo 1.7 **should** be backwards compatible. If you have an existing codebase utilizing Dojo 1.x everything should "JustWork". This guide is not for covering any regressions found, but rather aims to help a developer convert his/her codebase to the new AMD goodness.

This guide also assumes you have a basic working knowledge of the Dojo Toolkit, package system, and JavaScript.

You may see **several** examples and tutorials using a variety of syntax. Hopefully this guide will empower you to recognize the difference between major versions. For example:

.. js ::

    dojo.require("dojo.event.*")
    
Is a snippet of code from Dojo **0.4**. If you ever see an asterisk in a module name know that you are likely reading an outdated tutorial (with the exception of this guide or any other guides trying to show the difference). Likewise, many Dojo documentation tutorials read like:

.. js ::

    dojo.provide("a.b.C");
    dojo.require("d.e.F");
    
While this is still valid and will work with the "legacy synchronous loader", the goal here is to teach about the new asynchronous/anonymous loader.

Basic Patterns, Changed
=======================

A lot of little syntax changes have occurred, as well as a number of fundamental paradigm shifts in how you access modules. Again, everything **should** be backwards compatible, and this guide is meant to teach adoption of the new available patterns (which will likely be adopted for Dojo 2.0 ... so there's that)

Loading Dojo
------------

Nothing has changed. For browser environments, point your web browser's ``script`` element at a ``dojo.js``. 

Additionally, there is no longer a special ``dojo.xd.js`` file provided on the CDN. The AMD conversion makes *every* module cross-domain-loadable. In fact, the AMD loader is essentially a stripped down version of the cross-domain loader Dojo has shipped for several years. If you are familiar with, and perhaps already using, Dojo from a cross-domain CDN these new patterns won't seem so new. 

dojo.require
------------

Previously, one would ``dojo.require()`` modules into a page. Take this basic example:

.. js ::

    dojo.require("dojo.cookie");
    dojo.require("my.Thinger");
    dojo.addOnLoad(function(){
        alert("modules and DOM ready!");
    })
    
``dojo.require`` has been replaced simply with ``require()``. This is provided by loading ``dojo.js``, as always. The same example redone with Dojo 1.7 would look like:

.. js ::

    require(["dojo/cookie", "my/Thinger"], function(cookie, Thinger){
        alert("wait! DOM might not be ready yet?!")
    }); 

The ``require()`` call follows the `requirejs <http://requirejs.org/docs/api.html>`_ API. It does lots of amazing things. That is beyond the scope of this document, currently.

Take notice of the difference in the two examples:

* ``dojo.require`` takes a dot-separated module name, ``require()`` takes a forward-slash separated module name
* ``require()`` takes a function parameter, acting as a callback.
* the alert in the ``require()`` callback says DOM isn't ready? huh?
* the ``require()`` callback is passed arguments. I named them `cookie` and `Thinger`

The module name conversion should be self-explanatory. Both point to some resource on disk. In this case ``dojo/cookie.js`` and ``my/Thinger.js``. Both loaders will load the two files (and any dependencies) and execute the code following. 

The ``require()`` callback function is important. In the former example, we ``alert()`` within a ``dojo.addOnLoad`` function. In Dojo < 1.7, dojo.addOnLoad meant "modules and DOM ready". With ``require()``, the callback simply means "the modules you asked for are ready", leaving the DOM the be a separate concern. This is easily achieved with the ``dojo/domReady`` plugin.

.. js ::

    require(["dojo/cookie", "my/Thinger", "dojo/domReady!"], function(cookie, Thinger){
        alert("okay, NOW the modules I wanted AND DOM are ready! phew.");
    })

So to summarize: instead of calling dojo.require() N times, call require() once, passing an array of module names you want. If you need DOMReady, use ``"dojo/domReady!"``. Note the ``!`` following the module name. That puts the ``dojo/domReady`` module into "plugin" mode.

The special ``Thinger`` and ``cookie`` variables created for our ``require()`` callback are whatever the return values from ``dojo/cookie.js`` and ``my/Thinger.js`` were, respectively. We will discuss the return value of ``my/Thinger`` while we deprecate dojo.provide_ in the next section.

dojo.provide
------------

Previously, and building on the dojo.require_ breakdown, one would define a module on disk using ``dojo.provide``:

.. js ::

    dojo.provide("my.Thinger");
    dojo.require("dijit._Widget");
    dojo.declare("my.Thinger", dijit._Widget, {
        // ...
    });
    
With Dojo 1.7+, this becomes ``define()``. Easier to show in code than words:

.. js ::

    define(["dojo/_base/declare", "dijit/_Widget"], function(declare, _Widget){
        return declare(_Widget, {
            // ...
        });
    });
    
Ok, so this is where it gets cool. First, ``define()`` looks like a ``require()`` call: array of dependencies, and a callback function with those dependencies passed, in order. We could "name" our module in the ``define()`` call, but that takes the "A" out of "AMD". Instead, we define some anonymous module that requires Dojo's :ref:`declare() <dojo/declare>` module, and the base Dijit mixin :ref:`dijit._Widget <dijit/_Widget>`. 

The return value of ``dojo/_base/declare`` is the old ``dojo.declare`` function we know and love. It is available to us as a local variable ``declare``, within the ``define`` callback, as is the old ``dijit._Widget`` base class we love to inherit from. 

``dojo.provide`` would expand the passed module name into an object in the global space. eg:

.. js ::

    dojo.provide("a.b.c.d.e.f.g");
    
Would create an object structure like: 

.. js ::

    { a: { b: { c: { d: { e: { f: { g: {} }}}}}}}
    
Part of the motivation for AMD is to avoid global pollution. You are no longer ``a.b.c.d.e.f.g``: you are whatever you return from your module. Above, we are returning the return value of our ``dojo/_base/declare`` call, which turns out to be whatever it is we ``declare'd``. Like magic, a completely nameless/global-less "Class", available to anyone. When someone calls:

.. js ::

    require(["my/Thinger"], function(Thinger){
        new Thinger(); //
    })

They are creating a new instance of whatever it is you returned. 

dojo.cache
----------

Most commonly used with ``dijit._Templated``, dojo.cache reads local resources from a tree and makes them available to your JavaScript in a variable. 

.. js ::

    dojo.provide("a.b.C");
    dojo.declare("a.b.C", null, {
        templateString: dojo.cache("a.b", "templates/C.html")
    });
    
The resource at ``a/b/templates/C.html`` would be loaded immediately, and used to populate the ``templateString`` variable. In Dojo 1.7+ this is done with the ``dojo/text!`` plugin. Pass the module name as the parameter to the plugin, and the return value is transferred to the variable in the callback. Here is it ``template``:

.. js ::

    define(["dojo/_base/declare", "dojo/text!a/b/templates/C.html"], function(declare, template){
        return declare("a.b.C", null, {
            templateString: template
        })
    });
    
dojo.ready
----------

As seen in the `dojo.require`_ section, ``dojo.ready`` (an alias to ``dojo.addOnLoad``) no longer considers DOM-readiness. Or rather: The ``require()`` callback is **not** synonymous with ``document.ready``. The ``require()`` callback **only** considers modules and plugins. To accomplish "modules and DOM ready" you have a couple of options:

.. js ::

    require(["a/b/C", "dojo/domReady!"], function(C){
        new C().placeAt(document.body)
    });

Above the module a/b/C.js is loaded, and the ``new`` call is deferred until ``document.ready``. Next, we'll look at the ``dojo/ready`` module (not a plugin):

.. js ::

    require(["a/b/C", "dojo/ready", "dojo/_base/declare"], function(C, ready, declare){
        
        var D = declare(C, {
            newProp: 10
        });
        
        ready(function(){
            // DOM nao!
        });
    });
        
In this example we loaded the ``declare``, ``a/b/C.js`` and ``dojo/ready`` modules. When all the module dependencies are loaded our ``require()`` callback fires. *Then*, we register another function by calling ``ready()`` (the return value from ``dojo/ready``, in the second position)

The Hands off Approach
======================

It may be possible for you to convert much of your codebase into AMD-compatible goodness in a mostly automated fashion. Or rather: the method described in the coming sections will modify much of your existing code, making it passable as AMD-ready, though the devil is in the details, and some guidance is needed.

The secret is to run a build. Running a build over a legacy application codebase will create output wrapped in AMD (somewhat poorly, but backwards compatible). This is the first step into having a truly anonymous/granular source tree.

Running a build
---------------

Let's take a simple module, and build it.
(Again, this guide assumes you have a build plan in place and have existing code using 1.6 we want to convert)

Our sample module looks like this:

.. js ::

    dojo.provide("my.HotApplication");
    dojo.require("my.HotController");
    dojo.require("dijit._Widget");
    
    dojo.declare("my.HotApplication", my.HotController, {
        templateString: dojo.cache("my", "templates/HotApplication.html")
    });
    
It is conveniently located in a ``my/`` folder with ``dojo/`` and ``dijit/`` siblings.  First step is to run a build, but remember to turn off all optimizations::

    $ ./build.sh profile=myprofile cssOptimize=0 optimize=0 layerOptimize=0 copyTests=1 mini=0 version=... 
    
It might be a good idea to turn ``stripConsole`` off as well. Running this build will result in a new file tree including your newly AMD'ified ``my/`` folder. Looking at the new ``HotApplication.js`` file we see:

.. js ::

    //>>built
    define("my/HotApplication", [
        "dojo", "dijit", "dojox", "dojo/require!my/HotController", "dijit/_Widget",
        "dojo/text!my/templates/HotApplication.html"
    ], function(dojo, dijit, dojox){
    dojo.provide("my.HotApplication");
    dojo.require("my.HotController");
    dojo.require("dijit._Widget");
    
    dojo.declare("my.HotApplication", my.HotController, {
        templateString: dojo.cache("my", "templates/HotApplication.html")
    });
    });
    //>>built

See what has happened? First, our module is no longer anonymous: given the name ``my/HotApplication`` ... Next, the first three dependencies listed are simply ``dojo``, ``dijit`` and ``dojox`` ... This is a backwards-compatibility require which populates the global ``dojo`` and ``dijit`` objects, so you can continue to use calls like `dojo.declare <dojo/declale>` and `dojo.byId <dojo/byId>` without having to know which base module to pick from. 

We also see a special plugin ``dojo.require!`` used to load "all the rest of the modules you required previously". This is a comma separated list of modules to load, all in a single string. 

Manual Conversion
-----------------

First, let's remove the ``//>>built`` pragmas, as we are essentially un-building our newly converted module. Then remove the define() name, "my/HotApplication", returning the module to be anonymous, and capable of moving around on disk without modification.

.. js ::

    define(["dojo", "dijit", "dojox", "dojo/require!........"], function(dojo, dijix, dojox){
        
    })
    
Now, unless we're using the object we create by calling ``dojo.provide`` we can remove that as well. If we need to continue populating the global space, you can continue to use ``provide``, or take the shortcut of using ``dojo.getObject``. 

.. js ::

    define(["dojo"], function(dojo){
        // FIXME: actually look up this call
        var obj = dojo.getObject("HotApplication", true, "my")
        return obj;
    });
    
There is no need to duplicate modules in a ``dojo.require()`` call versus a ``dojo/require!`` plugin, so remove the former. Additionally, if you'd like to eliminate the ``dojo.require!`` plugin all together simply remove it, expanding out the items into new ``define`` dependencies:

.. js ::

    define([
        "dojo", "dijit", "dojox", "my/HotController", "dijit/_Widget", "dojo/text!my/templates/HotApplication.html"
    ], function(dojo, dijit, dojox, Controller, _Widget, template){
        
        return dojo.declare("my.HotApplication", Controller, {
            templateString: template
        });
        
    });
    
Now we need to goto ``my/HotController.js`` and ensure it is properly using a ``define()`` call, and returning the class previously living at ``my.HotController`` (now referenced locally as ``Controller``)

To move to the more modern AMD and Dojo approach, we then want to upgrade to using the smallest modules possible, rather than all of dojo, dijit, and dojox. We also want to remove any global identifiers. The above example would then become:

.. js ::

    define([
        "dojo/_base/declare", "my/HotController", "dijit/_WidgetBase", "dojo/text!my/templates/HotApplication.html"
    ], function(declareController, _WidgetBase, template){
        
        return declare(Controller, {
            templateString: template
        });
        
    });
    

Automation
----------

The `dojo-amd-converter <https://github.com/SitePen/dojo-amd-converter/>`_ may help you automate some or most of the conversion of your Dojo application from pre-AMD to AMD syntax.
