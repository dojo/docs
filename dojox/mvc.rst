.. _dojox/mvc:

=========
dojox/mvc
=========

:Authors: Akira Sudoh, Ed Chatelain, Rahul Akolkar
:Developers: Akira Sudoh, Ed Chatelain, Rahul Akolkar
:since: V1.7

.. contents ::
    :depth: 2

Introduction
============

Enterprise Rich Internet Applications (RIAs) often focus more on rich data vs. the rich media aspects of RIAs more typical of consumer applications. For example, such RIAs depend on implementing the well-known CRUD operations on data stored in back-end systems. The dojox/mvc package focuses on View to Model data binding (eg. View Controller) concerns on the client, easing development of data-rich UI, which Create, Read, Update, and Delete data. dojox.mvc deals with data binding/controller concerns within a View, but does not deal with application level concerns that span multiple Views (such as navigation), see dojox/app for Application-level Controller concerns.

How it works
============

``dojox/mvc`` has the following properties:

* It enables widgets (desktop and mobile) to "bind" to data within the model. A bind creates a bi-directional or a single directional update mechanism between the bound view and the underlying data.

* The data model is "live" data i.e. it maintains any updates driven by the view on the underlying data.

* The data model issues updates to portions of the view if the data they bind to is updated in the model. For example, if two widgets are bound to the same part of a data model, updating the value of one in the view will cause the data model to issue an update to the other widget with the new value.

* When the model is backed by a dojo.store or dojo.data query, the client-side updates can be persisted once the client is ready to "submit" the changes (which may include both value changes or structural changes - adds/deletes). The datamodel allows control over when the underlying data is persisted i.e. this can be more incremental or batched per application needs. 

Features
========

Data binding APIs, as well as several other APIs, widgets, etc., are available in ``dojox/mvc``.

Data binding API
----------------

There are two data binding APIs:

* :ref:`dojox/mvc/sync <dojox/mvc/sync>` provides a simple way for data binding, by keeping two :ref:`dojo/Stateful <dojo/Stateful>` objects in sync.
* :ref:`dojox/mvc/at <dojox/mvc/at>` typically is used in ``data-dojo-props`` for declarative way of data binding, where a widget can synchronize its attribute with another :ref:`dojo/Stateful <dojo/Stateful>`. It can also be used in the first parameter of widget constructor (list of initial property values) for programmatic way of data binding.

Both APIs above support:

* Optional one-way sync (the default is two-way sync). See :ref:`dojox/mvc/sync:Data binding direction <dojox/mvc/sync#data-binding-direction>` for details.
* Optional data conversion as data goes from model to widget, and vise versa. See :ref:`dojox/mvc/sync:Data converter <dojox/mvc/sync#data-converter>` for details.

Above APIs use :ref:`dojo/Stateful <dojo/Stateful>` as the endpoints of data binding, including :ref:`widgets <dijit/_WidgetBase>` that inherit :ref:`dojo/Stateful <dojo/Stateful>`.

Components in-between data binding endpoints
--------------------------------------------

There are also some helper classes (below), also based on :ref:`dojo/Stateful <dojo/Stateful>`, that typically work in-between such endpoints:

* :ref:`dojox/mvc/ModelRefController <dojox/mvc/ModelRefController>` has a way to replace its data model with another, with such replacement being notified to widgets, etc.
* :ref:`dojox/mvc/EditModelRefController <dojox/mvc/EditModelRefController>` is an inheritance of :ref:`dojox/mvc/ModelRefController <dojox/mvc/ModelRefController>`, which manages the data model of before/after the edit.
* :ref:`dojox/mvc/StoreRefController <dojox/mvc/StoreRefController>` is an inheritance of :ref:`dojox/mvc/ModelRefController <dojox/mvc/ModelRefController>`, which keeps a reference of :ref:`Dojo Object Store <dojo/store>` and has several methods to work with the store whose arrival will be notified to watching widgets, etc..
* :ref:`dojox/mvc/EditStoreRefController <dojox/mvc/EditStoreRefController>` is an inheritance of :ref:`dojox/mvc/EditModelRefController <dojox/mvc/EditModelRefController>` and :ref:`dojox/mvc/StoreRefController <dojox/mvc/StoreRefController>`. In addition to what :ref:`dojox/mvc/EditModelRefController <dojox/mvc/EditModelRefController>` and :ref:`dojox/mvc/StoreRefController <dojox/mvc/StoreRefController>` do, the ``commit()`` method sends the data model as well as the removed entries in array to the data store.
* :ref:`dojox/mvc/ListController <dojox/mvc/ListController>` is an inheritance of :ref:`dojox/mvc/ModelRefController <dojox/mvc/ModelRefController>`, working with an array as the model, and maintains its current position so that widgets referring to this controller can update their UI just by changing the position in this controller.

Widgets, etc.
-------------

A number of widgets and MVC containers, etc. are also available, including:

