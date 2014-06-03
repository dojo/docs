.. _dojox/form/manager/_Mixin:

=========================
dojox.form.manager._Mixin
=========================

:Project owner: Eugene Lazutkin
:since: 1.3

.. contents ::
   :depth: 3

Introduction
============

This class is the main component of the form manager, which provides the initialization and core functionality. It can be used on its own as a mixin to other widgets, or as a part of :ref:`dojox.form.Manager <dojox/form/Manager>`. All other form manager mixins require this class to be mixed in as well.

On startup this mixin inspects its body and registers all found form widgets, and attached nodes (by ``data-dojo-attach-point``). Additionally it provides some low-level properties and methods to handle controlled elements.

Methods and properties
======================

This section describes all public methods and properties of the dojox.form.manager._Mixin class.

General
-------

Only one property falls under this category: watch_.

watch
~~~~~

This is a Boolean property, which is used to control :ref:`observers <dojox/form/manager/index>`. When this property is ``true`` change events are processed and passed to relevant observers as usual. When it is ``false``, change events are ignored.

This property is useful when you want to modify/update controlled elements, but you don't want to cause observers to run.

Example:

.. js ::

  // stop change event processing
  fm.watch = false;
  // update some fields without alerting observers
  fm.setFormValues({
    lastName:  "Smith",
    firstName: "Jane"
  });
  // start change event processing
  fm.watch = true;

Value access
------------

Methods in this category provide primitives for low-level access to values of individual form elements. For high-level access to values use :ref:`_ValueMixin <dojox/form/manager/_ValueMixin>`.

Note: :ref:`_NodeMixin <dojox/form/manager/_NodeMixin>` implements a complimentary method: :ref:`formNodeValue <dojox/form/manager/_NodeMixin>`.

formWidgetValue
~~~~~~~~~~~~~~~

This method allows to get/set values of controlled form widgets. It can be used two ways: with one parameter to get the value, and with two parameters to set the value:

.. js ::

  // reading the value
  var value = fm.formWidgetValue("lastName");
  // writing the value
  fm.formWidgetValue("lastName", "Smith");

The first parameter is a name of :ref:`a controlled form element <dojox/form/manager/index>` (a string). The optional second parameter is a value to be set. It is usually a string too.

The returned value is:

* A form element's value for the getter version.
* The form manager itself for the setter version providing easy chaining.

formPointValue
~~~~~~~~~~~~~~

This method is similar to formWidgetValue_ method but works on :ref:`nodes attached to the widget itself <dojox/form/manager/index>`:

.. js ::

  // reading the value
  var value = fm.formPointValue("firstName");
  // writing the value
  fm.formPointValue("lastName", "Jane");

Usage and syntax is exactly the same as for formWidgetValue_.

Inspection
----------

Methods in this category provide primitives to iterate over controlled elements. These methods are major building blocks for all other mixins. In most cases you should avoid using them directly relying on more high-level methods of other mixins. Do use them if you write your own mixins.

Note: :ref:`_NodeMixin <dojox/form/manager/_NodeMixin>` implements a complimentary method: :ref:`inspectFormNodes <dojox/form/manager/_NodeMixin>`.

inspectFormWidgets
~~~~~~~~~~~~~~~~~~

This method iterates over controlled elements:

.. js ::

  var inspector = function(name, widget, value){
    var oldValue = this.formWidgetValue(name);
    this.formWidgetValue(name, value);
    return oldValue;
  };

  var state = ["firstName", "lastName"];

  var defaultValue = "X";

  fm.inspectFormWidgets(inspector, state, defaultValue);

There are three ways to use this method:

1. ``state`` is an array of form names. In this case ``inspector`` is called with the same 3rd parameter ``defaultValue`` for every widget in the array. The above example uses this form of inspection: both ``lastName`` and ``firstName`` will be set to ``"X"``.

