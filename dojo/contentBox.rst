#format dojo_rst

dojo.contentBox
===============

:Status: Draft
:Version: 1.0
:Project owner: ?--
:Available: since 1.0

.. contents::
   :depth: 2

Getter/setter for the content-box of node.


============
Introduction
============

Returns an object in the expected format of box (regardless if box is passed). The object might look like:

{ l: 50, t: 200, w: 300: h: 150 }

for a node offset from its parent 50px to the left, 200px from the top with a content width of 300px and a content-height of 150px. Note that the content box may have a much larger border or margin box, depending on the box model currently in use and CSS values set/inherited for node.

=====
Usage
=====

TODO: how to use the component/class/method

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   // your code
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
