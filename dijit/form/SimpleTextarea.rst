.. _dijit/form/SimpleTextarea:

=========================
dijit/form/SimpleTextarea
=========================

:Authors: Doug Hays, Bill Keese, Nikolai Onken
:Developers: Doug Hays, Bill Keese
:since: V1.0

.. contents ::
    :depth: 2

A SimpleTextarea widget is an exact replacement for the native textarea HTML element and was created to provide
a thin widget wrapper that was necessary to interact with the :ref:`Form <dijit/form/Form>` widget,
and to provide the ability to specify *rows* and *cols* attributes
which are not available in the :ref:`Textarea <dijit/form/Textarea>` widget.
Unlike the :ref:`Textarea <dijit/form/Textarea>` widget, the height of this widget does not adjust to its content.
It takes nearly all the parameters (*name*, *style*, etc.) that are available with a native textarea HTML element.
Note that when declaring a SimpleTextarea in markup you should use a <textarea> node to preserve the newline formatting.
When specifying the *cols* attribute, you must also specify *style="width:auto;"* in order for the parameter to take effect.

Examples
========

Programmatic example
--------------------

First we will create a SimpleTextarea widget programmatically.
Notice how we pass the *name*, *rows* and *cols* parameters into the object creation.
The *value* attribute can be set with the widget's set('value', text) method.

.. code-example ::
  :djConfig: async: true

  .. js ::

    require(["dijit/form/SimpleTextarea", "dojo/domReady!"], function(SimpleTextarea){
        var textarea = new SimpleTextarea({
            name: "myarea",
            rows: "4",
            cols: "50",
            style: "width:auto;"
        }, "myarea");
        textarea.startup();
        textarea.set("value", "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.");
    });

  .. html ::

    <textarea id="myarea">

Declarative example
-------------------

Here we'll create a SimpleTextarea widget declaratively.
In this instance, the initial *value* is the child text node of the textarea element.

.. code-example ::
  :djConfig: async: true

  .. js ::

    require(["dojo/parser", "dijit/form/SimpleTextarea"]);

  .. html ::

    <textarea id="textarea2" name="textarea2" data-dojo-type="dijit/form/SimpleTextarea" rows="4" cols="50" style="width:auto;">Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.</textarea>