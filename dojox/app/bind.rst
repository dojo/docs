.. _dojox/app/bind:

dojox.app.bind
==============

:Status: Draft
:Version: 1.0
:Available: since V1.7

``dojox.app.bind`` provides a function to query ``dojox.mvc` widgets, and get and set binding data for each widgets with "ref" or data-dojo-props="ref: xxx" tag. ``dojoType``, ``data-dojo-type``, ``ref`` and ``data-dojo-props`` are compatible in a view.

Binding API
-----------
The method signature of the bind function ``dojox.app.bind`` is:

.. code-block :: javascript

  function(/*Array of widgets*/ widgets, /*Object*/ models)

Parameters Detail
-----------

widgets
~~~~~~~~~~~~~
An array of dojo widgets where bind function will search for bindable ``dojox.mvc`` widgets

models
~~~~~~~~~~~~~
An object which contains pairs of model name and its associated ``dojo.Stateful`` model object

Sample Binding
-----------
Sample raw data could look like:

.. code-block :: javascript

  modelApp.names = [{
            "Serial" : "360324",
            "First"  : "John",
            "Last"   : "Doe",
            "Email"  : "jdoe@us.ibm.com",
            "ShipTo" : {
                "Street" : "123 Valley Rd",
                "City"   : "Katonah",
                "State"  : "NY",
                "Zip"    : "10536"
            },
            "BillTo" : {
                "Street" : "17 Skyline Dr",
                "City"   : "Hawthorne",
                "State"  : "NY",
                "Zip"    : "10532"
            }
        }];

The sample application configuration for data to be bound could look like:

.. code-block :: javascript

  // Define data store for dojox.app.bind
  "stores": {
    "namesStore":{
      "type": "dojo.store.Memory",
      "params": {
        "data": "modelApp.names"
      }
    }
  },
  // Define data models for dojox.app.bind
  "models": {
    "names": {
      "params":{
        "store": {"$ref":"#stores.namesStore"}
      }
    }
  }

The sample view template for data binding could look like:

.. code-block :: html

  <div id="infoGroup" class="fieldset" dojoType="dojox.mvc.Group" ref="'names.0'">
    <div class="field-row">
      <span>Order #</span>
      <input type=text id="lastnameInput" dojoType="dojox.mobile.TextBox"
             placeholder="Order #" ref="'rel:Serial'"></input>
    </div>
    <div class="field-row">
      <span>Last</span>
      <input type=text id="serialInput" dojoType="dojox.mobile.TextBox"
             placeholder="Last" ref="'rel:Last'"></input>
    </div>
    <div class="field-row">
      <span>Email</span>
      <input type=text id="emailInput1" dojoType="dojox.mobile.TextBox"
             placeholder="Last" ref="'rel:Email'"></input>
    </div>
  </div>

The result would look like:

.. image :: /pic1.png

Sample Summary
~~~~~~~~~~~~~
In this sample, “stores” use “modelApp.names” data to create a  dojo.store.Memory store  named “namesStore”. While “models” use “namesStore” to create a ``dojox.mvc.StatefulModel` model. Then simple.html template bind the model to  infoGroup with ref="'names.0'", and each  ``dojox.mobile.TextBox`` widget bind a data with “ref” property.

After the application startup, you can see the data was bound to the view (in the red rectangle) and there's no data operation in user's code to complete this function.
