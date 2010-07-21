#format dojo_rst

dojox.form.manager._FormMixin
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

This class is the component of the form manager. It should be used together with `_Mixin <dojox/form/manager/_Mixin>`_.

If the widget is based on ``<form>`` element, this mixin provides the enhanced functionality to reset and submit the form using the standard browser form submitting process. ``onreset`` and ``onsubmit`` events are processed automatically.

======================
Methods and properties
======================

This section describes all public methods and properties of the dojox.form.manager._FormMixin class.

General
-------

Following public properties are defined to support standard form attributes: ``name``, ``action``, ``method``, ``encType``, ``accept-charset``, ``accept``, ``target``. Please refer to the HTML DOM documentation for details on these standard attributes: `HTMLFormElement <http://www.w3.org/TR/2000/WD-DOM-Level-1-20000929/level-one-html.html#ID-40002357>`_.

reset
~~~~~

This method is used to reset the form. See `HTMLFormElement <http://www.w3.org/TR/2000/WD-DOM-Level-1-20000929/level-one-html.html#ID-40002357>`_ for more details.

It goes over all controlled form widgets calling ``reset()`` on them (if it is defined), and calls ``reset()`` on the underlying ``<form>`` element, if there is one.

The method takes no parameters and returns the form manager itself for easy chaining.

Example:

.. code-block :: javascript

  fm.reset();

submit
~~~~~~

This method is used to submit the form. See `HTMLFormElement <http://www.w3.org/TR/2000/WD-DOM-Level-1-20000929/level-one-html.html#ID-40002357>`_ for more details.

The method works only if the top widget's node is ``<form>`` node. It calls onSubmit_ method, and if it returned anything but ``false`` (the identity check is used), it calls ``submit()`` on the underlying ``<form>`` node.

The method takes no parameters and returns nothing. If it is successful, the browser will submit the form, and navigate according to the server's response.

Example:

.. code-block :: javascript

  fm.submit();

isValid
~~~~~~~

This method validates all controlled and enabled form widgets by calling their ``isValid()`` method, if it was defined. If any form widget returns ``false``, the method returns ``false`` too. Otherwise it returns ``true``. The method takes no parameters.

Example:

.. code-block :: javascript

  if(fm.isValid()){
    // all individual form widgets were validated successfully
  }else{
    // some form widget has failed the validation
  }

*Note: this method doesn't validate form nodes controlled by* `_NodeMixin <dojox/form/manager/_NodeMixin>`_ *or node attributes of the form manager widget. You should implement your own validation for them.*

isForm
~~~~~~

This is the Boolean property, which is set during the initialization of the form manager widget. If it is ``true``, the root node of the widget is ``<form>``. Otherwise it is ``false``.

.. code-block :: javascript

  if(fm.isForm){
    // we are based on the actual <form> node
  }else{
    // we are not based on the node --- use XHR
  }

Event handlers
--------------

The mixin processes ``onreset`` and ``onsubmit`` events automatically re-routing them to callbacks that are meant to be overridden in the form manager widget by users.

onReset
~~~~~~~

This callback is called when ``onreset`` event was raised in any way. It should return ``false`` to stop reset_ from happening. The default implementation returns ``true``.

The method takes one parameter: the event object.

Example:

.. code-block :: javascript

  fm.onReset = function(){ return false; }; // never allow to reset

onSubmit
~~~~~~~~

This callback is called when ``onsubmit`` event was raised in any way. It should return ``false`` to stop submit_ from happening. The default implementation calculates onValid and returns its value. It prevents the form from submitting if any form widget was not valid.

The method takes one parameter: the event object.

Example:

.. code-block :: javascript

  fm.onSubmit = function(){ return false; }; // never allow to submit

Lifecycle
---------

Lifecycle methods are part of every widget. They are used to initialize and destroy a widget. If you mix dojox.form.manager._FormMixin in your own widget, make sure that these methods are not overwritten. If you overwrite them, make sure to call ``this.inherited(arguments)`` at the appropriate place, so they can initialize/destroy the widget properly.

startup
~~~~~~~

This is the standard method of any widget. It is responsible for starting up the widget after it was created and the DOM was parsed. For more details, see `dijit._Widget <dijit/_Widget>`_.

====
Tips
====

This mixin makes sense mostly for ``<form>``-based form manager widgets. If your widget is not based on ``<form>`` the only useful method is isValid_. Think carefully if you really need it. On the other hand including this mixin in the absence of ``<form>`` doesn't have adverse effects on the functionality.

In some cases it makes sense to base your form manager widget on ``<form>`` node even if you don't want to submit the form with the browser relying on XHR-like methods instead. Having ``<form>`` enables automatic processing of ``Enter`` key anywhere in the form as ``onsubmit`` event. Don't forget to override onSubmit_ method returning ``false`` to prevent the form from actual submission, and start I/O using alternative means.
