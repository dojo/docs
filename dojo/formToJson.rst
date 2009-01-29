#format dojo_rst

dojo.formToJson
===============

:Status: Draft
:Version: 1.0
:Available: since V0.9

.. contents::
   :depth: 2

Helper function for converting a HTML form to a JSON string

============
Introduction
============

This function is one of many helpers used by the dojo Xhr subsystem for handling AJAX style requests.  This particular function takes a HTML form node and converts the form elements into a JSON string.  This function is identical to doing the operation: 

*dojo.toJson(dojo.formToObject("formid"));*  

You can refer to the `dojo.formToObject <dojo/formToObject>`_ documentation for more details.

=====
Usage
=====

Usage is simple and straightforward, you pass the form node or the string id of a form node to convert.  The function will hand back a JSON string of the name/value pairs from the form elements.

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   var formId = "myId";
   var formJSON = dojo.formToJson(formId);

   //Assuming a form of:
   // <form id="myform">
   //    <input type="text" name="field1" value="value1">
   //    <input type="text" name="field2" value="value2">
   //    <input type="button" name="someButton" value="someValue">
   // </form>
   //
   //The structure of formJson will be:
   // {
   //   "field1": "value1",
   //   "field2": "value2"
   // }
   //Note the button was skipped.
 </script>



========
Examples
========

Example 1: Using formToJson to create an JSON version of a form
---------------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      function convertForm() {
        dojo.connect(dijit.byId("convertForm"), "onClick", function(){
           var formJson=  dojo.formToObject("myform");

           //Attach it into the dom as pretty-printed text.
           dojo.byId("formObject").innerHTML = formJson;
        });
      }
      dojo.addOnLoad(convertForm);
    </script>

  .. cv :: html 

    <button id="convertForm" dojoType="dijit.form.Button">Click to convert the form to an object</button><br><br>
    <b>The FORM</b><br><br>
    <form id="myform">
       <input type="text" name="field1" value="value1">
       <input type="text" name="field2" value="value2">
       <input type="button" name="someButton" value="someValue">
    </form>
    <br><br>
    <b>The form as an object:</b>
    <pre id="formObject"></pre>

Example 2: Using formToJson to create a JSON version of a form with dijit widgets
---------------------------------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.TextBox");
      dojo.require("dijit.form.Button");
      function convertFormDigits() {
        dojo.connect(dijit.byId("convertFormDigits"), "onClick", function(){
           var formJson=  dojo.formToJson("myform");

           //Attach it into the dom as pretty-printed text.
           dojo.byId("formObject2").innerHTML = formJson;
        });
      }
      dojo.addOnLoad(convertFormDigits);
    </script>

  .. cv :: html 

    <button id="convertFormDigits" dojoType="dijit.form.Button">Click to convert the form to an object</button><br><br>
    <b>The FORM</b><br><br>
    <form id="myform">
       <input type="text" dojoType="dijit.form.TextBox" name="field1" value="value1">
       <input type="text" dojoType="dijit.form.TextBox" name="field2" value="value2">
       <button dojoType="dijit.form.Button" name="someButton" value="someValue">someValue</button>
    </form>
    <br><br>
    <b>The form as an object:</b>
    <pre id="formObject2"></pre>


========
See also
========

* `dojo.objectToQuery <dojo/objectToQuery>`_
* `dojo.queryToObject <dojo/queryToObject>`_
* `dojo.formToQuery <dojo/formToQuery>`_
* `dojo.formToObject <dojo/formToObject >`_
