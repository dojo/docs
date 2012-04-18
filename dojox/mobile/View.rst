.. _dojox/mobile/View:

=================
dojox.mobile.View
=================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.5

.. contents ::
    :depth: 2

Introduction
============

View is a container widget which represents an entire mobile device screen. One html page can have multiple Views, but only one View is visible at a time.  The user can navigate through views with animated transition effects.

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
View is a container which represents the device screen. You should place all the contents in a View. There may be one or more Views in a page. In dojo-1.6 or older, one and only one view must have the selected=true parameter so that it is displayed at startup time. In dojo-1.7, if no views have selected=true, the first view is displayed at startup time.

Views can be nested to form a group of views. In dojo-1.7 or older, view transitions should be performed between sibling views (on the same level). An exceptional case is to transition to a sibling of an ancestor. All other cases are invalid. However, such limitations have been removed in dojo-1.8. 

Examples
========

Declarative example
-------------------

In this example, there are two Views, "view1" and "view2", and the user can move the views back and forth.

.. html ::

  <div id="view1" data-dojo-type="dojox.mobile.View">
    <h1 data-dojo-type="dojox.mobile.Heading">View 1</h1>
    <ul data-dojo-type="dojox.mobile.RoundRectList">
      <li data-dojo-type="dojox.mobile.ListItem"
          data-dojo-props='icon:"images/i-icon-1.png",
                           moveTo:"view2",
                           transition:"slide"'>Go To View 2</li>
    </ul>
  </div>

  <div id="view2" data-dojo-type="dojox.mobile.View">
    <h1 data-dojo-type="dojox.mobile.Heading"
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
