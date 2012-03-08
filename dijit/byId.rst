.. _dijit/byId:

==========
dijit.byId
==========

:Project owner: Bill Keese
:since: V0.9

.. contents ::
   :depth: 2

dijit.byId is a function for looking up a specific widget by its assigned name (id). This function is similar to
:ref:`dojo.byId <dojo/byId>` but whereas ``dojo.byId`` returns DOMNodes, ``dijit.byId`` returns a JavaScript object that
is the instance of the widget.

As of Dojo 1.7, the features that manage dijits and other widgets on a page has been located in :ref:`dijit/registry
<dijit/registry>` and the preferred method for looking up a widget is now available there and it is best practice to use
``registry.byId`` in lieu of ``dijit.byId``.

Introduction
============

``dijit.byId`` and ``dojo.byId`` are often confused, particularly by first time users. ``dijit.byId`` function should be
used when you wish to obtain a direct reference to the JavaScript object instance of your widget and access functions of
that widget. ``dojo.byId`` should be used when you want to directly access a DOM node.

.. api-inline :: dijit.byId

Usage
=====

Usage of this function is trivial. Simply call it with a string of the id for the widget you wish to obtain the handle
of. The return value will either be the JavaScript object instance that represents the widget or null/undefined if it is
not found in the widget registry.

.. js ::
 
   require("dijit/registry", function(registry)){
     var myWidget = registry.byId("myWidget");
   });

Examples
========

Example 1: Locating a widget by its ID
--------------------------------------

.. code-example ::

  We need to require in the modules we need and lookup our widget:

  .. js ::

      require(["dojo/dom", "dijit/registry", "dijit/form/TextBox"], 
        function(dom, registry) {
          // Locate the JS object.
          console.log(dom.byId("textNode"));
          var widget = registry.byId("myTextBox");
          if (widget){
            // Find my output node and write out I found my textbox and got its value.
            dom.byId("textNode").innerHTML = "Found my text box.  It has value: [" + widget.get("value") + "]";
          }else{
            // Find my output node and write out I couldn't find the widget.
            dom.byId("textNode").innerHTML = "Could not locate my text box widget!";
          }
      });

  Here is the HTML structure we need to support our example:

  .. html ::

    <input id="myTextBox" data-dojo-type="dijit/form/TextBox" type="text" value="Default Value"></input>
    <br><br>
    <div id="textNode" style="background-color: lightgray"></div>


Example 2: Locating a widget by its id and accessing its DOM node (main DOM rendering element)
----------------------------------------------------------------------------------------------

.. code-example ::
  
  .. js ::

      dojo.require("dijit.form.TextBox");

      dojo.ready(function(){
        // Locate the JS object.
        var widget = dijit.byId("myTextBox2");
        if(widget){
          // Get its DOM node:
          var dNode = widget.domNode;

          // Find my output node and write out I found my textbox and got its value + what type of DOM node is its primary node.
          dojo.byId("textNode2").innerHTML = "Found my text box.  It has value: [" + widget.get("value") + "] and its primary DOM node tag name is: [" + dNode.tagName + "]";
        }else{
          // Find my output node and write out I couldn't find the widget.
          dojo.byId("textNode2").innerHTML = "Could not locate my text box widget!";
        }
      });

  .. html ::

    <input id="myTextBox2" data-dojo-type="dijit/form/TextBox" type="text" value="Default Value"></input>
    <br><br>
    <div id="textNode2" style="background-color: lightgray"></div>


Example 3: Comparing dojo.byId and dijit.byId
---------------------------------------------

*This example shows how the output of each is different.*

.. code-example ::
  
  .. js ::

      dojo.require("dijit.form.TextBox");

      dojo.ready(function(){
        // Locate the JS object.
        var dibiWidget = dijit.byId("myTextBox3");
        var dobiWidget = dojo.byId("myTextBox3");
        var dibiDOM = dijit.byId("textNode3");
        var dobiDOM = dojo.byId("textNode3");


        dojo.byId("textNode3").innerHTML = "dijit.byId for widget id returned: " + dibiWidget + "<br>" +
                                          "dojo.byId for widget id returned: " + dobiWidget + "<br>" +
                                          "dijit.byId for dom id returned: " + dibiDOM + "<br>" +
                                          "dojo.byId for dom id returned: " + dobiDOM + "<br>";
      });

  .. html ::

    <input id="myTextBox3" data-dojo-type="dijit/form/TextBox" type="text" value="Default Value"></input>
    <br><br>
    <div id="textNode3" style="background-color: lightgray"></div>


data-dojo-id, dijit.byId() and dojo.byId()
==========================================

A common question new users of dojo have is what is the difference between attribute data-dojo-id
(known as jsId before dojo 1.6), dijit.byId() and dojo.byId().

Consider the following simple ContentPane widget which has an id property (standard HTML attribute for any tag)
and a data-dojo-id attribute (dojo specific id attribute explained below):

.. html ::
 
 <div id="myDivId"
      data-dojo-type="dijit/layout/ContentPane"
      data-dojo-id="myDojoId">
    Hello Everyone!
 </div>

dojo.byId()
-----------

dojo.byId() is no different than the often used document.getElementById() to access the DOM node for the div tag:
simply pass in the tag’s id attribute value.

For example:

.. js ::

 dojo.byId("myDivId").style.height = '300px';

This would set a style height property.

dijit.byId()
------------

dijit.byId() is a little different.
First off, it only works on parsed dijits either declared in markup with a data-dojo-type attribute or programmatically.
The same id attribute is used as a parameter, but what is returned in this case is an object that was created
by the dojo widget system when the markup is parsed and transformed into a dijit.
This allows you to change dojo-specific attributes for the widget or call methods defined in the class
the dijit corresponds to (in this case, we can call methods of the ContentPane class).
For example, we can set the content of the ContentPane via setContent().

.. js ::

 dijit.byId("myDivId").setContent("Hello World!");

You could also change the style like we did with dojo.byId() above using the domNode property of the ContentPane.
(Actually, domNode is defined higher up the inheritance tree so every dijit has a domNode property.  Very convenient!)
This example also saves the results of dijit.byId() into a local variable.

.. js ::

 myContentPane = dijit.byId("myDivId");
 myContentPane.domNode.style.height = '300px';
 myContentPane.setContent("Hello World!");

data-dojo-id (jsId before dojo 1.6)
-----------------------------------

HTML attribute data-dojo-id saves you one more step in working with widgets by automatically creating a global javascript variable for you (the dojo parser does this).
This variable contains the same object as returned by dijit.byId().
Whatever value you give to the data-dojo-id attribute becomes the name of the global variable so watch out for reserved words or having two widgets with the same data-dojo-id!
Since my Content Pane has a data-dojo-id attribute value of myDojoId I could simplify the above code a little by removing the dijit.byId() and using my data-dojo-id attribute as the variable name:

.. js ::

 myDojoId.domNode.style.height = '300px';
 myDojoId.setContent("Hello World!");

Attribute data-dojo-id is not required, it is there as a convenience.

See also
========

* :ref:`dojo.byId <dojo/byId>`
