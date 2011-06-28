#format dojo_rst

Dijit
=====

.. contents::
   :depth: 2

Dijit is Dojo's UI Library, and lives as a separate namespace ``dijit``. Dijit requires Dojo Core. Each of the widgets and functionality provided by Dijit are described in the following sections, though the aforementioned `quickstart <quickstart/index>`_ guides cover some basics.

* `About Dijit <dijit/info>`_

=======
Widgets
=======

* `dijit._Templated <dijit/_Templated>`_

  This is deprecated as of **1.7+**, `dijit._TemplatedMixin <dijit/_TemplatedMixin>`_ should be used instead and if necessary `dijit._WidgetsInTemplateMixin <dijit/_WidgetsInTemplateMixin>`_

* `dijit._TemplatedMixin <dijit/_TemplatedMixin>`_
* `dijit._WidgetsInTemplateMixin <dijit/_WidgetsInTemplateMixin>`_
* `dijit._Widget <dijit/_Widget>`_

  * `a11y  <dijit/a11y/index>`_

    * `a11y Strategy <dijit/a11y/strategy>`_
    * `a11y Resources <dijit/a11y/resources>`_
    * `Creating Accessible Widgets <quickstart/writingWidgets/a11y>`_
    * `Testing for Accessibility <quickstart/writingWidgets/a11yTesting>`_
    * `a11y Requirements <developer/a11y-requirements>`_
    * `a11y Statement <dijit/a11y/statement>`_

  * `Themes and Theming <dijit/themes>`_

* `dijit._CssStateMixin <dijit/_CssStateMixin>`_
* `dijit.Calendar <dijit/Calendar>`_
* `dijit.CalendarLite <dijit/CalendarLite>`_

  **1.7+** A lighter version of `dijit.Calendar <dijit/Calendar>`_, more geared for mobile devices (e.g. does not have keyboard navigation)

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
Form Handling
=============

