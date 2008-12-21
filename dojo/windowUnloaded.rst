#format dojo_rst

dojo.windowUnloaded
===================

:Status: Draft
:Version: 1.2.3
:Available: since V?

.. contents::
   :depth: 2

Signal fired by impending window destruction.


============
Introduction
============

The dojo.windowUnloaded function is triggered on the onwindowunload browser event. This event is triggered when the user is leaving the current page.

It executes all the functions contained in an existing private array.

To add a function to this array use dojo.addOnWindowUnload.  

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

.. code-block :: javascript


 <script type="text/javascript">
  dojo.addOnWindowUnload(function(){ alert('Bye'); });
  dojo.addOnWindowUnload(function(){ alert('Bye again'); });
 </script>

Declarative example
-------------------

TODO: example


========
See also
========

* TODO: links to other related articles
