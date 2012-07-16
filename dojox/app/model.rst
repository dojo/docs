.. _dojox/app/model:

===============
dojox/app/model
===============

:since: V1.7

``dojox/app/model`` depending on the application models configuration, this module is creating either simple or MVC models
for the views to bind their widgets to.

Models can be declared in the application configuration at application level or different view levels. The model declared
at application level can be accessed by all scenes and views in this application. The model declared at view level can be
accessed by this view or its children views.

Sample application configuration for ``dojox/app/model``:

.. js ::

  "stores": {
    "store1":{
      "type": "dojo/store/Memory",
      "params": { // parameters used to initialize the data store
        "data": "modelApp.names"
      }
    },
    "store1":{
      "type": "dojo/store/JsonRest",
      "params": {
        "data": "modelApp.repeatData"
      }
    }
  }

  "models": {
    "model1": {
       "modelLoader": "dojox/app/utils/mvcModel",
       "type": "dojox/mvc/EditStoreRefListController",
        "params":{
          "store": {"$ref":"#stores.namesStore"}
        }
    },
    "model2": {
      "modelLoader": "dojox/app/utils/simpleModel",
      "params":{
        "store": {"$ref":"#stores.namesStore"}
      }
    }
  }

When the ``dojox/app/utils/mvcModel`` model loader is used, ``dojox/mvc`` models are created otherwise simple models are created.

The created models are avaible on the view instance trough the loadedModels property. For example you can access them in the controller of your view:


.. js ::

  define([], function(){
    return {
      init: function(){
         var mvcModel = this.loadedModels["model1"];
      }
    }
  );

