#format dojo_rst

dijit.form.Textarea
===================

:Status: Draft
:Version: 1.2

A Textarea widget is like a regular HTML textarea, but it dynamically resizes to fit the content of the text inside. It takes nearly all the parameters (name, value, etc.) that a vanilla textarea takes. Cols is not supported and the width should be specified with style width. Rows is not supported since this widget adjusts the height. It is especially useful in an `InlineEditBox <dijit/form/InlineEditBox>`_. Note that when declaring a Textarea in markup you should use a <textarea> node to preserve the newline formatting.

Examples
--------

First of all we will create a textarea programatically

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.form.Textarea");
      dojo.addOnLoad(function(){
        var textarea = new dijit.form.Textarea({
          id: "textarea"
        },"textarea");
      });
    </script>

  .. cv:: html

    <textarea id="textarea" />

Here we'll create a textarea declaratively

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.form.Textarea");
    </script>

  .. cv:: html

    <textarea id="textareaTwo" dojoType="dijit.form.Textarea" />
