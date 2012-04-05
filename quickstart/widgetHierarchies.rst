.. _quickstart/widgetHierarchies:

===============================================================
Widget Hierarchies: containers, dijit._Container, and startup()
===============================================================
:Authors: Bill Keese

.. contents ::
    :depth: 2

Often developers will build a hierarchy of widgets.  For example, a :ref:`dijit.Menu <dijit/Menu>` will contain :ref:`dijit.MenuItem <dijit/MenuItem>`'s, or a :ref:`dijit.layout.BorderContainer <dijit/layout/BorderContainer>` will contain multiple :ref:`dijit.layout.ContentPane <dijit/layout/ContentPane>`'s, each of which contains some other widgets like :ref:`dijit.form.TextBox <dijit/form/TextBox>` and :ref:`dijit.form.Button <dijit/form/Button>`.


Widgets that are meant to contain other widgets must:

  * define a containerNode attribute pointing to the DOMNode containing the child widgets (either to the widget's root node or a descendant)
  * call startup() on the child widgets (when startup() is called on the widget)

Note that "other widgets" here refers to widgets added by the user (ie, by the calling code),
rather than an internal widgets which are hidden from the user, and appear to be part of the main widget.
Examples are :ref:`dijit/layout/ContentPane <dijit/layout/ContentPane>` and :ref:`dijit/Toolbar <dijit/Toolbar>`.
A widget that is *not* considered a container is  :ref:`dijit/InlineEditBox <dijit/InlineEditBox>`,
because even though it contains button widgets, they appear to be part of the InlineEditBox and are not listed by
getChildren().

Since widgets are required to call startup() on their children, the parser (:ref:`dojo.parser <dojo/parser>`) will ***not*** call startup on those widgets.  This allows the parent widget to do processing both before and after the child widget is started.  Therefore, when adding child widgets to a parent widget, be sure to use the proper API, so that the parent knows the child exists.

dijit/_Container
================

:ref:`dijit/_Container <dijit/_Container>`
is a mixin for widgets with child widgets,
especially for widgets that contain nothing but an ordered list of child widgets, like a :ref:`dijit.Menu <dijit/Menu>`.
It implements the contract for containers listed above, and goes farther.

In particular, dijit/_Container implements the addChild() and removeChild() API.

All of the widgets named \*\*\*Container (ex: :ref:`dijit.layout.TabContainer <dijit/layout/TabContainer>`) extend dijit/_Container.

dijit/_Contained
================

:ref:`dijit/_Contained <dijit/_Contained>` is the counterpart to :ref:`dijit/_Container <dijit/_Container>`.
It represents a widget that has a dijit._Container as a parent.
However, :ref:`dijit/_Container <dijit/_Container>` can contain any widget, regardless of whether it extends
:ref:`dijit/_Contained <dijit/_Contained>`, so this class is generally not used.
