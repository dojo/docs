#format dojo_rst

dojox.form.manager
==================

:Status: Draft
:Version: 1.3 (trunk)
:Project owner: Eugene Lazutkin
:Available: since 1.3

.. contents::
   :depth: 3

============
Introduction
============

The form manager is designed to implement highly interactive event-driven `CRUD <http://en.wikipedia.org/wiki/Create,_read,_update_and_delete>`_ (sub)applications. In most cases such application can be a reflection of underlying database tables, or an interface to complex calculations.

The form manager helps to do following common tasks:

* Working with both form widgets and common HTML elements presenting the unified API regardless of underlying form elements.
* Unified interfaces for underlying form elements:

  * Get or set values.
  * Enable or disable form fields.
  * Show or hide HTML elements.
  * Add or remove classes of all controlled elements.

* Unified interface to enable/disable underlying form elements.
* Processing of unified change events for underlying form elements using *observers*.
* Orchestration of complex client-side validation of groups of fields. A simple form widget validation is supported automatically.
* Orchestration of I/O.
* Form support on the level of `dijit.form.Form <dijit/form/Form>`_.

In general the form manager shields programmers and designers from dealing with specific form elements. It is quite possible for a designer to use a text input widget for some field, rearrange the HTML later changing the field to a select node, and then change it to a group of radio buttons --- all without changing a single line in the form-handling code. All event processing, value access, enable/disable functionality, and so on will continue working regardless of those changes.

Controlled elements
-------------------

The form manager works with following elements (inspected on instantiation):

* Form widgets.

  All form widgets (objects based on `dijit.form._FormWidget <dijit/form/_FormWidget>`_) are recognized automatically. A value of the ``name`` attribute of form widget is used as a unique identifier for this widget.

  *Important exception: radio buttons all share the same name and grouped as a single complex widget.*

* HTML form elements.

  All HTML form elements (``<input>``, ``<select>``, ``<textarea>``, ``<button>``) are recognized automatically, if `_NodeMixin <dojox/form/manager/_NodeMixin>`_ is included. A value of the ``name`` attribute of form element is used as a unique identifier for this widget.

  *Important exception: radio buttons all share the same name and grouped as a single complex widget.*

* Any node attribute of the widget itself.

  The usual source of such nodes is the ``dojoAttachPoint`` directive of `dojo.parser() <dojo/parser>`_. Following names are ignored: ``domNode``, ``containerNode``, ``srcNodeRef``, ``bgIframe`` (they are used internally by the widget machinery).

The DOM nodes of the 3rd class are not considered to be form fields automatically and will be ignored by value-related operations to prevent inefficiencies. But in some cases it is important to use such non-form elements as a read-only fields. If you want to designate a DOM node as a value field, you should do two things:

* Use ``dojoAttachPoint`` on such node so it'll be promoted to widget attributes.
* Mark this node with a CSS class ``dojoFormValue``. This class indicates that you opt-in this node as a value node.

Example:

.. code-block :: html
  :linenos:

  <div dojoType="dojox.form.Manager">
    <input type="checkbox" dojoType="dijit.form.CheckBox" name="w01" value="w01">
    <input type="text" name="e03" value="e03">
    <span dojoAttachPoint="n01" class="dojoFormValue">&nbsp;</span>
    <span dojoAttachPoint="n02">test</span>
  </div>

This fictitious form demonstrates following:

* The form manager widget is created on line #1. Note that this example doesn't use the ``<form>`` tag.
* The form widget on line #2 will be automatically recognized as a controlled element. It can be accessed as ``"w01"``.
* The form node on line #3 will be automatically recognized as a controlled element, if node processing is added like in this example. It can be accessed as ``"e03"``.
* The span node on line #4 will be automatically recognized as a controlled element. Its value can be read/written because it is marked with the CSS class ``dojoFormValue``.
* The span node on line #5 will be automatically recognized as a controlled element. Its value **cannot** be read/written because it is **not** marked with the CSS class ``dojoFormValue``. All other operations will work as normal.

Event processing
----------------

The form manager normalizes change events on all form widgets and HTML form elements. In order to request this special event processing, add ``observer`` attribute to a form widget or an HTML form element. The value of ``observer`` is a string that lists event handler names using comma to separate them.

In a radio button group all observers are pooled together regardless of what element of the group they are attached to and attached to the whole group as the single form widget.

Observers cannot be attached to non-form elements for obvious reasons (no way to deduce the change event). Use ``dojoAttachEvent`` for that.

An observer method is a method on the current form manager. They can be added by adding them to the form manager object using common JavaScript methods, or added dynamically with `dojo.parser() <dojo/parser>`_.

When the change event is triggered each relevant observer will be called in the context of the form manager with following parameters:

* ``value`` --- the new value of form widget or form element.
* ``name`` --- the name of form widget or form element. This parameter is useful when you attach the same observer to different form elements.
* ``element`` --- the widget object for widgets, or a DOM node for form nodes. This parameter is rarely used but can be helpful for some advanced processing.
* ``evt`` --- the original event object. This parameter is rarely used but can be helpful for some advanced processing.

