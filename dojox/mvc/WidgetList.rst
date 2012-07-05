.. _dojox/mvc/WidgetList:

====================
dojox.mvc.WidgetList
====================

:Authors: Akira Sudoh, Ed Chatelain
:Developers: Akira Sudoh, Ed Chatelain
:since: V1.8


.. contents ::
   :depth: 2

A widget that creates child widgets repeatedly based on the children attribute (the repeated data) and childType/childMixins/childParams attributes (determines how to create each child widget).

Parameters
======================

+------------------+-------------+----------+--------------------------------------------------------------------------------------------------------+
|Parameter         |Type         |Default   |Description                                                                                             |
+------------------+-------------+----------+--------------------------------------------------------------------------------------------------------+
|children          |StatefulArray|          |The array of data model that is used to render child nodes.                                             |
+------------------+-------------+----------+--------------------------------------------------------------------------------------------------------+
|childClz          |Function     |          |The class of the child widget. Takes precedence over childType/childMixins.                             |
|                  |             |          |                                                                                                        |
+------------------+-------------+----------+--------------------------------------------------------------------------------------------------------+
|childType         |String       |          |The module ID of child widget. childClz takes precedence over this/childMixins.                         |
|                  |             |          |Can be specified via data-mvc-child-type attribute of widget declaration.                               |
+------------------+-------------+----------+--------------------------------------------------------------------------------------------------------+
|childMixins       |String       |          |The list of module IDs, separated by comma, of the classes that will be mixed into child widget.        |
|                  |             |          |childClz takes precedence over childType/this.Can be specified via data-mvc-child-mixins attribute of   |
|                  |             |          |widget declaration.                                                                                     |
+------------------+-------------+----------+--------------------------------------------------------------------------------------------------------+
|childParams       |Object       |          |The mixin properties for child widget. Can be specified via data-mvc-child-props attribute of widget    |
|                  |             |          |declaration. "this" in data-mvc-child-props will have the following properties:                         |
|                  |             |          |- this.parent - This widget's instance.                                                                 |
|                  |             |          |- this.target - The data item in children.                                                              |
+------------------+-------------+----------+--------------------------------------------------------------------------------------------------------+
|childBindings     |Object       |          |Data bindings for child widget.                                                                         |
|                  |             |          |                                                                                                        |
+------------------+-------------+----------+--------------------------------------------------------------------------------------------------------+
|templateString    |String       |          |The template string for each child items. templateString in child widgets take precedence over this.    |
|                  |             |          |                                                                                                        |
+------------------+-------------+----------+--------------------------------------------------------------------------------------------------------+
|partialRebuild    |Boolean      |false     |If true, only rebuild repeat items for changed elements. Otherwise, rebuild everything if there is a    |
|                  |             |          |change in children.                                                                                     |
+------------------+-------------+----------+--------------------------------------------------------------------------------------------------------+


Examples
========

Declarative example 1:
----------------------
Create multiple instances of dijit/TextBox based on the data in array, and 
create multiple instances a label and a Textbox using dojox/mvc/InlineTemplate.

.. code-example::
  :djConfig: parseOnLoad: true, mvc: {debugBindings: true}
  :version: local
  :toolbar: versions, themes

  .. js ::

		require([
        'dojo/parser',
        'dojo/ready',
        'dojox/mvc/getStateful',
        'dijit/form/TextBox',
        'dijit/form/Button',
        'dojox/mvc/Group',
        'dojox/mvc/WidgetList',
        'dojox/mvc/Output'
        ], function(parser, ready, getStateful){

        // Initial data
		var data = {
  			"identifier": "Serial",
   			"items": [ 
                    {
                        "Serial"  : "A111",
                        "First"   : "Anne",
                        "Last"    : "Ackerman",
                        "Email"   : "a.a@test.com"
                    },
                    {
                        "Serial"  : "B111",
                        "First"   : "Ben",
                        "Last"    : "Beckham",
                        "Email"   : "b.b@test.com"
                    },
                    {
                        "Serial"  : "I111",
                        "First"   : "Irene",
                        "Last"    : "Ira",
                        "Email"   : "i.i@test.com"
                    },
                    {
                        "Serial"  : "J111",
                        "First"   : "John",
                        "Last"    : "Jacklin",
                        "Email"   : "j.j@test.com"
                    }
                ]
			};

                // The getStateful call will take json data and create make it Stateful
                searchRecords = getStateful(data);
        });

  .. css ::

        .row { width: 500px; display: inline-block; margin: 5px; }
        .cell { width: 20%;  display:inline-block; }

  .. html ::

		<script type="dojo/require">at: "dojox/mvc/at"</script>
		<div id="main">
			<div data-dojo-type="dojox/mvc/Group"
				data-dojo-props="target: searchRecords">
        	<!--
                The WidgetList container denotes a templated UI that operates over
                a collection of data records.
        	-->
        	<h4>Declarative WidgetList using data-mvc-child-type to create TextBox with data bound to the First name from the items: </h4>
        	<div data-dojo-type="dojox/mvc/WidgetList"
                 data-dojo-props="children: at('rel:', 'items')"
                 data-mvc-child-type="dijit/form/TextBox"
                 data-mvc-child-props="value: at(this.target, 'First'),
                                                class: 'row'">
        	</div>
		</div>
		<h4>Declarative WidgetList using a dojox/mvc/InlineTemplate to create label with the Serial and a TextBox with data bound to the First name from the items: </h4>
		<div data-dojo-type="dojox/mvc/WidgetList"
			data-dojo-mixins="dojox/mvc/_InlineTemplateMixin"
			data-dojo-props="children: at(searchRecords, 'items')">
			<script type="dojox/mvc/InlineTemplate">
			<div>
				<span data-dojo-type="dijit/_WidgetBase"
						data-dojo-props="value: at('rel:', 'Serial'),
							_setValueAttr: {node: 'domNode',
									type: 'innerText'}">
					</span>:
					<span data-dojo-type="dijit/form/TextBox"
						data-dojo-props="value: at('rel:', 'First')"></span>
				</div>
			</script>
		</div>
		<p>Updates to either set of TextBoxes will be reflected in the other set when tabbing out of the field, since they are bound to the same model properties.
		</div>

		
