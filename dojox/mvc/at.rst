.. _dojox/mvc/at:

============
dojox/mvc/at
============

:Authors: Akira Sudoh, Ed Chatelain
:Developers: Akira Sudoh, Ed Chatelain
:since: V1.8

.. contents ::
  :depth: 2

================
dojox/mvc/at API
================

The module's value is an ``at`` function that can be directly called to create a pointer (called at handle) to a :ref:`dojo/Stateful <dojo/Stateful>` property.
The ``at`` function is in below form, which returns an at handle:

.. js ::

  at(target, targetProp);

The following parameters should be provided to the at function:

* ``target`` - This is the :ref:`dojo/Stateful <dojo/Stateful>` to point to, or a string either in ``rel:target`` or in ``widget:widgetid`` format. ``rel:target`` format looks for a particular property in parent widget (see `Relative data binding`_ for more details). ``widget:widgetid`` format looks for a widget with ``widgetid`` ID.
* ``targetProp`` - This is the :ref:`dojo/Stateful <dojo/Stateful>` property name in target, or ``*``. Using ``*`` means "all properties". (See :ref:`dojox/mvc/sync:Wildcard syntax <dojox/mvc/sync#wildcard-syntax>` for more details)

-------------------------------
at function syntax with widgets
-------------------------------

``at`` function is typically used as a mixin property of a widget (:ref:`data-dojo-props <dojo/parser#parser-parameters>` or the first parameter of widget's constructor), in below forms, where in both cases the value property in above TextBox is synchronized with ``target.targetProp``:

.. html ::

  <script type="dojo/require">at: "dojox/mvc/at"</script>
  <input data-dojo-type="dijit/form/TextBox" 
   data-dojo-props="value: at(target, 'targetProp')">

.. js ::

  require(["dojo/Stateful", "dijit/form/TextBox", "dojox/mvc/at"], function(Stateful, TextBox, at){
    var target = new Stateful({targetProp: "foo"});
    var textbox = new TextBox({
      value: at(target, targetProp)
    }, srcNodeRef);
    textbox.startup();
  });

--------------
Basic examples
--------------

In below example, two seconds later, the text box changes from "Foo" to "Bar" as the ``value`` property in ``model`` changes.

.. code-example::
  :djConfig: parseOnLoad: false, async: true, mvc: {debugBindings: true}
  :toolbar: versions, themes
  :version: 1.8-2.0
  :width: 320
  :height: 60

  .. js ::

    require([
        "dojo/parser", "dojo/when", "dojo/Stateful", "dojo/domReady!"
    ], function(parser, when, Stateful){
        model = new Stateful({value: "Foo"});
        when(parser.parse(), function(){
            setTimeout(function(){ model.set("value", "Bar"); }, 2000);
        });
    });

  .. html ::

    <script type="dojo/require">at: "dojox/mvc/at"</script>
    <input type="text"
     data-dojo-type="dijit/form/TextBox"
     data-dojo-props="value: at(model, 'value')">

In below example, edit in text box is reflected to the text next to it:

.. code-example::
  :djConfig: parseOnLoad: false, async: true, mvc: {debugBindings: true}
  :toolbar: versions, themes
  :version: 1.8-2.0
  :width: 480
  :height: 60

  .. js ::

    require([
        "dojo/parser", "dojo/domReady!"
    ], function(parser){
        parser.parse();
    });

  .. html ::

    <script type="dojo/require">at: "dojox/mvc/at"</script>
    <span data-dojo-id="model"
     data-dojo-type="dojo/Stateful"
     data-dojo-props="value: 'Foo'"></span>
    <input type="text"
     data-dojo-type="dijit/form/TextBox"
     data-dojo-props="value: at(model, 'value')">
    <span data-dojo-type="dijit/_WidgetBase"
     data-dojo-props="_setValueAttr: {node: 'domNode', type: 'innerText'}, value: at(model, 'value')"></span>

----------------------
Data binding direction
----------------------

By default, ``at`` function used with widget watches for changes both at ``target.targetProp`` and the property (attribute) in widget and reflects one change to another. ``at`` function allows to specify the direction via ``direction`` function of at handle, which takes one of the following at its first argument:

* ``at.from`` - Only reflect changes in ``target.targetProp`` to the property (attribute) in widget
* ``at.to`` - Only reflect changes in the property (attribute) in widget to ``target.targetProp``
* ``at.both`` - Reflect changes in each other (Default)

The basic usage of ``direction`` function is in below form, where change in ``target.targetProp`` will be reflected to value in TextBox, but not in the opposite direction:

.. code-example::
  :djConfig: parseOnLoad: false, async: true, mvc: {debugBindings: true}
  :toolbar: versions, themes
  :version: 1.8-2.0
  :width: 480
  :height: 60

  .. js ::

    require([
        "dojo/parser", "dojo/when", "dojo/Stateful", "dojo/domReady!"
    ], function(parser, when, Stateful){
        model = new Stateful({value: "Foo"});
        when(parser.parse(), function(){
            setTimeout(function(){ model.set("value", "Bar"); }, 2000);
        });
    });

  .. html ::

    <script type="dojo/require">at: "dojox/mvc/at"</script>
    <span data-dojo-type="dijit/_WidgetBase"
     data-dojo-props="_setValueAttr: {node: 'domNode', type: 'innerText'},
                      value: at(model, 'value')"></span>
    <input data-dojo-type="dijit/form/TextBox" 
     data-dojo-props="value: at(model, 'value').direction(at.from)">

See :ref:`dojox/mvc/sync:Data binding direction <dojox/mvc/sync#data-binding-direction>` for more details.

--------------
Data converter
--------------

``at`` function used with widget allows ``target.targetProp`` and property (attribute) in widget to have different format as they are synchronized, for example, ``target.targetProp`` to have Number ``2`` and property (attribute) in widget to have String ``"2"``. It's done via ``transform`` function of at handle, in below form:

.. html ::

  <script type="dojo/require">at: "dojox/mvc/at"</script>
  <input data-dojo-type="dijit/form/TextBox" 
   data-dojo-props="value: at(target, 'targetProp').transform({
                      format: function(value){
                        return '' + value;
                      },
                      parse: function(value){
                        return value - 0;
                      }
                    })">