2. ``state`` is an object. In this case keys of the object are form names, while corresponding values are actual values to be passed to ``inspector`` as the 3rd parameter (in this case ``defaultValue`` is not used):

  .. js ::

    var state = {
      firstName: "Jill",
      lastName:  "Taylor"
    };
    fm.inspectFormWidgets(inspector, state);

  The above example sets ``lastName`` to ``"Taylor"`` and ``firstName`` to ``"Jill"``.

3. ``state`` is ``null`` or missing. In this case the method will iterate over all controlled widgets passing ``defaultValue`` as the ``value`` parameter to ``inspector``.

  .. js ::

    fm.inspectFormWidgets(inspector, null, "X");

  The above example sets all controlled widgets to ``"X"``.

While iterating the method collects all returned values of ``inspector`` in an object keyed by corresponding widget names, and returns it as the result.

.. js ::

  var state = {
    firstName: "Jill",
    lastName:  "Taylor"
  };
  var result = fm.inspectFormWidgets(inspector, state);

  console.log(result.firstName);                // Jane
  console.log(result.lastName);                 // Smith

  console.log(fm.formWidgetValue("firstName")); // Jill
  console.log(fm.formWidgetValue("lastName"));  // Taylor

``inspector`` function is called for every inspected widget in the context of the form manager. It has following signature:

.. js ::

  var inspector = function(name, widget, value){
    // ...
    return someValue;
  };

``name`` is the name of the inspected widget, ``widget`` is the widget itself, or an array of widgets for radio button widgets, ``value`` is the value passed to the function according to the above described rules. ``inspector``'s return value will be collected and returned as a part of the result object as described above.

What ``inspector`` does is up to you. It can modify or just read widget values. It can return something meaningful or nothing at all. It is strongly suggested to use other form manager's methods to get/set widget values rather than doing it manually.

inspectAttachedPoints
~~~~~~~~~~~~~~~~~~~~~

This method is similar to inspectFormWidgets_ method but works on :ref:`nodes attached to the widget itself <dojox/form/manager/index>`. The only difference is the inspector signature, which uses a DOM node instead of a widget:

.. js ::

  var inspector = function(name, node, value){
    // ...
    return someValue;
  };

Everything else is the same. Example:

.. js ::

  var inspector = function(name){
    return this.formPointValue(name);
  };

  // collect all current values of attached nodes
  var result = fm.inspectAttachedPoints(inspector);

inspect
~~~~~~~

This is the high-level method, which has the same signature as inspectFormWidgets_ and inspectAttachedPoints_. The major difference is: it iterates over widgets **and** attached nodes **and** form nodes (for the last one you have to include :ref:`_NodeMixin <dojox/form/manager/_NodeMixin>`):

.. js ::

  var inspector = function(name){
    return this.formPointValue(name);
  };

  // collect all current values of attached nodes
  var result = fm.inspect(inspector);

``inspector``'s signature is similar to inspectFormWidgets_'s ``inspector``, but the 2nd argument will be a form widget for widgets, a DOM node for attached nodes and form nodes, or an array of widgets or DOM nodes for radio buttons.

Registration
------------

These functions can register/unregister widgets. In most cases these methods are not used directly because dojox.form.manager._Mixin registers all children form widgets automatically. But if you create/delete widgets dynamically, you should register/unregister them manually.

Note: :ref:`_NodeMixin <dojox/form/manager/_NodeMixin>` implements complimentary methods: :ref:`registerNode <dojox/form/manager/_NodeMixin>`, :ref:`unregisterNode <dojox/form/manager/_NodeMixin>`, :ref:`registerNodeDescendants <dojox/form/manager/_NodeMixin>`, :ref:`unregisterNodeDescendants <dojox/form/manager/_NodeMixin>`.

registerWidget
~~~~~~~~~~~~~~

This method registers a form widget with a form manager, and connects its observers. This widget is not required to be a descendant of the form manager it is being registered with. Three signatures are recognized:

1. Register by widget id:

  .. js ::

    fm.registerWidget(id);

