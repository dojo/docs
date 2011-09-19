#format dojo_rst

dojox.mvc._DataBindingMixin
===========================

:Status: Draft
:Version: 0.1
:Authors: Rahul Akolkar, Ed Chatelain
:Developers: Rahul Akolkar, Ed Chatelain
:Available: since V1.7


.. contents::
   :depth: 2

Provides the ability for dijits or custom view components to become data binding aware.  Data binding awareness enables dijits or other view layer 
components to bind to locations within a client-side data model, which is commonly an instance of the dojox.mvc.StatefulModel class. A bind is a bi-directional update mechanism which is capable of synchronizing value changes between the bound dijit or other view component and the specified location within the data model, as well as changes to other properties such as "valid", "required", "readOnly" etc


========
Examples
========

Declarative example1
--------------------

.. code-block :: html

	<script>
		var model;
		require(["dijit/StatefulModel", "dojo/parser"], function(StatefulModel, parser){
			model = new StatefulModel({ data : {
				hello : "Hello World"
			}});
			parser.parse();
		});
	</script>

	<input id="hello1" data-dojo-type="dijit.form.TextBox"
		data-dojo-props="ref: model.hello"></input>

	<input id="hello2" data-dojo-type="dijit.form.TextBox"
		data-dojo-props="ref: model.hello"></input>

In the above example, both dijit.form.TextBox instances (with IDs "hello1" and "hello2" respectively) are bound to the same reference location in the data model i.e. "hello" via the "ref" expression "model.hello". Both will have an initial value of "Hello World". Thereafter, a change in the value of either of the two textboxes will cause an update of the value in the data model at location "hello" which will in turn cause a matching update of the value in the other textbox.

=================
Available Methods
=================

* `dojox.mvc.Bind <dojox/mvc/Bind>`_

Bind the specified property of the target to the specified property of the source with the supplied transformation.


======================
Parameters
======================

+------------------+---------+--------------+--------------------------------------------------------------------------------------------------------+
|Parameter         |Type     |Default       |Description                                                                                             |
+------------------+---------+--------------+--------------------------------------------------------------------------------------------------------+
|source            |Stateful |              |The source dojo.Stateful object for the bind.                                                           |
+------------------+---------+--------------+--------------------------------------------------------------------------------------------------------+
|sourceProp        |String   |              |The name of the source's property whose change triggers the bind.                                       |
+------------------+---------+--------------+--------------------------------------------------------------------------------------------------------+
|target            |Stateful |              |The target dojo.Stateful object for the bind whose property will be updated with the result of the      |
|                  |         |              |function.                                                                                               |
+------------------+---------+--------------+--------------------------------------------------------------------------------------------------------+
|targetProp        |String   |              |The name of the target's property to be updated with the result of the function.                        |
+------------------+---------+--------------+--------------------------------------------------------------------------------------------------------+
|func              |Function |              |The optional calculation to be performed to obtain the target property value.                           |
+------------------+---------+--------------+--------------------------------------------------------------------------------------------------------+
|bindOnlyIfUnequal |Function | false        |Whether the bind notification should happen only if the old and new values are unequal (optional).      |
+------------------+---------+--------------+--------------------------------------------------------------------------------------------------------+


=================
Available Methods
=================

* `dojox.mvc.BindInputs <dojox/mvc/BindInputs>`_

Bind the values at the sources specified in the first argument array such that a composing function in the second argument is called when any of the values changes.


======================
Parameters
======================

+------------------+----------+-------------+--------------------------------------------------------------------------------------------------------+
|Parameter         |Type      |Default      |Description                                                                                             |
+------------------+----------+-------------+--------------------------------------------------------------------------------------------------------+
|sourceBindArray   |Stateful[]|             |The array of dojo.Stateful objects to watch values changes on.                                          |
+------------------+----------+-------------+--------------------------------------------------------------------------------------------------------+
|func              |String    |             |The composing function that is called when any of the source values change.                             |
+------------------+----------+-------------+--------------------------------------------------------------------------------------------------------+
