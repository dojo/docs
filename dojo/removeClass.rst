#format dojo_rst

dojo.removeClass
----------------

Removes a class from a Node. Follows the same pattern as most Dojo functionality by accepting a string ID of a Node, or a DOM Node reference, removing a passed class from the class="" attribute.

.. code-block :: javascript
  :linenos:

  dojo.removeClass("someNode","removedClass");
  var node = dojo.byId("someNode").parentNode;
  dojo.removeClass(node, "removedClass");

You can also use removeClass as a dojo.query chain:

.. code-block :: javascript
  :linenos:

  dojo.query(".someSelector").removeClass("someClass");

will remove class="someClass" from all nodes that have class="someSelector", if the node already has the class.

See: `dojo.addClass <dojo/addClass>`_ and `dojo.hasClass <dojo/hasClass>`_
