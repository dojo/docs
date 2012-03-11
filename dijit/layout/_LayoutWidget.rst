.. _dijit/layout/_LayoutWidget:

==========================
dijit/layout/_LayoutWidget
==========================

.. contents ::
    :depth: 2

Typically layout widgets inherit from the dijit/layout/_LayoutWidget base class.
This implements addChild(), removeChild(), startup(), and resize().

The widget is responsible for implementing some callback methods and setting some properties though:

Properties to Set
=================

this.containerNode
------------------

The widget must have a containerNode property (typically declared in the template, data-dojo-attach-point="containerNode").
All the child widgets will be put under here.

baseClass
---------

Like other widgets, you should define baseClass to be the CSS class name associated with the widget, for example "dijitTabContainer".


Methods To Implement
====================

layout()
--------

When the widget is started or resized, layout() is called.
layout()'s job is to arrange the contents of the widget according to its [new] size.
For example, BorderContainer will set the size of the center pane to whatever space is left over after placing the top, bottom, left and right panes.
layout() can (and should) reference this._contentBox to get the size available for laying out its children.

_setupChild()
-------------

addChild() is *not* called for widgets that are in the original markup.
For example, addChild() is not called for the ContentPanes
in the markup below:

.. html ::

     <div data-dojo-type="dijit/layout/TabContainer" id="tc">
         <div data-dojo-type="dijit/layout/ContentPane" title=...>...</div>
         <div data-dojo-type="dijit/layout/ContentPane" title=...>...</div>
     </div>

However, addChild() is called when children are added programmatically, like:

.. js ::

  require(["dojo/ready", "dijit/registry", "dijit/layout/ContentPane"], function(ready, registry, ContentPane)){
      ready(function(){
          registry.byId("tc").addChild( new ContentPane() );
      });
  }

To bridge this gap and do processing common to both initial children and added children, there's a method called _setupChild().
_setupChild() is useful for tasks like in TabContainer where it sets up a tab label for each child.


Lifecycle
=========

The lifecycle of layout widgets is particularly complex because they
  * do sizing in JavaScript
  * are hierarchical: there's a relationship between parent and children widgets.

At the time that postCreate() etc. is called, the child widgets do not yet exist, and also the widget may not be connected to the document yet, so neither sizing nor parent/child related processing can be done.
Thus, some/most setup has to occur in startup().

*Lifecycle:*

  1. properties are mixed in
  2. postMixInProperties() is called
  3. the widget's DOM is setup from the template
  4. postCreate() is called
  5. widget's children are initialized
  6. widget.domNode into the document's DOM tree (by the user)
  7. user calls startup()
  8. layout() is called (widget should position its children correctly, and do other initialization that depends on calls to marginBox() etc. here)

See also the lifecycle of a standard widget in :ref:`dijit._Widget <dijit/_Widget>`.

addChild()
----------

Children can be added to a layout widget before or after its been started (via the startup() call on it, or an ancestor in its hierarchy).
Thus, addChild() and removeChild() must work before or after the widget has been started.
They can reference the this._started field to detect this state.

The distinction is important.
Consider SplitContainer's lifecycle:

  1. initial children may be specified in markup
  2. or if programmatic creation, addChild() is called for each (initial child)
  3. up to this point no sizing processing has been done
  4. SplitContainer domNode is added to the document
  5. startup() is called
  6. SplitContainer sizes all its children, to fit in the available space.

Note that split container only did sizing once, thus avoiding an n^2 computation that would occur if it processed the initial children one by one, recalculating sizes each time.

However:

  7. user calls addChild() or removeChild()
  8. SplitContainer resizes existing children to make room for new child

When children are added or removed after startup(), SplitContainer must immediately do sizing.
