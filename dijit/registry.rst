.. _dijit/registry:

==============
dijit/registry
==============

:Author: Colin Snover
:since: 1.7.0

.. contents ::
   :depth: 2

Introduction
============

dijit/registry stores a collection of all the dijit widgets within a page.
It is commonly used to retrieve a reference to a widget from a related piece of data (such as the widget’s DOM node or ID).
It contains functions formerly found on the root ``dijit`` object for looking up widgets, such as ``dijit.byId`` and ``dijit.byNode``.


Usage
=====

Retrieving a widget from the registry using a widget ID
-------------------------------------------------------

``registry.byId`` returns the widget that corresponds to the given ID.
If no such widget exists, it returns undefined.

.. js ::
 
  require(["dijit/registry"], function(registry){
      var widget = registry.byId("myWidgetId");
  });
  
  
Retrieving a widget by its id and accessing its DOM node (main DOM rendering element)
----------------------------------------------------------------------------------------------
.. code-example ::
  :djConfig: async: true, parseOnLoad: true
  
  .. js ::
      
      require(["dojo/parser","dojo/ready","dojo/dom", "dijit/registry", "dijit/form/TextBox"], 
        function(parser,ready, dom, registry) {
          ready(function() {
              // Locate the JS object.
              var widget = registry.byId("myTextBox2");
              if (widget){
                var dNode = widget.domNode;
                // Find my output node and write out I found my textbox and got its value.
                dom.byId("textNode2").innerHTML = "Found my text box.  It has value: [" + widget.get("value") + "] and its primary DOM node tag name is: [" + dNode.tagName + "]";
              }else{
                // Find my output node and write out I couldn't find the widget.
                dom.byId("textNode2").innerHTML = "Could not locate my text box widget!";
              }
          });
      });

  .. html ::

    <input id="myTextBox2" data-dojo-type="dijit/form/TextBox" type="text" value="Default Value"></input>
    <br><br>
    <div id="textNode2" style="background-color: lightgray"></div>

    
Retrieving a widget from the registry using the widget’s DOM node
-----------------------------------------------------------------

``registry.byNode`` returns the widget that corresponds to the given DOM node.
If the DOM node does not belong to a widget, it returns undefined.

.. js ::
 
  require(["dijit/registry"], function(registry){
      var widget = registry.byNode(domNode);
  });

Finding all widgets underneath a DOM node
-----------------------------------------

``registry.findWidgets`` returns an array of all non-nested widgets inside the given DOM node.

.. js ::
 
  require(["dojo/_base/array", "dijit/registry", "dijit/form/TextBox"], function(arrayUtil, registry, TextBox){
      var formWidgets = registry.findWidgets(formNode);
  });

Note that ``registry.findWidgets`` will *not* descend into widgets.
That is to say, if you had a DOM like this:

.. html ::
 
  <div id="root" data-dojo-type="dijit/Dialog">
      <form data-dojo-type="dijit/form/Form">
          <input data-dojo-type="dijit/form/TextBox">
      </form>
      <div>
          <form data-dojo-type="dijit/form/Form">
              <input data-dojo-type="dijit/form/TextBox">
          </form>
      </div>
  </div>

Calling ``findWidgets`` on the ``root`` node would **only** return the Form widgets, not the TextBox widgets.

Finding the nearest enclosing widget for a DOM node
---------------------------------------------------

``registry.getEnclosingWidget`` returns the closest widget to the given DOM node.

.. js ::
 
  require(["dijit/registry"], function(registry){
      var parentWidget = registry.getEnclosingWidget(domNode);
  });

Note that ``getEnclosingWidget`` will check for and return the widget corresponding to the given DOM node, if one exists.
For instance, given the following DOM:

.. html ::
 
  <div data-dojo-type="dijit/form/Form">
      <input id="myTextField" data-dojo-type="dijit/form/TextBox">
  </div>

The following will return the TextBox widget, **not** the Form widget:

.. js ::
 
  require(["dojo/dom", "dijit/registry"], function(dom, registry){
      registry.getEnclosingWidget(dom.byId("myTextField")); // returns TextBox
  });

Iterating Over The Registry
---------------------------
If you need to iterate over the entire registry, it is best to call ``registry.toArray``
and use the standard :ref:`dojo array <dojo/_base/array>` functions.

.. js ::

  require(["dojo/_base/array", "dijit/registry"], function(array, registry){
      array.forEach(registry.toArray(), ...);
  });


