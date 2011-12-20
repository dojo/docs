.. _dojox/form/manager/_EnableMixin:

===============================
dojox.form.manager._EnableMixin
===============================

:Project owner: Eugene Lazutkin
:since: 1.3

.. contents ::
   :depth: 3

Introduction
============

This class is the component of the form manager. It should be used together with :ref:`\_Mixin <dojox/form/manager/_Mixin>`.

The mixin provides commonly used methods to enable/disable form elements. It operates only on form widgets collected by :ref:`\_Mixin <dojox/form/manager/_Mixin>` and form nodes collected by :ref:`\_NodeMixin <dojox/form/manager/_NodeMixin>` (see :ref:`controlled elements <dojox/form/manager/index>` for more details).

Methods and properties
======================

This section describes all public methods and properties of the dojox.form.manager._EnableMixin class.

gatherEnableState
~~~~~~~~~~~~~~~~~

This method collects enable/disable state information in a dictionary object as Boolean values (``true`` means enabled). It is modeled after :ref:`\_ValueMixin's gatherFromValues() <dojox/form/manager/_ValueMixin>`.

There are three ways to use this method:

1. Call it with the array of names (represented by strings):

  .. js ::

    var names = ["firstName", "lastName"];
    var state = fm.gatherEnableState(names);

  Only supplied names will be collected.

2. Call it with a dictionary (an object). Only keys will be used, values will be ignored:

  .. js ::

    var names = {firstName: 1, lastName: 1};
    var state = fm.gatherEnableState(names);

  Only supplied names will be collected.

  This form is especially useful when we already collected values, and want to collect their enable/disable state:

  .. js ::

    var names = ["firstName", "lastName"];
    var values = fm.gatherFormValues(names);
    // later in the code
    var state  = fm.gatherEnableState(values);

3. The parameter is ``null``, or ``undefined``, or missing. In this case states of all known form elements will be collected:

  .. js ::

    var state = fm.gatherEnableState();

enable
~~~~~~

This method enables/disables form elements. It can take 0, 1 or 2 parameters described below, and returns the form manager itself for easy chaining.

There are three ways to use this method:

1. Call it with the array of names (represented by strings):

  .. js ::

    var names = ["firstName", "lastName"], defaultState = true;
    fm.enable(names, defaultState);

  All form elements with supplied names will be enabled or disabled according to the value of ``defaultState`` (``true`` means "enable").

  ``defaultState`` can be omitted. In this case it is assumed to be ``true``:

  .. js ::

    var names = ["firstName", "lastName"];
    fm.enable(names);

  The code above enables two form elements.

2. Call it with a dictionary (an object).

  .. js ::

    var state = {firstName: true, lastName: false};
    fm.enable(state);

  The example above enables ``"firstName"`` and disables ``"lastName"``.

3. The ``state`` parameter is ``null``, or ``undefined``. In this case states of all known form elements will be enabled or disabled according to the value of ``defaultState``:

  .. js ::

    var defaultState = true;
    fm.enable(null, defaultState);

  The code above enables all known form elements.

  ``defaultState`` can be omitted too. In this case it is assumed to be ``true``:

  .. js ::

    fm.enable();

  The code above enables all form elements.

disable
~~~~~~~

This method is complimentary to enable_. Just like enable_ it takes a state object but it always uses ``false`` (for "disable") as the default state. It can take 0, or 1 parameter described below, and returns the previous enable/disable state just like gatherEnableState_.

There are three ways to use this method:

1. Call it with the array of names (represented by strings):

  .. js ::

    var names = ["firstName", "lastName"];
    var oldState = fm.disable(names);

  All form elements with supplied names will be disabled.

2. Call it with a dictionary (an object). In this case it behaves exactly like enable_.

  .. js ::

    var state = {firstName: true, lastName: false};
    var oldState = fm.disable(state);

  The example above enables ``"firstName"`` and disables ``"lastName"``.

3. The ``state`` parameter is ``null``, or ``undefined``, or missing. In this case states of all known form elements will be disabled:

  .. js ::

    fm.disable();

Usage
=====

All three methods are designed to work together:

.. js ::

  // prepare to submit the form asynchronously

  // collect the previous state of all form elements
  var state = fm.gatherEnableState();

  // disable all form elements so user cannot change them
  // until we are finished with I/O
  fm.disable();

  // ... performing I/O ...

  // we got the response back => revert to the old state
  fm.enable(state);

or it can be done like that:

.. js ::

  // prepare to submit the form asynchronously

  // collect the previous state of all form elements and
  // disable all form elements so user cannot change them
  // until we are finished with I/O
  var state = fm.disable();

  // ... performing I/O ...

  // we got the response back => revert to the old state
  fm.enable(state);
