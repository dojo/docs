.. _dojox/mobile/scrollable:

=======================
dojox/mobile/scrollable
=======================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.7

.. contents ::
    :depth: 2

Introduction
============

The dojox/mobile/scrollable module defines a mixin for enabling touch scrolling capability.

Mobile WebKit browsers do not allow scrolling inner DIVs. (For instance,
on iOS you need the two-finger operation to scroll them.)
That means you cannot have fixed-positioned header/footer bars.
To solve this issue, this module disables the browsers default scrolling
behavior, and rebuilds its own scrolling machinery by handling touch
events.

Usage
=====

You will typically not use this module directly, you will use one the dojox/mobile widgets that inherit from it:
:ref:`ScrollableView <dojox/mobile/ScrollableView>`,
:ref:`SwapView <dojox/mobile/SwapView>`,
:ref:`ScrollablePane <dojox/mobile/ScrollablePane>` or
:ref:`SpinWheel <dojox/mobile/SpinWheel>`.
