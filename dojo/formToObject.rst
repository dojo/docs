#format dojo_rst

dojo.formToObject
==================

:Status: Draft
:Version: 1.0
:Available: since V0.9

.. contents::
   :depth: 2

Helper function for converting a HTML form to a JavaScript Object

============
Introduction
============

This function is one of many helpers used by the dojo Xhr subsystem for handling AJAX style requests.  This particular function takes a HTML form node and converts the form elements into a JavaScript object of name/value pairs.  Disabled form elements, buttons, and other non-valued HTML elements are skipped. The resulting object can then be processed however you like.  Note that the form can contain dijit.form.* items.

=====
Usage
=====

Usage is simple and straightforward, you pass the form node or the string id of a form node to convert.  The function will hand back a JavaScript object of the name/value pairs from the form elements. The values are either strings or arrays. If a checkbox group has a single item selected the function will return a string value; if several, an array.

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   var formId = "myId";
   var formObj = dojo.formToObject(formId);

   //Assuming a form of:
   // <form id="myform">
   //    <input type="text" name="field1" value="value1">
   //    <input type="text" name="field2" value="value2">
   //    <input type="button" name="someButton" value="someValue">
   // </form>
   //
   //The structure of formObj will be:
   // {
   //   field1: "value1",
   //   field2: "value2"
   // }
   //Note the button was skipped.
 </script>



========
Examples
========

Example 1: Using formToObject to create an object version of a form
-------------------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      function convertForm() {
        dojo.connect(dijit.byId("convertForm"), "onClick", function(){
           var formObject =  dojo.formToObject("myform");

           //Attach it into the dom as pretty-printed text.
           dojo.byId("formObject").innerHTML = dojo.toJson(formObject, true);
        });
      }
      dojo.addOnLoad(convertForm);
    </script>

  .. cv :: html 

    <button id="convertForm" dojoType="dijit.form.Button">Click to convert the form to an object</button><br><br>
    <b>The FORM</b><br><br>
    <form id="myform">
       field1: <input type="text" name="field1" value="value1"><br />
       field2: <input type="text" name="field2" value="value2"><br />
       cb_group.foo: <input id="f6_checkbox1" type="checkbox" name="cb_group" value="foo" checked><br />
       cb_group.boo: <input id="f6_checkbox2" type="checkbox" name="cb_group" value="boo"><br />
       radio_group.baz: <input id="f6_radio1" type="radio" name="radio_group" value="baz"><br />
       radio_group.bam: <input id="f6_radio2" type="radio" name="radio_group" value="bam" checked><br />
       radio_group.baf: <input id="f6_radio3" type="radio" name="radio_group" value="baf"><br />
       <input type="button" name="someButton" value="someValue">
    </form>
    <br><br>
    <b>The form as an object:</b>
    <pre id="formObject"></pre>

Example 2: Using formToObject to create an object version of a form with dijit widgets
--------------------------------------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.TextBox");
      dojo.require("dijit.form.Button");
      function convertFormDigits() {
        dojo.connect(dijit.byId("convertFormDigits"), "onClick", function(){
           var formObject =  dojo.formToObject("myform2");

           //Attach it into the dom as pretty-printed text.
           dojo.byId("formObject2").innerHTML = dojo.toJson(formObject, true);
        });
      }
      dojo.addOnLoad(convertFormDigits);
    </script>

  .. cv :: html 

    <button id="convertFormDigits" dojoType="dijit.form.Button">Click to convert the form to an object</button><br><br>
    <b>The FORM</b><br><br>
    <form id="myform2">
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
* `dojo.formToJson <dojo/formToJson>`_
