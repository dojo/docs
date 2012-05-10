.. _dojox/mvc:

=========
dojox.mvc
=========

:Authors: Rahul Akolkar, Ed Chatelain, Akira Sudoh
:Developers: Rahul Akolkar, Ed Chatelain, Akira Sudoh
:since: V1.7

.. contents ::
    :depth: 2

Introduction
============

Enterprise Rich Internet Applications (RIAs) often focus more on rich data vs. the rich media aspects of RIAs more typical of consumer applications. For example, such RIAs depend on implementing the well-known CRUD operations on data stored in back-end systems. The dojox/mvc package focuses on View to Model data binding (eg. View Controller) concerns on the client, easing development of data-rich UI’s which Create, Read, Update, and Delete data. dojox.mvc deals with data binding/controller concerns within a View, but does not deal with application level concerns that span multiple Views (such as navigation), see dojox/app for Application-level Controller concerns.

How it works
dojox/mvc has the following properties:

    It enables widgets (desktop and mobile) to "bind" to data within the model. A bind creates a bi-directional or a single directional update mechanism between the bound view and the underlying data.
    The data model is "live" data i.e. it maintains any updates driven by the view on the underlying data.
    The data model issues updates to portions of the view if the data they bind to is updated in the model. For example, if two widgets are bound to the same part of a data model, updating the value of one in the view will cause the data model to issue an update to the other containing the new value.
    When the model is backed by a dojo.store or dojo.data query, the client-side updates can be persisted once the client is ready to "submit" the changes (which may include both value changes or structural changes - adds/deletes). The datamodel allows control over when the underlying data is persisted i.e. this can be more incremental or batched per application needs. 

Features
========

* :ref:`A simple data binding layer (dojox/mvc/sync) which support one-way or two-way binding and a converter.  <dojox/mvc/sync>`
* :ref:`at - Typically used in in data-dojo-props so that a widget can synchronize its attribute with another dojo.Stateful (dojox/mvc/at)  <dojox/mvc/at>`

* A number of new widgets and MVC containers, including:

  * :ref:`Output: A data-bound output widget  <dojox/mvc/Output>`
  * :ref:`Group: An aggregation of widgets with the same parent data binding context  <dojox/mvc/Group>`
  * :ref:`Repeat: A model-bound repeater widget that binds to a data collection  <dojox/mvc/Repeat>`
  * :ref:`Generate: A simple example of UI generation from a supplied data model  <dojox/mvc/Generate>`

* :ref:`StatefulModel has been depricated.  <dojox/mvc/StatefulModel>`
* :ref:`_DataBindingMixin has been depricated.  <dojox/mvc/_DataBindingMixin>`
 
Usage
=====

Loading the basic dojox.mvc codebase is extremely simple.

.. js ::

    require([
        "dojox/mvc", // load the basic MVC support, including the data binding mixin
        "dojox/mvc/Group" // load other MVC containers, as needed by the application
    ], function(mvc, Group){
        // ...
    });

dojox.mvc can also be loaded using the legacy ``dojo.require`` API:

.. js ::
 
    // Load the basic MVC support, including the data binding mixin.
    dojo.require("dojox.mvc");

    // Load other MVC containers, as needed by the application.
    dojo.require("dojox.mvc.Group");


Examples
========

Basic example, input-output sync: Anything typed into the input fields will be updated in the model and reflected in the output field when you leave the input field.  The "Reset" button will reset the model back to it's original values.  The other buttons show how to programmatically set things in the model to have the update reflected in the widget, and how to programmatically update the widget and have it update the model.

.. code-example::
  :djConfig: parseOnLoad: true
  :version: local
  :toolbar: versions, themes

  .. js ::

		var model; 
		require([
			'dojo/parser',
			'dojo/ready',
			'dojox/mvc',
			'dijit/form/TextBox',
			'dijit/form/Button',
			'dojox/mvc/Group',
			'dojox/mvc/Output'
			], function(parser, ready, mvc){

				// The dojox.mvc.StatefulModel class creates a data model instance
				// where each leaf within the data model is decorated with dojo.Stateful
				// properties that widgets can bind to and watch for their changes.
				model = mvc.newStatefulModel({ data : {
				            "First" : "John",
				            "Last"  : "Doe",
				            "Email" : "jdoe@example.com"
				        }});
			});

  .. css ::

        .row { width: 500px; display: inline-block; margin: 5px; }
        .cell { width: 20%;  display:inline-block; }
        .textcell { width: 30%;  display:inline-block; }   

  .. html ::

    <div id="main">
        <div class="row">
            <label class="cell" for="firstId">First:</label>
            <input class="textcell" id="firstId" data-dojo-type="dijit.form.TextBox"
                   data-dojo-props="ref: model.First"></input>
            <!-- Content in output below will always be in sync with value of textbox above -->
            <span data-dojo-type="dojox.mvc.Output" data-dojo-props="ref: model.First">
                (first name is: ${this.value})
            </span>
        </div>
        <div class="row">
            <label class="cell" for="lastnameInput">Last:</label>
            <input class="textcell" id="lastnameInput" data-dojo-type="dijit.form.TextBox"
                   data-dojo-props="ref: model.Last"></input>
            <span data-dojo-type="dojox.mvc.Output" data-dojo-props="ref: model.Last">
                (last name is: ${this.value})
            </span>
        </div>
        <div class="row">
            <label class="cell" for="emailInput">Email:</label>
            <input class="textcell" id="emailInput" data-dojo-type="dijit.form.TextBox"
                   data-dojo-props="ref: model.Email"></input>
            <span data-dojo-type="dojox.mvc.Output" data-dojo-props="ref: model.Email">
                (email is: ${this.value})
            </span>
        </div>
        <br/>
        Model:
        <button id="reset" type="button" data-dojo-type="dijit.form.Button" 
                data-dojo-props="onClick: function(){model.reset();}">Reset</button>
	<button id="fromModel" type="button" data-dojo-type="dijit.form.Button" data-dojo-props="onClick: 
        	function(){model.First.set('value','Updated in Model');}">Update First from Model</button>
	<button id="fromWidget" type="button" data-dojo-type="dijit.form.Button" data-dojo-props="onClick: 
                function(){dijit.byId('firstId').set('value','Updated Widget');}">Update First from Widget</button>
    </div>
