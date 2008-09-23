#format dojo_rst

dijit.InlineEditBox
===================

.. contents::
    :depth: 2

:Status: Draft
:Version: 1.2
:Authors: Bill Keese

InlineEditBox is best described as a behavior on some text on the page, such that clicking that text brings up an editor, and when the text is saved, the screen is reverted to it's original state (but with the new text). The editor is created on-demand, so as to not slow down page load.


Programatic InlineEditBox
-------------------------

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.InlineEditBox");
      dojo.require("dijit.form.Textarea");

      var eb;
      dojo.addOnLoad(function(){
	  eb = new dijit.InlineEditBox({
            editor: "dijit.form.Textarea",
            autosave: false
          }, "ieb");
      });
    </script>

  .. cv:: html

    <div id="ieb">
      When you click on this div you'll be able to edit it (in plain text).
      The editor's size will initially match the size of the (original) text, but will expand/contract as you type.
    </div>

Note that it was created with autoSave=false to make save/cancel buttons appear.
Otherwise, the return key will end the edit, which is not appropriate for a multi-line edit.

Markup
------
Creation from markup is even easier.  Here's an example with an initial value.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.InlineEditBox");
      dojo.require("dijit.form.NumberSpinner");
    </script>

  .. cv:: html

    <span dojoType="dijit.InlineEditBox" editor="dijit.form.NumberSpinner" editorParams="{constraints: {places:0} }" width="70px" title="quantity">15</span>

Initial blank value
-------------------
If the InlineEditBox has no value it displays an icon so that the user has something to click to start the edit.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.InlineEditBox");
      dojo.require("dijit.form.NumberTextBox");
    </script>

  .. cv:: html

    <span dojoType="dijit.InlineEditBox" editor="dijit.form.NumberTextBox" title="quantity"></span>


Notes on i18n
-------------
Note that the web server is responsible for the initial formatting of the data.
For example, if you are display a large number, it would be formatted as 123,456,789.55 in the United States but as 123.456.789,00 in some European countries.   InlineEditBox expects the number to be formatted in the page's locale and will fail if it can't parse it according to that locale.
