.. _build/transforms/copy:

====================
Build Transform copy
====================

:Author: Rawld Gill

.. contents ::
   :depth: 2

Summary
=======

Copies a resource from a source location to a destination location.

Description
===========

This transform copies a resource from the discovered source location to the discovered destination location. On Windows,
the build-in command processor ``copy`` command is used; ``cp`` is used in all other environments.

Profile Knobs
=============

None.

Source Location
===============

util/build/transforms/copy.js
