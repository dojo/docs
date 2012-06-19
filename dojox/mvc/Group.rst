.. _dojox/mvc/Group:

===============
dojox.mvc.Group
===============

:Authors: Rahul Akolkar, Ed Chatelain
:Developers: Rahul Akolkar, Ed Chatelain
:since: V1.7


.. contents ::
   :depth: 2

A simple model-bound container widget with single-node binding to a data model. A group is usually bound to an intermediate dojo.Stateful node in the data model. Child dijits or custom view components inside a group inherit their parent data binding context from it.

Parameters
======================

+------------------+-------------+----------+--------------------------------------------------------------------------------------------------------+
|Parameter         |Type         |Default   |Description                                                                                             |
+------------------+-------------+----------+--------------------------------------------------------------------------------------------------------+
|target            |dojo/Stateful|          |The data model used for relative data binding.                                                          |
+------------------+-------------+----------+--------------------------------------------------------------------------------------------------------+


Examples
========

Declarative example
-------------------

.. code-example::
  :djConfig: parseOnLoad: true
  :version: local
  :toolbar: versions, themes

  .. js ::

		var model;
 
		require([
			'dojo/parser',
			'dojo/ready',
			'dojox/mvc/getStateful',
			'dijit/form/TextBox',
			'dijit/form/Button',
			'dojox/mvc/Group',
			'dojox/mvc/Output'
			], function(parser, ready, getStateful){
			
			// Initial data
			var order = {
				"Serial" : "360324",
				"First" : "John",
				"Last" : "Doe",
				"Email" : "jdoe@example.com",
				"ShipTo" : {
					"Street" : "123 Valley Rd",
					"City" : "Katonah",
					"State" : "NY",
					"Zip" : "10536"
				},
				"BillTo" : {
					"Street" : "17 Skyline Dr",
					"City" : "Hawthorne",
					"State" : "NY",
					"Zip" : "10532"
				}
			};
				// The getStateful call will take json data and create make it Stateful
				model = getStateful(order);
				// the model created above is initialized with 
				// model.First set to "John", model.Last set to "Doe" and model.Email set to "jdoe@example.com"

			});

			function setRef(id, model, attr) {
				require([
				         "dijit/registry",
				         "dojox/mvc/at"
				         ], function(registry, at){
								var widget = registry.byId(id);
								widget.set("target", model[attr]);
							});
			};

  .. css ::

        .row { width: 500px; display: inline-block; margin: 5px; }
        .cell { width: 20%;  display:inline-block; }

  .. html ::

		<script type="dojo/require">at: "dojox/mvc/at"</script>
		<div id="main">
		<div id="leftNav"></div>
		<div id="mainContent">
		<!--
			The group container denotes some logical grouping of widgets and also serves
			to establish a parent data binding context for its children.
			The target attribute for the outermost container obtains the binding from the
			"page scope" itself.
		-->
		<!--
			For convenience, the widget hierarchy matches the data hierarchy
			(see JSON literal above).
			In this implementation, the child attributes are simple property names
			of the parent binding context.
		-->
		<div class="row" id="addrGroup" data-dojo-type="dojox/mvc/Group" 
							data-dojo-props="target: model.ShipTo">
			<div class="row">
				<label class="cell" for="streetInput">Street:</label>
				<input class="cell" id="streetInput" data-dojo-type="dijit/form/TextBox" 
					data-dojo-props="value: at('rel:', 'Street')">
			</div>
			<div class="row">
				<label class="cell" for="cityInput">City:</label>
				<input class="cell" id="cityInput" data-dojo-type="dijit/form/TextBox" 
					data-dojo-props="value: at('rel:', 'City')">
			</div>
			<div class="row">
				<label class="cell" for="stateInput">State:</label>
				<input class="cell" id="stateInput" data-dojo-type="dijit/form/TextBox" 
					data-dojo-props="value: at('rel:', 'State')">
			</div>
			<div class="row">
				<label class="cell" for="zipInput">Zipcode:</label>
				<input class="cell" id="zipInput" data-dojo-type="dijit/form/TextBox" 
					data-dojo-props="value: at('rel:', 'Zip')">
			</div>
		</div>
		<br/>
		Choose:
		<button id="shipto" type="button" data-dojo-type="dijit/form/Button" 
				data-dojo-props="onClick: function(){setRef('addrGroup', model, 'ShipTo');}">Ship To</button>
		<button id="billto" type="button" data-dojo-type="dijit/form/Button" 
				data-dojo-props="onClick: function(){setRef('addrGroup', model, 'BillTo');}">Bill To</button>
		<br/>
		<br/>
		</div></div>
