.. _dojo/promise/Promise:

====================
dojo/promise/Promise
====================

:authors: Mark Wubben
:since: V1.8

.. contents ::
    :depth: 2

**dojo/promise/Promise** is the abstract base class that defines Dojo Promises.

Introduction
============

**dojo/promise/Promise** defines the Dojo Promises API and is an abstract class.  :ref:`dojo/Deferred <dojo/Deferred>` for example implements the class.  The class is intended to encapsulate communication between asynchronous threads.

Usage
=====

Since it is an abstract class, direct usage doesn't make sense.  Developers want to create asynchronous processes should inherit from this class and implement the abstract methods:

.. js ::

  define(["dojo/promise/Promise", "dojo/_base/declare"], function(Promise, declare){
    return declare([Promise], {
      then: function(){
        // Implementation of .then()
      },
      cancel: function(){
        // Implementation of .cancel()
      },
      isResolved: function(){
        // Implementation of .isResolved()
      },
      isRejected: function(){
        // Implementation of .isRejected()
      },
      isFulfilled: function(){
        // Implementation of .isFulfilled()
      },
      isCanceled: function(){
        // Implementation of .isCanceled()
      }
    });
  });

The API is defined below:

then()
------

Adds callbacks to the Promise, takes the following arguments:

======== ========= =================================================================
Argument Type      Description
======== ========= =================================================================
callback Function? The function that should be called when the promise is resolved.
errback  Function? The function that should be called when the promise is rejected.
progback Function? The function that should be called when the promise has progress.
======== ========= =================================================================

Should return a new promise with the callbacks applied.

cancel()
--------

Lets a consumer of a promise signal that it is no longer interested in the result. A deferred should also cancel the
operation if possible. It takes a single argument:

======== ====== ==========================================================================
Argument Type   Description
======== ====== ==========================================================================
reason   Mixed? May be sent to the deferred's canceller as the reason for the cancellation
======== ====== ==========================================================================

isResolved()
------------

Should return ``true`` if the promise is resolved, otherwise ``false``.

isRejected()
------------

Should return ``true`` if the promise has been rejected, otherwise ``false``.

isFulfilled()
-------------

Should return ``true`` if the promise is fulfilled (resolve, rejected or cancelled), otherwise ``false``.

isCanceled()
------------

Should return ``true`` if the promise has been cancelled, otherwise ``false``.

otherwise()
------

Adds an error callback to a promise and should return a promise with the error callback applied. It takes a single
argument:

======== ========= ================================================================
Argument Type      Description
======== ========= ================================================================
errback  Function? The function that should be called when the promise is rejected.
======== ========= ================================================================

always()
------

Adds a single callback to operate in the case of resolution or rejection.  It takes a single argument:

================= ========= ==============================================================
Argument          Type      Description
================= ========= ==============================================================
callbackOrErrback Function? The function that should be called on resolution or rejection.
================= ========= ==============================================================

trace()
-------

Trace the promise. Any supplied arguments are emitted in trace events. It returns the original promise.

traceRejected()
---------------

Trace rejection of the promise. Any supplied arguments are emitted in trace events. It returns the original promise.

See also
========

* :ref:`dojo/promise <dojo/promise>` - The rest of the Dojo Promise API

* :ref:`dojo/Deferred <dojo/Deferred>` - An implementation of the the Promise class

* :ref:`dojo/when <dojo/when>` - Used for transparently managing promises and other arbitrary values

