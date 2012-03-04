.. _dojo/moduleUrl:

==============
dojo.moduleUrl
==============

:since: v0.9

.. contents ::
   :depth: 2

dojo.moduleUrl is used to return a dojo._Url object relative to a module.

**Note:** ``dojo.moduleUrl`` is deprecated in Dojo 1.7+; use ``require.toUrl``
instead.

Usage
=====

Dojo 1.7+ (AMD)
---------------

In Dojo 1.7+, use ``require.toUrl`` instead of ``dojo.moduleUrl``:

.. js ::

   require(["dojo/_base/xhr", "dojo/dom"], function(xhr, dom){
       // points to $dojoroot/dijit/form/tests/TestFile.html
       var url = require.toUrl("dijit/form/tests/TestFile.html");
       xhr.get({
           url: url,
           load: function(html){
               dom.byId("foo").innerHTML = html;
           }
       });
  });

For more information on ``require.toUrl``,
see the documentation for :ref:`the Dojo Loader <loader/amd>`.

Dojo < 1.7
----------

.. js ::

   // points to $dojoroot/dijit/form/tests/TestFile.html
   var url = dojo.moduleUrl("dijit.form", "tests/TestFile.html");
   dojo.xhrGet({
       url: url,
       load: function(html){
           dojo.byId("foo").innerHTML = html;
       }
   });

See also
========

* :ref:`dojo.registerModulePath <dojo/registerModulePath>`
* :ref:`dojo.cache <dojo/cache>`
