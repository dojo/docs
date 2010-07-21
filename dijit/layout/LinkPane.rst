#format dojo_rst

dijit.layout.LinkPane
=====================

A simple widget which acts similarly to a `ContentPane <dijit/layout/ContentPane>`_ with the subtle difference being the innerHTML of the widget is used as the title, and works exclusively with remote html (by way of a href="" attribute)

Example:
========

When the parser runs and sees this node, a content pane will be generated with the title "Hello", and the content will be pulled from "foo.html"

.. code-block :: html
  
  <a href="foo.html" dojoType="dijit.layout.LinkPane">Hello</a>

This can be used in other layout widgets, such as a `TabContainer <dijit/layout/TabContainer>`_:

.. code-block :: html

  <div dojoType="dijit.layout.TabContainer" style="height:300px; width:500px">
      <a href="page1.html" dojoType="dijit.layout.LinkPane">Tab 1</a>
      <a href="page2.html" dojoType="dijit.layout.LinkPane">Tab 2</a>
      <a href="page3.html" dojoType="dijit.layout.LinkPane">Tab 3</a>
  </div>

See Also:
=========

* `dijit.layout <dijit/layout>`_
