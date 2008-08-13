## page was renamed from 1.2/dijit/form
## page was renamed from dijit/form
#format dojo_rst

dijit.form
==========

:Status: Draft
:Version: 1.2

The following widgets can be used in a FORM tag, in a dijit.form.Form widget, or outside of a form.

* `dijit.form.Button <form/Button>`_
* `dijit.form.CheckBox <form/CheckBox>`_
* `dijit.form.ComboBox <form/ComboBox>`_
* `dijit.form.CurrencyTextBox <form/CurrencyTextBox>`_
* `dijit.form.DateTextBox <form/DateTextBox>`_
* `dijit.form.FilteringSelect <form/FilteringSelect>`_
* `dijit.form.Form <form/Form>`_
* `dijit.form.MultiSelect <form/MultiSelect>`_
* `dijit.form.NumberSpinner <form/NumberSpinner>`_
* `dijit.form.NumberTextBox <form/NumberTextBox>`_
* `dijit.form.SimpleTextarea <form/SimpleTextarea>`_
* `dijit.form.Slider <form/Slider>`_
* `dijit.form.Textarea <form/Textarea>`_
* `dijit.form.TextBox <form/TextBox>`_
* `dijit.form.TimeTextBox <form/TimeTextBox>`_
* `dijit.form.ValidationTextbox <form/ValidationTextbox>`_

Use Dijit Form Controls All Over!
---------------------------------

Because they're easy to mix and match, novice Dojo users often combine Dijit form controls with plain ol' HTML controls.  That's not good for several reasons:

* The Dijit form controls follow the Dijit Theme but plain HTML controls will not.  They will stick out like a sore thumb amongst other nicely-colored widgets.  
* TODO: Think of some other things

Never fear.  For every HTML control, there's a Dijit equivalent that does the same thing, and obeys most of the HTML attributes.

* <input type="text"> becomes dojoType="dijit.form.TextBox"
* <input type="checkbox"> becomes dojoType="dijit.form.Checkbox"
* <textarea> becomes dojoType="dijit.form.TextArea"
* <select> becomes dojoType="dijit.FilteringSelect"
* <input type="radio"> becomes TODO



Mapped Form Controls
--------------------

The following form controls are variations on <input type="text">.  

LIST

.. image:: MappedTextBox.gif
