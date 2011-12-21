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
|ref               |String or    |          |The value of the data binding expression passed declaratively by the developer. This usually references |
|                  |StatefulModel|          |a location within an existing datamodel and may be a relative reference based on the parent / container |
|                  |             |          |data binding (dot-separated string).                                                                    |
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

        // Load the parser, we'll use the declarative data binding syntax (ref).
        dojo.require("dojo.parser");

        // Load the dijits we need.
        dojo.require("dijit.form.Button");
        dojo.require("dijit.form.TextBox");

        // Load the basic MVC support, Output and Group .
        dojo.require("dojox.mvc");
        dojo.require("dojox.mvc.Group");
        dojo.require("dojox.mvc.Output");

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
        // The dojox.mvc.StatefulModel class creates a data model instance
        // where each leaf within the data model is decorated with dojo.Stateful
        // properties that widgets can bind to and watch for their changes.
        var model = new dojox.mvc.StatefulModel({ data : order });

  .. css ::

        .row { width: 500px; display: inline-block; margin: 5px; }
        .cell { width: 20%;  display:inline-block; }

  .. html ::

    <div id="main">
        <div class="row" id="addrGroup" data-dojo-type="dojox.mvc.Group" data-dojo-props="ref: 'model.ShipTo'">
            <div class="row">
                <label class="cell" for="streetInput">Street:</label>
                <input class="cell" id="streetInput" data-dojo-type="dijit.form.TextBox" data-dojo-props="ref: 'Street'"/>
            </div>
            <div class="row">
                <label class="cell" for="cityInput">City:</label>
                <input class="cell" id="cityInput" data-dojo-type="dijit.form.TextBox" data-dojo-props="ref: 'City'"/>
            </div>
            <div class="row">
                <label class="cell" for="stateInput">State:</label>
                <input class="cell" id="stateInput" data-dojo-type="dijit.form.TextBox" data-dojo-props="ref: 'State'"/>
            </div>
            <div class="row">
                <label class="cell" for="zipInput">Zipcode:</label>
                <input class="cell" id="zipInput" data-dojo-type="dijit.form.TextBox" data-dojo-props="ref: 'Zip'"/>
            </div>
        </div>
        <br/>
        Choose:
        <button id="shipto" type="button" data-dojo-type="dijit.form.Button" onClick="dijit.byId('addrGroup').set('ref',model.ShipTo);">Ship To</button>
        <button id="billto" type="button" data-dojo-type="dijit.form.Button" onClick="dijit.byId('addrGroup').set('ref',model.BillTo);">Bill To</button>
    </div>
