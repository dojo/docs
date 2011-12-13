.. _dojox/app/bind:

==============
dojox.app.bind
==============

:since: V1.7

dojox.app.bind provides a function to query dojox.mvc widgets, get and set binding data for each widgets with "ref" or data-dojo-props="ref: xxx" tag. data-dojo-type, data-dojo-type, ref and data-dojo-props are compatible in a view.

Binding API
==============

Method signature of the bind function dojox.app.bind provides.

.. js ::

  function(/*Array of widgets*/ widgets, /*Object*/ models)

Parameters Detail

+----------------------+---------------------------------------------+
|**Parameter**         |**Description**                              |
+----------------------+---------------------------------------------+
| widgets              |An array of dojo widgets where bind function |
|                      |will search for bindable dojox.mvc widgets   |
+----------------------+---------------------------------------------+
| models               |An object which contains pairs of model name |
|                      |and its associated dojo.Stateful model object|
+----------------------+---------------------------------------------+

Sample
=============

Sample raw data for data binding

.. js ::

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

Sample application configuration for data to be bound

.. js ::

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

Sample view template for data binding - simple.html

.. html ::

  <div id="infoGroup" class="fieldset" data-dojo-type="dojox.mvc.Group" ref="'names.0'">
    <div class="field-row">
      <span>Order #</span>
      <input type=text id="lastnameInput" data-dojo-type="dojox.mobile.TextBox"
             placeholder="Order #" ref="'rel:Serial'"></input>
    </div>
    <div class="field-row">
      <span>Last</span>
      <input type=text id="serialInput" data-dojo-type="dojox.mobile.TextBox"
             placeholder="Last" ref="'rel:Last'"></input>
    </div>
    <div class="field-row">
      <span>Email</span>
      <input type=text id="emailInput1" data-dojo-type="dojox.mobile.TextBox"
             placeholder="Last" ref="'rel:Email'"></input>
    </div>
  </div>

Sample UI rendering result with data bound

.. image :: ./pic1.png

Sample Summary

In this sample, “stores” use “modelApp.names” data to create a  dojo.store.Memory store  named “namesStore”. While “models” use “namesStore” to create a dojox.mvc.StatefulModel model. Then simple.html template bind the model to  infoGroup with ref="'names.0'", and each  dojox.mobile.TextBox widget bind a data with “ref” property.

After the application startup, you can see the data was bound to the view (in the red rectangle) and there's no data operation in user's code to complete this function.
