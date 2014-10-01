.. _dijit/Destroyable:

=================
dijit/Destroyable
=================

.. contents ::
    :depth: 2

Introduction
============

dijit/Destroyable is used to track handles of an instance, and then destroy them when the instance is destroyed.
The application must call destroy() on the instance in order to release the handles.

Destroyable is one of the superclasses of _WidgetBase.

Usage
=====

.. js ::

    define([
        "dojo/aspect", "dojo/_base/declare", "dojo/dom-construct", "dojo/on",
        "dijit/Destroyable"
    ], function(aspect, declare, domConstruct, on,  Destroyable){

        ...

        var DestroyableSubClass = declare(Destroyable, {
            constructor: function(aStatefulObject){
                var self = this;
                this.domNode = domConstruct.create("button");
                this.own(
                    // setup an event handler (automatically remove() when I'm destroyed)
                    on(this.domNode, "click", function(){ ... }),

                    // watch external object (automatically unwatch() when I'm destroyed)
                    aStatefulObject.watch("x", function(name, oVal, nVal){ ... }),

                    // create a supporting (internal) widget, to be destroyed when I'm destroyed
                    new MySupportingWidget(...)
                );
            }
        });
    });

Handles
=======
``own()``'s arguments can be either Promises with ``cancel()`` methods, or any handles
with ``destroy()``, ``remove()``, or ``destroyRecursive()`` methods.