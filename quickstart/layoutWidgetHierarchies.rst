#format dojo_rst

Layout Widget Hierarchies: isLayoutContainer and dijit.layout._LayoutWidget
===========================================================================
:Status: Contributed
:Version: 0.1
:Authors: Bill Keese

.. contents::
	:depth: 2

Often developers will build a hierarchy of layout related widgets.  For example, a `dijit.layout.BorderContainer <dijit/layout/BorderContainer>`_ will contain a few `dijit.layout.TabContainer <dijit/layout/TabContainer>`_'s, each of which has multiple `dijit.layout.ContentPane <dijit/layout/ContentPane>`_'s, each of which contains some other widgets like `dijit.form.TextBox <dijit/form/TextBox>`_ and `dijit.form.Button <dijit/form/Button>`_.

========
resize()
========
The main widget method for dealing with layout is resize().   Resize() serves two main purposes:

    * resize(): render (a.k.a. layout) the widget, doing JS sizing calculations   (called both to do initial layout, plus re-layout after a size change)
    * resize(newSize): change (or initially set) the size of the widget, and re-layout

Resize() can only be called when a widget is visible.   When a widget is hidden via display:none, or if one of it's ancestor DOM nodes is display:none) or if the widget DOM isn't attached to the document yet, then the JS sizing won't work.

Both layout widgets and their children need to support the resize() method.    (One exception: ContentPane children do not need a resize() method unless they do JS sizing).   See below for more details.

=================
isLayoutContainer
=================
Widgets that define an isLayoutContainer attribute promise to:

    * Calls resize() on (top level) child widgets when those widgets become visible.

isLayoutContainer widgets will often will pass in a size on the child.resize() call, but they might just call resize() w/out any parameters.

isLayoutContainer widgets also define the flag:

    * isContainer: true

so that child can call getParent().

isLayoutContainer children
---------------------------
Since javascript sizing doesn't work until a widget has been made visible, child widgets of an isLayoutContainer will usually detect if parent has the isLayoutContainer container, then branch:

 * yes: on startup(), skip layout operations.    instead wait for resize() call.
 * no: startup() must do sizing

This is important because it means that the appropriate interfaces (addChild(), attr("content", ...)) must be used so that the parent knows about the child.   If the child DOM is added directly to the parent's DOM, the parent won't know about it, and it won't call resize()

==========================
dijit.layout._LayoutWidget
==========================
Most layout widgets extend dijit.layout._LayoutWidget.   _LayoutWidget implements the isLayoutContainer contract specified above, with some helper functions.

It also implements (by extension of dijit._Container) the idea that the widget simply contains a list of widgets of children,  rather than a rich-text mixture of plain DOM Nodes and widgets.

Finally, any `dijit.layout._LayoutWidget <dijit/layout/_LayoutWidget>`_ can be the child of another `dijit.layout._LayoutWidget <dijit/layout/_LayoutWidget>`_, so it implements the idea listed above about skipping calling resize() from startup().

dijit.layout._LayoutWidget children
-----------------------------------
Children of a `dijit.layout._LayoutWidget <dijit/layout/_LayoutWidget>`_ need to implement the resize(size) method which sets the size of the widget (and does any necessary JS size calculations).

========================
dijit.layout.ContentPane
========================
Since dijit.layout.ContentPane <dijit/layout/ContentPane>`_ is often used in layout widget hierarchies, it implements the isLayoutContainer interface.   When the ContentPane itself is made visible, it calls resize() on each top level widget child.

It doesn't extend `dijit.layout._LayoutWidget <dijit/layout/_LayoutWidget>`_ because it can contain a rich text mixture of plain DOM nodes and widgets, as opposed to `dijit.layout._LayoutWidget <dijit/layout/_LayoutWidget>`_ which simply contains an ordered (linear) list of widgets.     This is also the reason that ContentPane doesn't have addChild() and removeChild() methods.    It does have a getChildren() method to find all of it's "top level" widgets.

One common use for ContentPane is to contain a single layout widget.  In this case (assuming that doLayout was not set to false), the ContentPane resizes it's single child to match it's own size.

======
Naming
======
The naming of these classes is unfortunate, but difficult to change for back-compat reasons.

In particular, _Container and _LayoutWidget imply the addChild()/removeChild() linear list-of-children interface, whereas isLayoutContainer does not.
