#format dojo_rst

dojox.mobile
============

:Status: Draft
:Version: 1.0
:Authors: Jared Jurkiewicz, Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama, Jared Jurkiewicz
:Available: since V1.5

.. contents::
    :depth: 2

Have you wanted to build applications for the iPhone, Android, or other similar WebKit based mobile browsers that had the look and feel of a 'native' application for the device, but was merely a web-page so you retained total control?  If so, then this module may provide much of what you need.  This project provides through CSS3 and custom styles, interfaces that display and work well on mobile devices.

The code is deliberately kept as lightweight as possible, using CSS3 animations and the like to perform the effects.  There is a compat.js, which will simulate most of the effects using dojo.fx where possible on browsers such as FireFox and IE.  It will not load by default, it has to be required in separately.

**Note that use of dijit._Container, dijit._Contained, dijit._Templated, and dojo.query is intentionally avoided to reduce download code size.**

========
Features
========

* Extemely lightweight parser for instantiating widgets to keep code size down.  It does not support embedded script behaviors or the like.
* Transitional effects such as flip, slide and fade to move between views.
* CSS3 Animations where possible.  This provides high-speed, smooth, animations on WebKit based browsers.  For non-webkit based browsers, a 'compat' module exists to mimic most of the animations by using dojo.animateProperty.
* CSS themes for Apple's iPhone and Google Android based mobile phones to mimic look and feel.
* A series of lightweight widgets to mimic basic mobile device native interfaces, including:

  * `View <dojox/mobile/View>`_- A single 'view'
  * `ScrollableView <dojox/mobile/ScrollableView>`_- A view with touch scroll
  * `FlippableView <dojox/mobile/FlippableView>`_- A view that can be swiped horizontally
  * `Heading <dojox/mobile/Heading>`_ - Styled to match the device
  * `RoundRect <dojox/mobile/RoundRect>`_ - Rounded-corner rectangle boxes.
  * `RoundRectCategory <dojox/mobile/RoundRectCategory>`_ - Rounded-corner list category
  * `EdgeToEdgeCategory <dojox/mobile/EdgeToEdgeCategory>`_ - Edge-To-Edge list category
  * `RoundRectList <dojox/mobile/RoundRectList>`_ - List of rounded-corner rectangles for data display.
  * `EdgeToEdgeList <dojox/mobile/EdgeToEdgeList>`_ - A basic list of items with equal width.
  * `ListItem <dojox/mobile/ListItem>`_ - Basic list items to use in the various list containers.
  * `Switch <dojox/mobile/Switch>`_ - An on/off toggle-style button.
  * `IconContainer <dojox/mobile/IconContainer>`_ - A container to house icons for actions/events.
  * `IconItem <dojox/mobile/IconItem>`_ - A widget for representing an icon and associated actions.
  * `Button <dojox/mobile/Button>`_ - A button that changes the color when pressed.
  * `ToolBarButton <dojox/mobile/ToolBarButton>`_ - A button that is placed in the Heading widget.
  * `TabBar <dojox/mobile/TabBar>`_ - A bar that can have TabBarButtons to control visibility of views.
  * `TabBarButton <dojox/mobile/TabBarButton>`_ - A button that is placed in the TabBar widget.
  * `ProgressIndicator <dojox/mobile/ProgressIndicator>`_ - A round spinning graphical indicator.

====================
Internationalization
====================

dojo.i18n is NOT used for dojox.mobile because:

  * Use of it increases the code size, which affects cachability of the content.
  * Not good for client-side runtime performance, which is important for mobile devices.  The lookup time matters to lighter devices such as a phone.  It has the added advantage of extending battery life due to avoiding CPU cycles for string manipulations.

Recommended approach is to substitute localized strings on the server due to the following reasons:

  * Server-side markup generation is the typical usage of dojox.mobile
  * Should be able to use server-side i18n facility (e.g. Java resource bundle)
  * No http requests to retrieve i18n resources are necessary
  * Client-side does not need to look up the i18n resource table
 
===========================
Cross-Browser Compatibility
===========================

Dojox.mobile supports not only webkit-based mobile browsers, but also non-CSS3 desktop browsers such as IE and (older) Firefox. The CSS3 compatibility module (dojox.mobile.compat) is provided to support non-CSS3 browsers.  By default compatibility is not loaded, so if you require your application to work on older browsers (or desktop browsers), you need to conditionally import the dojox.mobile.compat package as part of its initialization.  See the example below:

