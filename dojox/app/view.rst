.. _dojox/app/view:

dojox.app.view
================

:Status: Draft
:Version: 1.0
:Available: since V1.7

``dojox.app.view`` provides a view like ``dojox.mobile.View``. It contains a template string which will be rendered with user defined template segments. A view should have no child view.

Sample View Configuration
-----------
A sample application configuration for ``dojox.app.view`` could look like:

.. code-block :: javascript

  "home": {
    "type": "dojox.app.view",
    "dependencies":["dojox/mobile/RoundRectList", "dojox/mobile/ListItem"],
    "template": "views/simple/home.html"
  }

A sample ``dojox.app.view`` template could look like:

.. code-block :: html

  &lt;div style="background:#c5ccd3;width: 100%; height: 100%;" class="view mblView"&gt;
  &lt;div dojoType="dojox.mobile.RoundRect" shadow="true"&gt;
    This is the content of the home scene. Hello World.
  &lt;/div&gt;
&lt;/div&gt;

The result of this configuration would look like:

.. image :: /pic.png
