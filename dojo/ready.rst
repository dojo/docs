.. _dojo/ready:

==========
dojo.ready
==========


dojo.ready() registers a function to run when the Dom is ready *and* all outstanding require() and dojo.require() calls have resolved.

Its functionality has been mostly replaced by :ref:`The AMD API <loader/amd>`, which registers a function to run when a set of dependencies have loaded, and the :ref:`domReady! plugin <dojo/domReady>`, which registers the DOM-ready event as a pseudo-dependency, thus delaying callback execution until the DOM has finished loading.

However, unlike domReady, dojo.ready() implements a priority queue, so applications can register which callbacks fire first by setting a priority for each callback.   In this way, the :ref:`dojo/parser <dojo/parser>` is set to run before user callbacks run when using ``parseOnLoad``. In these cases, ``dojo.ready()`` can still be useful for widgets or other code that depend on a particular order of execution.

Note that if the DOM has already loaded, and all dependencies have been resolved, ready() functions fire immediately.

Examples
========
A typical usage is:

.. js ::
  
  require(["dojo/ready", "dojo/parser", "dijit/registry", "dijit/Dialog"], function(ready, parser, registry){
       ready(function(){
             // This won't run until the DOM has loaded, the parser has run, and other modules like dijit/hccss
             // have also run.
             var dialog = registry.byId("myDialog");
             ...
       });
  });

This will register some code to run before the parser does:


.. js ::
  
  require(["dojo/ready", "dojo/parser", "dijit/registry", "dijit/Dialog"], function(ready, parser, registry){
       ready(80, function(){
             // Runs before parser, which is priority == 90
             ...
       });
  });
