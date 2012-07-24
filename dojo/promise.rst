.. _dojo/promise:

============
dojo/promise
============

:authors: Mark Wubben
:since: V1.8

.. contents ::
    :depth: 2

**dojo/promise** is the package that manages promises, or in other words, communication between asynchronous threads.

Introduction
============

Promises are the programming concept that allow easier programming of non-blocking asynchronous code. The ``dojo/promise`` module is Dojo's implementation of the concept. The module is made up ``dojo/promise/Promise`` and two helper modules ``dojo/promise/all`` and
``dojo/promise/first``. Related modules are ``dojo/Deferred``, ``dojo/when`` and ``dojo/errors/CancelError``.

* :ref:`dojo/promise/Promise <dojo/promise/Promise>`

  The abstract base class that defines Dojo Promises.

* :ref:`dojo/promise/all <dojo/promise/all>`

  Takes multiple promises and returns a new promise that is fulfilled when all promises have been fulfilled.

* :ref:`dojo/promise/first <dojo/promise/first>`

  Takes multiple promises and returns a new promise that is fulfilled when the first of the promises have been 
  fulfilled.

See also
========

* `Futures and Promises Wikipedia Article <http://en.wikipedia.org/wiki/Futures_and_promises>`_

* :ref:`dojo/Deferred <dojo/Deferred>` - The class for managing asynchronous threads.

* :ref:`dojo/when <dojo/when>` - The module that allows seamless management of promises and other arbitrary values.

* :ref:`dojo/errors/CancelError <dojo/errors/CancelError>` - Defines the default error that will be raised if a promise is canceled without a reason.
