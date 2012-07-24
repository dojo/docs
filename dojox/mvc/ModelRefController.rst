.. _dojox/mvc/ModelRefController:

============================
dojox/mvc/ModelRefController
============================

:Authors: Akira Sudoh, Ed Chatelain
:Developers: Akira Sudoh, Ed Chatelain
:since: V1.8

.. contents ::
  :depth: 2

``dojox/mvc/ModelRefController`` is a controller that keeps a reference to :ref:`dojo/Stateful <dojo/Stateful>`-based data model.
Useful for:

* Having a way to replace a data model with another, and making widgets respond to that
* Adding custom methods that work between model and widgets

To help above, it does the following on behalf of such model:

* Provides data from model via :ref:`dojo/Stateful <dojo/Stateful>` ``get()`` interface
* Stores data to model via :ref:`dojo/Stateful <dojo/Stateful>` ``set()`` interface
* Watches for change in model (the attribute named by ``this._refModelProp``, ``model`` is the default) via :ref:`dojo/Stateful <dojo/Stateful>` ``watch()`` interface (The callback is called when there is a change in data model, as well as when the data model itself is replaced with different one)

=====
Usage
=====

In below example, the text box refers to ``value`` property in the controller (with ``ctrl`` ID).
The controller provides the ``value`` property on behalf of the model (``model`` property in the controller).
Two seconds later, the text box changes from "Foo" to "Bar" as the controller changes the data model it refers to:

.. code-example::
  :djConfig: parseOnLoad: false, async: true, mvc: {debugBindings: true}
  :toolbar: versions, themes
  :version: 1.8-2.0
  :width: 320
  :height: 60

  .. js ::

    require([
        "dojo/parser", "dojo/when", "dijit/registry", "dojo/domReady!"
    ], function(parser, when, registry){
        when(parser.parse(), function(){
            setTimeout(function(){ registry.byId("ctrl").set("model", modelBar); }, 2000);
        });
    });

  .. html ::

    <script type="dojo/require">at: "dojox/mvc/at"</script>
    <span data-dojo-id="modelFoo"
     data-dojo-type="dojo/Stateful"
     data-dojo-props="value: 'Foo'"></span>
    <span data-dojo-id="modelBar"
     data-dojo-type="dojo/Stateful"
     data-dojo-props="value: 'Bar'"></span>
    <span id="ctrl"
     data-dojo-type="dojox/mvc/ModelRefController"
     data-dojo-props="model: modelFoo"></span>
    <input type="text"
     data-dojo-type="dijit/form/TextBox"
     data-dojo-props="value: at('widget:ctrl', 'value')">

In below example, it runs a custom method (lookup) when there is a change in "Zip" or "Country" attributes in the controller:

.. html ::

  <div id="addressLookupController" class="dijitDisplayNone"
   data-dojo-type="dojox/mvc/ModelRefController"
   data-dojo-props="model: loanModel, ownProps: {_setZipAttr: 1, _setCountyAttr: 1}">
      <script type="dojo/method" event="_setZipAttr" args="value">
          var changed = this.model.Zip != value;
          this.model._changeAttrValue("Zip", value);
          if(changed){
              lookup(this.model);
          }
          return this;
      </script>
      <script type="dojo/method" event="_setCountyAttr" args="value">
          var changed = this.model.County != value;
          this.model._changeAttrValue("County", value);
          if(changed){
              lookup(this.model);
          }
          return this;
      </script>
  </div>
