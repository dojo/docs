.. _dojox/mobile:

===========
Dojo Mobile
===========

:Authors: Yoshiroh Kamiyama, Doug Hays, Chris Mitchell
:Developers: Yoshiroh Kamiyama, Doug Hays
:since: V1.5

.. contents ::
    :depth: 2

Introduction
============

The Dojo Mobile package provides a number of widgets that can be used to build web-based applications for mobile devices such as iPhone, Android, or BlackBerry. These widgets work best with webkit-based browsers, such as Safari or Chrome, since webkit-specific CSS3 features are extensively used. However, the widgets should work in a "graceful degradation" manner even on non-CSS3 browsers, such as IE or (older) Firefox. In that case, fancy effects, such as animation, gradient color, or round corner rectangle, may not work, but you can still operate your application.
Furthermore, as a separate file, a compatibility module, dojox/mobile/compat, is available, which simulates some of CSS3 features used in this module. If you use the compatibility module, fancy visual effects work better even on non-CSS3 browsers.

Dojo Mobile is designed to be as lightweight as possible to achieve a better user experience on mobile. It has only a few dependencies on other dojo/dijit modules. It has less dependency even on the dojo and dijit base modules, so many of the base modules can be eliminated at build time. Also, it has its own very small parser that is a subset of the core dojo.parser, but has enough capability to bootstrap your application.

.. image :: settings-i-a.png

Available Widgets
=================

Views
-----

* :ref:`View <dojox/mobile/View>`

  A container that represents a mobile device screen

* :ref:`ScrollableView <dojox/mobile/ScrollableView>`

  A view with touch scroll capability

* :ref:`SwapView <dojox/mobile/SwapView>`

  A view that can be swiped horizontally (formerly known as FlippableView)

Heading
-------

* :ref:`Heading <dojox/mobile/Heading>`

  A navigation bar that appears at the top

* :ref:`ToolBarButton <dojox/mobile/ToolBarButton>`

  A button that is placed in the Heading widget

Lists
-----

* :ref:`RoundRectCategory <dojox/mobile/RoundRectCategory>`

  Rounded-corner list category

* :ref:`EdgeToEdgeCategory <dojox/mobile/EdgeToEdgeCategory>`

  Edge-To-Edge list category

* :ref:`RoundRectList <dojox/mobile/RoundRectList>`

  A list of items in a rounded-corner rectangle

* :ref:`EdgeToEdgeList <dojox/mobile/EdgeToEdgeList>`

  A list of items with equal width

* :ref:`RoundRectDataList <dojox/mobile/RoundRectDataList>`

  RoundRectList with dojo.data support

* :ref:`EdgeToEdgeDataList <dojox/mobile/EdgeToEdgeDataList>`

  EdgeToEdgeList with dojo.data support

* :ref:`ListItem <dojox/mobile/ListItem>`

  A list item to use in a list widget

IconContainer
-------------

* :ref:`IconContainer <dojox/mobile/IconContainer>`

  A container to house icons for actions/events

* :ref:`IconItem <dojox/mobile/IconItem>`

  A widget for representing an icon and associated actions

TabBar
------

* :ref:`TabBar <dojox/mobile/TabBar>`

  A bar that can have TabBarButtons to control visibility of views

* :ref:`TabBarButton <dojox/mobile/TabBarButton>`

  A button that is placed in the TabBar widget

Panes
-----

* :ref:`RoundRect <dojox/mobile/RoundRect>`

  A rounded-corner rectangle boxes

* :ref:`ContentPane <dojox/mobile/ContentPane>`

  A pane that can load and display HTML content/fragments. Similar to dijit/layout/ContentPane.

Openers
-------

* :ref:`Opener <dojox/mobile/Opener>`

  A component that encapsulates the mechanism for displaying secondary views such as dialogs.  Openers take screen sizes into account and can display the next view as a slide-in dialog (phone) or inside a tooltip dialog (tablet)

