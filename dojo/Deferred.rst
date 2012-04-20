.. _dojo/Deferred:

=============
dojo/Deferred
=============

:authors: Mark Wubben
:since: V1.8

.. contents ::
    :depth: 2

**dojo/Deferred** manages the communication between asynchronous threads (callbacks). Previously it resided in Dojo
Base, but in 1.8 it was rewritten based on the new Promise architecture and moved out of base. ``dojo/Deferred``
encapsulates a sequence of callbacks in response to a value that may not yet be available. All of ``dojo/request``
modules make use of this class.

Introduction
============

Usage
=====

Examples
========

See also
========
