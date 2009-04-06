#format dojo_rst

dijit.form.SimpleTextarea
=========================

:Status: Draft
:Version: 1.3
:Authors: Doug Hays, Bill Keese, Nikolai Onken
:Developers: Doug Hays, Bill Keese
:Available: since V1.0

.. contents::
    :depth: 2

A SimpleTextarea widget is an exact replacement for the native TEXTAREA element and was created to provide a thin widget wrapper that was necessary to interact with the `Form <dijit/form/Form>`_ widget, and to provide the ability to specify *rows* and *cols* attributes which are not available in the `Textarea <dijit/form/Textarea>`_ widget.  Unlike the `Textarea <dijit/form/Textarea>`_ widget, the height of this widget does not adjust to its content. It takes nearly all the parameters (*name*, *style*, etc.) that are available with a native TEXTAREA element.  Note that when declaring a SimpleTextarea in markup you should use a <textarea> node to preserve the newline formatting.  When specifying the *cols* attribute, you must also specify *style="width:auto;"* in order for the parameter to take effect.

========
Examples
========

Programmatic example
--------------------

First we will create a SimpleTextarea widget programatically. Notice how we pass the *name*, *rows* and *cols* parameters into the object creation.  The *value* attribute can be set with the widget's attr('value', text) method.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.form.SimpleTextarea");
      dojo.addOnLoad(function(){
        var textarea = new dijit.form.SimpleTextarea({
          name: "myarea",
          rows: "4",
          cols: "50",
          style: "width:auto;"
        },"myarea");
        textarea.attr('value','Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.');
      });
    </script>

  .. cv:: html

    <textarea id="myarea" />

Declarative example
-------------------

Here we'll create a SimpleTextarea widget declaratively.  In this instance, the initial *value* is the child text node of the TEXTAREA element.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.form.SimpleTextarea");
    </script>

  .. cv:: html

    <textarea id="textarea2" name="textarea2" dojoType="dijit.form.SimpleTextarea" rows="4" cols="50" style="width:auto;">Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.</textarea> 


=============
Accessibility
=============

Keyboard
--------

The SimpleTextarea widget uses native HTML TEXTAREA controls.
