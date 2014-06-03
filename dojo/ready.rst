.. _dojo/ready:

==========
dojo/ready
==========

.. contents ::
  :depth: 2

**dojo/ready** registers a function to run when the DOM is ready *and* all outstanding ``require()`` calls have been resolved, and other registered functions with a higher priority have completed.

Its functionality has been mostly replaced by :ref:`The AMD API <loader/amd>`, which registers a function to run when a set of dependencies have loaded, and the :ref:`dojo/domReady! <dojo/domReady>` plugin, which registers the DOM-ready event as a pseudo-dependency, thus delaying callback execution until the DOM has finished loading.

However, unlike ``dojo/domReady``, ``dojo/ready`` implements a priority queue, so applications can register which callbacks fire first by setting a priority for each callback.   In this way, the :ref:`dojo/parser <dojo/parser>` is set to run before user callbacks run when using ``parseOnLoad``. In these cases, ``dojo/ready`` can still be useful for widgets or other code that depend on a particular order of execution.

*Note* that if the DOM has already loaded, and all dependencies have been resolved, ``ready()`` functions will fire immediately.

Usage
=====

.. js ::

  require(["dojo/ready"], function(ready){
    ready(function(){
      // This function won't run until the DOM has loaded and other modules that register 
      // have run.
    });
  });


Examples
========

.. code-example ::
  :djConfig: parseOnLoad: true, async: true

  Register a function to fire after DOM ready and ``dojo/parser`` complete.

  .. js ::

    require(["dojo/ready", "dijit/registry", "dojo/parser", "dijit/form/Button"], 
    function(ready, registry){
      ready(function(){
        registry.byId("myWidget").set("label", "I fired after parser!");
      });
    });

  .. html ::

    <button type="button" id="myWidget" data-dojo-type="dijit/form/Button">Parsed Label</button>

.. code-example ::
  :djConfig: parseOnLoad: true, async: true

  Registers a function to fire after DOM ready but before the ``dojo/parser`` completes.

  .. js ::

    require(["dojo/ready", "dojo/dom", "dojo/parser", "dijit/form/Button"],
    function(ready, dom){
      ready(80, function(){
        dom.byId("myWidget").innerHTML = "A different label!";
      });
    });

  .. html ::

    <button type="button" id="myWidget" data-dojo-type="dijit/form/Button">Parsed Label</button>

See Also
========

* :ref:`dojo/domReady! <dojo/domReady>` - AMD Plugin to signal when the DOM is ready.
