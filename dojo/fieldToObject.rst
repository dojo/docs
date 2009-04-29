#format dojo_rst

dojo.fieldToObject
==================

:Status: Draft
:Version: 1.0
:Available: since V1.4

.. contents::
   :depth: 2

Helper function for converting a HTML form field to a JavaScript Object

============
Introduction
============

This function is one of many helpers used by the dojo Xhr subsystem for handling AJAX style requests.  This particular function takes a HTML form field and converts the field's value to a string or an array of strings. Disabled form elements and unchecked radio and checkboxes are skipped. Multi-select elements are returned as an array of string values.

This function is used internally by `dojo.formToObject <dojo/formToObject>`_ to convert each form field to a value.

=====
Usage
=====

Pass the form field node or the string id of a form field node.  The function will hand back a string array for multi-select fields, a string value for other fields.

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   var firstInputValue = dojo.fieldToObject("firstInput");

   //Assuming a form of:
   // <form id="myform">
   //    <input id="firstInput" type="text" name="field1" value="value1">
   //    <input type="text" name="field2" value="value2">
   //    <input type="button" name="someButton" value="someValue">
   // </form>
   //
   //firstInputValue will be "value1"
 </script>



========
Examples
========

Example 1: Using fieldToObject to get field values
-------------------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      function convertFields() {
        dojo.connect(dojo.byId("convertFields"), "onclick", function(){
           var shape = dojo.fieldToObject("shape");
           var colors = dojo.fieldToObject(dojo.byId("myform").color);

           //Attach it into the dom as pretty-printed text.
           dojo.byId("output").innerHTML = "Shape is: " + shape + ", Colors is an array: " + colors;
        });
      }
      dojo.addOnLoad(convertFields);
    </script>

  .. cv :: html 

    <button id="convertFields">Click to convert the form to an object</button><br><br>
    <b>The FORM</b><br><br>
    <form id="myform">
       <input id="shape" type="text" name="shape" value="round">
       <select name="color" multiple>
          <option selected value="red">Red</option>
          <option value="blue">Blue</option>
          <option selected value="green">Green</option>          
       </select>
    </form>
    <br><br>
    <b>The form as an object:</b>
    <pre id="output"></pre>


========
See also
========

* `dojo.formToObject <dojo/formToObject>`_
