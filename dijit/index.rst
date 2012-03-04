.. _dijit/index:

==============
Dijit Overview
==============

.. contents ::
   :depth: 2

**Dijit** is Dojo's UI Library, and lives as a separate namespace ``dijit``. Dijit requires :ref:`Dojo Core <dojo/#dojo-core>` and :ref:`Dojo Base <dojo/_base>`.

Each of the widgets and functionality provided by Dijit are described in the following sections, though the the
:ref:`quickstart <quickstart>` guides and the `Tutorials <http://dojotoolkit.org/documentation/>`_ cover some basics.

General Information
===================

* :ref:`About Dijit <dijit/info>`

* :ref:`Themes and Theming <dijit/themes>`

* :ref:`Accessibility (a11y) <dijit/a11y>`

  * :ref:`a11y Strategy <dijit/a11y/strategy>`

  * :ref:`a11y Resources <dijit/a11y/resources>`

  * :ref:`Creating Accessible Widgets <quickstart/writingWidgets/a11y>`

  * :ref:`Testing for Accessibility <quickstart/writingWidgets/a11yTesting>`

  * :ref:`a11y Requirements <developer/a11y-requirements>`

  * :ref:`a11y Statement <dijit/a11y/statement>`

Base Utilities
==============

* :ref:`dijit/_base <dijit/_base/>` **STUB**

  * :ref:`dijit/_base/focus <dijit/_base/focus>` **COPIED**

  * :ref:`dijit/_base/place <dijit/_base/place>` **COPIED**

  * :ref:`dijit/_base/popup <dijit/_base/popup>` **COPIED**

  * :ref:`dijit/_base/typematic <dijit/_base/typematic>` **COPIED**

  * :ref:`dijit/_base/manager <dijit/_base/manager>` **STUB**

  * :ref:`dijit/_base/scroll <dijit/_base/scroll>` **STUB**

  * :ref:`dijit/_base/sniff <dijit/_base/sniff>` **STUB**

  * :ref:`dijit/_base/wai <dijit/_base/wai>` **STUB**

  * :ref:`dijit/_base/window <dijit/_base/window>` **STUB**

Utility Classes
===============

Utility methods and classes used by widgets or by applications with widgets.

* :ref:`dijit.focus <dijit/focus>` - keeps track of focused node and active widgets

* :ref:`dijit.hccss <dijit/hccss>` - for detecting when IE or FF is in high contrast (aka no background images) mode

* :ref:`dijit.place <dijit/place>` - low level code for positioning popups / drop downs

* :ref:`dijit.popup <dijit/popup>` - high level library routines for positioning popups / drop downs

* :ref:`dijit.registry <dijit/registry>` - registry of all widgets on the page

* :ref:`dijit.typematic <dijit/typematic>` - for normalizing key-repeat across browsers, plus simulation "mouse-repeat"

Infrastructure Widgets
======================

* :ref:`dijit._WidgetBase <dijit/_WidgetBase>` (and also deprecated :ref:`dijit._Widget <dijit/_Widget>`)

* :ref:`dijit._TemplatedMixin <dijit/_TemplatedMixin>` (and also deprecated :ref:`dijit._Templated <dijit/_Templated>`)

* :ref:`dijit._WidgetsInTemplateMixin <dijit/_WidgetsInTemplateMixin>`

* :ref:`dijit._CssStateMixin <dijit/_CssStateMixin>`

* :ref:`dijit._FocusMixin <dijit/_FocusMixin>`

* :ref:`dijit._HasDropDown <dijit/_HasDropDown>`

* :ref:`dijit._OnDijitClickMixin <dijit/_OnDijitClickMixin>`

* :ref:`dijit._BidiSupport <dijit/_BidiSupport>` **STUB**

* :ref:`dijit._Calendar <dijit/_Calendar>` **STUB**

* :ref:`dijit._Contained <dijit/_Contained>` **STUB**

* :ref:`dijit._Container <dijit/_Container>` **STUB**

