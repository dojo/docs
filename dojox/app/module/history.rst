.. _dojox/app/module/history:

============================
dojox.app.module.history
============================

:since: V1.7

dojox.app.module.history manages transition forward and backward between views/scenes. A view can use 'transitionOptions' or 'href' to navigate forward or backward by utilizing HTML5 history API.

Usage
==========

Forward transition using transitionOptions

transitionOptions can be used on any dojox.mobile widgets which inherited from dojox.mobile._ItemBase. The following sample will result in transition to the 'second' view in 'main' scene of the application.

.. html ::

  <li data-dojo-type="dojox.mobile.ListItem" iconPos="0,0,29,29"  clickable="true" transitionOptions='{target:"main,second",url: "#main,second"}'>
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

.. html ::

  <a href="#main,main">to main,main</a>

Backward transition
To start backward transition, all we need to do is to add a back button on the Heading widgets of dojox.mobile. The back attribute declares the back button label on the heading in the following sample.

.. html ::

  <h1 data-dojo-type="dojox.mobile.Heading" back="Home">Data Binding Example</h1>

Sample
=====================
Sample excerpt of view template with regarding to navigation and history

main.html

.. html ::

  <ul data-dojo-type="dojox.mobile.RoundRectList" iconBase="../images/i-icon-all.png">
    <h2 data-dojo-type="dojox.mobile.EdgeToEdgeCategory">Main Scene Views</h2>
  
    <li data-dojo-type="dojox.mobile.ListItem" iconPos="0,0,29,29" clickable="false">
      Main Scene::Main View (Current View)
    </li>
    <li data-dojo-type="dojox.mobile.ListItem" iconPos="0,0,29,29"  clickable="true" transitionOptions='{title:"Main Scene::SecondView",target:"main,second",url: "#main,second"}'>
      Main Scene::Second View
    </li>
    <li data-dojo-type="dojox.mobile.ListItem" iconPos="0,0,29,29"  clickable="true" transitionOptions='{title:"Main Scene::ThirdView",target:"main,third",url: "#main,third"}'>
      Main Scene::Third View
    </li>
  </ul>

second.html

.. html ::

  <h1 data-dojo-type="dojox.mobile.Heading" back="Back">View simple/second</h1>
  <div data-dojo-type="dojox.mobile.RoundRect" shadow="true">
    <a href="#main,main">to main,main</a><br>
    <a href="#main,second">to main,second</a><br>
    <a href="#main,third">to main,third</a><br>
  </div>
  <div data-dojo-type="dojox.mobile.RoundRect" shadow="true">
    <a href="#tabscene,tab2">to tabscene,tab2</a><br>
  </div>

Sample views are rendered as following. 'Main Scene::Second View' will transition to 'View simple/second' by  transitionOptions configuration, and 'to main,main' link will transition to 'Main Scene Views' by 'href' configuration. And 'back' button will backward to 'Main Scene Views'.

.. image :: ./pic1.png
  
.. image :: ./pic2.png
