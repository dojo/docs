.. _dojox/mobile/View:

=================
dojox/mobile/View
=================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.5

.. contents ::
    :depth: 2

Introduction
============

View is a container widget for any HTML element and/or Dojo widgets. As a Dojo widget container 
it can itself contain View widgets forming a set of nested views. A Dojo Mobile application is 
usually made  of multiple View widgets and the user can navigate through the views back and forth 
with animated transition effects.

Constructor Parameters
======================

+--------------+----------+---------+-------------------------------------------------------------------------------+
|Parameter     |Type      |Default  |Description                                                                    |
+--------------+----------+---------+-------------------------------------------------------------------------------+
|selected      |Boolean   |false    |If true, the view is displayed at startup time.                                |
+--------------+----------+---------+-------------------------------------------------------------------------------+
|keepScrollPos |Boolean   |true     |If true, the scroll position is kept when transition occurs between views.     |
+--------------+----------+---------+-------------------------------------------------------------------------------+
|tag           |String    |"div"    |A name of html tag to create as domNode.                                       |
+--------------+----------+---------+-------------------------------------------------------------------------------+

Usage
=====

When using several sibling views (direct children of the same element), you can use 
the 'selected' attribute to define whether the view should be displayed when the application 
is launched. If no view has selected=true, the first sibling view is displayed at startup time. 

Examples
========

Declarative example
-------------------

In this example, there are two Views, "view1" and "view2", and the user can move the views back and forth.

.. html ::

  <div id="view1" data-dojo-type="dojox/mobile/View">
    <h1 data-dojo-type="dojox/mobile/Heading">View 1</h1>
    <ul data-dojo-type="dojox/mobile/RoundRectList">
      <li data-dojo-type="dojox/mobile/ListItem"
          data-dojo-props='icon:"images/i-icon-1.png",
                           moveTo:"view2",
                           transition:"slide"'>Go To View 2</li>
    </ul>
  </div>

  <div id="view2" data-dojo-type="dojox/mobile/View">
    <h1 data-dojo-type="dojox/mobile/Heading"
        data-dojo-props='back:"View 1",
                         moveTo:"view1"'>View 2</h1>
  </div>

.. image :: View-anim.gif

Programmatic example
--------------------

.. js ::

  var view1 = new View(null, "view1");

  var heading1 = new Heading({
    label: "View 1"
  });
  view1.addChild(heading1);

  var categ1 = new RoundRectCategory({
    label: "Documents"
  });
  view1.addChild(categ1);

  var list1 = new RoundRectList();
  view1.addChild(list1);

  var counter = 4;
  for(var i = 1; i <= 3; i++){
    var item1 = new ListItem({
      icon: "images/i-icon-"+i+".png",
      label: "Document 000"+counter,
      moveTo: "view2"
    });
    list1.addChild(item1);
    counter++;
  }

  view1.startup();

.. html ::

  <body>
    <div id="view1"></div>
  </body>
