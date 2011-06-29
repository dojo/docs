#format dojo_rst
dojox.app.history
=================

:Status: Draft
:Version: 1.0
:Available: since V1.7

dojox.app.module.history manages transition forward and backward between views/scenes. A view can use 'transitionOptions' or 'href' to navigate forward or backward by utilizing HTML5 history API.

==========
Usage
==========

Forward transition using transitionOptions

trasitionOptions can be used on any dojox.mobile widgets which inherited from dojox.mobile._ItemBase. The following sample will result in transition to the 'second' view in 'main' scene of the application.

.. code-block :: html

  <li dojoType="dojox.mobile.ListItem" iconPos="0,0,29,29"  clickable="true" transitionOptions='{target:"main,second",url: "#main,second"}'>
    Main Scene::Second View
  </li>

transitionOptions attributes

+-------------------+---------------------------------------------------------------+----------------+
|**Attribute**      |**Description**                                                |**Type**        |
+-------------------+---------------------------------------------------------------+----------------+
|target             |The target view or scene id path. Note the value for the target|String          |
|                   |should be the complete id path from its ancestor scene to the  |                |
|                   |leaf view                                                      |                |
+-------------------+---------------------------------------------------------------+----------------+
|url                |The url that will be used to update the location value in      |String          |
|                   |browser's address bar after the transition.                    |                |
+-------------------+---------------------------------------------------------------+----------------+

Forward transition using href

Besides the transitionOptions on mobile widgets, href attribute in hyperlink can also start the transition in dojox.app. Following sample will result in transition to 'main' view of 'main' scene.

.. code-block :: html

  <a href="#main,main">to main,main</a>

Backward transition
To start backward transition, all we need to do is to add a back button on the Heading widgets of dojox.mobile. The back attribute declares the back button label on the heading in the following sample.

.. code-block :: html

  <h1 dojoType="dojox.mobile.Heading" back="Home">Data Binding Example</h1>

=====================
Sample
=====================
