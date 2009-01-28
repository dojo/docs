#format dojo_rst

dojo.queryToObject
==================

:Status: Draft
:Version: 1.0
:Available: since V0.9

.. contents::
   :depth: 2

Helper function for converting a URI query string to a JavaScript Object

============
Introduction
============

This function is one of many helpers used by the dojo Xhr subsystem for handling AJAX style requests.  This particular function takes the query portion of a URI and returns a JavaScript object of the name/value pairs.  It handles both single and myylti-valued query parameters.

=====
Usage
=====

Usage is simple and straightforward, you pass the query string of the URI as the parameter to the function and it will return it in JavaScript object form.

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   var uri = "http://some.server.org/somecontext/?foo=bar&foo=bar2&bit=bye
   var query = uri.substring(uri.indexOf("?") + 1, uri.length);
   var queryObject = dojo.queryToObject(query);

   //The structur of queryObject will be:
   // {
   //   foo: ["bar", "bar2],
   //   bit: "byte"
   // }
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
