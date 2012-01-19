.. _dojox/app:

=========
dojox.app
=========

:since: V1.7

``dojox.app`` is an application framework designed to allow simple configuration
of nested scenes and views and to facilitate the transitioning between these
views.  It is similar in function to the ``dojox.mobile.app`` framework, but will
not be limited to use on mobile devices.  Applications for desktops, mobiles,
and tablets will be configurable and buildable for easy and fast deployment.

There are two core modules that will need to work together to accomplish these goals:

  - dojox/app - A library that provides high-level application controllers, defined by metadata which describes the overall structure and navigation of the application and it's views.
  - dojox/mvc - A library that provides the ability to have view concerns separated from model or data concerns but have simple bindings or connections between them that can keep either side in sync, as well as respond to events or actions.  The library also provides the ability to generate data-bound forms and views dynamically, built on key elements of mvc and app.

Overview
=========
The following diagram represents layout management.  The difference between a scene and a view is that scenes may have multiple children views but a view does not have a child.

dojox.app Components
====================
``dojox.app`` is constructed of seven core modules;  each very focused and compact.

:ref:`dojox.app.view <dojox/app/view>`
--------------------------------------
``dojox.app.view`` provides a view like ``dojox.mobile.View``. It contains a template string which will be rendered with user defined template segments. A view should have no child view.

:ref:`dojox.app.bind <dojox/app/bind>`
--------------------------------------
``dojox.app.bind`` is used to query ``dojox.mvc`` widgets and get/set binding data for each widgets with  "ref" or data-dojo-props="ref: xxx" tag. ``dojoType``, ``data-dojo-type``, ``ref`` and ``data-dojo-props`` attributes are compatible in a view.

:ref:`dojox.app.model <dojox/app/model>`
----------------------------------------
``dojox.app.model`` creates a ``StatefulModel`` data source with JSON data or dojo data store. The data model can be ``binded`` to a ``dojox.mvc`` widget using ``dojox.app.bind``.

:ref:`dojox.app.scene <dojox/app/scene>`
----------------------------------------
``dojox.app.scene`` is used to create the layout for each child view, manage the transition between views, and resize the layout to fit the display area. A scene can contain one or more children views or scenes. The difference between scene and view is that scene can have multiple children scenes views but view cannot have children.

dojox.app.module.env
--------------------
``dojox.app.module.env`` provides the dojo, dijit, and dojox environments.

:ref:`dojox.app.module.history <dojox/app/module/history>`
----------------------------------------------------------
``dojox.app.module.history`` manages transitions forward and backward between views/scenes. A view can use 'transitionOptions' or 'href' to navigate forward or backward by utilizing HTML5 history API.

:ref:`dojox.app.main <dojox/app/main>`
--------------------------------------
``dojox.app.main`` (Application) is used to create a ``dojox.app`` application by the configuration in ``config.json``. The main responsibilities of ``dojox.app.main`` include loading the application configuration, loading data from data source, creating views, creating data models, binding data models to views using ``dojox.app.bind``, creating scenes between views, and parsing the application with ``dojo.parser.parse``.


The Configuration Object
========================
Configuration comes in the form of a basic object with several key, pre-defined properties:

id
--
String.  The ``dojox.app`` application's id.

.. js ::

  id: "sampleApp",

name
----
String.  The ``dojox.app`` application's name.

.. js ::

  name: "Sample App",

description
-----------
String.  The description of the ``dojox.app`` application

.. js ::

  description: "Sample application that does what is needed",

dependencies
------------
Array. Dependencies of ``dojox.app`` application. It can be defined as global     
dependencies for application or as view dependencies in a view.        
Represented as array of string paths to dependencies.

.. js ::

  "dependencies": [
    "dojox/mobile/TabBar",
    "dojox/mobile/RoundRect",
    "dojox/mobile/TabBarButton",
    "dojox/mobile/Button",
    "dojox/mobile/RoundRect",
    "dojox/mobile/Heading"
  ],

modules
-------
Array.  Modules for the application. Used as the mixins in 
``dojo.declare()`` for the application. They modify the top level behavior 
of the application, how it processes the config, or any other life cycle
Represented as array of string paths to modules.

.. js ::

  "modules": [
  "dojox/app/module/env",
  "dojox/app/module/history"
  ],

stores
------
Object.  Dojo data stores which are used by ``dojox.app`` the data model. A data    
store is composed by store name, store type and store parameters.      
Represented as an object with sub-objects, with type and               
params properties to be passed to store during initialization.

