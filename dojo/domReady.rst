.. _dojo/domReady:

dojo/domReady!
==============

============
Introduction
============

dojo/domReady! is an AMD plugin that resolves when the DOM has finished loading.

Sooner or later, every Javascript programmer tries something like this:

.. code-block :: html
  :linenos:

  <script>
    if(dayOfWeek == "Sunday"){
       document.musicPrefs.other.value = "Afrobeat";
    }
  </script>
  <form name="musicPrefs">
    <input type="text" name="other">
  ...

It doesn't work because the "other" control is not defined yet. You can move the code to the bottom of the page, but that removes the linear nature of HTML. If you're reading the code, you want to zero in on a control, and see the code that influences it close by.

.. code-block :: javascript
  :linenos:

  function setAfrobeat(){
     document.musicPrefs.other.value="Afrobeat";
  }
  require("dojo/domReady!", setAfrobeat);

.. code-block :: javascript

conveniently replaces the one above. When the function is small, you may prefer to write it inline:

.. code-block :: javascript
  :linenos:

  require("dojo/domReady!", function() {
           document.musicPrefs.other.value="Afrobeat";
  });

As a more complicated example, this code will wait until the DOM has finished loading and then change all anchors to be red:

.. code-block :: javascript
 :linenos:

  require(["dojo/query", "dojo/NodeList-dom", "dojo/domReady!"],
    function(query){
      query(".a").style("color", "red");
  });

dojo/domReady! is similar to :ref:`dojo.ready <dojo/ready>` or :ref:`dojo.addOnLoad <dojo/addOnLoad>`, but more granular, because dojo/domReady! merely waits for the DOM to finish loading, without waiting for other require() or dojo.require() calls to complete.

========================
dojo/domReady! and dijit
========================
Note that waiting for dojo/domReady! to fire is often not sufficient when working with widgets.   Many widgets shouldn't be initialized or accessed until the following modules load and execute:

   * :ref:`dojo/uacss <dojo/uacss>`
   * :ref:`dijit/hccss <dijit/hccss>`
   * :ref:`dojo/parser <dojo/parser>`

Thus when working with widgets you should generally put your code inside of a ready() callback.
