#format dojo_rst

Widget Hierarchies: isContainer, dijit._Container, and startup()
================================================================
:Status: Contributed
:Version: 0.1
:Authors: Bill Keese

.. contents::
	:depth: 2

Often developers will build a hierarchy of widgets.  For example, a `dijit.Menu <dijit/Menu>`_ will contain `dijit.MenuItem <dijit/MenuItem>`_'s, or a `dijit.layout.BorderContainer <dijit/layout/BorderContainer>`_ will contain multiple `dijit.layout.ContentPane <dijit/layout/ContentPane>`_'s, each of which contains some other widgets like `dijit.form.TextBox <dijit/form/TextBox>`_ and `dijit.form.Button <dijit/form/Button>`_.

There are two levels of classification for widgets that contain other widgets, isContainer and _Container:

===========
isContainer
===========
Widgets that define the isContainer flag are meant to contain other widgets.  They must:

  * define a containerNode attribute pointing to the DOMNode containing the child widgets (either to the widget's root node or a descendant)
  * call startup() on the child widgets (when startup() is called on the isContainer widget)

Since isContainer widgets promise to call startup() on their children, the parser (`dojo.parser <dojo/parser>`_) will ***not*** call startup on those widgets.  This allows the parent widget to do processing both before and after the child widget is started.  Therefore, when adding child widgets to a parent widget, be sure to use the proper API, so that the parent knows the child exists.

================
dijit._Container
================

dijit._Container implements the isContainer contract above, and goes farther.   It is a base class for widgets with an ordered list of children, like a `dijit.Menu <dijit/Menu>`_.

In particular, dijit._Container implements the addChild() and removeChild() API, and a simple getChildren() method based on the assumption that all children are direct descendants of containerNode.

All of the widgets named \*\*\*Container (ex: `dijit.layout.TabContainer <dijit/layout/TabContainer>`_) extend dijit._Container.

`dijit.layout.ContentPane <dijit/layout/ContentPane>`_, on the other hand, defines isContainer but does not extend dijit._Container (since it contains rich text rather than a simple list of widgets).

================
dijit._Contained
================

This is the counterpart to dijit._Container.  It represents a widget that has a dijit._Container as a parent.   dijit._Contained.getParent() will find the immediate parent widget and return it, but only if it defines isContainer.   Essentially that means that it will always return the parent, since all widgets that can contain other widgets (at least those defined by dijit) define isContainer.
