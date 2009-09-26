#format dojo_rst

dojo.empty
==========

:Status: Draft
:Version: 1.0
:Project owner: ?--
:Available: since V?

.. contents::
   :depth: 2

Empty the contents of a DOM element. dojo.empty deletes all children but keeps the node there.


============
Introduction
============

TODO: introduce the component/class/method


=====
Usage
=====

dojo.empty safely removes all children of the node.

Parameters: 

node: DOMNode|String
  a reference to a DOM node or an id.


.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   // Destroy node's children byId:
   dojo.empty("someId");

   // Destroy all nodes' children in a list by reference:
   dojo.query(".someNode").forEach(dojo.empty);
 </script>



========
Examples
========

Programmatic example
--------------------

TODO: example

Declarative example
-------------------

TODO: example


========
See also
========

* TODO: links to other related articles
