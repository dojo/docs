.. _dijit/layout/LayoutContainer:

============================
dijit/layout/LayoutContainer
============================

:Authors: Bill Keese, Nikolai Onken, Marcus Reimann
:Developers: Bill Keese
:since: V1.0

.. contents ::
    :depth: 2

This widget is a container partitioned into up to five regions:
left (or leading), right (or trailing), top, and bottom with a mandatory center to fill in any remaining space.

Usage
=====

Regions
-------

Each child element must have an attribute "region" which indicates where it should be positioned (most names are self explanatory):

  * top
  * bottom
  * right
  * left
  * center
  * leading: used have flexible layout in left-to-right/right-to-left environments.
    In ltr, it will be equivalent to left, in rtl equivalent to right.
  * trailing: opposite of 'leading': right in ltr, left in rtl

There can be multiple widgets for each region, in which case their order (i.e.
closeness to the edge of the LayoutContainer) is controlled by their relative layoutPriority settings.

There must always be one region marked 'center'.

Setting sizes
-------------
Sizes are specified for the edge regions in pixels or percentage using CSS -- height for top and bottom and width for the sides.
You might specify a top region of height:100px and a left region of width:50%.
The center must not have any dimensions specified in CSS as it resizes automatically to fill the remaining space.
Do not set the width of the top/bottom panes or the height of the left/right panes as that would be meaningless.

Besides setting the size of the LayoutContainer itself, you generally need to set the width of the leading and trailing
(left and the right) panes.
You shouldn't need to set the height of the top/bottom panes as that can be determined automatically.


``Note:`` In order to set the overall size of a LayoutContainer to the full size of the viewport;
to allow LayoutContainer to automatically size to a percentage during initial layout; and / or to resize itself
(and its children) automatically when the window resizes, both the `<html>` and `<body>` elements need an explicit size
set as well as a size on the LayoutContainer itself:

.. css ::
  
    body, html { width:100%; height:100%; margin:0; padding:0; overflow:hidden; }
    #LayoutContainer { width:100%; height:100% }

Otherwise, the computed dimensional styles of the LayoutContainer will report 0
rather than the browser-calculated size of the viewport.
This is due to the counter-intuitive fact that the parent `<html>` and `<body>` elements have default width and height
style values of 0 despite visibly filling the viewport as implemented by browsers.


Layout modes
------------

LayoutContainer operates in a choice of two layout modes: the design attribute may be set to "headline" (by default) or "sidebar".
With the "headline" layout, the top and bottom sections extend the entire width of the box and the remaining regions are placed in the middle.
With the "sidebar" layout, the side panels take priority, extending the full height of the box.

However, the layoutPriority setting for child panes overrides the design attribute on the LayoutContainer.
In other words, if the top and bottom sections have a lower layoutPriority then the left and right panes then the top and bottom panes will extend the entire width of the box.
 
Examples
========

Declarative example
-------------------

.. code-example::
  :type: inline
  :height: 400
  :width: 660

  Let's specify a simple LayoutContainer with a left and center region

  .. css ::

   html, body {
       width: 100%;
       height: 100%;
       margin: 0;
       overflow:hidden;
   }

   #layoutContainer {
       width: 100%;
       height: 100%;
   }

  .. js ::

    require(["dojo/parser", "dijit/layout/ContentPane", "dijit/layout/LayoutContainer"]);

  .. html ::
    
    <div data-dojo-type="dijit/layout/LayoutContainer" data-dojo-props="design:'sidebar'" id="layoutContainer">
        <div data-dojo-type="dijit/layout/ContentPane" data-dojo-props="region:'leading'" style="width: 100px;">Hi, I'm leading pane</div>
        <div data-dojo-type="dijit/layout/ContentPane" data-dojo-props="region:'center'">Hi, I'm center pane</div>
    </div>


Using layoutPriority
--------------------

This example uses layoutPriority to include two left panes in one LayoutContainer:

.. code-example::
  :type: inline
  :height: 400
  :width: 660
  :version: 1.6

  .. js ::

    require(["dojo/parser", "dijit/layout/ContentPane", "dijit/layout/LayoutContainer"]);
  
  .. html ::
    
    <div data-dojo-type="dijit/layout/LayoutContainer" data-dojo-props="liveSplitters:true" id="layoutPriorityBorderContainer">
        <div data-dojo-type="dijit/layout/ContentPane" data-dojo-props="region:'leading', layoutPriority:1" style="width: 100px;">Left #1</div>
        <div data-dojo-type="dijit/layout/ContentPane" data-dojo-props="region:'leading', layoutPriority:2" style="width: 100px;">Left #2</div>
        <div data-dojo-type="dijit/layout/ContentPane" data-dojo-props="region:'center'">Hi, I'm center</div>
    </div>
  
  .. css ::
 
    html, body {
        width: 100%;
        height: 100%;
        margin: 0;
        overflow:hidden;
    }

    #layoutPriorityBorderContainer {
        width: 100%;
        height: 100%;
    }


Accessibility
=============

Note: The children of LayoutContainer must be created in the source code in their natural tab order.
Header regions should be first and footer regions last.
In Left to right locales, left regions should be before center and right ones.

See also
========

* :ref:`dijit/layout/BorderContainer <dijit/layout/BorderContainer>` - subclass of LayoutContainer
