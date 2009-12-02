#format dojo_rst

dojo.destroy
============

:Project owner: ?--
:Available: since V1.3

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

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   // Destroy a node byId:
   dojo.destroy("someId");

  // Destroy all nodes in a list by reference:
  dojo.query(".someNode").forEach(dojo.destroy);
 </script>

This function only works with DomNodes, and returns nothing.

=========  ==============  =============================================================================
Parameter  Type            Description
=========  ==============  =============================================================================
node       String|DomNode  A String ID or DomNode reference of the element to be destroyed.
=========  ==============  =============================================================================
  

========
See also
========

* `DOM Utilities <quickstart/dom>`_
