.. _dojo/domReady:

==============
dojo/domReady!
==============

:since: v1.7

.. contents ::
  :depth: 2

**dojo/domReady!** is an AMD loaded plugin that will wait until the DOM has finished loading before returning.

Introduction
============

Sooner or later, every JavaScript programmer tries something like this:

.. html ::

  <script type="text/javascript">
      if(dayOfWeek == "Sunday"){
        document.musicPrefs.other.value = "Afrobeat";
      }
  </script>
  <form name="musicPrefs">
      <input type="text" name="other">
      ...
  </form>

It doesn't work because the "other" control is not defined yet. You can move the code to the bottom of the page, but 
that removes the linear nature of HTML. If you're reading the code, you want to zero in on a control, and see the code 
that influences it close by.

``dojo/domReady!`` solves this problem:

.. js ::

  require(["dojo/domReady!"], function(){
    // will not run until DOM is finished loading
    if(dayOfWeek == "Sunday"){
      document.musicPrefs.other.value = "Afrobeat";
    }
  });

``dojo/domReady!`` is similar to old usage prior to 1.7 of :ref:`dojo.ready() <dojo/ready>` or 
:ref:`dojo.addOnLoad() <dojo/addOnLoad>`, but more specific, because ``dojo/domReady!`` merely waits for the DOM to 
finish loading, without waiting for other ``require()`` or ``dojo.require()`` calls to complete.

Usage
=====

.. js ::

  require(["dojo/domReady!"], function(){
    // will not be called until DOM is ready
  });

Common convention is to not to assign it a return variable to the callback function, since its return is meaningless.  
Also, it is common convention put it at the end of any array of requirements:

.. js ::

  require(["dojo/dom", "dojo/query", "dojo/on", "dojo/domReady!"], function(dom, query, on){
    // ...
  });

Notes
=====

Dijit/Widgets
-------------

Note that waiting for ``dojo/domReady!`` to fire is often not sufficient when working with widgets. Many widgets 
shouldn't be initialized or accessed until the following modules load and execute:

* :ref:`dojo/uacss <dojo/uacss>`

* :ref:`dijit/hccss <dijit/hccss>`

* :ref:`dojo/parser <dojo/parser>`

Thus when working with widgets you should generally put your code inside of a :ref:`dojo/ready() <dojo/ready>` 
callback:

.. js ::

  require(["dijit/form/Button", "dojo/ready"], function(Button, ready){
    ready(function(){
      // deal with widgets here
    });
  });

Sync Loader
-----------

You should not use ``dojo/domReady!`` with modules that may be loaded with the legacy synchronous loader.

In other words, if your application does *not* specify ``async: true`` in the Dojo configuration, or if it loads 
modules via ``dojo.require()`` instead of the AMD ``require()`` API, then using ``dojo/domReady!`` may cause 
``dojo.ready()`` to call its callback before all the modules have loaded.

For reference, the cause of this intermittent failure is that when you write:

.. js ::

  define(["m1", "m2", ..., "mn"], function(m1, m2, ..., mn){//...

and run in sync mode, the loader *ensures* the evaluation of ``m1..mn`` *in order*. It does than by just traversing 
each dependency tree as it comes to it. And it expects each dependency tree to be fully "traversable" and the module 
completely resolved at the end of the traversal.

Now comes along ``dojo/domReady!``. The loader loads all the dependencies for ``dojo/domReady!`` and then demands the 
plugin resource be resolved. But ``dojo/domReady!`` may not be able to resolve the demanded plugin resource (an empty 
module ID which is intended to signal the DOM is ready) because the DOM may not be ready. The loader notices this an 
sees that the module was not capable of being loaded synchronously, gives up and continues.

This is an intentional limitation in the loader, since handling it would have required more complicated code.
It will cease to be an issue for Dojo 2.0, when the synchronous loader is desupported.

See Also
========

* :ref:`dojo/ready <dojo/ready>` - The module for more complex callback management.
