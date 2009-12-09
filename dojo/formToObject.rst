#format dojo_rst

dojo.formToObject
==================

:Available: since V0.9

.. contents::
   :depth: 2

Helper function for converting a HTML form to a JavaScript Object


============
Introduction
============

This function is one of many helpers used by the dojo Xhr subsystem for handling AJAX style requests. This particular function takes a HTML form node and converts the form elements into a JavaScript object of name/value pairs. Disabled form elements, buttons, and other non-valued HTML elements are skipped. The resulting object can then be processed however you like. Note that the form can contain dijit.form.* items.


=====
Usage
=====

Usage is simple and straightforward, you pass the form node or the string id of a form node to convert. The function will hand back a JavaScript object of the name/value pairs from the form elements. The values are either strings or arrays. If a checkbox group has a single item selected the function will return a string value; if several, an array.

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

Using formToObject to create an object version of a form
--------------------------------------------------------

.. code-example::
  
  .. javascript::

    <script type="text/javascript">
      dojo.require("dijit.form.Button");

      dojo.addOnLoad(function(){
        dojo.connect(dijit.byId("convertForm"), "onClick", function(){
           var formObject1 =  dojo.formToObject("myform");

           // Attach it into the dom as pretty-printed text.
           dojo.byId("formObject").innerHTML = dojo.toJson(formObject1, true);
        });
      });
    </script>

  .. html:: 

    <p>The FORM</p>
    <form id="myform">
       <p>text1: <input type="text" name="text1" value="value1"><br>
       text2: <input type="text" name="text2" value="value2"><br>
       cb_group.foo: <input id="f6_checkbox1" type="checkbox" name="cb_group" value="foo" checked><br>
       cb_group.boo: <input id="f6_checkbox2" type="checkbox" name="cb_group" value="boo"><br>
       radio_group.baz: <input id="f6_radio1" type="radio" name="radio_group" value="baz"><br>
       radio_group.bam: <input id="f6_radio2" type="radio" name="radio_group" value="bam" checked><br>
       radio_group.baf: <input id="f6_radio3" type="radio" name="radio_group" value="baf"></p>
    </form>
    <p><button id="convertForm" dojoType="dijit.form.Button">Click to convert the form to an object</button></p>
    <p>The form as an object:</p>
    <pre id="formObject"></pre>


Using formToObject to create an object version of a form with dijit widgets
---------------------------------------------------------------------------

.. code-example::
  
  .. javascript::

    <script type="text/javascript">
      dojo.require("dijit.form.TextBox");
      dojo.require("dijit.form.CheckBox");
      dojo.require("dijit.form.Button");

      dojo.addOnLoad(function(){
        dojo.connect(dijit.byId("convertFormDigits"), "onClick", function(){
           var formObject2 =  dojo.formToObject("myform2");

           // Attach it into the dom as pretty-printed text.
           dojo.byId("formObject2").innerHTML = dojo.toJson(formObject2, true);
        });
      });
    </script>

  .. html:: 

    <button id="convertFormDigits" dojoType="dijit.form.Button">Click to convert the form to an object</button><br><br>
    <b>The FORM</b><br><br>
    <form id="myform2">
       <input type="text" dojoType="dijit.form.TextBox" name="field1" value="value1">
       <input type="text" dojoType="dijit.form.TextBox" name="field2" value="value2">
       <input id="mycheck" dojoType="dijit.form.CheckBox" name="field3" value="agreed" checked> <label for="mycheck">I agree</label>
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