* :ref:`dojox/mvc/Output <dojox/mvc/Output>` A data-bound output widget.
* :ref:`dojox/mvc/Group <dojox/mvc/Group>` An aggregation of widgets with the same parent data binding context.
* :ref:`dojox/mvc/WidgetList <dojox/mvc/WidgetList>` A model-bound widget that creates child widgets repeatedly based on a data collection.
* :ref:`dojox/mvc/Repeat <dojox/mvc/Repeat>` A model-bound repeater widget that binds to a data collection.
* :ref:`dojox/mvc/Generate <dojox/mvc/Generate>` A simple example of UI generation from a supplied data model.
* :ref:`dojox/mvc/StatefulSeries <dojox/mvc/StatefulSeries>` A chart data plugin ("series") class that watches for properties specified in :ref:`dojox/mvc/at <dojox/mvc/at>` handles in the given data.

Advanced data model as well as its helper
-----------------------------------------

:ref:`dojox/mvc/WidgetList <dojox/mvc/WidgetList>`, :ref:`dojox/mvc/ListController <dojox/mvc/ListController>`, etc. work with array of data. For those components react to change in array, such as adds/removals, etc., :ref:`dojox/mvc/StatefulArray <dojox/mvc/StatefulArray>`, which is mostly interface-compatible to native Array, is available.

For easy conversion of plain objects/arrays from/to :ref:`dojo/Stateful <dojo/Stateful>` and :ref:`dojox/mvc/StatefulArray <dojox/mvc/StatefulArray>`, the following APIs are available:

* :ref:`dojox/mvc/getStateful <dojox/mvc/getStateful>` creates :ref:`dojo/Stateful <dojo/Stateful>` and :ref:`dojox/mvc/StatefulArray <dojox/mvc/StatefulArray>` from plain objects/arrays.
* :ref:`dojox/mvc/getPlainValue <dojox/mvc/getPlainValue>` creates plain objects/arrays from :ref:`dojo/Stateful <dojo/Stateful>` and :ref:`dojox/mvc/StatefulArray <dojox/mvc/StatefulArray>`.

Deprecated APIs and their successors
------------------------------------

:ref:`dojox/mvc/StatefulModel <dojox/mvc/StatefulModel>` has been deprecated. :ref:`dojox/mvc/StatefulModel <dojox/mvc/StatefulModel>` had several different features, such as:

* Support for array (Notifying removals/additions of elements to watchers)
* Conversion of :ref:`dojox/mvc/StatefulModel <dojox/mvc/StatefulModel>` from/to plain objects/values
* Bridge to :ref:`Dojo Object Store <dojo/store>`

Though some applications use all of these features, many applications do not. For example:

* As 1.8 ``dojox/mvc`` supports binding any :ref:`dojo/Stateful <dojo/Stateful>` properties, :ref:`dojox/mvc/StatefulModel <dojox/mvc/StatefulModel>`'s unique approach of converting non-object value to :ref:`dojox/mvc/StatefulModel <dojox/mvc/StatefulModel>` (with "value" attribute) is no longer needed. Regular :ref:`dojo/Stateful <dojo/Stateful>` can be used as data model, in many cases.
* Some applications do not use array in data model at all.
* Some applications use arrays in data model in a static manner (No notification is needed for removals/additions of elements for such kind of applications).
* Some applications would implement getters/setters in its data models to work with more complex data (e.g. XML from REST call, whose request for data item tends to be served by XPath).

To be able to support these different needs :ref:`dojox/mvc/StatefulModel <dojox/mvc/StatefulModel>` is being separated into to classes that support each item:

* :ref:`dojox/mvc/StatefulArray <dojox/mvc/StatefulArray>` works as a successor of ``add()``/``remove()`` functions as well as their notification system.
* :ref:`dojox/mvc/getStateful <dojox/mvc/getStateful>` works as a successor of ``newStatefulModel()`` in ``dojox/mvc``.
* :ref:`dojox/mvc/getPlainValue <dojox/mvc/getPlainValue>` works as a successor of ``toPlainObject()``.
* :ref:`dojox/mvc/EditStoreRefController <dojox/mvc/EditStoreRefController>` works as a successor of data store integration feature in :ref:`dojox/mvc/StatefulModel <dojox/mvc/StatefulModel>`, such as ``commit()`` and ``_saveToStore()``.

:ref:`dojox/mvc/_DataBindingMixin <dojox/mvc/_DataBindingMixin>` has been deprecated.

Examples
========

Basic example, input-output sync: Anything typed into the input fields will be updated in the model and reflected in the output field when you leave the input field.

