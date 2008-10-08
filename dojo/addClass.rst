#format dojo_rst

dojo.addClass
-------------

Adds a CSS class to a node.

.. code-block :: javascript
  :linenos:

  dojo.addClass("someNode", "someClass");

The node can be a string ID of a DOM Node, or a reference to a DOM Node:

.. code-block :: javascript
  :linenos:

  var node = dojo.byId("someNode").parentNode;
  dojo.addClass(node, "someNodesParent");

When using addClass with dojo.query, the node parameter is omitted:

.. code-block :: javascript
  :linenos:

  dojo.query(".randomClass").addClass("anotherClass");

will find all the nodes with `class="randomClass"` and add "anotherClass" to the class attribute.

Relates to `dojo.hasClass <dojo/hasClass>`_ and `dojo.removeClass <dojo/removeClass>`_