* :ref:`Overlay <dojox/mobile/Overlay>`

  A component that displays a secondary view which partially occludes the original using a slide in transition effect. Useful for displaying dialogs.

* :ref:`Tooltip <dojox/mobile/Tooltip>`

  A


Form Controls
-------------

* :ref:`Button <dojox/mobile/Button>`

  A button that changes the color when pressed

* :ref:`CheckBox <dojox/mobile/CheckBox>`

  A checkbox component displaying a boolean value.

* :ref:`ComboBox <dojox/mobile/ComboBox>`

  A combo box allowing user to edit input values with the built-in keyboard.

* :ref:`ExpandingTextArea <dojox/mobile/ExpandingTextArea>`

  A text area that can automatically adjust its dimensions based on how much content it holds.

* :ref:`RadioButton <dojox/mobile/RadioButton>`

  A component for displaying a discrete set of selectable items.

* :ref:`Slider <dojox/mobile/Slider>`

  A control that allows changing a numeric value by touching and dragging a slide handle.

* :ref:`Switch <dojox/mobile/Switch>`

  A toggle switch with a sliding knob.  Useful for displaying boolean settings.

* :ref:`TextArea <dojox/mobile/TextArea>`

  A multi-line text input control.

* :ref:`TextBox <dojox/mobile/TextBox>`

  A text input control.

* :ref:`ToggleButton <dojox/mobile/ToggleButton>`

  A button that can toggle between two states.

Layout
------

* :ref:`FixedSplitter <dojox/mobile/FixedSplitter>`

  A layout component that displays two content areas, with the position between the areas fixed at a given position.

* :ref:`FixedSplitterPane <dojox/mobile/FixedSplitterPane>`

  Used for the two content areas in a fixed splitter control.

Indicators
----------

* :ref:`PageIndicator <dojox/mobile/PageIndicator>`

  A

* :ref:`ProgressIndicator <dojox/mobile/ProgressIndicator>`

  A round spinning graphical indicator

Carousel
--------

* :ref:`Carousel <dojox/mobile/Carousel>`

  A widget that manages a list of images or content, and displays a paging indicator.  Allows a user to flick left/right to move between content items.

Spin Wheel
----------

* :ref:`SpinWheel <dojox/mobile/SpinWheel>`

  A value picker component that has one or more slots.

* :ref:`SpinWheelSlot <dojox/mobile/SpinWheelSlot>`

  A slot that is placed in a SpinWheel.

* :ref:`SpinWheelDatePicker <dojox/mobile/SpinWheelDatePicker>`

  A date picker component that is derived from SpinWheel.

* :ref:`SpinWheelTimePicker <dojox/mobile/SpinWheelTimePicker>`

  A time picker component that is derived from SpinWheel.

Utils
-----

* :ref:`Badge <dojox/mobile/Badge>`

  An utility to create/update a badge node.


Getting Started
===============

Loading the basic Dojo Mobile codebase is extremely simple.  It's a couple requires and then selecting the CSS.  That's it.

