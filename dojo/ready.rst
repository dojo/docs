.. _dojo/ready:

dojo.ready
==============

:Version: 1.4

dojo.ready() registers a function to run when the Dom is ready *and* all outstanding require() and dojo.require() calls have resolved.

It's functionality has somewhat been replaced by :ref:`The AMD API <loader/amd>`, which registers a function to run when a set of dependencies have loaded, and the :ref:`domReady! plugin <dojo/domReady>`, which registers the DOM-ready event as a pseudo-dependency, thus delaying callback execution until the DOM has finished loading.

However, dojo.ready() implements a priority queue, so applications can register which callbacks fire first, by setting a priority for each callback.   In this way, the :ref:`dojo/parser <dojo/parser>` is set to run before user callbacks run.    So, dojo.ready() is still useful to be used with widgets or other code that depends on other callbacks executing before it does.

Note that if the DOM has already loaded, and all dependencies have been resolved, ready() functions fire immediately.

Examples
========
A typical usage is:

.. js ::
  :linenos:

  require(["dojo/ready", "dojo/parser", "dijit/registry", "dijit/Dialog", function(ready, parser, registry) {
       ready(function(){
             // This won't run until the DOM has loaded, the parser has run, and other modules like dijit/hccss
             // have also run.
             var dialog = registry.byId("myDialog");
             ...
       });
  });

This will register some code to run before the parser does:


.. js ::
  :linenos:

  require(["dojo/ready", "dojo/parser", "dijit/registry", "dijit/Dialog", function(ready, parser, registry) {
       ready(80, function(){
             // Runs before parser, which is priority == 90
             ...
       });
  });
