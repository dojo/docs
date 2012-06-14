.. _dojox/mvc/ListController:

========================
dojox/mvc/ListController
========================

:Authors: Akira Sudoh, Ed Chatelain
:Developers: Akira Sudoh, Ed Chatelain
:since: V1.8

.. contents ::
  :depth: 2

dojox/mvc/ListController is a controller working with an array as the model.
It maintains its current position (cursorIndex or cursorId) so that widgets referring to this controller can update their UI just by changing the position in this controller.

=====
Usage
=====

In below example, the dojox/mvc/ListController refers to an instance of dojox/mvc/StatefulArray as the model, and the cursorIndex is updated every two seconds. As the result, text box changes its value every two seconds:

.. html ::

  <html>
      <head>
          <script src="/path/to/dojo-toolkit/dojo/dojo.js" type="text/javascript" data-dojo-config="parseOnLoad: 0"></script>
          <script type="text/javascript">
              require([
                  "dojo/parser", "dijit/registry", "dojox/mvc/StatefulArray",
                  "dijit/form/TextBox", "dojox/mvc/ListController", "dojo/domReady!"
              ], function(parser, registry, StatefulArray){
                  var count = 0;
                  model = new StatefulArray([{value: "First"}, {value: "Second"}, {value: "Third"}, {value: "Fourth"}, {value: "Fifth"}]);
                  setInterval(function(){ registry.byId("ctrl").set("cursorIndex", ++count % 5); }, 2000);
                  parser.parse();
              });
          </script>
      </head>
      <body>
          <script type="dojo/require">at: "dojox/mvc/at"</script>
          <span id="ctrl" data-dojo-type="dojox/mvc/ListController" data-dojo-props="model: model"></span>
          <input type="text" data-dojo-type="dijit/form/TextBox" data-dojo-props="value: at('widget:ctrl', 'value')">
      </body>
  </html>
