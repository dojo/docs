#format dojo_rst

dojox.mobile
============

:Status: Draft
:Version: 1.0
:Authors: Jared Jurkiewicz
:Developers: Yoshiroh Kamiyama, Jared Jurkiewicz
:Available: since V1.5

.. contents::
    :depth: 2

Have you wanted to build applications for the iPhone, Android, or other similar WebKit based mobile browsers that had the look and feel of a 'native' application for the device, but was merely a web-page so you retained total control?  If so, then this module may provide much of what you need.  This project provides through CSS3 and custom styles, interfaces that display and work wellon mobile devices.

The code is deliberately kept as lightweight as possible, using CSS3 animations and the like to perform the effects.  There is a compat.js, which will simulate most of the effects using dojo.animateProperty and dojox.gfx where possible on browsers such as FireFox and IE.  It will not load by default, it has to be required in separately.

========
Features
========

* Extemely lightweight parser for instantiating widgets to keep code size down.  It does not support embedded script behaviors or the like.
* Transitional effects such as flip, slide and fade to move between views.
* CSS3 Animations where possible.  This provides high-speed, smooth, animations on WebKit based browsers.  For non-webkit based browsers, a 'compat' module exists to mimic most of the animations by using dojo.animateProperty.
* CSS themes for Apple's iPhone and Google Android based mobile phones to mimic look and feel.
* A series of lightweight widgets to mimic basic mobile device native interfaces, including:

  * View - A single 'page')
  * Switch - An on/off toggle-style button.)
  * Button - Styled to match the device)
  * Heading - Styled to match the device)
  * Round-corner rectangle boxes.
  * Edge-To-Edge category heading.
  * Round Corner - List of rounded-corner rectangles for data display.
  * Edge to Edge List - A basic list.
  * ListItem - Basic list items to use in the various list containers.
  * IconContainer - A container to house icons for actions/events.
  * IconItem - A idget for representing an icon and associated actions.
  * Tab Container - A basic native-looking tab container.
  * TabPane - A basic container for tab content (used in conjunction with Tab Container)
  * ProgressIndicator - A native-looking progress bar/display page.

---- /!\ '''Edit conflict - other version:''' ----

=====
Usage
=====

Loading the basic dojox.mobile codebase is extremely simple.  It's a couple requires and then selecting the CSS.  That's it.

Loading the javascript:

.. code-block :: javascript
 
    // Load the basic mobile widgetry and support code. 
    dojo.require("dojox.mobile");
    // Load the lightweight parser.  dojo.parser can also be used, but it requires much more code to be loaded.
    dojo.require("dojox.mobile.parser");


Selecting the CSS to apply (iphone or android currently) is equally simple:

.. code-block :: html

  <style>
    @import "dojox/editor/plugins/resources/css/TextColor.css";
  </style>

---- /!\ '''Edit conflict - your version:''' ----

=====
Usage
=====

Loading the basic dojox.mobile codebase is extremely simple.  It's a couple requires and then selecting the CSS.  That's it.

Loading the javascript:

.. code-block :: javascript
 
    // Load the basic mobile widgetry and support code. 
    dojo.require("dojox.mobile");
    
    // Load the lightweight parser.  dojo.parser can also be used, but it requires much more code to be loaded.
    dojo.require("dojox.mobile.parser");

    // Load the non-webkit animation compat package (if necessary)
    dojo.requireIf(dojo.isWebKit, "dojox.mobile.compat");


Selecting the CSS to apply (iphone or android currently) is equally simple:

.. code-block :: html

  <style>
    @import "dojox/editor/plugins/resources/css/TextColor.css";
  </style>


---- /!\ '''End of edit conflict''' ----
