#format dojo_rst

Bi-directional Text (Bi-Di)
===========================

:Status: Draft
:Version: 1.0
:Authorsr: Adam Peller
:Available: since V?

.. contents::
   :depth: 2

Some languages, mostly middle-eastern in origin, have text flow from the right to the left (e.g. Hebrew and Arabic) This affects not just the characters in a sentence, but the entire flow of the user interface. The web browser generally takes care of this "mirroring" for us, provided the DIR attribute is set to "rtl" for right-to-left text direction. Note that text direction and locale are orthogonal concepts as defined by the `HTML spec <http://www.w3.org/TR/html401/struct/dirlang.html>`_.

Dojo functions, including Dijit, only support a single text direction per document, which must be declared on the HTML or BODY element with the DIR attribute. With some exceptions, the HTML elements comprising the widgets on the page are flipped from right to left by the browser -- browser quirks occasionally require additional workarounds. Still, some other issues remain when mirroring the user interface of complex page fragments, such as those created by widgets. For example, if a graphic indicates a left or right direction, it may also have to be flipped or swapped to follow the new right-to-left logic. Wherever possible, mirroring is achieved using CSS rules. Sometimes the logic of an application or widget must change to accommodate Bi-Di. Keyboard accelerators or other code logic may also have to be modified. For example, in right-to-left mode, menu widgets drop down and to the left and contents are right-justified.

Bi-Di issues are largely related to widgets, and are therefore addressed mostly within the Dijit project. To support right-to-left users, some extra CSS is required. At the present time, these rules reside in a separate stylesheet and must be explicitly loaded to provide Bi-Di support. (e.g. themes/tundra/tundra_rtl.css, which imports themes/tundra/tundra.css for you)

As of the 1.1 release, all Dijits, except for deprecated widgets, are Bi-Di capable. DojoX BiDi support varies.

As of the 1.0 release, the following widgets have limited Bi-Di support using the Tundra theme:

* dijit.ColorPalette
* dijit.Declaration
* dijit.Dialog
* dijit.Menu
* dijit.ProgressBar
* dijit.TitlePane
* dijit.ToolBar
* dijit.Tooltip
* dijit.Tree
* dijit.form.Button
* dijit.form.CheckBox
* dijit.form.ComboBox
* dijit.form.CurrencyTextBox
* dijit.form.DateTextBox
* dijit.form.FilteringSelect
* dijit.form.Form
* dijit.form.InlineEditBox
* dijit.form.NumberSpinner
* dijit.form.NumberTextBox
* dijit.form.Textarea
* dijit.form.TextBox
* dijit.form.TimeTextBox
* dijit.form.ValidationTextBox
* dijit.layout.ContentPane
* dijit.layout.LinkPane
* dijit.layout.StackContainer
* dijit.layout.AccordionContainer
