.. _dojox/mvc/Generate:

===================
dojox.mvc.Generate
===================

:Authors: Rahul Akolkar, Ed Chatelain
:Developers: Rahul Akolkar, Ed Chatelain
:since: V1.7


.. contents ::
   :depth: 2

A container that generates a view based on the data model its bound to. A generate introspects its data binding and creates a view contained in it that allows displaying the bound data. Child dijits or custom view components inside it inherit their parent data binding context from it.

Parameters
======================

+------------------+-------------+---------------------------------+---------------------------------------------------------------------------------+
|Parameter         |Type         |Default                          |Description                                                                      |
+------------------+-------------+---------------------------------+---------------------------------------------------------------------------------+
|widgetMapping     |Object       |{"String" : "dijit.form.TextBox"}|The mapping of types to a widget class.                                          |
|                  |             |                                 |ie: {'String' : 'dojox.mobile.TextBox'}                                          |
+------------------+-------------+---------------------------------+---------------------------------------------------------------------------------+
|classMapping      |Object       |{"Label" : "generate-label-cell",|The mapping of class to use for each node.                                       |
|                  |             |"String" : "generate-dijit-cell",|                                                                                 |
|                  |             |"Heading" : "generate-heading",  |                                                                                 |
|                  |             |"Row" : "row"}                   |                                                                                 |
+------------------+-------------+---------------------------------+---------------------------------------------------------------------------------+
|idNameMapping     |Object       |{"String" : "textbox_t"}         |The mapping of id and name to use. Set idNameMapping to override this. A count   |
|                  |             |                                 |will be added to the id and name.                                                |
+------------------+-------------+---------------------------------+---------------------------------------------------------------------------------+


Examples
========

Declarative example
--------------------

.. code-example::
  :djConfig: parseOnLoad: true, mvc: {debugBindings: 1}
  :version: local
  :toolbar: versions, themes

  .. js ::

			require([
				"dojo/parser",
				"dojo/_base/json",
				"dijit/form/Textarea",
				"dojox/mvc/Generate"
			], function(parser){
				parser.parse();
			});

  .. html ::

		<script type="dojo/require">at: "dojox/mvc/at"</script>
		<div id="wrapper">
			<div id="header">
				<div id="navigation"></div>
				<div id="headerInsert">
				<h1>View generation example</h1>
				<h2>Data Binding - Generate Container.</h2>
			</div>
		</div>
		<div id="main">
			<div id="leftNav"></div>
			<div id="mainContent">
				<h3>Model</h3>
				<div class="row">
					<textarea id="textarea" data-dojo-type="dijit/form/Textarea">
		{
			Serial: "360324",
			First: "John",
			Last: "Doe",
			Email: "jdoe@example.com",
			Address: {
				Street: "123 Valley Rd",
				City: "Katonah",
				State: "NY",
				Zip: "10536"
			},
			Phones: [
				{
					Areacode: "111",
					Local: "111-1111"
				},{
					Areacode: "222",
					Local: "222-2222"
				}
			],
			Member: {
				Since: "2010",
				Type: "Gold"
			}
		}
					</textarea>
				</div>
				<h3>Generated View</h3>
				<div data-dojo-type="dojox/mvc/Generate"
				 data-dojo-props="children: at('widget:textarea', 'value').direction(at.from).transform({format: dojo.fromJson}), idNameMapping: {String: 'view_t'}"></div>
			</div>
		</div>
		</div>

		<p>In the above example, the Generate will create a view with a label and TextBox for each of the fields listed in the textarea, and any updates to the textarea will be cause the view to be updated when you tab out of the text area.</p>
