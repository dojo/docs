#format dojo_rst

dojox.form.manager
==================

:Status: Draft
:Version: 1.3 (trunk)
:Available: 1.3
:Author: Eugene Lazutkin

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

In general the form manager shields programmers and designers from dealing with specific form elements. It is quite possible for a designer to use a text input widget for some field, rearrange the HTML later changing the field to a select node, and then change it to a group of radio buttons --- all without changing a single line in the form-handling code. All event processing, value access, enable/disable functionality, and so on will work regardless of those changes.

Controlled elements
-------------------

The form manager works with following elements (inspected on instantiation):

* Form widgets.

  All form widgets (objects based on `dijit.form._FormWidget <dijit/form/_FormWidget>`_) are recognized automatically. A value of the ``name`` attribute of form widget is used as a unique identifier for this widget.

  *Important exception: radio buttons all share the same name and grouped as a single complex widget.*

* HTML form elements.

  All HTML form elements (``<input>``, ``<select>``, ``<textarea>``, ``<button>``) are recognized automatically, if `_nodeMixin <dojox/form/manager/_NodeMixin>`_ is included. A value of the ``name`` attribute of form element is used as a unique identifier for this widget.

  *Important exception: radio buttons all share the same name and grouped as a single complex widget.*

* Any node attribute of the widget itself.

  The usual source of such nodes is the ``dojoAttachPoint`` directive of `dojo.parser() <dojo/parser>`_. Following names are ignored: ``domNode``, ``containerNode``, ``srcNodeRef``, ``bgIframe`` (they are used internally by the widget machinery).

The DOM nodes of the 3rd class are not considered to be form fields automatically and will be ignored by value-related operations to prevent inefficiencies. But in some cases it is important to use such non-form elements as a read-only fields. If you want to designate a DOM node as a value field, you should do two things:

* Use ``dojoAttachPoint`` on such node so it'll be promoted to widget attributes.
* Mark this node with a CSS class ``dojoFormValue``. This class indicates that you opt-in this node as a value node.

Event processing
----------------

The form manager normalizes change events on all form widgets and HTML form elements. In order to get those events

=====
Usage
=====

The form manager package consists of the main widget: `Manager <dojox/form/Manager>`_ and a set of mixins (don't mind the leading underscore):

* `_Mixin <dojox/form/manager/_Mixin>`_

  The main mixin, which should be always included. Handles form widgets, ``dojoAttachPoint``-s, and *observers* directly.

* `_NodeMixin <dojox/form/manager/_NodeMixin>`_

  Responsible for working with HTML form elements.

* `_FormMixin <dojox/form/manager/_FormMixin>`_

  Helpful when you top element is a <form>. In this case it provides ``onReset()`` and ``onSubmit()`` functionality with reasonable defaults. Additionally it provides ``isValid()`` method, which validates all form widgets individually.

* `_ValueMixin <dojox/form/manager/_ValueMixin>`_

  Provides a unified way to access (get/set) a value of any controlled element. Provides group-get/set functionality as well.

* `_EnableMixin <dojox/form/manager/_EnableMixin>`_

  Provides a unified way to access (get/set) an ``enable`` state of any controlled element with a group-get/set functionality as well.

* `_DisplayMixin <dojox/form/manager/_DisplayMixin>`_

  Provides a unified way to access (get/set) an ``display`` state of any controlled HTML element with a group-get/set functionality as well.

* `_ClassMixin <dojox/form/manager/_ClassMixin>`_

  Provides a unified way to add/remove a CSS class on any controlled element with a group-get/set functionality as well.

The mixins provides for utmost flexibility. All functionality is in mixins, and users can mix and match only necessary features. Writing additional mixins is supported and actively encouraged!

`Manager <dojox/form/Manager>`_ is a simple widget that includes all above listed mixins, and treats its body as a template. Using it you don't need to put the template in the separate file but can do it completely inline. It allows to use normal template-specific directives for `dojo.parser() <dojo/parser>`_: ``dojoAttachPoint``, ``dojoAttachEvent``, and a special directive used in the form manager: ``observer`` to designate methods to be called for all high-level change events on this element (a form widget or an HTML form element).
