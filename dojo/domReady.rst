.. _dojo/domReady:

==============
dojo/domReady!
==============

Introduction
============

dojo/domReady! is an AMD plugin that resolves when the DOM has finished loading.

Sooner or later, every JavaScript programmer tries something like this:

.. html ::

  <script>
    if(dayOfWeek == "Sunday"){
       document.musicPrefs.other.value = "Afrobeat";
    }
  </script>
  <form name="musicPrefs">
    <input type="text" name="other">
  ...

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

  require(["dojo/query", "dojo/NodeList-dom", "dojo/domReady!"],
    function(query){
      query(".a").style("color", "red");
  });

dojo/domReady! is similar to :ref:`dojo.ready <dojo/ready>` or :ref:`dojo.addOnLoad <dojo/addOnLoad>`, but more granular, because dojo/domReady! merely waits for the DOM to finish loading, without waiting for other require() or dojo.require() calls to complete.

Cautions
========

Dijit
-----
Note that waiting for dojo/domReady! to fire is often not sufficient when working with widgets.   Many widgets shouldn't be initialized or accessed until the following modules load and execute:

   * :ref:`dojo/uacss <dojo/uacss>`
   * :ref:`dijit/hccss <dijit/hccss>`
   * :ref:`dojo/parser <dojo/parser>`

Thus when working with widgets you should generally put your code inside of a dojo/ready() callback, or use nested requires statements.

.. js ::

    // Dojo 1.7 (AMD)
    require(["dojo/ready"], function(ready){
        ready(function(){
            require(["dijit/Dialog", "dijit/TitlePane"], function(Dialog, TitlePane){
                ready(function(){
                    // dijit.Dialog and friends are ready, create one from a node with id="bar"
                    var dialog = new Dialog({ title:"Lazy Loaded" }, "bar");
                });
            });
        });
    });


Sync loader
-----------
You should not use dojo/domReady! in any modules that may be loaded with the legacy synchronous loader.

In other words, if your application does *not* specify async:true as a data-dojo-config parameter, or if it loads modules via dojo.require() instead of the new AMD require() API, then using dojo/domReady! may cause dojo.ready() to call its callback before all the modules have loaded.
