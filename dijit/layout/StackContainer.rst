#format dojo_rst

dijit.layout.StackContainer
===========================

:Available: since V1.0

.. contents::
    :depth: 2

A container that has multiple children, but shows only one child at a time (like looking at the pages in a book one by one). 


============
Introduction
============

This container is good for wizards, slide shows, and long lists or text blocks.


=====
Usage
=====

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   var foo = new dijit.layout.StackContainer(params, srcNodeRef);
 </script>

parameters:
  ==========  ===============  ===========
  parameter   type             description
  ==========  ===============  ===========
  params      object           Optional.
  srcNodeRef  DomNode|String   
  ==========  ===============  ===========


Set the current pane
--------------------

StackContainer's current pane can be set via the selectChild() method, or it can be controlled from a StackController. StackController
is a controller not in the MVC send of the word, but like a TV remote control... it's sets which page the StackController is tuned to.

Retrieving the currently selected Container
-------------------------------------------

To retrieve the currently selected container use following attribute

.. code-block :: javascript
 :linenos:

  var selectedContainer = yourContainer.selectedChildWidget

*yourContainer* has to be a reference (for example: dijit.byId("myStackContainer")) to the ContainerWidget, meaning the StackContainer or any widgets inheriting from StackContainer

Set the size of the pane
------------------------

doLayout="false" sets the size of the StackContainer to the size of his child panes.

Published topics
----------------

StackContainer publishes topics 

* [widgetId]-**addChild**, 
* [widgetId]-**removeChild**, and 
* [widgetId]-**selectChild**.


========
Examples
========

Programmatic example
--------------------

Here's an example of a progamatically created StackContainer, and associated StackController:

.. cv-compound::
 
  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.layout.StackContainer");
    dojo.require("dijit.layout.ContentPane");
    dojo.addOnLoad(function(){
        var sc = new dijit.layout.StackContainer({
            style: "height: 300px; width: 400px;",
            id: "myProgStackContainer"
        },"scontainer-prog");
  
        var cp1 = new dijit.layout.ContentPane({
             title: "page 1",
             content: "page 1 content"
        });
        sc.addChild(cp1);
  
        var cp2 = new dijit.layout.ContentPane({
             title: "page 2",
             content: "page 2 content"
        });
        sc.addChild(cp2);
  
        var controller = new dijit.layout.StackController({containerId: "myProgStackContainer"}, "scontroller-prog");

        sc.startup();
        controller.startup();
    });
    </script>

  The html is very simple

  .. cv:: html

    <div id="scontainer-prog"></div>
    <div id="scontroller-prog"></div>


Declarative example
-------------------

Here you will see a declaratively created StackContainer

.. cv-compound::
  
  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.layout.StackContainer");
    dojo.require("dijit.layout.ContentPane");
    dojo.require("dijit.form.Button");
    </script>

  .. cv:: html

    <button id="previous" onClick="dijit.byId('stackContainer').back()" dojoType="dijit.form.Button">&lt;</button>
    <span dojoType="dijit.layout.StackController" containerId="stackContainer"></span>
    <button id="next" onClick="dijit.byId('stackContainer').forward()" dojoType="dijit.form.Button">&gt;</button>
  
    <div dojoType="dijit.layout.StackContainer" id="stackContainer">
      <div dojoType="dijit.layout.ContentPane" title="Questions">
      Please answer following questions
      </div>
      <div dojoType="dijit.layout.ContentPane" title="Answers">
      Here is what you should have answered :P
      </div>
    </div>

  .. cv:: css

    <style type="text/css">
      #stackContainer {
          border: 1px solid #ccc;
          margin-top: 10px;
      }
      
      #stackContainer div {
          padding: 5px;
      }
    </style>


=============
Accessibility
=============

Keyboard
--------

==========================================    =================================================
Action                                        Key
==========================================    =================================================
Navigate to next tab button                   Right arrow
Navigate to previous tab button               Left arrow
Navigate into page                            Tab
Navigate to next page                         Ctrl + page down, ctrl + tab (except IE7)
Navigate to previous page                     Ctrl + page up
==========================================    =================================================