.. code-example::
  :djConfig: parseOnLoad: false, async: true, mvc: {debugBindings: true}
  :toolbar: versions, themes
  :version: 1.8-2.0

  .. js ::

    var model;
    require([
        "dojo/parser",
        "dojo/Stateful",
        "dojo/domReady!"
    ], function(parser, Stateful){
        // For this test we can use a simple dojo/Stateful as our model
        model = new Stateful({First: "John", Last: "Doe", Email: "jdoe@example.com"});
        parser.parse();
    });

  .. css ::

    .row { width: 500px; display: inline-block; margin: 5px; }
    .cell { width: 20%;  display:inline-block; }
    .textcell { width: 30%;  display:inline-block; }   

  .. html ::

    <script type="dojo/require">at: "dojox/mvc/at"</script>
    <div id="wrapper">
        <div id="header">
            <div id="navigation"></div>
            <div id="headerInsert">
              <h1>Input Ouput Sync</h1>
              <h2>Data Binding Example</h2>
            </div>
        </div>
        <div id="main">
            <div id="leftNav"></div>
            <div id="mainContent">
                <div class="row">
                    <label class="cell" for="firstnameInput">First:</label>
                    <input class="cell" id="firstnameInput" data-dojo-type="dijit/form/TextBox" 
                           data-dojo-props="value: at(model, 'First')">
                    <!-- Content in output below will always be in sync with value of textbox above -->
                    (First name is:
                    <span data-dojo-type="dojox/mvc/Output" 
                          data-dojo-props="value: at(model, 'First')"></span>)
                </div>
                <div class="row">
                    <label class="cell" for="lastnameInput">Last:</label>
                    <input class="cell" id="lastnameInput" data-dojo-type="dijit/form/TextBox" 
                           data-dojo-props="value: at(model, 'Last')">
                    (Last name is:
                    <span data-dojo-type="dojox/mvc/Output" 
                          data-dojo-props="value: at(model, 'Last')"></span>)
                </div>
                <div class="row">
                    <label class="cell" for="emailInput">Email:</label>
                    <input class="cell" id="emailInput" data-dojo-type="dijit/form/TextBox" 
                           data-dojo-props="value: at(model, 'Email')">
                    (email is:
                    <span data-dojo-type="dojox/mvc/Output" 
                          data-dojo-props="value: at(model, 'Email')"></span>)
                </div>
            </div>
        </div>
    </div>

Basic example two, input-output sync: Anything typed into the input fields will be updated in the model and reflected in the output field when you leave the input field.  The "Reset" button will reset the model back to it's original values.  The other buttons show how to programmatically set things in the model to have the update reflected in the widget, and how to programmatically update the widget and have it update the model.

.. code-example::
  :djConfig: parseOnLoad: false, async: true, mvc: {debugBindings: true}
  :toolbar: versions, themes
  :version: 1.8-2.0

  .. js ::

    var model;
    require([
        "dojo/parser",
        "dojo/Stateful",
        "dojo/domReady!"
    ], function(parser, Stateful){
        model = new Stateful({First: "John", Last: "Doe", Email: "jdoe@example.com"});
        parser.parse();
    });

  .. css ::

    .row { width: 500px; display: inline-block; margin: 5px; }
    .cell { width: 20%;  display:inline-block; }
    .textcell { width: 30%;  display:inline-block; }   

  .. html ::

    <script type="dojo/require">at: "dojox/mvc/at"</script>
    <div id="main">
        <span id="ctrl" data-dojo-type="dojox/mvc/EditModelRefController" data-dojo-props="sourceModel: model"></span>
        <div class="row">
            <label class="cell" for="firstId">First:</label>
            <input class="textcell" id="firstId" data-dojo-type="dijit/form/TextBox"
                   data-dojo-props="value: at('widget:ctrl', 'First')"></input>
            <!-- Content in output below will always be in sync with value of textbox above -->
            <span data-dojo-type="dojox/mvc/Output"
                  data-dojo-props="value: at('widget:ctrl', 'First')">
                (first name is: ${this.value})
            </span>
        </div>
        <div class="row">
            <label class="cell" for="lastnameInput">Last:</label>
            <input class="textcell" id="lastnameInput" data-dojo-type="dijit/form/TextBox"
                   data-dojo-props="value: at('widget:ctrl', 'Last')"></input>
            <span data-dojo-type="dojox/mvc/Output"
                  data-dojo-props="value: at('widget:ctrl', 'Last')">
                (last name is: ${this.value})
            </span>
        </div>
        <div class="row">
            <label class="cell" for="emailInput">Email:</label>
            <input class="textcell" id="emailInput" data-dojo-type="dijit/form/TextBox"
                   data-dojo-props="value: at('widget:ctrl', 'Email')"></input>
            <span data-dojo-type="dojox/mvc/Output"
                  data-dojo-props="value: at('widget:ctrl', 'Email')">
                (email is: ${this.value})
            </span>
        </div>
        <br/>
        Model:
        <button id="reset" type="button" data-dojo-type="dijit/form/Button" 
                data-dojo-props="onClick: function(){ require('dijit/registry').byId('ctrl').reset(); }">Reset</button>
        <button id="fromModel" type="button" data-dojo-type="dijit/form/Button"
                data-dojo-props="onClick: function(){ require('dijit/registry').byId('ctrl').set('First', 'Updated in Model'); }">Update First from Model</button>
        <button id="fromWidget" type="button" data-dojo-type="dijit/form/Button"
                data-dojo-props="onClick: function(){ require('dijit/registry').byId('firstId').set('value', 'Updated Widget'); }">Update First from Widget</button>
    </div>
