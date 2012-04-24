.. _dojo/promise/CancelError:

========================
dojo/promise/CancelError
========================

:authors: Mark Wubben
:since: V1.8

.. contents ::
    :depth: 2

**dojo/promise/CancelError** is the default error if a promise is canceled without a reason.

Introduction
============

If strict is enabled on a :ref:`dojo/Deferred <dojo/Deferred>` this is the default error that will be thrown if a promise is cancelled without a reason.

See also
========

* :ref:`dojo/promise <dojo/promise>` - The rest of the Dojo Promise API.

* :ref:`dojo/Deferred <dojo/Deferred>` - The base class for managing asynchronous thread communication in Dojo.