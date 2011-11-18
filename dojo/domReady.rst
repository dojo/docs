#format dojo_rst

=============
dojo/domReady
=============

dojo/domReady is an AMD plugin that resolves when the DOM has finished loading.

For example, this code will wait until the DOM has finished loading and then change all anchors to be read:

.. code-block :: javascript
 :linenos:

  require(["dojo/query", "dojo/NodeList-dom", "dojo/domReady!"],
    function(query){
      query(".a").style("color", "red");
  });

dojo/domReady! is similar to `dojo.ready <dojo/ready>`_ or `dojo.addOnLoad <dojo/addOnLoad>`_ but more granular, because it merely waits for the DOM to finish loading, without waiting for other require() or dojo.require() calls.