Loading Dojo Mobile (using Dojo 1.7+ preferred api's)
-----------------------------------------------------

This example assumes Dojo script is being loaded asynchronously with "async:1" config property.  Using this approach
helps ensure the bare minimum code is used, and loaded as fast as possible.

.. js ::
 
  require([
    "dojox/mobile/parser", // (Optional) This mobile app uses declarative programming with fast mobile parser
    "dojox/mobile",        // (Required) This is a mobile app.
    "dojox/mobile/compat"  // (Optional) This mobile app supports running on desktop browsers
  ], function(parser, mobile, compat){ Optional module aliases that can then be referenced inside callback block
    // Do something with mobile api's.  At this point Dojo Mobile api's are ready for use.
  );

If you prefer to use "progressive enhancement" design techniques and not use Dojo's simple declarative programming model, you can choose not to specify the dojox/mobile/parser module and in script construct widgets programmatically.

If you don't need compatibility support for modern desktop browsers (FF, IE8+), you can choose note to specify the dojox/mobile/compat module.  In this case, mobile support will only work properly on Webkit-based mobile browsers (Dojo Mobile's default environment support).

Loading Dojo Mobile (using Dojo pre-1.7 style api's)
----------------------------------------------------

This example uses synchronous loading, and loads all of Dojo core.  This results in more code being loaded than the bare minimum, and uses a synchronous loader which will be slower to load modules than the above async example (preferred).

.. js ::
     
    dojo.require("dojox.mobile"); // Load the basic mobile widget kernel and support code.
    dojo.require("dojox.mobile.parser"); // (Optional) Load the lightweight parser.  dojo.parser can also be used, but it requires much more code to be loaded.
    dojo.requireIf(!dojo.isWebKit, "dojox.mobile.compat"); // (Optional) Load the compat layer if the incoming browser isn't webkit based
    // Do something with Dojo Mobile...

Applying a Mobile Device Theme Using CSS
----------------------------------------

Selecting the CSS to apply (iphone, android, blackberry or custom) is equally simple:

.. html ::

  <link rel="stylesheet" type="text/css" href="dojox/mobile/themes/iphone/iphone.css"></link>

Automatically Applying Mobile Device Themes Using CSS
-----------------------------------------------------
You can also use Dojo Mobile's automatic device detection and theme loading by adding the "dojox/mobile/deviceTheme" to your requires list.  When automatic device detection and theme loading is enabled, Dojo Mobile will insert appropriate stylesheet links dynamically into the header, based on user agent sniffing.

When this approach is taken, you can also pass an additional query parameter string, device={theme id} to force a specific theme from a browser url input (this feature is useful for creating samples and demos as well as testing what a page looks like on various devices).

Typical Use
-----------

Typical usage is to create one or more views in a page, and create a round rectangle list, an edge-to-edge list, an icon container, etc. in the views. You can specify an animated transition between the views.
The following example shows how to create views and make a transition between them.

.. image :: hello-example.png

..

Example (using HTML5 validating declarative markup and mobile parser)

.. html ::

   <!DOCTYPE HTML>
    <html>
      <head>
        <meta name="viewport" content="width=device-width,initial-scale=1,
       maximum-scale=1,minimum-scale=1,user-scalable=no"/>
        <meta name="apple-mobile-web-app-capable" content="yes" />
        <link href="dojox/mobile/themes/iphone/iphone.css" rel="stylesheet"></link>
        <script src="dojo/dojo.js" djConfig="async:1,parseOnLoad: true"></script>
        <script>
          require([
            "dojox/mobile/parser", // This mobile app uses declarative programming with fast mobile parser
            "dojox/mobile",        // This is a mobile app.
          ]); // Skip module alias and function block because we're not doing anything special...
        </script>
      </head>
      <body>
        <div id="foo" data-dojo-type="dojox.mobile.View">
          <h1 data-dojo-type="dojox.mobile.Heading">View 1</h1>
          <ul data-dojo-type="dojox.mobile.RoundRectList">
            <li data-dojo-type="dojox.mobile.ListItem" moveTo="bar" label="Hello"
                 icon="dojox/mobile/tests/images/i-icon-1.png"></li>
          </ul>
        </div>
   
        <div id="bar" data-dojo-type="dojox.mobile.View">
          <h1 data-dojo-type="dojox.mobile.Heading" back="Home" moveTo="foo">View 2</h1>
          <ul data-dojo-type="dojox.mobile.RoundRectList">
            <li data-dojo-type="dojox.mobile.ListItem" label="World"
                 icon="dojox/mobile/tests/images/i-icon-2.png"></li>
          </ul>
        </div>
      </body>
    </html>
..

Example using older (non-validating) HTML and mobile parser:

.. html ::

    <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
    <html>
      <head>
        <meta name="viewport" content="width=device-width,initial-scale=1,
       maximum-scale=1,minimum-scale=1,user-scalable=no"/>
        <meta name="apple-mobile-web-app-capable" content="yes" />
        <link href="dojox/mobile/themes/iphone/iphone.css" rel="stylesheet"></link>
        <script src="dojo/dojo.js" djConfig="parseOnLoad: true"></script>
        <script>
          require([
            "dojox/mobile/parser", // This mobile app uses declarative programming with fast mobile parser
            "dojox/mobile",        // This is a mobile app.
          ]); // Skip module alias and function block because we're not doing anything special...
        </script>
      </head>
      <body>
        <div id="foo" data-dojo-type="dojox.mobile.View">
          <h1 data-dojo-type="dojox.mobile.Heading">View 1</h1>
          <ul data-dojo-type="dojox.mobile.RoundRectList">
            <li data-dojo-type="dojox.mobile.ListItem" moveTo="bar" label="Hello"
                icon="dojox/mobile/tests/images/i-icon-1.png"></li>
          </ul>
        </div>
   
        <div id="bar" data-dojo-type="dojox.mobile.View">
          <h1 data-dojo-type="dojox.mobile.Heading" back="Home" moveTo="foo">View 2</h1>
          <ul data-dojo-type="dojox.mobile.RoundRectList">
            <li data-dojo-type="dojox.mobile.ListItem" label="World"
                icon="dojox/mobile/tests/images/i-icon-2.png"></li>
          </ul>
        </div>
      </body>
    </html>

..

* Line 1 is the standard HTML DOCTYPE.  Example 1 is using HTML5, Example 2 uses HTML4.  HTML5 introduces data-* attribute support, so the first example uses data-dojo-type attribute names (which will validate properly) versus example 2 which uses Dojo extended attributes (non-validating).  The HTML5 style markup is preferred going forward to Dojo 2.0 (but Ex 2 will continue to be supported through 1.x releases).

* Line 4 is a viewport setting, which sets the width, height and scale of the browser area used to display the content. Mobile Safari recognizes this meta tag.

* Line 5 tells iPhone/iPad that the web application should run in full-screen mode.

* Line 6 loads a style sheet for iPhone theme. You may want to load a different theme instead.

* Line 7 loads Dojo kernel API's.  The first example is using asynchronous AMD loader, the second example uses synchronous pre-Dojo1.7 style loader.  If you debug this example with browser debug tools, you'll see that example1 loads and enters document ready state much faster than example 2.  The async loader (ex1) style is the preferred notation going forward to Dojo 2.0 (but Ex 2 will continue to be supported through 1.x releases).

* Line 10 loads lightweight mobile parser, since this example uses declarative markup.  The parser will automatically instantiates the mobile widgets associated with dom elements. You can of course use the default parser (dojo/parser) instead if you're using dijit widgets on views, but the mobile parser is much smaller and has enough capability to bootstrap simple dojo application pages like this example.

  The desktop browser compatibility module for non-CSS3 browsers is not used in this example, so it will likely only render properly on webkit-based browsers.

* Line 16 through Line 22 is the first view. It contains a heading and a round rectangle list. This view will be shown at start up, since it is the first view and the selected="true" attribute is not specified for the second view.

* Line 24 through Line 30 is the second view, which will be shown when you tap on a list item in the first view.


Programmer's Guide
==================

* :ref:`Dynamic Content Loading <dojox/mobile/dynamic-content-loading>`
* :ref:`Listening to Transition Events <dojox/mobile/transition-events>`
* :ref:`Cross-browser Support <dojox/mobile/cross-browser-support>`
* :ref:`Internationalization (i18n) <dojox/mobile/internationalization>`
* :ref:`Build <dojox/mobile/build>`

Appendix
========

* :ref:`Frequently Asked Questions <dojox/mobile/faq>`
* :ref:`Differences between 1.6 and 1.7 <dojox/mobile/differences-16-17>`
