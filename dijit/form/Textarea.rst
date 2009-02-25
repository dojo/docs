#format dojo_rst

dijit.form.Textarea
===================

:Status: Draft
:Version: 1.0
:Authors: Doug Hays, Bill Keese, Nikolai Onken
:Developers: ?-
:Available: since V?

.. contents::
    :depth: 2

A Textarea widget is like a regular HTML textarea, but it dynamically resizes to fit the content of the text inside. It takes nearly all the parameters (*name*, *value*, etc.) that a vanilla textarea takes. The attribute *cols* is not supported since the width should be specified with style *width*. Also *rows* is not supported since this widget adjusts the height. It is especially useful in an `InlineEditBox <dijit/InlineEditBox>`_. Note that when declaring a Textarea in markup you should use a <textarea> node to preserve the newline formatting.


========
Examples
========

Programmatic example
--------------------

First we will create a Textarea widget programatically. Notice how we pass the *name*, *style* and *value* parameters into the object creation.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.form.Textarea");
      dojo.addOnLoad(function(){
        var textarea = new dijit.form.Textarea({
          name: "myarea",
          value: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.",
          style: "width:200px;"
        },"myarea");
      });
    </script>

  .. cv:: html

    <textarea id="myarea"></textarea>

Declarative example
-------------------

Here we'll create a Textarea widget declaratively. In this instance, the initial *value* is the child text node of the TEXTAREA element.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.form.Textarea");
    </script>

  .. cv:: html

    <textarea id="textarea2" nae="textarea2" dojoType="dijit.form.Textarea" style="width:200px;">Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.</textarea> 


=============
Accessibility
=============

Keyboard
--------

================================================  ==========   ===============
Action	                                          Key	       Comments
================================================  ==========   ===============
Move focus to the next widget in the tab order.   Tab
Move focus to the prior widget in the tab order.  Shift+Tab
Enter a newline into the text.                    Enter
Revert the last entry.                            Esc          If the user has not entered data, the Esc key is ignored.
================================================  ==========   ===============


Known Issues
------------

* On Firefox 2, the user must press the Tab key twice before keyboard focus moves to the next widget. (There is no problem when using Shift+Tab.) This is a permanent restriction on Firefox 2.
