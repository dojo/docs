.. _dijit/_WidgetsInTemplateMixin:

=============================
dijit._WidgetsInTemplateMixin
=============================

:Authors: Peter Higgins, Bill Keese, Nikolai Onken
:Project owner: Bill Keese
:since: V1.7

.. contents ::
   :depth: 2

Description
===========

The :ref:`_TemplatedMixin <dijit/_TemplatedMixin>` page describes how to make widgets with templates.

But what if we want to have a widget inside of the template, as in:

.. html ::

  <div class="combinedDateTime">
     <div data-dojo-type="dijit/form/DateTextBox"></div>
     <div data-dojo-type="dijit/form/TimeTextBox"></div>
  </div>

When using this template in a directly extended widget class, you will need to mixin :ref:`dijit._WidgetsInTemplateMixin <dijit/_WidgetsInTemplateMixin>`  in addition to :ref:`dijit._TemplatedMixin <dijit/_TemplatedMixin>`.

Note that :ref:`dijit.Declaration <dijit/Declaration>`-based widget classes automatically include :ref:`dijit._WidgetsInTemplateMixin <dijit/_WidgetsInTemplateMixin>`

data-dojo-attach-point
----------------------

In this case, the data-dojo-attach-point becomes a pointer to the sub-widget, not to a DOM node.
For example, with this template:

.. html ::

  <div class="combinedDateTime">
     <div data-dojo-type="dijit/form/DateTextBox" data-dojo-attach-point="start"></div>
     <div data-dojo-type="dijit/form/TimeTextBox" data-dojo-attach-point="end"></div>
  </div>

You can do this in your widget code:

.. js ::

  this.start.set('value', new Date());


data-dojo-attach-event
----------------------

data-dojo-attach-event also functions to attach a widget event (not a DOM event) on the sub widget to the main widget.
For example, consider InlineEditBox which embeds dijit buttons into it's own template:

.. html ::

  <fieldset data-dojo-attach-point="editNode" role="presentation" style="position: absolute; visibility:hidden" class="dijitReset dijitInline"
    data-dojo-attach-event="onkeypress: _onKeyPress"
    ><div data-dojo-attach-point="editorPlaceholder"></div
    ><span data-dojo-attach-point="buttonContainer"
        ><button class='saveButton' data-dojo-attach-point="saveButton"
                data-dojo-type="dijit/form/Button" data-dojo-attach-event="onClick:save" disabled="true">
            ${buttonSave}
        </button
        ><button class='cancelButton' data-dojo-attach-point="cancelButton"
                data-dojo-type="dijit/form/Button" data-dojo-attach-event="onClick:cancel">
            ${buttonCancel}
        </button
    ></span
  ></fieldset>

The onClick event on the dijit.form.Button will call InlineEditBox.save().


The :ref:`dijit._WidgetsInTemplateMixin <dijit/_WidgetsInTemplateMixin>` mixin does not support adding layout widgets as children.
In particular there are issues with startup() and resize() calls to the children.

Also note that a widget's getChildren() method and similar methods will *not* include the widgets declared in the template, but rather just the widgets inside the containerNode.
This is because the widgets declared in the template are internal objects, effectively hidden from widget users.
In other words, only the developer of the widget knows that it internally contains widgets.


Common Pitfalls
===============

1. Don't try to make the root node itself a widget. That's not supported (that would make the top node the root of two separate widgets and we can't support that).


See also
========

* :ref:`Writing Widgets <quickstart/writingWidgets>`
