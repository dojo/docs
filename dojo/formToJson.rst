.. _dojo/formToJson:

===============
dojo.formToJson
===============

:since: V0.9

.. contents ::
   :depth: 2

Helper function for converting a HTML form to a JSON string

Introduction
============

This function is one of many helpers used by the dojo Xhr subsystem for handling AJAX style requests.  This particular function takes a HTML form node and converts the form elements into a JSON string.  This function is identical to doing the operation:

*dojo.toJson(dojo.formToObject("formid"));*

You can refer to the :ref:`dojo.formToObject <dojo/formToObject>` documentation for more details.

Since Dojo 1.7, ``dojo.formToJson`` is exposed via the ``toJson`` method of the ``dojo/dom-form`` module.  An alias is kept in ``dojo/_base/xhr`` for backward-compatibility.

Usage
=====

Usage is simple and straightforward, you pass the form node or the string id of a form node to convert.  The function will hand back a JSON string of the name/value pairs from the form elements.

Dojo 1.7+ (AMD)
---------------

.. js ::
 
  require(["dojo/dom-form"], function(domForm){
    var formId = "myId";
    var formJson = domForm.toJson(formId);

    // Assuming a form of:
    // <form id="myform">
    //    <input type="text" name="field1" value="value1">
    //    <input type="text" name="field2" value="value2">
    //    <input type="button" name="someButton" value="someValue">
    // </form>
    //
    // The structure of formJson will be:
    // {"field1":"value1", "field2":"value2"}
    // Note the button was skipped.
  });


Dojo < 1.7
----------

.. js ::
 
  var formId = "myId";
  var formJson = dojo.formToJson(formId);

  // Assuming a form of:
  // <form id="myform">
  //    <input type="text" name="field1" value="value1">
  //    <input type="text" name="field2" value="value2">
  //    <input type="button" name="someButton" value="someValue">
  // </form>
  //
  // The structure of formJson will be:
  // {"field1":"value1", "field2":"value2"}
  // Note the button was skipped.


Examples
========

Example 1: Using formToJson to create an JSON version of a form
---------------------------------------------------------------

.. code-example ::
  
  .. js ::

      function convertForm(){
        dojo.connect(dijit.byId("convertForm"), "onClick", function(){
           var formJson = dojo.formToJson("myform");

           // Attach it into the dom as pretty-printed text.
           dojo.byId("formObject").innerHTML = formJson;
        });
      }
      dojo.ready(convertForm);

  .. html ::

    <button id="convertForm" data-dojo-type="dijit.form.Button">Click to convert the form to an object</button><br><br>
    <b>The FORM</b><br><br>
    <form id="myform">
       <input type="text" name="field1" value="value1">
       <input type="text" name="field2" value="value2">
       <input type="button" name="someButton" value="someValue">
    </form>
    <br><br>
    <b>The form as JSON:</b>
    <pre id="formObject"></pre>

Example 2: Using formToJson to create a JSON version of a form with dijit widgets
---------------------------------------------------------------------------------

.. code-example ::
  
  .. js ::

      dojo.require("dijit.form.TextBox");
      dojo.require("dijit.form.Button");
      function convertFormDigits(){
        dojo.connect(dijit.byId("convertFormDigits"), "onClick", function(){
           var formJson=  dojo.formToJson("myform2");

           // Attach it into the dom as pretty-printed text.
           dojo.byId("formObject2").innerHTML = formJson;
        });
      }
      dojo.ready(convertFormDigits);

  .. html ::

    <button id="convertFormDigits" data-dojo-type="dijit.form.Button">Click to convert the form to an object</button><br><br>
    <b>The FORM</b><br><br>
    <form id="myform2">
       <input type="text" data-dojo-type="dijit.form.TextBox" name="field1" value="value1">
       <input type="text" data-dojo-type="dijit.form.TextBox" name="field2" value="value2">
       <button data-dojo-type="dijit.form.Button" name="someButton" value="someValue">someValue</button>
    </form>
    <br><br>
    <b>The form as JSON:</b>
    <pre id="formObject2"></pre>


See also
========

* :ref:`dojo.objectToQuery <dojo/objectToQuery>`
* :ref:`dojo.queryToObject <dojo/queryToObject>`
* :ref:`dojo.formToQuery <dojo/formToQuery>`
* :ref:`dojo.formToObject <dojo/formToObject>`
