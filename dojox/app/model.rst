.. _dojox/app/model:

================
dojox.app.model
================

:since: V1.7


dojox.app.model creates statefulModel data objects using JSON data or dojo data store. The data model can be bound to a dojox.mvc widget by dojox.app.bind.

Models can be declared in the application configuration at application level or different view levels. The model declared at application level can be accessed by all scenes and views in this application. The model declared at view level can be accessed by this view or its children views.

Sample
==============
Sample application configuration for dojox.app.model

.. js ::

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
  },
  
  // Define views and their associated models
  "views":{
    "repeat": {
      "type": "dojox.app.view",
      "models": {
        "repeatmodel": {
          "params":{
            "store": {"$ref":"#stores.repeatStore"}
          }
        }
      },
      "template": "views/repeat.html",
      "dependencies":["dojox/mobile/TextBox"],
    }
  }

When the model named 'repeatmodel' is created, it can only be bound to view named 'repeat'. When the model named 'names' is created, it can be bound to any view in the application. For data binding, please check dojox.app.bind.