2. Register by widget's DOM node:

  .. js ::

    fm.registerWidget(node);

3. Register a widget object:

  .. js ::

    fm.registerWidget(widget);

unregisterWidget
~~~~~~~~~~~~~~~~

This method disconnects widget's observers, and removes it from internal structures of a form manager. The only way to unregister a widget is by its form name:

.. js ::

  fm.unregisterWidget(name);

registerWidgetDescendants
~~~~~~~~~~~~~~~~~~~~~~~~~

This method calls registerWidget_ for every descendant form widget of a given widget (usually a layout widget). This method is useful when you add several widgets dynamically. These widgets do not need to be descendants of the form manager they are being registered with. For example you can register a dialog widget, which is attached directly to the ``body`` element.

Like with registerWidget_ widget three signatures are recognized:

1. Register by widget id:

  .. js ::

    fm.registerWidgetDescendants(id);

2. Register by widget's DOM node:

  .. js ::

    fm.registerWidgetDescendants(node);

3. Register by specifying a widget object:

  .. js ::

    fm.registerWidgetDescendants(widget);

unregisterWidgetDescendants
~~~~~~~~~~~~~~~~~~~~~~~~~~~

This method calls unregisterWidget_ for every descendant form widget of a given widget (usually a layout widget). Its signature is the same as registerWidgetDescendants_'s signature (all three variants).

Lifecycle
---------

Lifecycle methods are part of every widget. They are used to initialize and destroy a widget. If you mix dojox.form.manager._Mixin in your own widget, make sure that these methods are not overwritten. If you overwrite them, make sure to call ``this.inherited(arguments)`` at the appropriate place, so they can initialize/destroy the widget properly.

startup
~~~~~~~

This is the standard method of any widget. It is responsible for starting up the widget after it was created and the DOM was parsed. For more details, see :ref:`dijit._Widget <dijit/_Widget>`.

destroy
~~~~~~~

This is the standard method of any widget. It is responsible for tearing up internal widget structures preparing the widget for the garbage collection. Usually it detaches event handlers, and kills references to DOM nodes. For more details, see :ref:`dijit._Widget <dijit/_Widget>`.

Additional functions
====================

For writers of additional mixins, this module provides several helper functions.

.. _dojox/form/manager#actionAdapter:

dojox.form.manager.actionAdapter
--------------------------------

As described above the inspector can receive a widget/node as the 2nd parameter, or an array of widgets/nodes. This adapter checks the 2nd value and applies the inspector directly, if it was called with a widget/node. If it was called with the array, the adapter will apply the inspector to all elements of the array.

.. js ::

  var inspector = function(name, elem, value){
    // ...
  };
  var adapted = dojox.form.manager.actionAdapter(inspector);
  fm.inspect(adapted);

This adapter is useful when you want to do a uniform processing of form elements, e.g., disabling them, or adding a CSS class.

dojox.form.manager.inspectorAdapter
-----------------------------------

This is a slightly different adapter for arrays versus widgets/nodes. The difference with :ref:`dojox/form/manager#actionAdapter` is in case of arrays it applies the inspector only to the first element of the array.

.. js ::

  var inspector = function(name){
    // ...
  };
  var adapted = dojox.form.manager.inspectorAdapter(inspector);
  fm.inspect(adapted);

This adapter is useful when you want to do a uniform inspection of form elements, e.g., reading and returning their values.

dojox.form.manager._keys
------------------------

This function takes an object and returns an array of all keys. It is very similar to :ref:`dojox.lang.functional.object.keys() <dojox/lang/functional/object>`. It is defined there only to reduce the dependency on other packages.

Technical notes
===============

_Mixin extends :ref:`dijit._Widget <dijit/_Widget>` with an extra attribute: ``observer``. It makes this attribute valid for all widgets. You can read more on observers in the :ref:`dojox.form.manager event processing documentation <dojox/form/manager/index>`.
