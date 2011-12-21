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

.. code-example ::

  .. js ::

        dojo.require("dijit.form.Textarea");
        dojo.require("dojox.mvc.StatefulModel");
        dojo.require("dojox.mvc.Generate");

        function updateView(){
            var modeldata = dojo.fromJson(dijit.byId("modelArea").value);
            var model = new dojox.mvc.StatefulModel({ data : modeldata });
            dijit.byId("view").set("ref", model);
        }
        dojo.ready(updateView);

  .. html ::

    <div id="mainContent">
        <h3>Model</h3>
        <div class="row">
            <textarea class="cell" data-dojo-type="dijit.form.Textarea" id="modelArea" data-dojo-props="onBlur: updateView">
    {
        "First"  : "John",
        "Last"   : "Doe",
        "Email"  : "jdoe@example.com",
        "Address": {
            "Street" : "123 Valley Rd",
            "City"   : "Katonah",
            "State"  : "NY",
            "Zip"    : "10536"
        },
        "Phones" : [{
            "Areacode" : "111",
            "Local"    : "111-1111"
        },{
            "Areacode" : "222",
            "Local"    : "222-2222"
        }]
    }
            </textarea>
        </div>
        <h3>Generated View</h3>
        <div id="view" data-dojo-type="dojox.mvc.Generate" data-dojo-props="idNameMapping:{'String' : 'view_t'}"></div>
    </div>

In the above example, the Generate will create a view with a label and TextBox for each of the fields listed in the textarea, and any updates to the textarea will be cause the view to be updated.
