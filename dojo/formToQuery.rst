.. _dojo/formToQuery:

================
dojo.formToQuery
================

:since: V0.9

.. contents ::
   :depth: 2

Helper function for converting a HTML form into an URL-encoded query string.

Introduction
============

This function is one of many helpers used by the dojo Xhr subsystem for handling AJAX style requests.  This particular function takes a HTML form node and converts the form elements into a query string suitable for passing on a URI.  This function is identical to doing the operation:

.. js ::

  dojo.objectToQuery(dojo.formToObject("formid"));

You can refer to the :ref:`dojo.formToObject <dojo/formToObject>` and :ref:`dojo.objectToQuery <dojo/objectToQuery>` documentation for more details on the general behavior.

Since Dojo 1.7, ``dojo.formToQuery`` is exposed via the ``toQuery`` method of the ``dojo/dom-form`` module.  An alias is kept in ``dojo/_base/xhr`` for backward-compatibility.

Usage
=====

Usage is simple and straightforward, you pass the form node or the string id of a form node to convert.  The function will hand back a string of the name/value pairs in URI query string format.

Dojo 1.7+ (AMD)
---------------

.. js ::
 
  require(["dojo/dom-form"], function(domForm){
    var formId = "myId";
    var formQuery = domForm.toQuery(formId);

    // Assuming a form of:
    // <form id="myform">
    //    <input type="text" name="field1" value="value1">
    //    <input type="text" name="field2" value="value2">
    //    <input type="button" name="someButton" value="someValue">
    // </form>
    //
    // The structure of formJson will be:
    // field1=value1&field2=value2
    // Note the button was skipped.
  });


Dojo < 1.7
----------

.. js :: 

  var formId = "myId";
  var formQuery = dojo.formToQuery(formId);

  // Assuming a form of:
  // <form id="myform">
  //    <input type="text" name="field1" value="value1">
  //    <input type="text" name="field2" value="value2">
  //    <input type="button" name="someButton" value="someValue">
  // </form>
  //
  // The structure of formJson will be:
  // field1=value1&field2=value2
  // Note the button was skipped.


Examples
========

Example 1: Using formToQuery to create an query string version of a form
------------------------------------------------------------------------

.. code-example ::
  
  .. js ::

      dojo.require("dijit.form.Button");
      function convertForm(){
        dojo.connect(dijit.byId("convertForm"), "onClick", function(){
           var formQuery = dojo.formToQuery("myform");

           // Attach it into the dom as pretty-printed text.
           dojo.byId("formQueryString").innerHTML = formQuery;
        });
      }
      dojo.ready(convertForm);

  .. html ::

    <button id="convertForm" data-dojo-type="dijit.form.Button" type="button">Click to convert the form to an object</button><br><br>
    <b>The FORM</b><br><br>
    <form id="myform">
       <input type="text" name="field1" value="value1">
       <input type="text" name="field2" value="value2">
       <input type="button" name="someButton" value="someValue">
    </form>
    <br><br>
    <b>The form as a query string:</b>
    <pre id="formQueryString"></pre>

Example 2: Using formToQuery to create a query string version of a form with dijit widgets
------------------------------------------------------------------------------------------

.. code-example ::
  
  .. js ::

      dojo.require("dijit.form.TextBox");
      dojo.require("dijit.form.Button");
      function convertFormDijits(){
        dojo.connect(dijit.byId("convertFormDijits"), "onClick", function(){
           var formQuery=  dojo.formToQuery("myform2");

           // Attach it into the dom as pretty-printed text.
           dojo.byId("formQuery2").innerHTML = formQuery;
        });
      }
      dojo.ready(convertFormDijits);

  .. html ::

    <button id="convertFormDijits" data-dojo-type="dijit.form.Button">Click to convert the form to an object</button><br><br>
    <b>The FORM</b><br><br>
    <form id="myform2">
       <input type="text" data-dojo-type="dijit.form.TextBox" name="field1" value="value1">
       <input type="text" data-dojo-type="dijit.form.TextBox" name="field2" value="value2">
       <button data-dojo-type="dijit.form.Button" name="someButton" value="someValue">someValue</button>
    </form>
    <br><br>
    <b>The form as a query string:</b>
    <pre id="formQuery2"></pre>


See also
========

* :ref:`dojo.objectToQuery <dojo/objectToQuery>`
* :ref:`dojo.queryToObject <dojo/queryToObject>`
* :ref:`dojo.formToJson <dojo/formToJson>`
* :ref:`dojo.formToObject <dojo/formToObject>`
