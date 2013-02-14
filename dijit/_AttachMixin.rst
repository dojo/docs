.. _dijit/_AttachMixin:

==================
dijit._AttachMixin
==================

TODOC!

.. contents ::
  :depth: 2

============
Introduction
============

`dijit/_AttachMixin` allows automatic attachment of attributes and event handlers for a dijit based on DOM node content.  The DOM nodes may be detached from the document, or already exist in the document.

This functionality is abstracted from :ref:`dijit/_TemplatedMixin` although historically this functionality was contained within that dijit.

=====
Usage
=====

Mixin `dijit/_AttachMixin` when you declare your dijit and direct it to use DOM nodes that contain suitable `data-dojo-attach-point` or `data-dojo-attach-event` properties:

.. html ::

    <div id="somenode"><a data-dojo-attach-point="anattachpoint"></div>


.. js ::

    var MyDijit = declare([ _WidgetBase, _AttachMixin ], {
        // .. declaration goes here ..
    })

You may also want to use :ref:`dijit/_WidgetsInTemplateMixin` to cause dijits in your DOM content, identified by having a `data-dojo-type` property, be parsed while your dijit is instantiated.

The `_srcNodeRef` of the dijit will be used as a basis for attaching.

**unfinished**