* :ref:`dijit._DialogMixin <dijit/_DialogMixin>` **STUB**

* :ref:`dijit._KeyNavContainer <dijit/_KeyNavContainer>` **STUB**

* :ref:`dijit._MenuBase <dijit/_MenuBase>` **STUB**

* :ref:`dijit._PaletteMixin <dijit/_PaletteMixin>` **STUB**

* :ref:`dijit._TimePicker <dijit/_TimePicker>` **STUB**

Menu Widgets
============
These are the main Menu widgets:

* :ref:`dijit.DropDownMenu <dijit/DropDownMenu>`

* :ref:`dijit.Menu <dijit/Menu>`

* :ref:`dijit.MenuBar <dijit/MenuBar>`

There are also supporting widgets such as :ref:`dijit.MenuItem <dijit/MenuItem>` which are discussed on the pages above.

Tree Widgets
============
* :ref:`dijit.Tree <dijit/Tree>`

  * :ref:`Model <dijit/tree/Model>`

  * :ref:`TreeStoreModel <dijit/tree/TreeStoreModel>`

  * :ref:`ForestStoreModel <dijit/tree/ForestStoreModel>`

* :ref:`dijit/_tree <dijit/_tree/>` **STUB**

  * :ref:`dijit._tree.dndSource <dijit/_tree/dndSource>` **STUB**

  * :ref:`dijit.tree._dndContainer <dijit/_tree/_dndContainer>` **STUB**

  * :ref:`dijit.tree._dndSelector <dijit/_tree/_dndSelector>` **STUB**

  * :ref:`dijit.tree.dndSource <dijit/tree/dndSource>` **STUB**

Miscellaneous Widgets
=====================

* :ref:`dijit.BackgroundIframe <dijit/BackgroundIframe>` **STUB**

* :ref:`dijit.Calendar <dijit/Calendar>`

* :ref:`dijit.CalendarLite <dijit/CalendarLite>`

  **1.7+** A lighter version of :ref:`dijit.Calendar <dijit/Calendar>`, more geared for mobile devices (e.g. does not 
  have keyboard navigation)

* :ref:`dijit.ColorPalette <dijit/ColorPalette>`

* :ref:`dijit.Declaration <dijit/Declaration>`

* :ref:`dijit.Dialog <dijit/Dialog>`

* :ref:`dijit.DialogUnderlay <dijit/DialogUnderlay>` **STUB**

* :ref:`dijit.Editor <dijit/Editor>`

* :ref:`dijit.InlineEditBox <dijit/InlineEditBox>`

* :ref:`dijit.ProgressBar <dijit/ProgressBar>`

* :ref:`dijit.TitlePane <dijit/TitlePane>`

* :ref:`dijit.Toolbar <dijit/Toolbar>`

* :ref:`dijit.ToolbarSeperator <dijit/ToolbarSeperator>` **STUB**

* :ref:`dijit.Tooltip <dijit/Tooltip>`

* :ref:`dijit.TooltipDialog <dijit/TooltipDialog>`

Form Widgets and Handling
=========================

