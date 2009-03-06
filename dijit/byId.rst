#format dojo_rst

dijit.byId
==========

:Status: Draft
:Version: 1.0
:Project owner: Bill Keese
:Available: since V0.9

.. contents::
   :depth: 2

dijit.byId is a function for looking up a specific widget by its assigned name (id).  This function is similar to `dojo.byId <dojo/byId>`_ but whereas dojo.byId returns DOMNodes, dijit.byId returns a JavaScript object that is the instance of the widget.  


============
Introduction
============

dijit.byId and dojo.byId are often confused, particularly by first time users.  This function should be used when you wish to obtain a direct handle the the JavaScript object instance of your widget and access functions of that widget.  

=====
Usage
=====

Usage of this function is trivial.  Simply call it with a string of the id for the widget you wish to obtain the handle of.  The return value will either be the JavaScript object instance that represents the widget or null/undefined if it is not found in the widget registry.

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   var myWidget = dijit.byId("myWidget");
 </script>

========
Examples
========

Example 1: Locating a widget by its ID
--------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.TextBox");

      function findWidget () {
        //Locate the JS object.
        var widget = dijit.byId("myTextBox");
        if(widget){ 
          //Find my output node and write out I found my textbox and got its value.
          dojo.byId("textNode").innerHTML = "Found my text box.  It has value: [" + widget.attr("value") + "]";
        }else{
          //Find my output node and write out I couldn't find the widget.
          dojo.byId("textNode").innerHTML = "Could not locate my text box widget!";
        }
      }
      dojo.addOnLoad(findWidget);
    </script>

  .. cv :: html 

    <input id="myTextBox" dojoType="dijit.form.TextBox" type="text" value="Default Value"></input>
    <br>
    <div id="textNode"></div>


========
See also
========

* `dojo.byId <dojo/byId>`_
