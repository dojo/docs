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

**Note that use of dijit._Container, dijit._Contained, dijit._Templated, and dojo.query is intentionally avoided to reduce download code size.**

========
Features
========

* Extemely lightweight parser for instantiating widgets to keep code size down.  It does not support embedded script behaviors or the like.
* Transitional effects such as flip, slide and fade to move between views.
* CSS3 Animations where possible.  This provides high-speed, smooth, animations on WebKit based browsers.  For non-webkit based browsers, a 'compat' module exists to mimic most of the animations by using dojo.animateProperty.
* CSS themes for Apple's iPhone and Google Android based mobile phones to mimic look and feel.
* A series of lightweight widgets to mimic basic mobile device native interfaces, including:

  * `View <dojox/mobile/View>`_- A single 'page'
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

====================
Internationalization
====================

dojo.i18n is NOT used for dojox.mobile because:

  * Use of it increases the code size, which affects cachability of the content.
  * Not good for client-side runtime performance, which is important for mobile devices.  The lookup time matters to lighter devices such as a phone.  It has the added advantage of extending battery life due to avoiding CPU cycles for string manipulations.

**Recommended approach is to substitute localized strings on the server**
 
===========================
Cross-Browser Compatibility
===========================

Dojox.mobile supports not only webkit-based mobile browsers, but also non-CSS3 PC browsers such as IE and (older) Firefox browsers. The CSS3 compatibility module (dojox.mobile.compat) is provided to support non-CSS3 browsers.  By default compatibility is not loaded, so if you require your application to work on older browsers (or desktop browsers), you need to conditionally import the dojox.mobile.compat package as part of its initialization.  See the example below:

.. code-block :: javascript

  dojo.require("dojox.mobile");
  dojo.requireIf(!dojo.isWebKit, "dojox.mobile.compat");

If dojox.mobile.compat is loaded, it directly replaces some of the methods of the dojox.mobile widgets to use emulation techniques for the normally CSS3 based animations.  This way, your applications do not need to be changed, and thus html pages remains the same regardless of whether this compatibility module is used or not.

Note:  dojox.mobile.compat automatically loads the compatibility CSS files. It searches the current page for <link> elements, and tries to load corresponding -compat.css files. For example, if it finds .../themes/iphone/iphone.css, it loads .../themes/iphone/iphone-compat.css. In order for this mechanism to work out, you should use the link tags to include the theme CSS files instead of @import statements. 

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

    // Load the compat layer if the incoming browser isn't webkit based
    dojo.requireIf(!dojo.isWebKit, "dojox.mobile.compat");


Selecting the CSS to apply (iphone or android currently) is equally simple:

.. code-block :: html

  <style>
    <link rel="stylesheet" type="text/css" href="dojox/mobile/themes/iphone/iphone.css">
  </style>


========
Examples
========

Basic example, view to view swapping:

.. code-example::
  :djConfig: parseOnLoad: true
  :version: local 

  .. javascript::

    <script>
      // Load the basic mobile widgetry and support code. 
      dojo.require("dojox.mobile");

      // Load the lightweight parser.  dojo.parser can also be used, but it requires much more code to be loaded.
      dojo.require("dojox.mobile.parser");

      // Load the compat layer if the incoming browser isn't webkit based
      dojo.requireIf(!dojo.isWebKit, "dojox.mobile.compat");
    </script>

  .. css::

    <style>
      @import "{{baseUrl}}dojox/mobile/themes/iphone/iphone.css";
    </style>
    
  .. html::

    <div id="main" dojoType="dojox.mobile.View" selected="true">
      <h1 dojoType="dojox.mobile.Heading">Settings</h1>
      <ul dojoType="dojox.mobile.EdgeToEdgeList">
        <li dojoType="dojox.mobile.ListItem" icon="{{baseUrl}}dojox/mobile/tests/images/a-icon-2-41x41.png">
          Coolness Mode
          <div class="mblItemSwitch" dojoType="dojox.mobile.Switch"></div>
        </li>
        <li dojoType="dojox.mobile.ListItem" icon="{{baseUrl}}dojox/mobile/tests/images/a-icon-2-41x41.png" rightText="mac" moveTo="disco">
          Disco Room
        </li>
        <li dojoType="dojox.mobile.ListItem" icon="images/a-icon-2-41x41.png" rightText="AcmePhone" moveTo="disco">
          Carrier
        </li>
      </ul>
    </div>

    <div id="disco" dojoType="dojox.mobile.View">
      <h1 dojoType="dojox.mobile.Heading">Hello</h1>
      <ul dojoType="dojox.mobile.EdgeToEdgeList">
        <ul dojoType="dojox.mobile.EdgeToEdgeList">
        <li dojoType="dojox.mobile.ListItem" moveTo="main">
          I'm a square, man.
        </li>
        <li dojoType="dojox.mobile.ListItem" moveTo="main">
          Leave Disco Room
        </li>
      </ul>
    </div>
