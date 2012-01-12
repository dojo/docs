.. _dijit/layout/LinkPane:

=====================
dijit.layout.LinkPane
=====================

.. contents ::
    :depth: 2

A simple widget which acts similarly to a :ref:`ContentPane <dijit/layout/ContentPane>` with the subtle difference being
the innerHTML of the widget is used as the title, and works exclusively with remote HTML (by way of a href="" attribute).

Example
=======

When the parser runs and sees this node, a content pane will be generated with the title "Hello",
and the content will be pulled from "foo.html"

.. html ::
  
  <a href="foo.html" data-dojo-type="dijit/layout/LinkPane">Hello</a>

This can be used in other layout widgets, such as a :ref:`TabContainer <dijit/layout/TabContainer>`:

.. html ::

  <div data-dojo-type="dijit/layout/TabContainer" style="height:300px; width:500px">
      <a href="page1.html" data-dojo-type="dijit/layout/LinkPane">Tab 1</a>
      <a href="page2.html" data-dojo-type="dijit/layout/LinkPane">Tab 2</a>
      <a href="page3.html" data-dojo-type="dijit/layout/LinkPane">Tab 3</a>
  </div>

See Also
========

* :ref:`dijit.layout <dijit/layout>`
