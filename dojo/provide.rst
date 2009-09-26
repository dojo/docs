#format dojo_rst

dojo.provide
============

:Status: Draft
:Version: 1.0
:Project owner: ?--
:Available: since V?

.. contents::
   :depth: 2

dojo.provide is a core part of the dojo packaging system. It enables telling the package manager that a specific package has been loaded. Asides from the functioning, there has been mention that it automatically instantiates objects corresponding to the namespace it is passed.


============
Introduction
============

Each javascript source file must have at least one dojo.provide() call at the top of the file, corresponding to the file name. For example, `js/dojo/foo.js` must have `dojo.provide("dojo.foo");` before any calls to `dojo.require()` are made.


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
