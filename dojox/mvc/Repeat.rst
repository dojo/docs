.. _dojox/mvc/Repeat:

=================
dojox.mvc.Repeat
=================

:Authors: Rahul Akolkar, Ed Chatelain
:Developers: Rahul Akolkar, Ed Chatelain
:since: V1.7


.. contents ::
   :depth: 2

A repeat is bound to an intermediate dojo.Stateful node corresponding to an array in the data model. Child dijits or custom view components inside it inherit their parent data binding context from it.

Parameters
==========

+------------------+-------------+----------+--------------------------------------------------------------------------------------------------------+
|Parameter         |Type         |Default   |Description                                                                                             |
+------------------+-------------+----------+--------------------------------------------------------------------------------------------------------+
|children          |StatefulArray|          |The array of data model that is used to render child nodes.                                             |
+------------------+-------------+----------+--------------------------------------------------------------------------------------------------------+
|index             |Integer      |          |An index used to track the current iteration when the repeating UI is produced. This may be used to     |
|                  |             |          |parameterize the content in the repeat template for the current iteration.                              |
+------------------+-------------+----------+--------------------------------------------------------------------------------------------------------+
|exprchar          |Character    | '$'      |Character to use for a substitution expression, for a substitution string like ${this.index}            |
|                  |             |          |                                                                                                        |
+------------------+-------------+----------+--------------------------------------------------------------------------------------------------------+


Examples
========

Declarative example
-------------------

.. code-example::
  :djConfig: parseOnLoad: true, mvc: {debugBindings: true}
  :version: local
  :toolbar: versions, themes

  .. js ::

		var searchRecords; 
		require([
			'dojo/parser',
			'dojo/ready',
			'dojox/mvc/getStateful',
			'dijit/form/TextBox',
			'dijit/form/Button',
			'dojox/mvc/Group',
			'dojox/mvc/Repeat',
			'dojox/mvc/Output'
			], function(parser, ready, getStateful){

			// Initial data
			var search_results_init = {
  			   "Query" : "Engineers",
  			      "Results" : [
                                {
                                  "First": "Anne",
                                  "Last" : "Ackerman",
                                  "Email": "a.a@test.com"
                                },
                                {
                                  "First": "Ben",
                                  "Last" : "Beckham",
                                  "Email": "b.b@test.com"
                                },
                                {
                                  "First": "John",
                                  "Last" : "Jacklin",
                                  "Email": "j.j@test.com"
                                }]
                        };
				// The getStateful call will take json data and create make it Stateful
				searchRecords = getStateful(search_results_init);
			});

  .. css ::

        .row { width: 500px; display: inline-block; margin: 5px; }
        .cell { width: 20%;  display:inline-block; }

  .. html ::

		<script type="dojo/require">at: "dojox/mvc/at"</script>
		<div id="main">
		<div data-dojo-type="dojox/mvc/Group" data-dojo-props="target: searchRecords">
        <!--
            The repeat container denotes a templated UI that operates over a collection
            of data records.
            The UI can be customized for each iteration using properties such as
            ${this.index} for the iteration index.
        -->
        <div id="repeatId" data-dojo-type="dojox/mvc/Repeat" data-dojo-props="children: at('rel:', 'Results')">
            <div class="row" data-dojo-type="dojox/mvc/Group" data-dojo-props="target: at('rel:', ${this.index})">
                <label class="cell" for="nameInput${this.index}">Name:</label>
                <input class="cell" data-dojo-type="dijit/form/TextBox" id="nameInput${this.index}"
                                    data-dojo-props="value: at('rel:', 'First')"></input>
            </div>
        </div>
		</div>
        <p>In the above example, the TextBoxes inside the repeat with the id="repeatId" will display the firstname of each of the entries in the model.
		</div>
