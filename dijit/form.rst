## page was renamed from 1.2/dijit/form
## page was renamed from dijit/form
#format dojo_rst

dijit.form
==========

:Status: Draft
:Version: 1.2

.. contents::
    :depth: 3

The dijit.form package contains "form widgets". What's a form widget? It roughly means a widget that appear inside a form, but technically we think of it as "anything that has a value".

The widgets can be used in a FORM tag, in a dijit.form.Form widget, or outside of a form.

Available Form Widgets
----------------------

The dijit.form widgets are:

=======
Buttons
=======

* `dijit.form.Button </Button>`_
* `dijit.form.DropDownButton </DropDownButton>`_ A button that displays a menu or some other popup when you press it.
* `dijit.form.ComboButton </ComboButton>`_
* `dijit.form.ToggleButton </ToggleButton>`_

=============
Input widgets 
=============

All Widgets, that are similar to <input>:

* `dijit.form.CurrencyTextBox </CurrencyTextBox>`_
* `dijit.form.DateTextBox </DateTextBox>`_
* `dijit.form.NumberSpinner </NumberSpinner>`_
* `dijit.form.NumberTextBox </NumberTextBox>`_
* `dijit.form.TextBox </TextBox>`_
* `dijit.form.TimeTextBox </TimeTextBox>`_
* `dijit.form.ValidationTextbox </ValidationTextbox>`_

========
TextArea
========

* `dijit.form.SimpleTextarea </SimpleTextarea>`_: simple wrapper of <textarea>; equivalent functionality
* `dijit.form.Textarea </Textarea>`_: auto expanding/contracting <textarea>

==============
Select widgets
==============

* `dijit.form.ComboBox </ComboBox>`_: this is often called "auto complete" and perhaps should be listed in the "Input widgets" section above since it allows the user to type any value and just gives suggested completions.
* `dijit.form.MultiSelect </MultiSelect>`_
* `dijit.form.FilteringSelect </FilteringSelect>`_: similar to a <select> but with type-ahead filtering of the drop down list.

=============
Miscellaneous
=============

* `dijit.form.Form </Form>`_: corresponds to a <form> itself; wraps other widgets
* `dijit.form.Slider </Slider>`_
* `dijit.form.CheckBox </CheckBox>`_
* `dijit.form.RadioButton </RadioButton>`_: to select one choice from a list

There are also some notable widgets in `dojox.form <dojox/form>`_ that complement the dijit.form pieces and will probably be incorporated into dijit eventually.

* TODO


Form validation
---------------

With Dojo Toolkit V1.2 the form widgets have been enhanced so that they won't turn yellow while the user is typing because the value they have is incomplete. However they will still turn yellow instantly if the value they are typing isn't valid (and can't be made valid by typing more characters). This change should provide good feedback to users.


Use Dijit Form Controls All Over!
---------------------------------

Because they're easy to mix and match, novice Dojo users often combine Dijit form controls with plain ol' HTML controls.  That's not good for several reasons:

* The Dijit form controls follow the Dijit Theme but plain HTML controls will not.  They will stick out like a sore thumb amongst other nicely-colored widgets.  
* dijit.form.Form and derived controls like Dialog can only deal with dijit.form widgets.

Never fear.  For every HTML control, there's a Dijit equivalent that does the same thing, and obeys most of the HTML attributes.

* <input type="text"> becomes dojoType="dijit.form.TextBox", dojoType="dijit.form.ValidationTextBox", dojoType="dijit.form.NumberTextBox", etc.
* <input type="checkbox"> becomes dojoType="dijit.form.Checkbox"
* <textarea> becomes dojoType="dijit.form.Textarea" or dojoType="dijit.form.SimpleTextArea"
* <select> becomes dojoType="dijit.FilteringSelect"
* <input type="radio"> becomes dojoType="dijit.form.RadioButton"
* <button> (or <input type="submit"> etc.) becomes dojotype="dijit.form.Button"


.. _mapped:


Mapped Form Controls
--------------------

Many of the form controls have a concept of "displayed value" vs. "serialized value" (aka the "real value"), which is the value passed to the server on form submit.  For example, a NumberSpinner may be declared like

.. code-block :: html

  <div dojoType=dijit.form.NumberSpinner value="1000">

(note the "value" keyword).  But when it's displayed in America it looks like "1,000" (with the comma).   And if they user types in "1,234,567", it gets sent back to the server as "123456789".

This is handled internally by having two <input> fields in the widget:

.. image:: MappedTextBox.gif

The upshot of this is that Dijit handles localization issues on the client, the server doesn't have to worry about it (except of course for translating the boilerplate text on the page, like the label for the above control).
