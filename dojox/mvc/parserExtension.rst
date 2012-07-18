.. _dojox/mvc/parserExtension:

=========================
dojox/mvc/parserExtension
=========================

:Authors: Akira Sudoh, Ed Chatelain
:Developers: Akira Sudoh, Ed Chatelain
:since: V1.8

.. contents ::
  :depth: 2

dojox/mvc/parserExtension extends dojo/parser and/or dojox/mobile/parser so that data binding can be done for non-widgets.
It reads data-mvc-bindings attribute in DOM node, so that properties in DOM node can be bound to data model or controller.

=====
Usage
=====

In below example, the CSS class of <span> changes when user clicks on check box, as:

* CSS class of <span> is bound to checked property in a dojo.Stateful (boldTextModel) that is boolean. It is one-way sync from data model to DOM node. When the value is true, the CSS class becomes "boldText". Otherwise, the CSS class becomes empty.
* Checked/unchecked state of the check box is bount do the same checked property in the dojo.Stateful (boldTextModel).

Also, the text in <span> changes when user makes a selection in combo box, as:

* The text in <span> is bound to value property in a dojo.Stateful (titleModel).
* The selected value of combo box is bound to the same value property in the dojo.Stateful (titleModel).

.. code-example::
  :djConfig: parseOnLoad: false, async: true, mvc: {debugBindings: true}
  :toolbar: versions, themes
  :version: 1.8-2.0
  :width: 240
  :height: 80

  .. css ::

    .boldText {
        font-weight: Bold;
    }

  .. js ::

    require([
        "dojox",
        "dojo/Stateful",
        "dojo/parser",
        "dojox/mvc/parserExtension",
        "dojo/domReady!"
    ], function(dojox, Stateful, parser){
        titleModel = new Stateful({value: "Foo"});
        boldTextModel = new Stateful({checked: false});
        parser.parse();
    });
  
  .. html::

    <script type="dojo/require">at: "dojox/mvc/at"</script>
    <div>
        Text:
        <span data-mvc-bindings="class: at(boldTextModel, 'checked').direction(at.from).transform({format: function(value){ return value ? 'boldText' : ''; }}),
                                 innerText: at(titleModel, 'value')"></span>
    </div>
    <div>
        Choose text from:
        <select type="combo" data-mvc-bindings="value: at(titleModel, 'value')">
            <option value="Foo">Foo</option>
            <option value="Bar">Bar</option>
        </select>
    </div>
    <div style="margin-top:8px;">
        The text should be bold:
        <input type="checkbox" data-mvc-bindings="checked: at(boldTextModel, 'checked')">
    </div>
