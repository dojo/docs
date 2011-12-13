.. _dojox/app/scene:

================
dojox.app.scene
================

:since: V1.7

dojox.app.scene is used to create the layout for each child view, manage the transition between views, resize layout to fit the display area. A scene can contains one or more children views or scenes. The difference between scene and view is that scene can have multiple children scenes views but view does not have child.

Usage
===============
If there is no child scene in the application, it is not necessary to declare the view as type 'dojox.app.scene' because dojox.app.main inherits dojox.app.scene and the application itself is a scene. For the application contains child scene, the child scene needs to be declared as 'dojox.app.scene' in the application like the 'tabscene' in the following sample.

Sample
===============
Sample application configuration

.. js ::

  "views": {
    "home": {
      "type": "dojox.app.view",
      "dependencies":["dojox/mobile/ListItem", "dojox/mobile/RoundRectList", "dojox/mobile/RoundRectCategory", "dojox/mobile/Heading"],
      "template": "views/main.html"
    },
  
    "simple":{
      "type": "dojox.app.view",
      "template": "views/simple.html",
      "dependencies":["dojox/mobile/TextBox"],
    },
  
    "repeat": {
      "type": "dojox.app.view",
      "models": {
        "repeatmodels": {
          "params":{
            "store": {"$ref":"#stores.repeatStore"}
          }
        }
      },
      "template": "views/repeat.html",
      "dependencies":["dojox/mobile/TextBox"],
    },
  
    "generate": {
      "type": "dojox.app.view",
      "template": "views/generate.html",
      "dependencies":["dojox/mobile/TextBox", "dojox/mobile/TextArea", "dojox/mvc/Generate"],
    },
  
    // simple scene which loads all views and shows the default first
    "tabscene": {
      // all views in the second scene will be bound to the user model
      "type": "dojox.app.scene",
      "template": "tabScene.html",
      "defaultView": "tab1",
      "defaultTransition": "flip",
  
      // the views available to this scene
      "views": {
        "tab1":{
          "template": "views/tabs/tab1.html"
        },
        "tab2":{
          "template": "views/tabs/tab2.html"
        },
        "tab3":{
          "template": "views/tabs/tab3.html"
        }
      }
    }
  }

Sample rendering result

.. image :: ./pic1.png
