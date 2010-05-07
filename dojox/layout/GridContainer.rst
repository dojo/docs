#format dojo_rst

dojox.layout.GridContainer
==========================

:Status: Draft
:Version: 1.0
:Project owner: ?--
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
        var portletContent=[
            dojo.create('div', {innerHTML: 'Some content within the Portlet "p0_0".'})
        ];
        // create a new Portlet:
        var portlet=new dojox.widget.Portlet({
            id: 'p0_0',
            closable: false,
            dndType: 'Portlet',
            title: 'Portlet at Pos 0-0',
            content: portletContent
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
        portlet.addChild(testButton);
        // add the first Portlet to the GridContainer:
        gridContainer.addChild(portlet);
        // startup GridContainer:
        gridContainer.startup();
    });
    </script>



TODOC, params, examples, adding/removing regions, columns.