* `dijit.form <dijit/form>`_

  * Text Boxes

    * `dijit.form.CurrencyTextBox <dijit/form/CurrencyTextBox>`_

      A specialized input widget for monetary values, much like the currency type in spreadsheet programs

    * `dijit.form.DateTextBox <dijit/form/DateTextBox>`_

      An easy-to-use date entry control which allows either typing or choosing a date from any calendar widget

    * `dijit.form.MappedTextBox <dijit/form/MappedTextBox>`_

      A subclass of `dijit.form.ValidationTextBox <dijit/form/ValidationTextBox>`_ that is designed to be a base class for widgets that have a visible formatted display value, and a serializable value in a hidden input field which is actually sent to the server.

    * `dijit.form.NumberSpinner <dijit/form/NumberSpinner>`_

      A input widget which restricts input to numeric input and offers down and up arrow buttons to "spin" the number up and down

    * `dijit.form.NumberTextBox <dijit/form/NumberTextBox>`_

      A input widget which restricts input to numeric input

    * `dijit.form.RangeBoundTextBox <dijit/form/RangeBoundTextBox>`_

      A base class for textbox form widgets which define a range of valid values.

    * `dijit.form.SimpleTextarea <dijit/form/SimpleTextarea>`_

      A simple wrapper of <textarea>; equivalent functionality

    * `dijit.form.Textarea <dijit/form/Textarea>`_

      An auto expanding/contracting <textarea>

    * `dijit.form.TextBox <dijit/form/TextBox>`_

      A basic <input type="text">-style form control

    * `dijit.form.TimeTextBox <dijit/form/TimeTextBox>`_

      A time input control which allows either typing or choosing a time from any time-picker widget

    * `dijit.form.ValidationTextBox <dijit/form/ValidationTextBox>`_

      A class for textbox widgets with the ability to validate content of various types and provide user feedback.

  * Select Type Widgets

    * `dijit.form.Select <dijit/form/Select>`_

      A styleable drop-down select box (similar to ``<select>``)

    * `dijit.form.ComboBox <dijit/form/ComboBox>`_

      An "auto complete", which allows the user to type any value and just gives suggested completions

    * `dijit.form.FilteringSelect <dijit/form/FilteringSelect>`_

      Similar to a ``<select>`` but with type-ahead filtering of the drop down list

    * `dijit.form.MultiSelect <dijit/form/MultiSelect>`_

      Allows the selection of multiple items (similar to ``<select multiple>``)

  * Buttons

    * `dijit.form.Button <dijit/form/Button>`_

      A representation of a normal <button> or <input type="submit/reset/button" />

    * `dijit.form.ComboButton <dijit/form/ComboButton>`_

      A button with an arrow to show a drop down (often a menu)

    * `dijit.form.DropDownButton <dijit/form/DropDownButton>`_

      A button which displays a menu or some other popup when you press it

    * `dijit.form.ToggleButton <dijit/form/ToggleButton>`_

      A cross between a Button and a Checkbox widget

  * Other Form Widgets

    * `dijit.form.CheckBox <dijit/form/CheckBox>`_

      Nearly the same as an HTML checkbox, but with fancy styling

    * `dijit.form.Form <dijit/form/Form>`_

      Corresponds to a <form> itself; wraps other widgets

    * `dijit.form.HorizontalRule <dijit/form/HorizontalRule>`_

      Horizontal ruler to use with a `dijit.form.HorizontalSlider <dijit/form/HorizontalSlider>`_.

    * `dijit.form.HorizontalRuleLabels <dijit/form/HorizontalRuleLabels>`_

      Horizontal ruler labels to use with a `dijit.form.HorizontalSlider <dijit/form/HorizontalSlider>`_.

    * `dijit.form.HorizontalSlider <dijit/form/HorizontalSlider>`_

      A scale with a handle you can drag left or right to select a value.

    * `dijit.form.RadioButton <dijit/form/RadioButton>`_

      To select one choice from a list

    * `dijit.form.Slider <dijit/form/Slider>`_

      **DEPRECATED** A scale with a handle you can drag up/down or left/right to select a value.  Require `dijit.form.HorizontalSlider <dijit/form/HorizontalSlider>`_ and `dijit.form.VerticalSlider <dijit/form/VerticalSlider>`_ explicitly.

    * `dijit.form.VerticalRule <dijit/form/VerticalRule>`_

      Vertical ruler to use with a `dijit.form.VerticalSlider <dijit/form/VerticalSlider>`_.

    * `dijit.form.VerticalRuleLabels <dijit/form/VerticalRuleLabels>`_

      Vertical ruler labels to use with a `dijit.form.VerticalSlider <dijit/form/VerticalSlider>`_.

    * `dijit.form.VerticalSlider <dijit/form/VerticalSlider>`_

      A vertical scale with a handle you can drag up or down to select a value.

======
Layout
======

* `dijit.layout <dijit/layout>`_

  * `dijit.layout._LayoutWidget <dijit/layout/_LayoutWidget>`_
  * `dijit.layout.AccordionContainer <dijit/layout/AccordionContainer>`_
  * `dijit.layout.BorderContainer <dijit/layout/BorderContainer>`_
  * `dijit.layout.ContentPane <dijit/layout/ContentPane>`_
  * `dijit.layout.LinkPane <dijit/layout/LinkPane>`_
  * `dijit.layout.StackContainer <dijit/layout/StackContainer>`_
  * `dijit.layout.TabContainer <dijit/layout/TabContainer>`_

=====================================
Note about programmatic instantiation
=====================================

For most of the dijit widgets, you can provide a ``refNode`` which is a placeholder to position your node. Beware that any attribute set on it (form action, input value, `etc`.) won't be taken into account. If you want to degrade nicely and have a non-JS compatible version of your site and avoid duplicating attributes on controls and on instantiation, you should use ``dojo.parser``:

.. code-block :: javascript

 // All attributes of myNode will be preserved in the widget
 dojo.parser.instantiate([ myNode ], {
   dojoType: "dijit.form.ValidationTextBox",
   dojoSpecificAttr1: value,
   dojoSpecificAttr2: value
 })
