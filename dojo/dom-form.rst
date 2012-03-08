.. _dojo/dom-form:

=============
dojo/dom-form
=============

:Project owner:	Eugene Lazutkin
:since: V1.7

.. contents ::
    :depth: 2

This module defines form-processing functions.  The convention for the return variable for this module is ``domForm``.

Features
========

AMD Features
------------

* :ref:`domForm.fieldToObject <dojo/fieldToObject>`

  Serialize a form field to a JavaScript object.

* :ref:`domForm.toObject <dojo/formToObject>`

  Serialize a form node to a JavaScript object.

* :ref:`domForm.toQuery <dojo/formToQuery>`

  Returns a URL-encoded string representing the form passed as either a node or string ID identifying the form to
  serialize.

* :ref:`domForm.toJson <dojo/formToJson>`

  Create a serialized JSON string from a form node or string ID identifying the form to serialize.

Legacy features are set in :ref:`dojo/_base/xhr <dojo/_base/xhr>`.

Examples
========

See also
========

* :ref:`dojo/dom <dojo/dom>` - Core DOM API

* :ref:`dojo/_base/html <dojo/_base/xhr>` - Legacy API aliases

.. api-link :: dojo.dom-form