Programmatic example 1:
-----------------------
Create multiple instances a label and a Textbox with the First and Last name using two types of programmatic creation of a WidgetList.

.. code-example::
  :djConfig: parseOnLoad: true, mvc: {debugBindings: true}
  :version: local
  :toolbar: versions, themes

  .. js ::

		var templateString2 = '<div class="row">'
		+ '<script type="dojo/require">at: "dojox/mvc/at"<\/script>'
		+ '<label class="cell">Name:</label>'
		+ '<input id="${parent.id}_textbox${indexAtStartup}" class="cell" data-dojo-type="dijit/form/TextBox" data-dojo-attach-point="firstNode"></input>'
		+ '<input class="cell" data-dojo-type="dijit/form/TextBox" data-dojo-attach-point="lastNode"></input>'
		+ '</div>';


		require([
			"dojo/_base/declare",
			"dojo/when",
			"dojo/dom",
			"dojo/parser",
			"dojo/promise/all",
			"dojo/store/Memory",
			"dijit/registry",
			"dijit/_WidgetBase",
			"dojox/mvc/at",
			"dojox/mvc/EditStoreRefListController",
			"dojox/mvc/WidgetList",
			"dijit/form/TextBox",
			"dojox/mvc/Group",
			"dojo/domReady!"
		], function(declare, when, ddom, parser, all, Memory, registry, _WidgetBase, at, EditStoreRefListController, WidgetList){

        // Initial data
		var data = {
  			"identifier": "Serial",
   			"items": [ 
                    {
                        "Serial"  : "A111",
                        "First"   : "Anne",
                        "Last"    : "Ackerman",
                        "Email"   : "a.a@test.com"
                    },
                    {
                        "Serial"  : "B111",
                        "First"   : "Ben",
                        "Last"    : "Beckham",
                        "Email"   : "b.b@test.com"
                    },
                    {
                        "Serial"  : "I111",
                        "First"   : "Irene",
                        "Last"    : "Ira",
                        "Email"   : "i.i@test.com"
                    },
                    {
                        "Serial"  : "J111",
                        "First"   : "John",
                        "Last"    : "Jacklin",
                        "Email"   : "j.j@test.com"
                    }
                ]
			};

			ctrl = new EditStoreRefListController({store: new Memory({data: data})});

			// Programatic WidgetList using childBindings and a templateString using attach-points
			(new WidgetList({templateString: templateString2, 
							children: at(ctrl, "model"),
							childBindings: {
								firstNode: {value: at("rel:", "First")},
								lastNode: {value: at("rel:", "Last")}
							}},
							ddom.byId("programmaticRepeat1"))).startup();
							
			// Programatic WidgetList using childParams and startup function to setup bindings with templateString using attach-points
			(new WidgetList({templateString: templateString2, 
							children: at(ctrl, "model"),
							childParams: {
								startup: function(){
									this.firstNode.set("value", at("rel:", "First"));
									this.lastNode.set("value", at("rel:", "Last"));
									this.inherited("startup", arguments);
							}}},
							ddom.byId("programmaticRepeat2"))).startup();
							
			when(all([parser.parse(), ctrl.queryStore()]), function(a){
				console.log("parser.parse and queryStore are complete ctrl.model is set to from the query",a[1]);
			});

        });


  .. css ::

        .row { width: 500px; display: inline-block; margin: 5px; }
        .cell { width: 20%;  display:inline-block; }

  .. html ::

		<div id="main">
			<h4>Programatic WidgetList using childBindings to setup the bindings with a templateString using attach-points: </h4>
			<div id="programmaticRepeat1"></div>
			<h4>Programatic WidgetList using childParams and startup function to setup bindings with templateString using attach-points: </h4>
			<div id="programmaticRepeat2"></div>
			<p>In the above example, the TextBoxes inside the WidgetList are bound to the same model, so updates in one list will be reflected in the other.        
		</div>
