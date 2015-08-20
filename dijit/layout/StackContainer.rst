.. _dijit/layout/StackContainer:

===========================
dijit/layout/StackContainer
===========================

:since: V1.0

.. contents ::
    :depth: 2

A container that has multiple children, but shows only one child at a time (like looking at the pages in a book one by one).


Introduction
============

This container is good for wizards, slide shows, and long lists or text blocks.


Usage
=====

.. js ::
 
   var foo = new dijit.layout.StackContainer(params, srcNodeRef);

parameters:
  ==========  ===============  ===========
  parameter   type             description
  ==========  ===============  ===========
  params      object           Optional.
  srcNodeRef  DomNode|String
  ==========  ===============  ===========


Set the current pane
--------------------

StackContainer's current pane can be set via the selectChild() method, or it can be controlled from a StackController.
StackController is a controller not in the MVC send of the word, but like a TV remote control:
it sets which page the StackController is tuned to.

Retrieving the currently selected Container
-------------------------------------------

To retrieve the currently selected container use following attribute

.. js ::
 
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


Examples
========

Programmatic example
--------------------

Here's an example of a programmatically created StackContainer, and associated StackController:

.. code-example ::
 
  .. js ::

    require([
        "dijit/layout/StackContainer",
        "dijit/layout/ContentPane",
        "dijit/layout/StackController",
        "dojo/domReady!"
    ], function(StackContainer, ContentPane, StackController){
        var sc = new StackContainer({
            style: "height: 300px; width: 400px;",
            id: "myProgStackContainer"
        }, "scontainer-prog");

        var cp1 = new ContentPane({
            title: "page 1",
            content: "page 1 content"
        });
        sc.addChild(cp1);

        var cp2 = new ContentPane({
            title: "page 2",
            content: "page 2 content"
        });
        sc.addChild(cp2);
        sc.startup();

        var controller = new StackController({containerId: "myProgStackContainer"}, "scontroller-prog");
        controller.startup();
    });

  The HTML is very simple

  .. html ::

    <div id="scontainer-prog"></div>
    <div id="scontroller-prog"></div>


Declarative example
-------------------

Here you will see a declaratively created StackContainer

.. code-example ::
  
  .. js ::

    require(["dojo/parser", "dijit/layout/StackContainer", "dijit/layout/StackController", "dijit/layout/ContentPane", "dijit/form/Button"]);

  .. html ::

    <button id="previous" data-dojo-type="dijit/form/Button" data-dojo-props="onClick:function(){myStackContainer.back()}">&lt;</button>
        <span data-dojo-type="dijit/layout/StackController" data-dojo-props="containerId:'stackContainer'"></span>
    <button id="next" data-dojo-type="dijit/form/Button" data-dojo-props="onClick:function(){myStackContainer.forward()}">&gt;</button>

    <div data-dojo-type="dijit/layout/StackContainer" data-dojo-id="myStackContainer">
        <div data-dojo-type="dijit/layout/ContentPane" title="Questions">
            Please answer following questions
        </div>
        <div data-dojo-type="dijit/layout/ContentPane" title="Answers">
            Here is what you should have answered :P
        </div>
    </div>

  .. css ::

      #stackContainer {
          border: 1px solid #ccc;
          margin-top: 10px;
      }

      #stackContainer div {
          padding: 5px;
      }


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
