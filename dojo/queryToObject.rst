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
   var uri = "http://some.server.org/somecontext/?foo=bar&foo=bar2&bit=byte";
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

Example 1: Using queryToObject to create a JavaScript form of a query
---------------------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      function convertQuery() {
        dojo.connect(dijit.byId("convertQuery"), "onClick", function(){
           var uri =  "http://uri.some.org/context?foo=bar&foo=bar2&bit=byte";

           //Isolate the query portion of the URI and convert it.
           var query = uri.substring(uri.indexOf("?") + 1, uri.length);
           query = dojo.queryToObject(query);

           //Attach it into the don as pretty-printed text.
           dojo.byId("query").innerHTML = dojo.toJson(query, true);
        });
      }
      dojo.addOnLoad(convertQuery);
    </script>

  .. cv :: html 

    <button id="convertQuery" dojoType="dijit.form.Button">Click to convert query portion of URI"></button>
    <b>The URI</b><br>
    http://uri.some.org/context?foo=bar&foo=bar2&bit=byte
    <br>
    <b>The Query converted to a JavaScript Object:</b>
    <pre id="query"></pre>

--------------------

TODO: example

Declarative example
-------------------

TODO: example


========
See also
========

* TODO: links to other related articles
