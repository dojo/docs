#format dojo_rst

Dijit
=====

.. contents::
   :depth: 2

Dijit is Dojo's UI Library, and lives as a separate namespace ``dijit``. Dijit requires Dojo Core. Each of the widgets and functionality provided by Dijit is describe in the following sections, though the aforementioned `quickstart <quickstart/index>`_ guides cover some basics.

* `About Dijit <dijit/info>`_


=======
Widgets
=======

* `dijit._Templated <dijit/_Templated>`_
* `dijit._Widget <dijit/_Widget>`_

  * `a11y  <dijit-a11y>`_

    * `a11y Strategy <dijit-a11y-strategy>`_
    * `a11y Resources <dijit-a11y-resources>`_
    * `Creating Accessible Widgets <quickstart/writingWidgets/a11y>`_
    * `Testing for Accessibility <quickstart/writingWidgets/a11yTesting>`_
    * `a11y Requirements <dijit-a11y-req>`_
    * `a11y Statement <dijit-a11y-statement>`_

* `dijit.Calendar <dijit/Calendar>`_
* `dijit.ColorPalette <dijit/ColorPalette>`_
* `dijit.Declaration <dijit/Declaration>`_
* `dijit.Dialog <dijit/Dialog>`_
* `dijit.Editor <dijit/Editor>`_
* `dijit.InlineEditBox <dijit/InlineEditBox>`_
* `dijit.Menu <dijit/Menu>`_
* `dijit.MenuBar <dijit/MenuBar>`_
* `dijit.ProgressBar <dijit/ProgressBar>`_
* `dijit.TitlePane <dijit/TitlePane>`_
* `dijit.Toolbar <dijit/Toolbar>`_
* `dijit.Tooltip <dijit/Tooltip>`_
* `dijit.TooltipDialog <dijit/TooltipDialog>`_
* `dijit.Tree <dijit/Tree>`_

  * `Model <dijit/tree/Model>`_
  * `TreeStoreModel <dijit/tree/TreeStoreModel>`_
  * `ForestStoreModel <dijit/tree/ForestStoreModel>`_


=============
Form handling
=============

* `dijit.form <dijit/form>`_

  * text boxes

    * `dijit.form.CurrencyTextBox <dijit/form/CurrencyTextBox>`_

      A specialized input widget for monetary values, much like the currency type in spreadsheet programs

    * `dijit.form.DateTextBox <dijit/form/DateTextBox>`_

      An easy-to-use date entry control which allows either typing or choosing a date from any calendar widget

    * `dijit.form.NumberSpinner <dijit/form/NumberSpinner>`_

      A input widget which restricts input to numeric input and offers down and up arrow buttons to "spin" the number up and down

    * `dijit.form.NumberTextBox <dijit/form/NumberTextBox>`_

      A input widget which restricts input to numeric input

    * `dijit.form.SimpleTextarea <dijit/form/SimpleTextarea>`_

      A simple wrapper of <textarea>; equivalent functionality

    * `dijit.form.Textarea <dijit/form/Textarea>`_

      An auto expanding/contracting <textarea>

    * `dijit.form.TextBox <dijit/form/TextBox>`_

      A basic <input type="text">-style form control

    * `dijit.form.TimeTextBox <dijit/form/TimeTextBox>`_

      A time input control which allows either typing or choosing a time from any time-picker widget

    * `dijit.form.ValidationTextBox <dijit/form/ValidationTextBox>`_

  * select type widgets

    * `dijit.form.ComboBox <dijit/form/ComboBox>`_

      A "auto complete", which allows the user to type any value and just gives suggested completions

    * `dijit.form.MultiSelect <dijit/form/MultiSelect>`_

      The MultiSelect widget allows the selection of multiple items

    * `dijit.form.FilteringSelect <dijit/form/FilteringSelect>`_

      Similar to a <select> but with type-ahead filtering of the drop down list

  * buttons

    * `dijit.form.Button <dijit/form/Button>`_

      A representation of a normal <button> or <input type="submit/reset/button" />

    * `dijit.form.ComboButton <dijit/form/ComboButton>`_

      A button with an arrow to show a drop down (often a menu)

    * `dijit.form.DropDownButton <dijit/form/DropDownButton>`_

      A button which displays a menu or some other popup when you press it

    * `dijit.form.ToggleButton <dijit/form/ToggleButton>`_

      A cross between a Button and a Checkbox widget

  * other controls

    * `dijit.form.CheckBox <dijit/form/CheckBox>`_

      Nearly the same as an HTML checkbox, but with fancy styling

    * `dijit.form.Form <dijit/form/Form>`_

      Corresponds to a <form> itself; wraps other widgets

    * `dijit.form.RadioButton <dijit/form/RadioButton>`_

      To select one choice from a list

    * `dijit.form.Slider <dijit/form/Slider>`_

      A scale with a handle you can drag up/down or left/right to select a value


======
Layout
======

* `dijit.layout <dijit/layout>`_

  * `dijit.layout._LayoutWidget <dijit/layout/_LayoutWidget>`_
  * `dijit.layout.AccordionContainer <dijit/layout/AccordionContainer>`_
  * `dijit.layout.BorderContainer <dijit/layout/BorderContainer>`_
  * `dijit.layout.ContentPane <dijit/layout/ContentPane>`_
  * `dijit.layout.StackContainer <dijit/layout/StackContainer>`_
  * `dijit.layout.TabContainer <dijit/layout/TabContainer>`_
