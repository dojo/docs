#format dojo_rst

dojox.embed.Flash
=================

:Status: Draft
:Version: 1.0
:Project owner: ?--
:Available: since V?

.. contents::
   :depth: 2

Base functionality to insert a flash movie into a document on the fly.


============
Introduction
============

TODO: introduce the component/class/method


=====
Usage
=====

TODO: how to use the component/class/method

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   dojo.require("dojox.embed.Flash");
   dojo.addOnLoad(function(){
     var movie = new dojox.embed.Flash({
       path: '/path-to-swf/flash.swf',
       width: '100%'
       height: 700,
       params: {wmode: 'opaque'}
       vars: {customFlashVariable: 'value'}
     }, "flashContainer");
   });
 </script>

 <div id="flashContainer">Alternative flash content</div>

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
