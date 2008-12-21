#format dojo_rst

dojo.windowUnloaded
===================

:Status: Draft
:Version: 1.0
:Available: since V?

.. contents::
   :depth: 2

Signal fired by impending window destruction.


============
Introduction
============

The dojo.windowUnloaded function is triggered on the onwindowunload browser event.
It executes all the functions contained in an existing array. To add a function to this array use dojo.addOnWindowUnload.  

=====
Usage
=====

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   dojo.addOnWindowUnload(function(){ alert('Bye :)'); })
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
