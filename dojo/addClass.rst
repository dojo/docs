#format dojo_rst

dojo.addClass
=============

:Status: Draft
:Version: 1.0
:Project owner: ?--
:Available: since V?

.. contents::
   :depth: 2

Adds a CSS class to a node.


=====
Usage
=====

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


========
See also
========

* `dojo.hasClass <dojo/hasClass>`_
* `dojo.removeClass <dojo/removeClass>`_
