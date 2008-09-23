#format dojo_rst

dijit.form.Textarea
===================

:Status: Draft
:Version: 1.2

A Textarea widget is like a regular HTML textarea, but it dynamically resizes to fit the content of the text inside. It takes nearly all the parameters (*name*, *value*, etc.) that a vanilla textarea takes. The attribute *cols* is not supported since the width should be specified with style *width*. Also *rows* is not supported since this widget adjusts the height. It is especially useful in an `InlineEditBox <dijit/form/InlineEditBox>`_. Note that when declaring a Textarea in markup you should use a <textarea> node to preserve the newline formatting.

Examples
--------

First we will create a Textarea widget programatically. Notice how we pass the *style* and *value* parameters into the object creation.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.form.Textarea");
      dojo.addOnLoad(function(){
        var textarea = new dijit.form.Textarea({
          id: "textarea",
          value: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.",
          style: "width:200px;"
        },"textarea");
      });
    </script>

  .. cv:: html

    <textarea id="textarea" />

Here we'll create a Textarea widget declaratively.  In this instance, the initial *value* is the child text node of the TEXTAREA element.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.form.Textarea");
    </script>

  .. cv:: html

    <textarea id="textareaTwo" dojoType="dijit.form.Textarea" style="width:200px;">Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.</textarea> 
