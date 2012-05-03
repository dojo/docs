.. _dojox/mobile/ViewController:

===========================
dojox.mobile.ViewController
===========================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.8

.. contents ::
    :depth: 2

Introduction
============

dojox.mobile.ViewController is a singleton class which controls view transitions. This class listens to "startTransition" events and performs view transitions. If the transition destination is an external view specified with the url parameter, the view content is retrieved and parsed to create a new target view.

Constructor Parameters
======================

None.

Examples
========

Load external views
-------------------

You can load external views from the URL of an html fragment or a JSON data by using the "openExternalView" function as described in the example below.

.. html ::

  <script type="text/javascript" src="dojox/mobile/deviceTheme.js" 
          data-dojo-config="mblThemeFiles: ['base','Button']"></script>

.. js ::

  require([
      "dijit/registry",
      "dojox/mobile/ViewController",
      "dojox/mobile/parser",
      "dojox/mobile",
      "dojox/mobile/Button"
  ], function(registry, ViewController){
      var vc = ViewController.getInstance();
      onBtn1Clicked = function(e){
          // the external view is loaded under the "container" view.
          vc.openExternalView({
              url:"data/view1.html", 
              transition:"slide"
          }, registry.byId("container").containerNode);
      };
  });

.. html ::

  <div id="home" data-dojo-type="dojox.mobile.View">
      <h1 data-dojo-type="dojox.mobile.Heading">Home</h1>
      <button data-dojo-type="dojox.mobile.Button" id="btn1" style="margin:5px;"
              data-dojo-props='onClick:onBtn1Clicked'>Load external view</button>
  </div>
  <div id="container" data-dojo-type="dojox.mobile.View">
      <!-- An external view is loaded here when clicking the button above -->
  </div>

.. html ::

  <!-- data/view1.html (HTML fragment file) -->
  <div id="view1" dojoType="dojox.mobile.View">
      <h1 dojoType="dojox.mobile.Heading" back="Home" moveTo="home">view1.html</h1>
      <ul dojoType="dojox.mobile.EdgeToEdgeList">
          <li dojoType="dojox.mobile.ListItem">Jack Coleman</li>
          <li dojoType="dojox.mobile.ListItem">James Evans</li>
          <li dojoType="dojox.mobile.ListItem">Jason Griffin</li>
      </ul>
  </div>

.. image :: ViewController-openExternalView.gif


If you want to just load the external view and prevent the transition after it's loaded, you can do so by specifying "noTransition:true" property as below:

.. js ::

  require([
      "dijit/registry",
      "dojox/mobile/ViewController",
      "dojox/mobile/parser",
      "dojox/mobile",
      "dojox/mobile/Button"
  ], function(registry, ViewController){
      var vc = ViewController.getInstance();
      onBtn1Clicked = function(e){
          // the external view is loaded under the "container" view,
          // but not transition to it after loaded.
          vc.openExternalView({
              url:"data/view1.html", 
              noTransition:true
          }, registry.byId("container").containerNode);
      };
  });