Example:

.. code-block :: html
  :linenos:

  <div dojoType="dojox.form.Manager">
    <input type="checkbox" dojoType="dijit.form.CheckBox" name="w01" value="w01" observer="log">
    <input type="text" name="e03" value="e03" observer="log,disabler">
    <span dojoAttachPoint="n01" class="dojoFormValue">&nbsp;</span>
    <span dojoAttachPoint="n02" dojoAttachEvent="onclick: clicked">test</span>
    <script type="dojo/method" event="log" args="value,name">
      console.log(name, " = ", value);
    </script>
    <script type="dojo/method" event="disabler" args="value,name">
      if(value.length > 5){
        this.disable([name]);
      }
    </script>
    <script type="dojo/method" event="clicked">
      console.log("we got clicked!");
    </script>
  </div>

We extended the previous example with observers and included required observers inline using ``dojo/method``. Let's go over new additions line by line:

* On line #2 we added an observer named ``log``. It will be called on every value change of the widget ``"w01"``.
* On line #3 we added two observers named ``log`` and ``disabler``. They both will be called on every value change of the widget ``"e03"``.
* On line #5 we added a simple ``onclick`` event handler named ``clicked``. It will be called when user clicks this DOM node.
* Lines ##6-8 define ``log()`` observer. It uses two parameters ``value`` and ``name`` ignoring the rest. When it is called it prints the name and the new value of the form widget or form node it is observing.
* Lines ##9-13 define ``disabler()`` observer. Just like ``log()`` it uses the same two parameters. It will disable the controlled widget/node when the length of its text value exceeds 5. Note that on line #11 it uses ``this``, which is the form manager object of that form.
* Lines ##14-16 define a simple event handler ``clicked()``, which doesn't use any parameters, and prints a static text.

==========
Components
==========

The form manager package consists of the main widget: `dojox.form.Manager <dojox/form/Manager>`_ and a set of mixins (don't mind the leading underscore) located in ``/dojox/form/manager``:

* `_Mixin <dojox/form/manager/_Mixin>`_

  The main mixin, which should be always included. It provides the initialization and handles form widgets, ``dojoAttachPoint``-s, and *observers* directly.

* `_NodeMixin <dojox/form/manager/_NodeMixin>`_

  *Optional.* It plugs into `_Mixin <dojox/form/manager/_Mixin>`_ extending it with new methods and ability to handle HTML form nodes.

* `_FormMixin <dojox/form/manager/_FormMixin>`_

  *Optional.* Helpful when the top element of the widget is a ``<form>``. In this case it provides ``onReset()`` and ``onSubmit()`` functionality with reasonable defaults. Additionally it provides ``isValid()`` method, which validates all form widgets individually. Essentially it mirrors `dijit.form.Form <dijit/form/Form>`_.

* `_ValueMixin <dojox/form/manager/_ValueMixin>`_

  *Optional.* Provides a unified way to access (get/set) a value of any controlled element. Provides group-get/set functionality as well. This is one of the most useful mixins.

* `_EnableMixin <dojox/form/manager/_EnableMixin>`_

  *Optional.* Provides a unified way to access (get/set) an ``enable`` state of any controlled element with a group-get/set functionality as well.

* `_DisplayMixin <dojox/form/manager/_DisplayMixin>`_

  *Optional.* Provides a unified way to access (get/set) an ``display`` state of any controlled HTML element with a group-get/set functionality as well.

* `_ClassMixin <dojox/form/manager/_ClassMixin>`_

  *Optional.* Provides a unified way to add/remove a CSS class on any controlled element with a group-get/set functionality as well.

You don't have to use `Manager <dojox/form/Manager>`_ directly. In many cases it is more beneficial to add form manager mixins directly to your custom widget adding a required functionality. Think of mixins as "plugins" for other widgets.

This architecture provides for ultimate flexibility. All functionality is in mixins, and user can mix and match only necessary features conserving the downloadable bytes, if needed. Writing additional mixins is supported and actively encouraged!

`Manager <dojox/form/Manager>`_ is a simple widget that includes all above listed mixins, and treats its body as a template. Using it you don't need to put the template in the separate file but can do it completely inline. It allows to use normal template-specific directives for `dojo.parser() <dojo/parser>`_: ``dojoAttachPoint``, ``dojoAttachEvent``, and a special directive used in the form manager: ``observer`` to designate methods to be called for all high-level change events on this element (a form widget or an HTML form element). You can use it as is, or as a sample code for your own custom widgets.

Please refer to documentation of individual mixins and the widget for details of their API and implementation.

===============
Available tests
===============

All tests are located in the ``dojox/form/tests/`` sub-directory. They are used by developers to test the conformance, and can be used by users to see how different objects and algorithms can be used. Following tests are available (these are external links to Dojo Nightlies, which are are not set up for speed but for debugging):

* `test_Manager1.html <http://archive.dojotoolkit.org/nightly/dojotoolkit/dojox/form/tests/test_Manager1.html>`_ tests all available components of the form manager package.
