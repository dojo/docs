#format dojo_rst

dojo.destroy
============

:Project owner: ?--
:Available: since V?

.. contents::
   :depth: 2

Destroys a DOM element. dojo.destroy deletes all children and the node itself.


============
Introduction
============

dojo.destroy removes a node from its parent, clobbering it and all of its children.


=====
Usage
=====

This function only works with DomNodes, and returns nothing.

Parameters:

node
  A String ID or DomNode reference of the element to be destroyed.

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   // Destroy a node byId:
   dojo.destroy("someId");

  // Destroy all nodes in a list by reference:
  dojo.query(".someNode").forEach(dojo.destroy);
 </script>
