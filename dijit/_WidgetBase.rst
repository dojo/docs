.. _dijit/_WidgetBase:

=================
dijit/_WidgetBase
=================

.. contents ::
   :depth: 2

Introduction
============

dijit/_WidgetBase is the base class for all widgets in dijit,
and in general is the base class for all dojo based widgets.
Usually widgets also extend other mixins such as :ref:`dijit/_TemplatedMixin <dijit/_TemplatedMixin>`.

Note that the underscore in the name implies not that _WidgetBase is a private class, but rather that it's a base 
class, rather than a widget directly usable.

Usage
=====

All widgets are created by calling :ref:`dojo/_base/declare <dojo/declare>`, extending from _WidgetBase:

.. js ::
   define(['dojo/_base/declare'], function (declare) {
       return declare(_WidgetBase, { ... });
   });
   
and then redefining a number of methods for the widget `lifecycle`_...

Lifecycle
=========

The lifecycle of a widget describes the phases of its creation and destruction which you can hook into.
It's useful to understand exactly what happens when.
Whether you are sub-classing an existing widget, using dojo/method script blocks, or passing in method overrides to the constructor, these are your entry points for making a widget do what you want it to do.

Widgets are classes, created with dojo/_base/declare.
All widgets inherit from dijit/_WidgetBase, and most get the _TemplatedMixin.
That provides you the following extension points (methods) you can override and provide implementation for:

- constructor
     Your constructor method will be called before the parameters are mixed into the widget,
     and can be used to initialize arrays, etc.

- parameters are mixed into the widget instance
     This is when attributes in the markup (ex: <button iconClass=...>) are mixed in or,
     if you are instantiating directly, the properties object you passed into the constructor
     (ex: new Button({label: "hi"})).
     This step itself is not overridable, but you can play with the result in...

- postMixInProperties
     If you provide a postMixInProperties method for your widget, it will be invoked before rendering occurs,
     and before any dom nodes are created.
     If you need to add or change the instance's properties before the widget is rendered - this is the place to do it.

- buildRendering
     :ref:`dijit/_TemplatedMixin <dijit/_TemplatedMixin>` provides an implementation of buildRendering
     that most times will do what you need.
     The template is fetched/read, nodes created and events hooked up during buildRendering.
     The end result is assigned to this.domNode.
     If you don't mixin :ref:`dijit/_TemplatedMixin <dijit/_TemplatedMixin>` (and most OOTB dijits do)
     and want to handle rendering yourself
     (e.g. to really streamline a simple widget, or even use a different templating system) this is where you'd do it.

- setters are called
     Setters are called for all attributes with custom setters
     (see the "Attributes" section in :ref:`Writing Your Own Widget <quickstart/writingWidgets>`)
     and that were either specified as constructor parameters or have non-null non-blank non-zero default values.

- postCreate
   This is typically the workhorse of a custom widget. The widget has been rendered
   (but note that child widgets in the containerNode have not!).
   The widget though may not be attached to the DOM yet so *you shouldn't do any sizing calculations in this method*.

- startup
    If you need to be sure parsing and creation of any child widgets has completed, use startup.
    This is often used for layout widgets like BorderContainer.
    If the widget does JS sizing, then startup() should call resize(), which does the sizing.

- destroy
     Implement destroy if you have special tear-down work to do (the superclasses will take care of most of it for you.
     Examples on how to destroy a widget:

  .. js ::
    // assumes you have loaded dijit/form/TextBox using AMD
    var widget = new TextBox({name: "firstname"}, "inputId");
    widget.destroy();

  .. js ::
    // assumes you have loaded dijit/registry using AMD
    registry.byId("dijitId").destroy();


Other methods
-------------

- resize
    All widgets that do JS sizing should have a method called resize(), that lays out the widget.
    Resize() should be called from startup() and will also be called by parent widgets like
    :ref:`dijit/layout/ContentPane <dijit/layout/ContentPane>`.

this.inherited()
----------------

In all cases its good practice to assume that you are overriding a method
that may do something important in a class up the inheritance chain.
So, call this.inherited() before or after your own code.
E.g.

.. js ::

  postCreate: function(){
     // do my stuff, then...
     this.inherited(arguments);
  }


Attributes
==========

Perhaps the most important feature of _WidgetBase is the ability to set attributes at widget initialization,
or to change their values later on in the widget's lifecycle.

dijit/_WidgetBase has implemented the set() method to do this.
For example, this call will set a DateTextBox's value to the current date:

.. js ::

   myDateTextBox.set('value', new Date())

There's also a get() method to retrieve an attribute's value.
This call will tell us if a TitlePane is opened or closed:

.. js ::

   myTitlePane.get('open')

Finally, there's a watch() method to detect when attribute values change:

.. js ::

   myTitlePane.watch("open", function(attr, oldVal, newVal){
      console.log("pane is now " + (newVal ? "opened" : "closed"));
   })

.. _dijit/_WidgetBase#custom-setters-getters:

Custom setters/getters
----------------------

get()/set() make use of custom setters/getters, which can map a widget attribute to a
DOMNode attribute, or perform any arbitrary code.
For details, see the :ref:`Writing Widgets QuickStart <quickstart/writingWidgets>` guide.

See also
========

* :ref:`Writing Widgets <quickstart/writingWidgets>`
