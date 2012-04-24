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

Promises are the programming concept that allow programming of non-blocking asynchronous code in order to reduce program
latency. The ``dojo/promise`` module is Dojo's implementation of the concept. The module is made up of two main classes
``dojo/promise/Promise`` and ``dojo/promise/CancelError`` and three helper modules ``dojo/promise/all``,
``dojo/promise/first`` and ``dojo/promise/tracer``.

* :ref:`dojo/promise/Promise <dojo/promise/Promise>`

  The abstract base class that defines Dojo Promises.

* :ref:`dojo/promise/CancelError <dojo/promise/CancelError>`

  Defines the default error that will be raised if a promise is cancelled without a reason.

* :ref:`dojo/promise/all <dojo/promise/all>`

  Takes multiple promises and returns a new promise that is fulfilled when all promises have been fulfilled.

* :ref:`dojo/promise/first <dojo/promise/first>`

  Takes multiple promises and returns a new promise that is fulfilled when the first of the promises have been 
  fulfilled.

* :ref:`dojo/promise/tracer <dojo/promise/tracer>`

  Trace promise fulfillment. Traced promises will emit events.

See also
========

* `Futures and Promises Wikipedia Article <http://en.wikipedia.org/wiki/Futures_and_promises>`_

* :ref:`dojo/Deferred <dojo/Deferred>` - The class for managing asynchronous threads.

* :ref:`dojo/when <dojo/when>` - The module that allows seamless management of promises and other arbitrary values.