Note that for backwards compatibility, the dijit.registry global variable (as opposed to the dijit/registry module)
includes array iterator methods (forEach, filter, byClass, map, every, and some).
However, AMD code should not expect these functions to be available in the Object returned from
require(["dijit/registry"]).

data-dojo-id, dijit/regsitry.byId() and dojo/dom.byId()
=======================================================

``registry.byId`` and ``dom.byId`` are often confused, particularly by first time users. ``registry.byId`` function should be used when you wish to obtain a direct reference to the JavaScript object instance of your widget and access functions of that widget. ``dom.byId`` should be used when you want to directly access a DOM node.

Consider the following simple ContentPane widget which has an id property (standard HTML attribute for any tag)
and a data-dojo-id attribute (dojo specific id attribute explained below):

.. html ::
 
 <div id="myDivId"
      data-dojo-type="dijit/layout/ContentPane"
      data-dojo-id="myDojoId">
    Hello Everyone!
 </div>

dom.byId()
-----------

dom.byId() is no different than the often used document.getElementById() to access the DOM node for the div tag:
simply pass in the tag’s id attribute value.

For example:

.. js ::

 dom.byId("myDivId").style.height = '300px';

This would set a style height property.

registry.byId()
---------------

regsitry.byId() is a little different.
First off, it only works on parsed dijits either declared in markup with a data-dojo-type attribute or programmatically.
The same id attribute is used as a parameter, but what is returned in this case is an object that was created
by the dojo widget system when the markup is parsed and transformed into a dijit.
This allows you to change dojo-specific attributes for the widget or call methods defined in the class
the dijit corresponds to (in this case, we can call methods of the ContentPane class).
For example, we can set the content of the ContentPane via set("content", value).

.. js ::

 regsitry.byId("myDivId").set("content", "Hello World!");

You could also change the style like we did with dom.byId() above using the domNode property of the ContentPane.
(Actually, domNode is defined higher up the inheritance tree so every dijit has a domNode property.  Very convenient!)
This example also saves the results of registry.byId() into a local variable.

.. js ::

 myContentPane = registry.byId("myDivId");
 myContentPane.domNode.style.height = '300px';
 myContentPane.set("content", "Hello World!");

data-dojo-id (jsId before dojo 1.6)
-----------------------------------

HTML attribute data-dojo-id saves you one more step in working with widgets by automatically creating a global JavaScript variable for you (the dojo parser does this).
This variable contains the same object as returned by registry.byId().
Whatever value you give to the data-dojo-id attribute becomes the name of the global variable so watch out for reserved words or having two widgets with the same data-dojo-id!
Since my Content Pane has a data-dojo-id attribute value of myDojoId I could simplify the above code a little by removing the registry.byId() and using my data-dojo-id attribute as the variable name:

.. js ::

 myDojoId.domNode.style.height = '300px';
 myDojoId.set("content", "Hello World!");

Attribute data-dojo-id is not required, it is there as a convenience.

Comparing dom.byId and registry.byId
---------------------------------------------

*This example shows how the output of each is different.*

.. code-example ::
  :djConfig: async: true, parseOnLoad: true
  
  .. js ::
  
    require(["dojo/parser","dojo/ready", "dojo/dom", "dijit/registry", "dijit/form/TextBox"], 
            function(parser,ready, dom, registry) {
                ready(function() {
                    // Locate the JS object.
                    var dibiWidget = registry.byId("myTextBox3");
                    var dobiWidget = dom.byId("myTextBox3");
                    var dibiDOM = registry.byId("textNode3");
                    var dobiDOM = dom.byId("textNode3");


                    dom.byId("textNode3").innerHTML = "registry.byId for widget id returned: " + dibiWidget + "<br>" +
                                                  "dom.byId for widget id returned: " + dobiWidget + "<br>" +
                                                  "registry.byId for dom id returned: " + dibiDOM + "<br>" +
                                                  "dom.byId for dom id returned: " + dobiDOM + "<br>";
                });
      });

  .. html ::

    <input id="myTextBox3" data-dojo-type="dijit/form/TextBox" type="text" value="Default Value"></input>
    <br><br>
    <div id="textNode3" style="background-color: lightgray"></div>

See also
========
* :ref:`dom.byId <dojo/dom#byid>`  
* :ref:`dijit.WidgetSet <dijit/WidgetSet>`
* :ref:`dojo.NodeList <dojo/NodeList>`
