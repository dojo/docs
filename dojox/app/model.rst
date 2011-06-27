#format dojo_rst
dojox.app.model
================

:Status: Draft
:Version: 1.0
:Available: since V1.7


dojox.app.model creates statefulModel data objects using JSON data or dojo data store. The data model can be binded to a dojox.mvc widget by dojox.app.bind.

==============
Sample
==============
Sample application configuration for dojox.app.model

.. code-block :: javascript

  // Define stores for dojox.app data model
  "stores": {
    "namesStore":{
      "type": "dojo.store.Memory",
      "params": {
        "data": "modelApp.names"
      }
    },
    "repeatStore":{
      "type": "dojo.store.Memory",
      "params": {
        "data": "modelApp.repeatData"
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

When the model named 'names' is created, it can be bound to a dojox.mvc.Group in the view template.

Sample view template

.. code-block :: html

  <div id="infoGroup" class="fieldset" dojoType="dojox.mvc.Group" ref="'names.0'">
  </div>
