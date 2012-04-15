.. _dojo/domReady:

==============
dojo/domReady!
==============

Introduction
============

dojo/domReady! is an AMD plugin that resolves when the DOM has finished loading.

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

It doesn't work because the "other" control is not defined yet. You can move the code to the bottom of the page, but that removes the linear nature of HTML. If you're reading the code, you want to zero in on a control, and see the code that influences it close by.

.. js :: 

  function setAfrobeat(){
      document.musicPrefs.other.value="Afrobeat";
  }
  require(["dojo/domReady!"], setAfrobeat);

conveniently replaces the one above. When the function is small, you may prefer to write it inline:

.. js ::

  require(["dojo/domReady!"], function(){
       document.musicPrefs.other.value="Afrobeat";
  });

As a more complicated example, this code will wait until the DOM has finished loading and then change all anchors to be red:

.. js ::

  require(["dojo/query", "dojo/NodeList-dom", "dojo/domReady!"], function(query){
      query(".a").style("color", "red");
  });

dojo/domReady! is similar to old usage prior to 1.7 of :ref:`dojo.ready <dojo/ready>` or :ref:`dojo.addOnLoad <dojo/addOnLoad>`, but more granular, because dojo/domReady! merely waits for the DOM to finish loading, without waiting for other require() or dojo.require() calls to complete.

Cautions
========

Dijit
-----
Note that waiting for dojo/domReady! to fire is often not sufficient when working with widgets. Many widgets shouldn't be initialized or accessed until the following modules load and execute:

   * :ref:`dojo/uacss <dojo/uacss>`
   * :ref:`dijit/hccss <dijit/hccss>`
   * :ref:`dojo/parser <dojo/parser>`

Thus when working with widgets you should generally put your code inside of a dojo/ready() callback.

Sync loader
-----------
You should not use dojo/domReady! in any modules that may be loaded with the legacy synchronous loader.

In other words, if your application does *not* specify async:true dojo config parameter,
or if it loads modules via dojo.require() instead of the new AMD require() API,
then using dojo/domReady! may cause dojo.ready() to call it's callback before all the modules have loaded.

For reference, the cause of this intermittent failure is that when you write:

.. js ::

   define(["m1", "m2", ..., "mn"], function(m1, m2, ..., mn){//...

and run in sync mode, the loader *ensures* the evaluation of m1..mn *in
order*. It does than by just traversing each dependency tree as it comes to
it. And it expects each dependency tree to be fully "traversable" and the
module completely resolved at the end of the traversal.

Now comes along dojo/domReady!. The loader loads all the dependencies for
dojo/domReady! and then demands the plugin resource be resolved. But
dojo/domReady! may not be able to resolve the demanded plugin resource (an
empty module id which is intended to signal the DOM is ready) because the DOM
may not be ready. The loader notices this an sees that the module was not
capable of being loaded synchronously...and gives up.


This is an intentional limitation in the loader, since handling it would have required more complicated code.
It will cease to be an issue for Dojo 2.0, when the synchronous loader is desupported.
