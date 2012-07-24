.. _dojox/mvc/EditStoreRefController:

================================
dojox/mvc/EditStoreRefController
================================

:Authors: Akira Sudoh, Ed Chatelain
:Developers: Akira Sudoh, Ed Chatelain
:since: V1.8

.. contents ::
  :depth: 2

``dojox/mvc/EditStoreRefController`` is an inheritance of :ref:`dojox/mvc/EditModelRefController <dojox/mvc/EditModelRefController>` and :ref:`dojox/mvc/StoreRefController <dojox/mvc/StoreRefController>`.
In addition to what :ref:`dojox/mvc/EditModelRefController <dojox/mvc/EditModelRefController>` and :ref:`dojox/mvc/StoreRefController <dojox/mvc/StoreRefController>` do, the ``commit()`` method sends the data model as well as the removed entries in array to the data store.

=====
Usage
=====

In below example, the check box refers to ``value`` property in the controller (with ``ctrl`` ID).
The controller provides the ``value`` property, from the data coming from data store (``store`` property in the controller), using the first one in array.
Two seconds later, the check box changes from unchecked to checked.
The change is committed to the data store, which is reflected to :ref:`dojo/store/Observable <dojo/store/Observable>` callback. 

.. code-example::
  :djConfig: parseOnLoad: false, async: true, mvc: {debugBindings: true}
  :toolbar: versions, themes
  :version: 1.8-2.0
  :width: 320
  :height: 60

  .. js ::

    require([
        "dojo/dom", "dojo/parser", "dojo/when", "dojo/store/Observable", "dojo/store/Memory", "dijit/registry", "dojo/domReady!"
    ], function(ddom, parser, when, Observable, Memory, registry){
        store = Observable(new Memory({data: [{id: "Foo", value: false}]}));
        when(parser.parse(), function(){
            registry.byId("ctrl").queryStore().observe(function(object, previousIndex, newIndex){
                alert("ID: " + object.id + ", value: " + object.value);
            }, true);
            var count = 0;
            var h = setInterval(function(){
                ddom.byId("check").click();
                registry.byId("ctrl").commit();
                if(++count >= 2){ clearInterval(h); }
            }, 2000);
        });
    });

  .. html ::

    <script type="dojo/require">at: "dojox/mvc/at"</script>
    <span id="ctrl"
     data-dojo-type="dojox/mvc/EditStoreRefController"
     data-dojo-mixins="dojox/mvc/ListController"
     data-dojo-props="store: store, cursorIndex: 0"></span>
    <input id="check" type="checkbox"
     data-dojo-type="dijit/form/CheckBox"
     data-dojo-props="checked: at('widget:ctrl', 'value')">
