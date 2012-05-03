.. _dojox/mobile/Badge:

==================
dojox.mobile.Badge
==================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.8

.. contents ::
    :depth: 2

Introduction
============

dojox.mobile.Badge is a utility to create/update a badge node. It is not a widget, but just a convenient function. Note that a badge consists of a simple DOM button. It can be created even without dojox.mobile.Badge.

.. image :: Badge.png

Constructor Parameters
======================

+--------------+----------+----------------------+----------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default               |Description                                                                                   |
+--------------+----------+----------------------+----------------------------------------------------------------------------------------------+
|value         |String    |"0"                   |A text to show in a badge.                                                                    |
+--------------+----------+----------------------+----------------------------------------------------------------------------------------------+
|className     |String    |"mblDomButtonRedBadge"|A class name of a DOM button.                                                                 |
+--------------+----------+----------------------+----------------------------------------------------------------------------------------------+
|fontSize      |Number    |16                    |Font size in pixel. The other styles are determined by the DOM button itself.                 |
+--------------+----------+----------------------+----------------------------------------------------------------------------------------------+

Examples
========

Declarative example
-------------------

.. html ::

  <!-- Need to load the CSS stylesheets for the badge classes you use -->
  <link href="dojox/mobile/themes/common/domButtons/DomButtonRedBadge.css" rel="stylesheet"/>
  <link href="dojox/mobile/themes/common/domButtons/DomButtonGreenBadge.css" rel="stylesheet"/>
  <link href="dojox/mobile/themes/common/domButtons/DomButtonBlueBadge.css" rel="stylesheet"/>

.. js ::

  require([
      "dojox/mobile",
      "dojox/mobile/parser",
      "dojox/mobile/Badge"
  ]);

.. html ::

  <!-- Using default style -->
  <div data-dojo-type="dojox.mobile.Badge" data-dojo-props='value:"10"'></div>

  <!-- Specifying className -->
  <div data-dojo-type="dojox.mobile.Badge" class="mblDomButtonRedBadge" data-dojo-props='value:"20"'></div>
  <div data-dojo-type="dojox.mobile.Badge" class="mblDomButtonBlueBadge" data-dojo-props='value:"30"'></div>
  <div data-dojo-type="dojox.mobile.Badge" class="mblDomButtonGreenBadge" data-dojo-props='value:"40"'></div>

  <!-- Specifying fontSize -->
  <div data-dojo-type="dojox.mobile.Badge" data-dojo-props='value:"50", fontSize:11'></div>
  <div data-dojo-type="dojox.mobile.Badge" 
          class="mblDomButtonBlueBadge" data-dojo-props='value:"60", fontSize:11'></div>
  <div data-dojo-type="dojox.mobile.Badge" 
          class="mblDomButtonGreenBadge" data-dojo-props='value:"70", fontSize:11'></div>

.. image :: Badge-example1.png


Programmatic example
--------------------

.. html ::

  <!-- Need to load the CSS stylesheets for the badge classes you use -->
  <link href="dojox/mobile/themes/common/domButtons/DomButtonRedBadge.css" rel="stylesheet"/>
  <link href="dojox/mobile/themes/common/domButtons/DomButtonGreenBadge.css" rel="stylesheet"/>
  <link href="dojox/mobile/themes/common/domButtons/DomButtonBlueBadge.css" rel="stylesheet"/>

.. js ::

  require([
      "dojo/_base/window",
      "dojo/ready",
      "dojox/mobile/Badge",
      "dojox/mobile",
      "dojox/mobile/parser"
  ], function(win, ready, Badge){
      ready(function(){
          // Using default style
          var badge1 = new Badge({value:"10"});
          win.body().appendChild(badge1.domNode);
          
          // Specifying className
          var badge2 = new Badge({value:"20", className:"mblDomButtonRedBadge"});
          win.body().appendChild(badge2.domNode);
          
          var badge3 = new Badge({value:"30", className:"mblDomButtonBlueBadge"});
          win.body().appendChild(badge3.domNode);
          
          var badge4 = new Badge({value:"40", className:"mblDomButtonGreenBadge"});
          win.body().appendChild(badge4.domNode);
          
          // Specifying fontSize
          var badge5 = new Badge({value:"50", fontSize:11});
          win.body().appendChild(badge5.domNode);
          
          var badge6 = new Badge({value:"60", fontSize:11, className:"mblDomButtonBlueBadge"});
          win.body().appendChild(badge6.domNode);
          
          var badge7 = new Badge({value:"70", fontSize:11, className:"mblDomButtonGreenBadge"});
          win.body().appendChild(badge7.domNode);
      });
  });

.. image :: Badge-example1.png

Getting/Setting the value
-------------------------

You can get/set the value of badge by calling getValue()/setValue(value) functions as described in the example below.

.. html ::

  <!-- Need to load the CSS stylesheets for the badge classes you use -->
  <link href="dojox/mobile/themes/common/domButtons/DomButtonRedBadge.css" rel="stylesheet"/>

.. js ::

  require([
      "dojo/ready",
      "dojo/_base/window",
      "dojox/mobile/Badge",
      "dojox/mobile",
      "dojox/mobile/parser"
  ], function(ready, win, Badge){
      ready(function(){
          // Create a badge
          var badge = new Badge({value:"10"});
          win.body().appendChild(badge.domNode);
          
          // Get the value of badge widget
          console.log(badge.getValue()); // "10"
          
          // Set the value of badge widget
          badge.setValue("100");
          console.log(badge.getValue()); // "100"
      });
  });
