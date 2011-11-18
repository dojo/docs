#format dojo_rst

dojo/domReady
=============

============
Introduction
============

dojo/domReady is an AMD plugin that resolves when the DOM has finished loading.

For example, this code will wait until the DOM has finished loading and then change all anchors to be read:

.. code-block :: javascript
 :linenos:

  require(["dojo/query", "dojo/NodeList-dom", "dojo/domReady!"],
    function(query){
      query(".a").style("color", "red");
  });

dojo/domReady! is similar to `dojo.ready <dojo/ready>`_ or `dojo.addOnLoad <dojo/addOnLoad>`_ but more granular, because it merely waits for the DOM to finish loading, without waiting for other require() or dojo.require() calls.

========================
dojo/domReady! and dijit
========================
Note that waiting for dojo/domReady! to fire is often not sufficient when working with widgets.   Many widgets shouldn't be initialized or accessed until the following modules load and execute:

   * `dojo/uacss <dojo/uacss>`_
   * `dijit/hccss <dijit/hccss>`_
   * `dojo/parser <dojo/parser>`_

Thus when working with widgets you should generally put your code inside of a ready() callback.
