.. _dojox/mvc:

=========
dojox.mvc
=========

:Authors: Akira Sudoh, Ed Chatelain, Rahul Akolkar
:Developers: Akira Sudoh, Ed Chatelain, Rahul Akolkar
:since: V1.7

.. contents ::
    :depth: 2

Introduction
============

Enterprise Rich Internet Applications (RIAs) often focus more on rich data vs. the rich media aspects of RIAs more typical of consumer applications. For example, such RIAs depend on implementing the well-known CRUD operations on data stored in back-end systems. The dojox/mvc package focuses on View to Model data binding (eg. View Controller) concerns on the client, easing development of data-rich UI’s which Create, Read, Update, and Delete data. dojox.mvc deals with data binding/controller concerns within a View, but does not deal with application level concerns that span multiple Views (such as navigation), see dojox/app for Application-level Controller concerns.

How it works
============

dojox/mvc has the following properties:

* It enables widgets (desktop and mobile) to "bind" to data within the model. A bind creates a bi-directional or a single directional update mechanism between the bound view and the underlying data.

* The data model is "live" data i.e. it maintains any updates driven by the view on the underlying data.

* The data model issues updates to portions of the view if the data they bind to is updated in the model. For example, if two widgets are bound to the same part of a data model, updating the value of one in the view will cause the data model to issue an update to the other widget with the new value.

* When the model is backed by a dojo.store or dojo.data query, the client-side updates can be persisted once the client is ready to "submit" the changes (which may include both value changes or structural changes - adds/deletes). The datamodel allows control over when the underlying data is persisted i.e. this can be more incremental or batched per application needs. 

Features
========

:ref:`dojox/mvc/sync <dojox/mvc/sync>` a simple data binding layer which support one-way or two-way binding and a converter.

:ref:`dojox/mvc/at <dojox/mvc/at>` typically used in in data-dojo-props so that a widget can synchronize its attribute with another dojo.Stateful.

:ref:`dojox/mvc/StatefulModel <dojox/mvc/StatefulModel>` has been deprecated.

* dojox/mvc/StatefulModel had several different features:

  * Support for array (Notifying removals/additions of elements to watchers)

  * Conversion of dojox/mvc/StatefulModel from/to plain objects/values

  * Bridge to Dojo Object Store

* Though some applications use all of these features, many applications do not.

  * As 1.8 dojox/mvc supports binding any stateful attribute, dojox/mvc/StatefulModel’s unique approach of converting non-object value to dojox/mvc/StatefulModel (with “value” attribute) is no longer needed. Regular dojo/Stateful can be used as data model, in many cases.

  * Some applications do not use array in data model at all.

  * Some applications use arrays in data model in a static manner (No notification is needed for removals/additions of elements for such kind of applications).

  * Some applications would implement getters/setters in its data models to work with more complex data (e.g. XML from REST call, whose request for data item tends to be served by XPath).

* To be able to support these different needs dojox/mvc/StatefulModel is being separated into to classes that support each item:


  * :ref:`dojox/mvc/StatefulArray <dojox/mvc/StatefulArray>` A class that supports handling array, which can notify removals/additions of elements.

  * :ref:`dojox/mvc/getStateful <dojox/mvc/getStateful>` A function that creates stateful objects from plain objects/values (Will work as a successor of dojox.mvc.newStatefulModel()).

  * :ref:`dojox/mvc/getPlainValue <dojox/mvc/getPlainValue>` A function that creates plain objects/values from stateful objects (Will works as a successor of dojox.mvc.StatefulModel.toPlainObject()).

  * :ref:`dojox/mvc/EditStoreRefController <dojox/mvc/EditStoreRefController>` Components to work with Dojo Object Store (Something that does dojox.mvc.StatefulModel.commit(), dojox.mvc.StatefulModel._commit() and dojox.mvc.StatefulModel._saveToStore()).


* A number of widgets and MVC containers are also available, including:

  * :ref:`dojox/mvc/Output <dojox/mvc/Output>` A data-bound output widget.
  * :ref:`dojox/mvc/Group <dojox/mvc/Group>` An aggregation of widgets with the same parent data binding context.
  * :ref:`dojox/mvc/Repeat <dojox/mvc/Repeat>` A model-bound repeater widget that binds to a data collection.
  * :ref:`dojox/mvc/Generate <dojox/mvc/Generate>` A simple example of UI generation from a supplied data model.

* :ref:`dojox/mvc/_DataBindingMixin <dojox/mvc/_DataBindingMixin>` has been deprecated.
 
Examples
========

Basic example, input-output sync: Anything typed into the input fields will be updated in the model and reflected in the output field when you leave the input field.

.. code-example::
  :djConfig: parseOnLoad: false, async: true, mvc:{debugBindings: true}
  :toolbar: versions, themes
  :version: 1.7-2.0

  .. js ::


		var model;
		require([
			'dojo/_base/kernel',
			'dojo/parser',
			'dojo/Stateful',
			'dijit/form/TextBox',
			'dijit/form/Button',
			'dojox/mvc/Output',
			'dojox/mvc/at'
			], function(kernel, parser, Stateful, TextBox, Button, Output, at){
				console.log("dojo kernel.version() is ",kernel.version);
				//alert(kernel.version);
				window.at = at;
				// For this test we can use a simple dojo/Stateful as our model
				model = new Stateful({First: "John", Last: "Doe", Email: "jdoe@example.com"});
				console.log("model=",model);
				//console.log("dojo.version() is "+dojo.version);
				parser.parse();
			});

  .. css ::

        .row { width: 500px; display: inline-block; margin: 5px; }
        .cell { width: 20%;  display:inline-block; }
        .textcell { width: 30%;  display:inline-block; }   

  .. html ::


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
		  <input class="cell" id="firstnameInput" data-dojo-type="dijit.form.TextBox" 
					data-dojo-props="value: at(model, 'First')">
		<!-- Content in output below will always be in sync with value of textbox above -->
			(first name is: <span data-dojo-type="dojox/mvc/Output" 
				data-dojo-props="_setValueAttr: {node: 'domNode', type: 'innerText'}, 
                                                                 value: at(model, 'First')"></span>)
		</div>
		<div class="row">
			<label class="cell" for="lastnameInput">Last:</label>
			<input class="cell" id="lastnameInput" data-dojo-type="dijit.form.TextBox" 
						data-dojo-props="value: at(model, 'Last')">
			(last name is: <span data-dojo-type="dojox/mvc/Output" 
				data-dojo-props="_setValueAttr: {node: 'domNode', type: 'innerText'}, 
                                                                 value: at(model, 'Last')"></span>)
		</div>
		<div class="row">
			<label class="cell" for="emailInput">Email:</label>
			<input class="cell" id="emailInput" data-dojo-type="dijit.form.TextBox" 
					data-dojo-props="value: at(model, 'Email')">
			(email is: <span data-dojo-type="dojox/mvc/Output" 
					data-dojo-props="_setValueAttr: {node: 'domNode', type: 'innerText'}, 
									value: at(model, 'Email')"></span>)
		</div>
	    </div>
	  </div>
	</div>



Basic example two, input-output sync: Anything typed into the input fields will be updated in the model and reflected in the output field when you leave the input field.  The "Reset" button will reset the model back to it's original values.  The other buttons show how to programmatically set things in the model to have the update reflected in the widget, and how to programmatically update the widget and have it update the model.

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