* :ref:`dijit.form <dijit/form>`

  * Text Boxes

    * :ref:`dijit.form.CurrencyTextBox <dijit/form/CurrencyTextBox>`

      A specialized input widget for monetary values, much like the currency type in spreadsheet programs

    * :ref:`dijit.form.DateTextBox <dijit/form/DateTextBox>`

      An easy-to-use date entry control which allows either typing or choosing a date from any calendar widget

    * :ref:`dijit.form.MappedTextBox <dijit/form/MappedTextBox>`

      A subclass of :ref:`dijit.form.ValidationTextBox <dijit/form/ValidationTextBox>` that is designed to be a base
      class for widgets that have a visible formatted display value, and a serializable value in a hidden input field
      which is actually sent to the server.

    * :ref:`dijit.form.NumberSpinner <dijit/form/NumberSpinner>`

      An input widget which restricts input to numeric input and offers down and up arrow buttons to "spin" the number
      up and down

    * :ref:`dijit.form.NumberTextBox <dijit/form/NumberTextBox>`

      A input widget which restricts input to numeric input

    * :ref:`dijit.form.RangeBoundTextBox <dijit/form/RangeBoundTextBox>`

      A base class for textbox form widgets which define a range of valid values.

    * :ref:`dijit.form.SimpleTextarea <dijit/form/SimpleTextarea>`

      A simple wrapper of <textarea>; equivalent functionality

    * :ref:`dijit.form.Textarea <dijit/form/Textarea>`

      An auto expanding/contracting <textarea>

    * :ref:`dijit.form.TextBox <dijit/form/TextBox>`

      A basic <input type="text">-style form control

    * :ref:`dijit.form.TimeTextBox <dijit/form/TimeTextBox>`

      A time input control which allows either typing or choosing a time from any time-picker widget

    * :ref:`dijit.form.ValidationTextBox <dijit/form/ValidationTextBox>`

      A class for textbox widgets with the ability to validate various types of content and to provide user feedback.

  * Select Type Widgets

    * :ref:`dijit.form.Select <dijit/form/Select>`

      A styleable drop-down select box (similar to ``<select>``)

    * :ref:`dijit.form.ComboBox <dijit/form/ComboBox>`

      An "auto complete", which allows the user to type any value and just gives suggested completions

    * :ref:`dijit.form.FilteringSelect <dijit/form/FilteringSelect>`

      Similar to a ``<select>`` but with type-ahead filtering of the drop down list

    * :ref:`dijit.form.MultiSelect <dijit/form/MultiSelect>`

      Allows the selection of multiple items (similar to ``<select multiple>``)

    * :ref:`dijit.form._FormSelectWidget <dijit/form/_FormSelectWidget>`

      Base class for widgets like :ref:`dijit.form.Select <dijit/form/Select>`


  * Buttons

    * :ref:`dijit.form.Button <dijit/form/Button>`

      A representation of a normal <button> or <input type="submit/reset/button" />

    * :ref:`dijit.form.ComboButton <dijit/form/ComboButton>`

      A button with an arrow to show a drop down (often a menu)

    * :ref:`dijit.form.DropDownButton <dijit/form/DropDownButton>`

      A button which displays a menu or some other popup when you press it

    * :ref:`dijit.form.ToggleButton <dijit/form/ToggleButton>`

      A cross between a Button and a Checkbox widget

  * Slider

    * :ref:`dijit.form.HorizontalRule <dijit/form/HorizontalRule>`

      Horizontal ruler to use with a :ref:`dijit.form.HorizontalSlider <dijit/form/HorizontalSlider>`.

    * :ref:`dijit.form.HorizontalRuleLabels <dijit/form/HorizontalRuleLabels>`

      Horizontal ruler labels to use with a :ref:`dijit.form.HorizontalSlider <dijit/form/HorizontalSlider>`.

    * :ref:`dijit.form.HorizontalSlider <dijit/form/HorizontalSlider>`

      A scale with a handle you can drag left or right to select a value.

    * :ref:`dijit.form.VerticalRule <dijit/form/VerticalRule>`

      Vertical ruler to use with a :ref:`dijit.form.VerticalSlider <dijit/form/VerticalSlider>`.

    * :ref:`dijit.form.VerticalRuleLabels <dijit/form/VerticalRuleLabels>`

      Vertical ruler labels to use with a :ref:`dijit.form.VerticalSlider <dijit/form/VerticalSlider>`.

    * :ref:`dijit.form.VerticalSlider <dijit/form/VerticalSlider>`

      A vertical scale with a handle you can drag up or down to select a value.

  * Other form widgets

    * :ref:`dijit.form.CheckBox <dijit/form/CheckBox>`

      Nearly the same as an HTML checkbox, but with fancy styling

    * :ref:`dijit.form.Form <dijit/form/Form>`

      Corresponds to a <form> itself; wraps other widgets

    * :ref:`dijit.form.RadioButton <dijit/form/RadioButton>`

      To select one choice from a list

  * Base classes and mixins

    * :ref:`dijit.form._FormWidget <dijit/form/_FormWidget>`

      Base class for all form widgets

    * :ref:`dijit.form._FormValueWidget <dijit/form/_FormValueWidget>`

      Base class for form widgets with a value

  * :ref:`dijit/form <dijit/form/>` **STUB**

    * :ref:`dijit.form._AutoCompleterMixin <dijit/form/_AutoCompleterMixin>` **STUB**

    * :ref:`dijit.form._ButtonMixin <dijit/form/_ButtonMixin>` **STUB**

    * :ref:`dijit.form._CheckBoxMixin <dijit/form/_CheckBoxMixin>` **STUB**

    * :ref:`dijit.form._ComboBoxMenu <dijit/form/_ComboBoxMenu>` **STUB**

    * :ref:`dijit.form._DateTimeTextBox <dijit/form/_DateTimeTextBox>` **STUB**

    * :ref:`dijit.form._ExpandingTextAreaMixin <dijit/form/_ExpandingTextAreaMixin>` **STUB**

    * :ref:`dijit.form._FormMixin <dijit/form/_FormMixin>` **STUB**

    * :ref:`dijit.form._FormValueMixin <dijit/form/_FormValueMixin>` **STUB**

    * :ref:`dijit.form._FormWidgetMixin <dijit/form/_FormWidgetMixin>` **STUB**

    * :ref:`dijit.form._ListBase <dijit/form/_ListBase>` **STUB**

    * :ref:`dijit.form._ListMouseMixin <dijit/form/_ListMouseMixin` **STUB**

    * :ref:`dijit.form._RadioButtonMixin <dijit/form/_RadioButtonMixin` **STUB**

    * :ref:`dijit.form._Spinner <dijit/form/_Spinner>` **STUB**

    * :ref:`dijit.form._TextBoxMixin <dijit/form/_TextBoxMixin>` **STUB**

    * :ref:`dijit.form._ToggleButtonMixin <dijit/form/_ToggleButtonMixin>` **STUB**

