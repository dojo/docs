#format dojo_rst

dojox.form.manager._NodeMixin
=============================

:Status: Draft
:Version: 1.3 (trunk)
:Project owner: Eugene Lazutkin
:Available: since 1.3

.. contents::
   :depth: 3

============
Introduction
============

This class defines low-level primitives for form nodes. It is complimentary to and should be used together with `dojox.form.manager._Mixin <dojox/form/manager/_Mixin>`_.

On startup this mixin inspects its body and registers all found form nodes (``<input>``, ``<select>``, ``<textarea>``, ``<button>``) unless they are part of some form widget.

======================
Methods and properties
======================

This section describes all public methods and properties of the dojox.form.manager._NodeMixin class.

Value access
------------

Methods in this category provide primitives for low-level access to values of individual form elements. For high-level access to values use `_ValueMixin <dojox/form/manager/_ValueMixin>`_.

formNodeValue
~~~~~~~~~~~~~

This method allows to get/set values of controlled form nodes. It is modeled after `dojox.form.manager._Mixin's formWidgetValue() <dojox/form/manager/_Mixin#formwidgetvalue>`_. It can be used two ways: with one parameter to get the value, and with two parameters to set the value:

.. code-block :: javascript

  // reading the value
  var value = fm.formNodeValue("lastName");
  // writing the value
  fm.formNodeValue("lastName", "Smith");

The first parameter is a name of `a controlled form element <dojox/form/manager#controlled-elements>`_ (a string). The optional second parameter is a value to be set. It is usually a string too.

The returned value is:

* A form element's value for the getter version.
* The form manager itself for the setter version providing easy chaining.

Inspection
----------

Methods in this category provide primitives to iterate over controlled elements. These methods are major building blocks for all other mixins. In most cases you should avoid using them directly relying on more high-level methods of other mixins. Do use them if you write your own mixins.

Note: this section is similar to
This method allows to get/set values of controlled form nodes. It is modeled after `dojox.form.manager._Mixin's inspectFormWidget() <dojox/form/manager/_Mixin#inspection>`_.

inspectFormNodes
~~~~~~~~~~~~~~~~

This method iterates over controlled elements:

.. code-block :: javascript

  var inspector = function(name, widget, value){
    var oldValue = this.formNodeValue(name);
    this.formNodeValue(name, value);
    return oldValue;
  };

  var state = ["firstName", "lastName"];

  var defaultValue = "X";

  fm.inspectFormNodes(inspector, state, defaultValue);

There are three ways to use this method:

1. ``state`` is an array of form names. In this case ``inspector`` is called with with the same 3rd parameter ``defaultValue`` for every node in the array. The above example uses this form of inspection: both ``lastName`` and ``firstName`` will be set to ``"X"``.

2. ``state`` is an object. In this case keys of the object are form names, while corresponding values are actual values to be passed to ``inspector`` as the 3rd parameter (in this case ``defaultValue`` is not used):

  .. code-block :: javascript

    var state = {
      firstName: "Jill",
      lastName:  "Taylor"
    };
    fm.inspectFormNodes(inspector, state);

  The above example sets ``lastName`` to ``"Taylor"`` and ``firstName`` to ``"Jill"``.

3. ``state`` is ``null`` or missing. In this case the method will iterate over all controlled nodes passing ``defaultValue`` as the ``value`` parameter to ``inspector``.

  .. code-block :: javascript

    fm.inspectFormNodes(inspector, null, "X");

  The above example sets all controlled widgets to ``"X"``.

While iterating the method collects all returned values of ``inspector`` in an object keyed by corresponding widget names, and returns it as the result.

.. code-block :: javascript

  var state = {
    firstName: "Jill",
    lastName:  "Taylor"
  };
  var result = fm.inspectFormNodes(inspector, state);

  console.log(result.firstName);              // Jane
  console.log(result.lastName);               // Smith

  console.log(fm.formNodeValue("firstName")); // Jill
  console.log(fm.formNodeValue("lastName"));  // Taylor

