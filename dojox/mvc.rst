.. _dojox/mvc:

=========
dojox.mvc
=========

:Authors: Rahul Akolkar, Ed Chatelain
:Developers: Rahul Akolkar, Ed Chatelain
:since: V1.7

.. contents ::
    :depth: 2

Introduction
============

Enterprise Rich Internet Applications (RIAs) often focus more on rich data vs. the rich media aspects of RIAs more typical of consumer applications. For example, such RIAs depend on implementing the well-known CRUD operations on data stored in back-end systems. The dojox.mvc project focuses on separation of MVC concerns on the client, thereby on easing development of data-rich applications and accelerating the authoring of applications to Create, Read, Update, and Delete data using a set of Dojo-based patterns.

This project is useful across form factors. For example, it may be used with dijit as well as dojox.mobile.

We begin by introducing a first-class client-side data model based on dojo.Stateful and extending Dojo Form widgets with support for the Model-View-Control (MVC) pattern key to separating data from presentation in user interface design. This basic MVC pattern allows for the flexible reuse of each of the Model, View, and Control artifacts by application authors in varying configurations.

Features
========

* :ref:`First-class client-side data model, StatefulModel  <dojox/mvc/StatefulModel>`
* :ref:`Simple data binding layer, Bind  <dojox/mvc/Bind>`
* :ref:`Data binding mixin for dijits, _DataBindingMixin  <dojox/mvc/_DataBindingMixin>`
* A number of new widgets and MVC containers, including:

  * :ref:`Output: A data-bound output widget  <dojox/mvc/Output>`
  * :ref:`Group: An aggregation of widgets with the same parent data binding context  <dojox/mvc/Group>`
  * :ref:`Repeat: A model-bound repeater widget that binds to a data collection  <dojox/mvc/Repeat>`
  * :ref:`Generate: A simple example of UI generation from a supplied data model  <dojox/mvc/Generate>`

 
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
