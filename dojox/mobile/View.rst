.. _dojox/mobile/View:

=================
dojox.mobile.View
=================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.5

.. contents ::
    :depth: 2

View is a container widget that represents entire mobile device screen. One html page can have multiple Views but only one View is visible at a time.  The user can navigate through views with animated transition effects.

Constructor Parameters
======================

+--------------+----------+---------+-------------------------------------------------------------------------------+
|Parameter     |Type      |Default  |Description                                                                    |
+--------------+----------+---------+-------------------------------------------------------------------------------+
|selected      |Boolean   |false    |If true, the view is displayed at startup time.                                |
+--------------+----------+---------+-------------------------------------------------------------------------------+
|keepScrollPos |Boolean   |true     |If true, the scroll position is kept when transition occurs between views.     |
+--------------+----------+---------+-------------------------------------------------------------------------------+

Usage
=====
View is a container that represents the device screen. You should place all the contents in a View. There may be one or more Views in a page. In dojo-1.6 or older, one and only one view must have the selected=true parameter so that it is displayed at startup time. In dojo-1.7, if no views have selected=true, the first view is displayed at startup time.

Views can be nested to form a group of views, but view transitions should be performed between sibling views (on the same level). In an exceptional case, it is possible to move to a sibling of an ancestor. The other cases are invalid.

Examples
========

Declarative example
-------------------

In this example, there are two Views, "view1" and "view2", and the user can move the views back and forth.

.. html ::

  <div id="view1" data-dojo-type="dojox.mobile.View" selected="true">
    <h1 data-dojo-type="dojox.mobile.Heading">View 1</h1>
    <ul data-dojo-type="dojox.mobile.RoundRectList">
      <li data-dojo-type="dojox.mobile.ListItem" icon="images/i-icon-1.png" moveTo="view2" transition="slide">
        Go To View 2
      </li>
    </ul>
  </div>

  <div id="view2" data-dojo-type="dojox.mobile.View">
    <h1 data-dojo-type="dojox.mobile.Heading" back="View 1" moveTo="view1">View 2</h1>
  </div>

.. image :: View-anim.gif

Programmatic example
--------------------

.. js ::

  var view1 = new dojox.mobile.View({
    id: "foo",
    selected: true
  }, "view1");
  view1.startup();

.. html ::

  <body>
    <div id="view1"></div>
  </body>
