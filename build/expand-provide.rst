.. _build/expand-provide:

============================
Expanding dojo.provide calls
============================

:since: V1.3

.. contents ::
   :depth: 2

Expands dojo.provide calls with faster calls at the expense of a larger file size in built layers.

Introduction
============

The Dojo Build provides a mechanism for expanding :ref:`dojo.provide <dojo/provide>` calls within your code into faster JavaScript equivalents, avoiding expensive lookups through :ref:`dojo.getObject <dojo/getObject>` when it is otherwise safe to assume. This is a simple toggle on a build command line or profile called "expandProvide", and defaults to 'false'.

Usage
=====

Only use the option if your profiling reveals that dojo.provide calls are taking a noticeable amount of time. It replaces dojo.provide("foo.bar") statements with the shortest valid programmatic equivalent:

.. js ::
  
  if(typeof foo=="undefined"){foo={};};foo.bar=foo.bar||{};

Simply pass the parameter as a command line argument:

.. js ::
  
  ~/dojo/util/buildscripts $ ./build.sh action=release expandProvide=true version=1.3.0 profile=standard

Or mix the option into your profile:

.. js ::
  
    dependencies = {
        // expand dojo.provide calls
        expandProvide: true,

        // rest of profile:
        layers: [{ /* ... */ }],
        prefixes: [
            [ "dijit", "../dijit" ],
            [ "dojox", "../dojox" ]
        ]
    }
