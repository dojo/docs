#format dojo_rst

dojo.moduleUrl
==============

:Available: since v0.9

.. contents::
   :depth: 2

dojo.moduleUrl is used to return a dojo._Url object relative to a module.

=====
Usage
=====

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   // points to $dojoroot/dijit/form/tests/TestFile.html
   var url = dojo.moduleUrl("dijit.form", "tests/TestFile.html"); 
   dojo.xhrGet({
       url: url,
       load: function(html){  
            dojo.byId("foo").innerHTML = html;
       }
   });
 </script>

========
See also
========

* `dojo.registerModulePath <dojo/registerModulePath>`_
* `dojo.cache <dojo/cache>`_
