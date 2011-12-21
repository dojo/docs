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
|ref               |String or    |          |The value of the data binding expression passed declaratively by the developer. This usually references |
|                  |StatefulModel|          |a location within an existing datamodel and may be a relative reference based on the parent / container |
|                  |             |          |data binding (dot-separated string).                                                                    |
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

.. code-example ::

  .. js ::

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
                }
            ]
        };

        // The dojox.mvc.StatefulModel class creates a data model instance
        // where each leaf within the data model is decorated with dojo.Stateful
        // properties that widgets can bind to and watch for their changes.
        var searchRecords = dojox.mvc.newStatefulModel({ data : search_results_init });

  .. html ::

    <div data-dojo-type="dojox.mvc.Group" data-dojo-props="ref: 'searchRecords'">
        <!--
            The repeat container denotes a templated UI that operates over a collection
            of data records.
            The UI can be customized for each iteration using properties such as
            ${this.index} for the iteration index.
        -->
        <div id="repeatId" data-dojo-type="dojox.mvc.Repeat" data-dojo-props="ref: 'results'">
            <div class="row" data-dojo-type="dojox.mvc.Group" data-dojo-props="ref: '${this.index}'">
                <label class="cell" for="nameInput${this.index}">Name:</label>
                <input class="cell" data-dojo-type="dijit.form.TextBox" id="nameInput${this.index}"
                                    data-dojo-props="ref: 'First'"></input>
            </div>
        </div>
    </div>

In the above example, the TextBoxes inside the repeat with the id="repeatId" will display the firstname of each of the entries in the model.
