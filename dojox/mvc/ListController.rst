.. _dojox/mvc/ListController:

========================
dojox/mvc/ListController
========================

:Authors: Akira Sudoh, Ed Chatelain
:Developers: Akira Sudoh, Ed Chatelain
:since: V1.8

.. contents ::
  :depth: 2

``dojox/mvc/ListController`` is a controller working with an array as the model.
It maintains its current position (``cursorIndex`` or ``cursorId``) so that widgets referring to this controller can update their UI just by changing the position in this controller.

=====
Usage
=====

In below example, the ``dojox/mvc/ListController`` refers to an instance of :ref:`dojox/mvc/StatefulArray <dojox/mvc/StatefulArray>` as the model, and the ``cursorIndex`` is updated every two seconds. As the result, text box changes its value every two seconds:

.. code-example::
  :djConfig: parseOnLoad: false, async: true, mvc: {debugBindings: true}
  :toolbar: versions, themes
  :version: 1.8-2.0
  :width: 320
  :height: 60

  .. js ::

    require([
        "dojo/parser", "dojo/when", "dijit/registry", "dojox/mvc/StatefulArray",
        "dijit/form/TextBox", "dojox/mvc/ListController", "dojo/domReady!"
    ], function(parser, when, registry, StatefulArray){
        var count = 0;
        model = new StatefulArray([{value: "First"}, {value: "Second"}, {value: "Third"}, {value: "Fourth"}, {value: "Fifth"}]);
        when(parser.parse(), function(){
            setInterval(function(){ registry.byId("ctrl").set("cursorIndex", ++count % 5); }, 2000);
        });
    });

  .. html ::

    <script type="dojo/require">at: "dojox/mvc/at"</script>
    <span id="ctrl"
     data-dojo-type="dojox/mvc/ListController"
     data-dojo-props="model: model"></span>
    <input type="text"
     data-dojo-type="dijit/form/TextBox"
     data-dojo-props="value: at('widget:ctrl', 'value')">
