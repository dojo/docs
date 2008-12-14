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
* Processing of unified change events for underlying form elements.
* Orchestration of complex client-side validation of groups of fields.
* Orchestration of I/O.
* Form support on the level of `dijit.form.Form <dijit/form/Form>`_.

===========
Flexibility
===========

The form manager package consists of the main widget: `Manager <dojox/form/Manager>`_ and a set of mixins (don't mind the leading underscore):

* `_Mixin <dojox/form/manager/_Mixin>`_
* `_NodeMixin <dojox/form/manager/_NodeMixin>`_
* `_FormMixin <dojox/form/manager/_FormMixin>`_
* `_ValueMixin <dojox/form/manager/_ValueMixin>`_
* `_EnableMixin <dojox/form/manager/_EnableMixin>`_
* `_DisplayMixin <dojox/form/manager/_DisplayMixin>`_
* `_ClassMixin <dojox/form/manager/_ClassMixin>`_

The mixins provides for utmost flexibility. All functionality is in mixins, and users can mix and match only necessary features. Writing additional mixins is supported and actively encouraged!
