#format dojo_rst

dojox.layout.GridContainer
==========================

:Status: Draft
:Authors: Peter Higgins, Shane O'Sullivan, Marcus Reimann
:Project owner: Shane O'Sullivan
:Available: since V1.3

.. contents::
   :depth: 2

dojox.layout.GridContainer is an **experimental** panel-like layout mechanism, allowing Drag and Drop between regions.


=====
Usage
=====

In order to use the GridContainer, you must issue the require statement:

.. code-block :: javascript
  :linenos:
  
  dojo.require("dojox.layout.GridContainer");

The project requires some Dijit functionality, and a custom DnD handler provided in the dojox.layout package.

Additionally, the required CSS files must be included in your page for proper operation. Two are needed:

  * dojox/layout/resources/GridContainer.css
  * dojox/layout/resources/DndGridContainer.css

By requiring the GridContainer, two new attributes are mixed into the dijit._Widget class:

  * column: Holds the current column a widget is in. (If any). Defaults to "1"
  * dragRestriction: Is the widget draggable? You can use this to prohibit the dragging of a specific Widget

To figure out which column you widget is in, use

.. code-block :: javascript
  :linenos:
  
  dijit.byId("exampleId").column;

If it doesn't work for you, make sure that you have the latest version from trunk, as this feature was broken in Dojo 1.5.0.

============
Toggling DnD
============

There might be several use-cases where you want to turn the drag & drop on or off. (For instance, you might offer some kind of "edit mode", where the dnd will work and otherwise it will be turned off)

This is very easy and can be done by calling:

.. code-block :: javascript
  :linenos:
  
  dijit.byId("gridContainer").enableDnd(); // Enables DND
  // or
  dijit.byId("gridContainer").disableDnd(); // Disables DND

==================================
Getting notified about DnD-Actions
==================================

The GridContainer uses the dojox.mdnd package to publish drag & drop events.

If you want to get notified of any event, use the following: (The event names are self explanatory)

.. code-block :: javascript
  :linenos:

  dojo.subscribe("/dojox/mdnd/drag/start", null, function(source, nodes, copy, target) {
      // Your Code here
  });

  dojo.subscribe("/dojox/mdnd/drag/cancel", null, function(source, nodes, copy, target) {
      // Your Code here
  });

  dojo.subscribe("/dojox/mdnd/drop", null, function(source, nodes, copy, target) {
      // Your Code here 
  });

========
Examples
========

Programmatic example
--------------------

.. code-example::
  :version: local

  .. css::
    :label: The CSS

    <link rel="stylesheet" href="../../../dojox/widget/Portlet/Portlet.css">
    <link rel="stylesheet" href="../../../dojox/layout/resources/GridContainer.css">

  One node as placeholder is all we need

  .. html::
    :label: Very basic HTML

    <div id='placeHere'>&nbsp;</div>

  Dynamic creation of a GridContainer, with a Portal and a DropDownButton inside.

  .. javascript::
    :label: The JavaScript

    <script type="text/javascript">
    dojo.require("dojox.layout.GridContainer");
    dojo.require("dojox.widget.Portlet");
    dojo.require("dijit.form.DropDownButton");
    dojo.require("dijit.TooltipDialog");

    dojo.addOnLoad(function(){
        // create a new GridContainer:
        var gridContainer = new dojox.layout.GridContainer({
            nbZones: 3,
            opacity: .5,
            hasResizableColumns: false,
            allowAutoScroll: false,
            withHandles: true,
            dragHandleClass: 'dijitTitlePaneTitle',
            style: {width:'100%'},
            acceptTypes: ['Portlet'],
            isOffset: true
        }, 'placeHere'); 
        // prepare some Content for the Portlet:
        var portletContent1 = [
            dojo.create('div', {innerHTML: 'Some content within the Portlet "dynPortlet1".'})
        ];
        // create a new Portlet:
        var portlet1 = new dojox.widget.Portlet({
            id: 'dynPortlet1',
            closable: false,
            dndType: 'Portlet',
            title: 'Portlet "dynPortlet1"',
            content: portletContent1
        });
        // create a new TooltipDialog:
        var tooltipDialog=new dijit.TooltipDialog({
            content: "Content for TooltipDialog",
            style: {width:'320px'}
        });
        // create a new DropDownButton and assign the TooltipDialog:
        var testButton = new dijit.form.DropDownButton({
            label: "Click me",
            dropDown: tooltipDialog
        });
        // add the DropDownButton to the Portlet:
        portlet1.addChild(testButton);
        // add the first Portlet to the GridContainer:
        gridContainer.addChild(portlet1);
        // startup GridContainer:
        gridContainer.startup();
    });
    </script>



TODOC, params, examples, adding/removing regions, columns.
