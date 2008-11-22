#format dojo_rst

dojo.clone
===============

:Status: Draft
:Version: 1.0
:Project owner: ?--
:Available: since V?

.. contents::
   :depth: 2

Part of Base Dojo (dojo.js) - Clones objects and/or nodes, returning a new object.

=====
Usage
=====

TODO: how to use the component/class/method

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   // your code
 </script>

dojo.clone is always "deep". Cyclic (e.g., circular or DAG) cases are explicitly not supported due to speed and space concerns. 

    * If you want a shallow copy of an object y = dojo.mixin({}, x);
    * If you want a shallow copy of an array: y = dojo.map(x, "return value;");
    * The rest will be covered by the deep copy: y = dojo.clone(x); 
