.. _dojo/queryToObject:

==================
dojo.queryToObject
==================

:since: V0.9

.. contents ::
   :depth: 2

Helper function for converting a URI query string to a JavaScript Object

Introduction
============

This function is one of many helpers used by the dojo Xhr subsystem for handling AJAX style requests.  This particular function takes the query portion of a URI and returns a JavaScript object of the name/value pairs.  It handles both single and multi-valued query parameters.  This function is useful in deconstructing URIs for display in page forms and the like.  It can also be used as a way to modify a query by converting to JavaScript, making changes to parameters, then converting it back to a query string via :ref:`dojo.objectToQuery <dojo/objectToQuery>`

Since Dojo 1.7, ``dojo.queryToObject`` is exposed via the ``queryToObject`` method of the ``dojo/io-query`` module.  An alias is kept in ``dojo/_base/xhr`` for backward-compatibility.

Usage
=====

Usage is simple and straightforward, you pass the query string of the URI as the parameter to the function and it will return it in JavaScript object form.

Dojo 1.7+ (AMD)
---------------

.. js ::
 
  require(["dojo/io-query"], function(ioQuery){
    var uri = "http://some.server.org/somecontext/?foo=bar&foo=bar2&bit=byte";
    var query = uri.substring(uri.indexOf("?") + 1, uri.length);
    var queryObject = ioQuery.queryToObject(query);

    // The structure of queryObject will be:
    // {
    //   foo: ["bar", "bar2],
    //   bit: "byte"
    // }
  });
 

Dojo < 1.7
----------

.. js ::
 
  var uri = "http://some.server.org/somecontext/?foo=bar&foo=bar2&bit=byte";
  var query = uri.substring(uri.indexOf("?") + 1, uri.length);
  var queryObject = dojo.queryToObject(query);

  // The structure of queryObject will be:
  // {
  //   foo: ["bar", "bar2],
  //   bit: "byte"
  // }


Examples
========

Example 1: Using queryToObject to create a JavaScript form of a query
---------------------------------------------------------------------

.. code-example ::
  
  .. js ::

      dojo.require("dijit.form.Button");
      function convertQuery(){
        dojo.connect(dijit.byId("convertQuery"), "onClick", function(){
           var uri =  "http://uri.some.org/context?foo=bar&foo=bar2&bit=byte";

           // Isolate the query portion of the URI and convert it.
           var query = uri.substring(uri.indexOf("?") + 1, uri.length);
           query = dojo.queryToObject(query);

           // Attach it into the don as pretty-printed text.
           dojo.byId("query").innerHTML = dojo.toJson(query, true);
        });
      }
      dojo.ready(convertQuery);

  .. html ::

    <button id="convertQuery" data-dojo-type="dijit.form.Button">Click to convert query portion of URI</button><br><br>
    <b>The URI</b><br><br>
    http://uri.some.org/context?foo=bar&foo=bar2&bit=byte
    <br><br>
    <b>The Query converted to a JavaScript Object (click the button!):</b>
    <pre id="query"></pre>

Example 2: Using queryToObject to alter query strings
-----------------------------------------------------

.. code-example ::
  
  .. js ::

      dojo.require("dijit.form.Button");
      function alterQuery(){
        dojo.connect(dijit.byId("alterQuery"), "onClick", function(){
           var uri =  "http://uri.some.org/context?foo=bar&foo=bar2&bit=byte";

           // Isolate the query portion of the URI and convert it.
           var query = uri.substring(uri.indexOf("?") + 1, uri.length);
           query = dojo.queryToObject(query);

           // let's make some changes.
           query.foo = "alteredFoo";
           query.newParam = "I'm new!";

           // Write the new URI out.
           dojo.byId("alteredQuery").innerHTML = uri.substring(0, uri.indexOf("?") + 1) + dojo.objectToQuery(query);
        });
      }
      dojo.ready(alterQuery);

  .. html ::

    <button id="alterQuery" data-dojo-type="dijit.form.Button">Click to alter the query string</button><br><br>
    <b>The URI</b><br><br>
    http://uri.some.org/context?foo=bar&foo=bar2&bit=byte
    <br><br>
    <b>The modified query string in the URI:</b>
    <div id="alteredQuery"></div>

See also
========

* :ref:`dojo.objectToQuery <dojo/objectToQuery>`
* :ref:`dojo.formToQuery <dojo/formToQuery>`
* :ref:`dojo.formToObject <dojo/formToObject>`
* :ref:`dojo.formToJson <dojo/formToJson>`
