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
    <br><br>
    <div id="textNode" style="background-color: lightgray"></div>


Example 2: Locating a widget by its id and accessing its DOM node (main DOM rendering element)
----------------------------------------------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.TextBox");

      function findWidgetDOM () {
        //Locate the JS object.
        var widget = dijit.byId("myTextBox2");
        if(widget){
          //Get its DOM node:
          var dNode = widget.domNode;

          //Find my output node and write out I found my textbox and got its value + what type of DOM node is its primary node.
          dojo.byId("textNode2").innerHTML = "Found my text box.  It has value: [" + widget.attr("value") + "] and its primary DOM node tag name is: [" + dNode.tagName + "]";
        }else{
          //Find my output node and write out I couldn't find the widget.
          dojo.byId("textNode2").innerHTML = "Could not locate my text box widget!";
        }
      }
      dojo.addOnLoad(findWidgetDOM);
    </script>

  .. cv :: html 

    <input id="myTextBox2" dojoType="dijit.form.TextBox" type="text" value="Default Value"></input>
    <br><br>
    <div id="textNode2" style="background-color: lightgray"></div>


Example 3: Comparing dojo.byId and dijit.byId
---------------------------------------------

*This example shows how the output of each is different.*

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dijit.form.TextBox");

      function compareDojoDijitById() {
        //Locate the JS object.
        var dibiWidget = dijit.byId("myTextBox3");
        var dobiWidget = dojo.byId("myTextBox3");
        var dibiDOM = dijit.byId("textNode3");
        var dobiDOM = dojo.byId("textNode3");


        dojo.byId("textNode3").innerHTML = "dijit.byId for widget id returned: " + dibiWidget + "<br>" +
                                          "dojo.byId for widget id returned: " + dobiWidget + "<br>" +
                                          "dijit.byId for dom id returned: " + dibiDOM + "<br>" +
                                          "dojo.byId for dom id returned: " + dobiDOM + "<br>";
      }
      dojo.addOnLoad(compareDojoDijitById);
    </script>

  .. cv :: html 

    <input id="myTextBox3" dojoType="dijit.form.TextBox" type="text" value="Default Value"></input>
    <br><br>
    <div id="textNode3" style="background-color: lightgray"></div>



========
See also
========

* `dojo.byId <dojo/byId>`_
