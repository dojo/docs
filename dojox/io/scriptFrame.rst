#format dojo_rst

dojox.io.scriptFrame
====================

:Status: Draft
:Version: 1.0
:Project owner: ?--
:Available: since V?

.. contents::
   :depth: 2

dojox.io.scriptFrame uses an iframe for dojo.io.script requests. 


============
Introduction
============

dojox.io.scriptFrame is useful in some long-polling comet situations in Firefox and Opera. Those browsers execute scripts in DOM order, not network-receive order, so a long-polling script will block other dynamically appended scripts from running until it completes. By using an iframe for the dojo.io.script requests, this issue can be avoided.


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
