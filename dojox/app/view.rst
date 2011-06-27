#format dojo_rst
dojox.app.view
================

:Status: Draft
:Version: 1.0
:Available: since V1.7

dojox.app.view provides a view like dojox.mobile.View. It contains a template string which will be rendered with user defined template segments. A view should have no child view. 

==============
Sample
==============
Sample application configuration for dojox.app.view

.. code-block :: javascript

  "home": { 
    "type": "dojox.app.view",
    "dependencies":["dojox/mobile/RoundRectList","dojox/mobile/ListItem"],
    "template": "views/simple/home.html"
  }
