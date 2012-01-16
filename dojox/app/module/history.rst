.. _dojox/app/module/history:

============================
dojox.app.module.history
============================

:since: V1.7

``dojox.app.module.history`` manages transition forward and backward between views/scenes. A view can use ``transitionOptions`` or ``href`` to navigate forward or backward by utilizing HTML5 history API.

Usage
-----

<<<<<<< HEAD
``trasitionOptions`` can be used on any ``dojox.mobile`` widgets which inherit from ``dojox.mobile._ItemBase``. The following sample will result in transition to the 'second' view in 'main' scene of the application.
=======
Forward transition using transitionOptions

transitionOptions can be used on any dojox.mobile widgets which inherited from dojox.mobile._ItemBase. The following sample will result in transition to the 'second' view in 'main' scene of the application.
>>>>>>> baf4a4717a90c7542de55b8461fa3d397455ba0a

.. html ::

  <li data-dojo-type="dojox.mobile.ListItem" iconPos="0,0,29,29"  clickable="true" transitionOptions='{target:"main,second",url: "#main,second"}'>
    Main Scene::Second View
  </li>

Transition Attributes
---------------------

------
target
------
String.  The target view or scene id path. Note the value for the target|String
should be the complete id path from its ancestor scene to the
leaf view.

---
url
---
String.  The url that will be used to update the location value in
browser's address bar after the transition.


Forward Transition Using ``href``
---------------------------------
Besides the ``transitionOptions`` on mobile widgets, the ``href`` attribute in a hyperlink can also start the transition in ``dojox.app``. The following HTML snippet results in a transition to the 'main' view of 'main' scene.

.. html ::

  <a href="#main,main">to main,main</a>


Backward transition
-------------------
To start the backward transition, all we need to do is to add a back button on the Heading widgets of ``dojox.mobile``. The back attribute declares the back button label on the heading in the following sample.

.. html ::

  <h1 data-dojo-type="dojox.mobile.Heading" back="Home">Data Binding Example</h1>

<<<<<<< HEAD

Sample App Navigation
---------------------
=======
Sample
=====================
>>>>>>> baf4a4717a90c7542de55b8461fa3d397455ba0a
Sample excerpt of view template with regarding to navigation and history

---------
main.html
---------

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

-----------
second.html
-----------

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

The following images show the resulting views. 'Main Scene::Second View' will transition to 'View simple/second' by ``transitionOptions`` configuration, and the 'to main,main' link will transition to 'Main Scene Views' by 'href' configuration. The 'back' button will navigate backward to 'Main Scene Views'.

.. image :: ./pic1.png
  
.. image :: ./pic2.png