.. js ::

  "stores": {
    "store1":{
      "type": "dojo.store.Memory",
      "params": { // parameters used to initialize the data store
        "data": "modelApp.names"
      }
    },
    "store1":{
      "type": "dojo.store.JsonRest",
      "params": {
        "data": "modelApp.repeatData"
      }
    }
  },

template
--------
String.  HTML file which will act as the application template.

.. js ::

  "template": "application.html",

models
------
Object.  Models and instantiation parameters for the models including 'type' as 
a property allows one to override the class that will be used for the  
model. By default it is ``dojox.mvc.model``.

.. js ::

  "models": {
    "names": {
      "params":{
        "store": {"$ref":"#stores.namesStore"}
      }
    }
  },

defaultView
-----------
String. The name of the scene/view to load when the application is initialized.

.. js ::

  "defaultView": "home",

defaultTransition
-----------------
String. The default animation type for the view transition.

.. js ::

  "defaultTransition": "slide",

views
-----
Object.  The children views/scenes of the application or current scene. Dependencies may be defined via views for optimization and organization purposes.  View types, models, and transition properties may be defined, along with the template. 

.. js ::
  
  "views": {
    // simple view without any children views or scenes
    // views can has its own dependencies which will be loaded
    // before the view is first intialized.
    "home": {
      "type": "dojox.app.view",
      "dependencies":[
        "dojox/mobile/RoundRectList",
        "dojox/mobile/ListItem",
        "dojox/mobile/EdgeToEdgeCategory"
      ],
      "template": "views/simple/home.html"
    },

    // simple scene which loads all views and shows the default first
    "main":{
      // all views in the main scene will be bound to the user model
      "models": [],
      "type": "dojox.app.scene",
      "template": "simple.html",
      "defaultView": "main",
      "defaultTransition": "slide",
      // the views available to this scene
      "views": {
        "main":{
          "template": "views/simple/main.html"
        },
        "second":{
          "template": "views/simple/second.html"
        },
        "third":{
          "template": "views/simple/third.html"
        }
      },
      "dependencies":[
        "dojox/mobile/RoundRectList",
        "dojox/mobile/ListItem",
        "dojox/mobile/EdgeToEdgeCategory",
        "dojox/mobile/EdgeToEdgeList"
      ]
    },
    "repeat": {
      "type": "dojox.app.view",
      // model declared at scene/view level will be accessible to this scene/view
      // or its children.
      "models": {
        "repeatmodels": {
          "params":{
            "store": {"$ref":"#stores.repeatStore"}
          }
        }
      },
      "template": "views/repeat.html",
      "dependencies":["dojox/mobile/TextBox"]
    }
  }

This configuration serves two purposes:  configuring the application within the client and acting as a map for building the application for production.


Sample dojox.app Usage
======================

As with any Dojo-based web application, it's important to create your HTML page with a ``SCRIPT`` tag referencing ``dojo.js`` and a ``SCRIPT`` tag referencing the application configuration file:

.. html

  <!DOCTYPE HTML PUBLIC "-// W3C// DTD HTML 4.01// EN" "http:// www.w3.org/TR/html4/strict.dtd">
  <html>
    <head>
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,minimum-scale=1,user-scalable=no"/>
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <title>Sample App</title>
    <link href="../../../mobile/themes/iphone/base.css" rel="stylesheet"></link>

    <script type="text/javascript" src="../../../../dojo/dojo.js"></script>
    <!-- the actual application launcher -->
    <script type="text/javascript" src="sampleApp.js"></script>

    </head>
  <body>

  </body>
  </html>

The next step is registering the modules path for the custom application namespace which will be called "app".  After the module is registered, the base dependencies are loaded via ``require()`` including the ``dojox/app`` base as well as application configuration:

.. js ::

  // Get current path
  var path = window.location.pathname;
  if(path.charAt(path.length)!="/"){
    path = path.split("/");
    path.pop();
    path=path.join("/");
  }

  // register current application module path
  dojo.registerModulePath("app", path);

  // load configuration json file
  require(["dojo/_base/html", "dojox/app/main", "dojo/text!app/config.json"], function(dojo, Application, config){
    // startup the application
    app = Application(eval("(" + config + ")"));
  });

Upon loading the ``dojox.app`` configuration file, views, scenes, and models are created with the template. The env resource provides a dojo runtime environment for ``dojox.app`` and history caching operations.

