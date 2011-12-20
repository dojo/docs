.. _dojo/objectToQuery:

==================
dojo.objectToQuery
==================

:since: V0.9

.. contents ::
   :depth: 2

Helper function for converting a JavaScript object into a properly encoded query string.

Introduction
============

This function is one of many helpers used by the dojo Xhr subsystem for handling AJAX style requests.  This particular function takes a JavaScript object and converts it to a query string suitable to append onto a URI.  This function is useful in constructing URIs quickly and cleanly, with the proper special character encoding.  The resultant query string can be converted back to a JavaScript object by the function :ref:`dojo.queryToObject  <dojo/queryToObject>`

Since Dojo 1.7, ``dojo.objectToQuery`` is exposed via the ``objectToQuery`` method of the ``dojo/io-query`` module.  An alias is kept in ``dojo/_base/xhr`` for backward-compatibility.

Usage
=====

Usage is simple and straightforward, you pass the object you wish converted to a query string and the function will return the query string.

Dojo 1.7+ (AMD)
---------------

.. js ::
 
  require(["dojo/io-query"], function(ioQuery){
    var uri = "http://some.server.org/somecontext/";
    var query = {
      foo: ["bar", "baz"],
      bit: "byte"
    };
    // Assemble the new uri with its query string attached.
    var queryStr = ioQuery.objectToQuery(query);
    uri = uri + "?" + queryStr;

    // The uri should look like:
    // http://some.server.org/somecontext/?foo=bar&foo=bar2&bit=byte
  });
 

Dojo < 1.7
----------

.. js ::
 
  var uri = "http://some.server.org/somecontext/";
  var query = {
    foo: ["bar", "baz"],
    bit: "byte"
  };

  // Assemble the new uri with its query string attached.
  var queryStr = dojo.objectToQuery(query);
  uri = uri + "?" + queryStr;

  // The uri should look like:
  // http://some.server.org/somecontext/?foo=bar&foo=bar2&bit=byte


Examples
========

Example 1: Using dojo.objectToQuery to create a query string and assign it to a URI
-----------------------------------------------------------------------------------

.. code-example ::
  
  .. js ::

      dojo.require("dijit.form.Button");
      function convertQuery(){
        dojo.connect(dijit.byId("convertQuery"), "onClick", function(){
           var uri =  "http://uri.some.org/context";
           var query = {
              foo: ["bar", "bar2"],
              bit: "byte"
           };

           // Assemble the new URI.
           var queryStr = dojo.objectToQuery(query);
           uri = uri + "?" + queryStr;

           // Attach it into the dom
           dojo.byId("query").innerHTML = uri;
        });
      }
      dojo.ready(convertQuery);

  .. html ::

    <button id="convertQuery" data-dojo-type="dijit.form.Button" type="button">Click to update the URI with a query generated from an object</button><br><br>
    <b>The URI</b><br><br>
    http://uri.some.org/context
    <br><br>
    <b>The modified URI with a query string.:</b>
    <pre id="query"></pre>

See also
========

* :ref:`dojo.queryToObject <dojo/queryToObject>`
* :ref:`dojo.formToQuery <dojo/formToQuery>`
* :ref:`dojo.formToObject <dojo/formToObject>`
* :ref:`dojo.formToJson <dojo/formToJson>`