``inspector`` function is called for every inspected node in the context of the form manager. It has following signature:

.. code-block :: javascript

  var inspector = function(name, node, value){
    // ...
    return someValue;
  };

``name`` is the name of the inspected widget, ``node`` is the node itself, or an array of widgets for radio button nodes, ``value`` is the value passed to the function according to the above described rules. ``inspector``'s return value will be collected and returned as a part of the result object as described above.

What ``inspector`` does is up to you. It can modify or just read node values. It can return something meaningful or nothing at all. It is strongly suggested to use other form manager's methods to get/set node values rather than doing it manually.

Registration
------------

These functions can register/unregister form nodes. In most cases these methods are not used directly because dojox.form.manager._NodeMixin registers all children form nodes automatically. But if you create/delete nodes dynamically, you should register/unregister them manually.

Note: methods in this section are modeled on `dojox.form.manager._Mixin's registration <dojox/form/manager/_Mixin#registration>`_.

registerNode
~~~~~~~~~~~~

This method registers a form node with a form manager, and connects its observers. This node is not required to be a descendant of the form manager it is being registered with. This method is modeled on `dojox.form.manager._Mixin's registerWidget() <dojox/form/manager/_Mixin#registerwidget>`_. Two signatures are recognized:

1. Register by node id:

  .. code-block :: javascript

    fm.registerNode(id);

2. Register a DOM node:

  .. code-block :: javascript

    fm.registerNode(node);

unregisterNode
~~~~~~~~~~~~~~

This method disconnects form node's observers, and removes it from internal structures of a form manager. This method is modeled on `dojox.form.manager._Mixin's unregisterWidget() <dojox/form/manager/_Mixin#unregisterwidget>`_. The only way to unregister a form node is by its form name:

.. code-block :: javascript

  fm.unregisterNode(name);

registerNodeDescendants
~~~~~~~~~~~~~~~~~~~~~~~

This method calls registerNode_ for every descendant form node of a given DOM node. This method is useful when you add several form nodes dynamically. These nodes do not need to be descendants of the form manager they are being registered with.

This method is modeled on `dojox.form.manager._Mixin's registerWidgetDescendants() <dojox/form/manager/_Mixin#registerwidgetdescendants>`_.

Like with registerNode_ two signatures are recognized:

1. Register by node id:

  .. code-block :: javascript

    fm.registerNodeDescendants(id);

2. Register by specifying a DOM node:

  .. code-block :: javascript

    fm.registerNodeDescendants(node);

unregisterNodeDescendants
~~~~~~~~~~~~~~~~~~~~~~~~~

This method calls unregisterNode_ for every descendant form node of a given DOM node. Its signature is the same as registerNodeDescendants_'s signature (both variants).

This method is modeled on `dojox.form.manager._Mixin's unregisterWidgetDescendants() <dojox/form/manager/_Mixin#unregisterwidgetdescendants>`_.

Lifecycle
---------

Lifecycle methods are part of every widget. They are used to initialize and destroy a widget. If you mix `dojox.form.manager._Mixin <dojox/form/manager/_Mixin>`_ in your own widget, make sure that these methods are not overwritten. If you overwrite them, make sure to call ``this.inherited(arguments)`` at the appropriate place, so they can initialize/destroy the widget properly.

destroy
~~~~~~~

This is the standard method of any widget. It is responsible for tearing up internal widget structures preparing the widget for the garbage collection. Usually it detaches event handlers, and kills references to DOM nodes. For more details, see `dijit._Widget <dijit/_Widget>`_.

====================
Additional functions
====================

dojox.form.manager.changeEvent
------------------------------

This is the low-level helper function, which returns an appropriate change event for a give DOM node.

.. code-block :: javascript

  var button = dojo.doc.createElement("button"),
      select = dojo.doc.createElement("select");

  console.log(dojox.form.manager.changeEvent(button)); // onclick
  console.log(dojox.form.manager.changeEvent(select)); // onchange
