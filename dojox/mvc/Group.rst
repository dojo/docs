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

        var model = dojox.mvc.newStatefulModel({ data : {
            "First" : "John",
            "Last"  : "Doe",
            "Email" : "jdoe@example.com"
        }});

  .. css ::

        .row { width: 500px; display: inline-block; margin: 5px; }
        .cell { width: 20%;  display:inline-block; }

  .. html ::

    <div id="main">
        <div class="row">
            <label class="cell" for="firstnameInput">First:</label>
            <input class="cell" id="firstnameInput" data-dojo-type="dijit.form.TextBox"
                   data-dojo-props="ref: model.First"></input>
            <!-- Content in output below will always be in sync with value of textbox above -->
            <span data-dojo-type="dojox.mvc.Output" data-dojo-props="ref: model.First">
                (first name is: ${this.value})
            </span>
        </div>
        <div class="row">
            <label class="cell" for="lastnameInput">Last:</label>
            <input class="cell" id="lastnameInput" data-dojo-type="dijit.form.TextBox"
                   data-dojo-props="ref: model.Last"></input>
            <span data-dojo-type="dojox.mvc.Output" data-dojo-props="ref: model.Last">
                (last name is: ${this.value})
            </span>
        </div>
        <div class="row">
            <label class="cell" for="emailInput">Email:</label>
            <input class="cell" id="emailInput" data-dojo-type="dijit.form.TextBox"
                   data-dojo-props="ref: model.Email"></input>
            <span data-dojo-type="dojox.mvc.Output" data-dojo-props="ref: model.Email">
                (email is: ${this.value})
            </span>
        </div>
        <br/>
        Model:
        <button id="reset" type="button" data-dojo-type="dijit.form.Button" data-dojo-props="onClick: function(){model.reset();}">Reset</button>
    </div>