The complete configuration for the sample app could look like:

.. js ::

  {
    "id": "sampleApp",
    "name": "Sample App",
    "description": "A Sample App",
    "splash": "splash",

    // Dependencies for the application. The modules in the dependencies array object will be
    // loaded before application is started.
    "dependencies": [
      "dojox/mobile/TabBar",
      "dojox/mobile/RoundRect",
      "dojox/mobile/TabBarButton",
      "dojox/mobile/Button",
      "dojox/mobile/RoundRect",
      "dojox/mobile/Heading"
    ],

    // stores we are using
    "stores": {
      "namesStore":{
        "type": "dojo.store.Memory",
        "params": { // parameters used to initialize the data store
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

    // models and instantiation parameters for the models. Including 'type' as a property
    // allows one to override the class that will be used for the model.  By default it is
    // dojox/mvc/model
    // The model declared at application level will be initialized before application startup
    // The model declared at scene/view level will be initialized before scene/view loaded
    "models": {
      "names": {
        "params":{
          "store": {"$ref":"#stores.namesStore"}
        }
      }
    },

    // Modules for the app.  The are basically used as the second
    // array of mixins in a dojo.declare().  Modify the top level behavior
    // of the app, how it processes the config or any other life cycle
    // by creating and including one or more of these
    "modules": [
      "dojox/app/module/env",
      "dojox/app/module/history"
    ],

    "template": "application.html",

    // the name of the scene to load when the app is initialized.
    "defaultView": "home",

    // The default animation effect of transition between sub scenes and views of
    // this application.
    "defaultTransition": "slide",

    // scenes are groups of views and models loaded at once
    // scenes and view in the application all have access to application level models
    "views": {
      // simple view without any children views or scenes
      // views can has its own dependencies which will be loaded
      // before the view is first initialized.
      "home": {
        "type": "dojox.app.view",
        "dependencies":[
          "dojox/mobile/RoundRectList",
          "dojox/mobile/ListItem",
          "dojox/mobile/EdgeToEdgeCategory"
        ],
        "template": "views/simple/home.html"
      },

      // simple scene which loads all views and shows the default first
      "main":{
        // all views in the main scene will be bound to the user model
        "models": [],
        "type": "dojox.app.scene",
        "template": "simple.html",
        "defaultView": "main",
        "defaultTransition": "slide",
        // the views available to this scene
        "views": {
          "main":{
            "template": "views/simple/main.html"
          },
          "second":{
            "template": "views/simple/second.html"
          },
          "third":{
            "template": "views/simple/third.html"
          }
        },
        "dependencies":[
          "dojox/mobile/RoundRectList",
          "dojox/mobile/ListItem",
          "dojox/mobile/EdgeToEdgeCategory",
          "dojox/mobile/EdgeToEdgeList"
        ]
      },
      "repeat": {
        "type": "dojox.app.view",
        // model declared at scene/view level will be accessible to this scene/view
        // or its children.
        "models": {
          "repeatmodels": {
            "params":{
              "store": {"$ref":"#stores.repeatStore"}
            }
          }
        },
        "template": "views/repeat.html",
        "dependencies":["dojox/mobile/TextBox"]
      }
    }
  }


An application may have as many scenes and views as required.  The end product will look like:

.. image :: ./app/pic3.png


Comparison with dojox.mobile.app
================================
The main difference between ``dojox.app`` and ``dojox.mobile.app`` is listed as following.

* ``dojox.app`` enables the model binding
* ``dojox.app`` uses scene/view structure to enable the nested scene or view which resembles the composite design pattern. It does not mean ``dojox.mobile.app`` cannot do that but it needs coding to implement that.
* ``dojox.app`` contains the layout mechanism to ensure the content at different application/scene/view level work well together
* ``dojox.mobile.app`` manage the navigation history in StageController by using a history stack. ``dojox.app`` manage the navigation history through HTML5 pushState standard and delegate it to browser enabled history management.

The following graphics compare ``dojox.app`` with ``dojox.mobile.app``:

.. image :: ./app/Diagram3.png

With ``dojox.mobile.app``, layout is managed by the widget library.  A scene has only one view and SceneAssistant is responsible for the lifecycle of that view.

.. image :: ./app/Diagram1.png

With ``dojox.app``, layout is managed by scene.  The difference between the scene and views is that a scene may have multiple views and children scenes, a view does not have children.