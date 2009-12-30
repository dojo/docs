#format dojo_rst

dojo.objectToQuery
==================

:Status: Draft
:Version: 1.0
:Available: since V0.9

.. contents::
   :depth: 2

Helper function for converting a JavaScript object into a properly encoded query string.

============
Introduction
============

This function is one of many helpers used by the dojo Xhr subsystem for handling AJAX style requests.  This particular function takes a JavaScript object and converts it to a query string suitable to append onto a URI.  This function is useful in constructing URIs quickly and cleanly, with the proper special character encoding.  The resultant query string can be converted back to a JavaScript object by the function `dojo.queryToObject  <dojo/queryToObject>`_

=====
Usage
=====

Usage is simple and straightforward, you pass the object you wish converted to a query string and the function will return the query string.

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   var uri = "http://some.server.org/somecontext/";
   var query = {
     foo: ["bar", "baz"],
     bit: "byte"     
   };

   //Assemble the new uri with its query string attached.
   var queryStr = dojo.objectToQuery(query);
   uri = uri + "?" + queryStr;

   //The uri should look like:
   // http://some.server.org/somecontext/?foo=bar&foo=bar2&bit=byte
 </script>


========
Examples
========

Example 1: Using dojo.objectToQuery to create a query string and assign it to a URI
-----------------------------------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      function convertQuery() {
        dojo.connect(dijit.byId("convertQuery"), "onClick", function(){
           var uri =  "http://uri.some.org/context";
           var query = {
              foo: ["bar","bar2"],
              bit: "byte"
           };

           //Assemble the new URI.
           var queryStr = dojo.objectToQuery(query);
           uri = uri + "?" + queryStr;

           //Attach it into the dom
           dojo.byId("query").innerHTML = uri;
        });
      }
      dojo.addOnLoad(convertQuery);
    </script>

  .. cv :: html 

    <button id="convertQuery" dojoType="dijit.form.Button">Click to update the URI with a query generated from an object</button><br><br>
    <b>The URI</b><br><br>
    http://uri.some.org/context
    <br><br>
    <b>The modified URI with a query string.:</b>
    <pre id="query"></pre>

========
See also
========

* `dojo.queryToObject <dojo/queryToObject>`_
* `dojo.formToQuery <dojo/formToQuery>`_
* `dojo.formToObject <dojo/formToObject>`_
* `dojo.formToJson <dojo/formToJson>`_
