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

dojox.app.view sample template - views/simple/home.html

.. code-block :: html

  <div class="view mblView">
    <h1 dojoType="dojox.mobile.RoundRectCategory" style="text-align:center;vertical-align:middle;margin-left:0px;padding-left:0px"><div>Welcome to Dojo Mobile Showcase</div>
    <img src="images/welcomeLogo.png"/>
    </h1>
  </div>

Sample render result

.. image :: /pic.png