Layout
======

* :ref:`dijit.layout <dijit/layout/>`

  * :ref:`dijit.layout._LayoutWidget <dijit/layout/_LayoutWidget>`

  * :ref:`dijit.layout.AccordionContainer <dijit/layout/AccordionContainer>`

  * :ref:`dijit.layout.BorderContainer <dijit/layout/BorderContainer>`

  * :ref:`dijit.layout.ContentPane <dijit/layout/ContentPane>`

  * :ref:`dijit.layout.LinkPane <dijit/layout/LinkPane>`

  * :ref:`dijit.layout.StackContainer <dijit/layout/StackContainer>`

  * :ref:`dijit.layout.TabContainer <dijit/layout/TabContainer>`

* :ref:`dijit/layout/utils <dijit/layout/utils>` **STUB**

* :ref:`dijit.layout.ScrollingTabController <dijit/layout/ScrollingTabController>` **STUB**

* :ref:`dijit.layout.StackController <dijit/layout/StackController>` **STUB**

* :ref:`dijit.layout.TabController <dijit/layout/TabController>` **STUB**

Note about programmatic instantiation
=====================================

For most of the Dijit widgets, you can provide a ``refNode`` which is a placeholder to position your node. Beware that
any attribute set on it (form action, input value, etc.) won't be taken into account.  If you want to degrade nicely and
have a non-JS compatible version of your site and avoid duplicating attributes on controls and on instantiation, you
should use :ref:`parser.instantiate() <dojo/parser>`:

.. js ::

  require(["dojo/parser", "dojo/dom", "dijit/form/ValidationTextBox"], function(parser, dom, ValidationTextBox){
    var myNode = dom.byId("myNode");
    // All attributes of myNode will be preserved in the widget
    parser.instantiate([ myNode ], {
      data-dojo-type: "dijit.form.ValidationTextBox",
      dojoSpecificAttr1: value,
      dojoSpecificAttr2: value
    });
  });