``transform`` function can be used with any objects having ``format``/``parse`` functions, like ``dojo/number`` and ``dojo/date/locale``. For example, ``dojo/date/locale`` can be used with ``transform`` function, in below form:

.. code-example::
  :djConfig: parseOnLoad: false, async: true, mvc: {debugBindings: true}
  :toolbar: versions, themes
  :version: 1.8-2.0
  :width: 480
  :height: 320

  .. js ::

    require([
        "dojo/parser", "dojo/domReady!"
    ], function(parser){
        parser.parse();
    });

  .. html ::

    <script type="dojo/require">at: "dojox/mvc/at", dateLocale: "dojo/date/locale"</script>
    <span data-dojo-id="model" data-dojo-type="dojo/Stateful" data-dojo-props="value: new Date"></span>
    <span data-dojo-type="dijit/_WidgetBase"
     data-dojo-props="_setValueAttr: {node: 'domNode', type: 'innerText'},
                      constraints: {selector: 'date'},
                      value: at(model, 'value').transform(dateLocale)"></span>
    <input data-dojo-type="dijit/form/DateTextBox" 
     data-dojo-props="value: at(model, 'value')">

The ``constraints`` attribute in the non-editable UI showing date is passed as the 2nd parameter to ``format``/``parse`` functions.

See :ref:`dojox/mvc/sync:Data converter <dojox/mvc/sync#data-converter>` for more details.

---------------------
Relative data binding
---------------------

When ``rel:propInParent`` format (``propInParent`` can be omitted here) is specified in the first argument of ``at`` function, it goes up DOM hierarchy to find a widget meeting the following criteria:

* The property in widget pointed by ``widget[widget._relTargetProp]`` (or ``widget.target`` as the default) exists -OR-
* Such property is defined in the widget class

Then ``widget[widget._relTargetProp || "target"].propInParent`` (or simply ``widget[widget._relTargetProp || "target"]`` if ``propInParent`` is omitted) will be used as data binding target, which the property in widget specified in data binding syntax will be in sync with. When binding target changes, data binding will be reestablished with the newer target.

The basic usage of relative data binding is in below form, where two seconds later, the text box changes from "Foo" to "Bar" as the parent widget for relative data binding (having ``target`` property) changes its ``target`` property from the one having "Foo" to the one having "Bar":

.. code-example::
  :djConfig: parseOnLoad: false, async: true, mvc: {debugBindings: true}
  :toolbar: versions, themes
  :version: 1.8-2.0
  :width: 480
  :height: 60

  .. js ::

    require([
        "dojo/parser", "dojo/when", "dojo/Stateful", "dojo/domReady!"
    ], function(parser, when, Stateful){
        model = new Stateful({child: {value: "Foo"}});
        when(parser.parse(), function(){
            setTimeout(function(){ model.set("child", new Stateful({value: "Bar"})); }, 2000);
        });
    });

  .. html ::

    <script type="dojo/require">at: "dojox/mvc/at"</script>
    <div data-dojo-type="dijit/_WidgetBase"
     data-dojo-props="target: at(model, 'child')">
        <input data-dojo-type="dijit/form/TextBox" 
         data-dojo-props="value: at('rel:', 'value')">
    </div>