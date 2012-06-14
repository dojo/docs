.. _dojox/mvc/StoreRefController:

============================
dojox/mvc/StoreRefController
============================

:Authors: Akira Sudoh, Ed Chatelain
:Developers: Akira Sudoh, Ed Chatelain
:since: V1.8

.. contents ::
  :depth: 2

dojox/mvc/StoreRefController is an inheritance of dojox/mvc/ModelRefController, which keeps a reference to Dojo Object Store (in store property).
It has several methods to work with the store:

* queryStore(): Runs query() against the store, and creates a data model from retrieved data
* getStore(): Runs get() against the store, and creates a data model from retrieved data
* putStore(): Runs put() against the store
* addStore(): Runs add() against the store
* removeStore(): Runs remove() against the store

dojo.Stateful get()/set()/watch() interfaces in dojox.mvc.StoreRefController will work with the data model from queryStore() or getStore().

=====
Usage
=====

In below example, the text box refers to "value" property in the controller (with "ctrl" ID).
The controller provides the "value" property, from the data coming from data store ("store" property in the controller).
Two seconds later, the text box changes from "Foo" to "Bar" as the controller gets new data from data store.

.. html ::

  <html>
      <head>
          <script src="/path/to/dojo-toolkit/dojo/dojo.js" type="text/javascript" data-dojo-config="parseOnLoad: 0"></script>
          <script type="text/javascript">
              require([
                  "dojo/parser", "dojo/store/Memory", "dijit/registry",
                  "dijit/form/TextBox", "dojox/mvc/StoreRefController", "dojo/domReady!"
              ], function(parser, Memory, registry){
                  store = new Memory({data: [{id: "Foo", value: "Foo"}, {id: "Bar", value: "Bar"}]});
                  parser.parse();
                  registry.byId("ctrl").getStore("Foo");
                  setTimeout(function(){ registry.byId("ctrl").getStore("Bar"); }, 2000);
              });
          </script>
      </head>
      <body>
          <script type="dojo/require">at: "dojox/mvc/at"</script>
          <span id="ctrl" data-dojo-type="dojox/mvc/StoreRefController" data-dojo-props="store: store"></span>
          <input type="text" data-dojo-type="dijit/form/TextBox" data-dojo-props="value: at('widget:ctrl', 'value')">
      </body>
  </html>
