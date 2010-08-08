#format dojo_rst

dojox.form.manager._DisplayMixin
================================

:Status: Draft
:Version: 1.3 (trunk)
:Project owner: Eugene Lazutkin
:Available: since 1.3

.. contents::
   :depth: 3

============
Introduction
============

This class is the component of the form manager. It should be used together with `\_Mixin <dojox/form/manager/_Mixin>`_.

The mixin provides commonly used methods to show/hide attached nodes (see `controlled elements <dojox/form/manager#controlled-elements>`_ for more details) by modifying ``display`` property of node's ``style`` using ``"none"`` value to hide the node, and ``""`` value to show it. It doesn't use any other ``display`` values.

This mixin is modeled after `\_EnableMixin <dojox/form/manager/_EnableMixin>`_.

======================
Methods and properties
======================

This section describes all public methods and properties of the dojox.form.manager._DisplayMixin class.

gatherDisplayState
~~~~~~~~~~~~~~~~~~

This method collects show/hide status information in a dictionary object as Boolean values (``true`` means shown). It is modeled after `\_valueMixin's gatherFromValues() <dojox/form/manager/_ValueMixin#gatherformvalues>`_.

There are three ways to use this method:

1. Call it with the array of names (represented by strings):

  .. code-block :: javascript

    var names = ["main", "opt"];
    var state = fm.gatherDisplayState(names);

  Only supplied names will be collected.

2. Call it with a dictionary (an object). Only keys will be used, values will be ignored:

  .. code-block :: javascript

    var names = {main: 1, opt: 1};
    var state = fm.gatherDisplayState(names);

  Only supplied names will be collected.

  This form is especially useful when we already collected values, and want to collect their display state:

  .. code-block :: javascript

    var names = ["main", "opt"];
    var values = fm.gatherFormValues(names);
    // later in the code
    var state  = fm.gatherDisplayState(values);

3. The parameter is ``null``, or ``undefined``, or missing. In this case states of all known form elements will be collected:

  .. code-block :: javascript

    var state = fm.gatherDisplayState();

show
~~~~

This method shows/hides attached nodes. It can take 0, 1 or 2 parameters described below, and returns the form manager itself for easy chaining.

There are three ways to use this method:

1. Call it with the array of names (represented by strings):

  .. code-block :: javascript

    var names = ["main", "opt"], defaultState = true;
    fm.show(names, defaultState);

  All form elements with supplied names will be shown or hidden according to the value of ``defaultState`` (``true`` means "show").

  ``defaultState`` can be omitted. In this case it is assumed to be ``true``:

  .. code-block :: javascript

    var names = ["main", "opt"];
    fm.show(names);

  The code above shows two form elements.

2. Call it with a dictionary (an object).

  .. code-block :: javascript

    var state = {main: true, opt: false};
    fm.enable(state);

  The example above shows ``"main"`` and hides ``"opt"``.

3. The ``state`` parameter is ``null``, or ``undefined``, or missing. In this case states of all known form elements will be shown or hidden according to the value of ``defaultState``:

  .. code-block :: javascript

    var defaultState = true;
    fm.show(defaultState);

  The code above shows all known attached nodes.

  ``defaultState`` can be omitted. In this case it is assumed to be ``true``:

  .. code-block :: javascript

    fm.show();

  The code above shows all attached nodes.

hide
~~~~

This method is complimentary to show_. Just like show_ it takes a state object but it always uses ``false`` (for "hide") as the default state. It can take 0, or 1 parameter described below, and returns the form manager itself for easy chaining.

There are three ways to use this method:

1. Call it with the array of names (represented by strings):

  .. code-block :: javascript

    var names = ["main", "opt"];
    fm.hide(names);

  All attached nodes with supplied names will be hidden.

2. Call it with a dictionary (an object). In this case it behaves exactly like show_.

  .. code-block :: javascript

    var state = {main: true, opt: false};
    fm.hide(state);

  The example above shows ``"main"`` and hides ``"opt"``.

3. The ``state`` parameter is ``null``, or ``undefined``, or missing. In this case states of all known attached nodes will be hidden:

  .. code-block :: javascript

    fm.hide();

=====
Usage
=====

All three methods are designed to work together:

.. code-block :: javascript

  // collect the previous state of all attached nodes
  var state = fm.gatherDisplayState();

  // show the optional panel
  fm.show(["opt"]);
  
  // hide the main panel
  fm.hide(["main"]);

  // revert to the original state
  fm.show(state);