.. code-block :: javascript

  dojo.require("dojox.mobile");
  dojo.requireIf(!dojo.isWebKit, "dojox.mobile.compat");

If dojox.mobile.compat is loaded, it directly replaces some of the methods of the dojox.mobile widgets to use emulation techniques for the normally CSS3 based animations.  This way, your applications do not need to be changed, and thus html pages remains the same regardless of whether this compatibility module is used or not.

Dojox.mobile.compat simply uses traditional techniques. For example, images are used for buttons, gradient colors, rounded corners, etc. For transition animations, dojo.fx is used.

Note:  dojox.mobile.compat automatically loads the compatibility CSS files. It searches the current page for <link> elements or @import directives in a <style> element, and tries to load corresponding -compat.css files. For example, if it finds .../themes/iphone/iphone.css, it loads .../themes/iphone/iphone-compat.css. (Note: dojox.mobile.compat in dojo-1.5 searches only for <link> elements, but the one in dojo-1.6 searches for @import as well.)

=====
Build
=====

Dojox.mobile was designed to have as few dependencies on the dojo and dijit base modules as possible in order to reduce the total download code size for better start-up time performance. For example, use of dijit._Container, dijit._Contained, dijit._Templated, and dojo.query is intentionally avoided even where they are normally used. However, by default, all the dojo base modules and the dijit base modules are baked into the built file (dojo.js) by the dojo build tool regardless of whether they are actually used or not. So, to take advantage of dojox.mobile's minimum-dependency approach, you need to specify appropriate build options and dependency information when you build your application. There are sample build profile files and batch files available for that purpose in the dojox/mobile/build/ directory.

Before running the build batch file, you may need to manually apply the following patch to your build script in order to completely remove all the unused modules from your build. (As you can see, it is just addition of "false&&" in the while condition.)
The patch disables finding the dojo base modules being used from the dependent modules with a simple pattern matching, which sometimes unexpectedly picks up unused modules.
The file to be patched is util/buildscripts/jslib/buildUtil.js.

.. code-block :: javascript

  --- buildUtil.js-orig
  +++ buildUtil.js
  @@ -1506,7 +1506,7 @@
     var addedResources = {};
  -  while((matches = buildUtil.baseMappingRegExp.exec(tempContents))){
  +  while(false&&(matches = buildUtil.baseMappingRegExp.exec(tempContents))){
         var baseResource = buildUtil.baseMappings[matches[1]];
         //Make sure we do not add the dependency to its source resource.

From the command line, you can run the batch file. Use "build.bat" for Windows, or "build.sh" for Linux. Simple usage is as follows.

.. code-block :: text

  > build
  Usage: build separate|single [webkit]
    separate  Create mobile.js that includes only dojox.mobile
    single    Create a single dojo.js layer that includes dojox.mobile
    webkit    Enable webkitMobile=true option (Loses PC browser support)

separate
	Create mobile.js that includes only the dojox.mobile modules. It does not include the dojo base or the dijit base modules. Compat.js is also created for desktop browser support.

single
	Create a single dojo.js layer that includes dojox.mobile and all the required modules. Compat.js is also created for desktop browser support.

webkit
	Enable the webkitMobile=true build option, which strips out many code chunks that are not necessary for webkit-based mobile browsers. For example, IE or Firefox specific code is excluded from the build. This reduces the total code size, but the built module will not work on desktop browsers even with the compatibility module (compat.js).

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

  <link rel="stylesheet" type="text/css" href="dojox/mobile/themes/iphone/iphone.css"></link>


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

    <link href="{{baseUrl}}dojox/mobile/themes/iphone/iphone.css" rel="stylesheet"></link>
    
  .. html::

    <div id="main" dojoType="dojox.mobile.View" selected="true">
      <h1 dojoType="dojox.mobile.Heading">Settings</h1>
      <ul dojoType="dojox.mobile.EdgeToEdgeList">
        <li dojoType="dojox.mobile.ListItem" icon="{{baseUrl}}dojox/mobile/tests/images/i-icon-1.png">
          Coolness Mode
          <div class="mblItemSwitch" dojoType="dojox.mobile.Switch"></div>
        </li>
        <li dojoType="dojox.mobile.ListItem" icon="{{baseUrl}}dojox/mobile/tests/images/i-icon-2.png" rightText="mac" moveTo="disco">
          Disco Room
        </li>
        <li dojoType="dojox.mobile.ListItem" icon="{{baseUrl}}dojox/mobile/tests/images/i-icon-3.png" rightText="AcmePhone" moveTo="disco">
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
