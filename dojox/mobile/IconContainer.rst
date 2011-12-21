.. _dojox/mobile/IconContainer:

==========================
dojox.mobile.IconContainer
==========================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.5

.. contents ::
    :depth: 2

IconContainer is a container widget that holds multiple icons each of which represents application component.

.. image :: IconContainer.png

Usage
=====

Since dojo-1.6, you need to dojo.require IconContainer because it has been moved from _base.js to IconContainer.js.

.. js ::

  dojo.require("dojox.mobile.IconContainer");

Constructor Parameters
======================

+------------------+----------+----------------+-----------------------------------------------------------------------------------------------------------+
|Parameter         |Type      |Default         |Description                                                                                                |
+------------------+----------+----------------+-----------------------------------------------------------------------------------------------------------+
|defaultIcon       |String    |""              |The default fall-back icon, which is displayed only when the specified icon has failed to load.            |
+------------------+----------+----------------+-----------------------------------------------------------------------------------------------------------+
|pressedIconOpacity|Number    |0.4             |The opacity of the pressed icon image.                                                                     |
+------------------+----------+----------------+-----------------------------------------------------------------------------------------------------------+
|transition        |String    |"below"         |A type of animated transition effect. You can choose from the standard transition types, "slide", "fade",  |
|                  |          |                |"flip", or from the extended transition types, "cover", "coverv", "dissolve", "reveal", "revealv",         |
|                  |          |                |"scaleIn", "scaleOut", "slidev", "swirl", "zoomIn", "zoomOut". If "none" is specified, transition occurs   |
|                  |          |                |immediately without animation.  If "below" is specified, the application contents are displayed below the  |
|                  |          |                |icons.                                                                                                     |
+------------------+----------+----------------+-----------------------------------------------------------------------------------------------------------+
|iconBase          |String    |""              |The default icon path for child items. If a child item does not have its own icon parameter specified, this|
|                  |          |                |value is used as its icon path. This parameter is especially useful when all or most of the icons are the  |
|                  |          |                |same, or you use CSS sprite icons, where you specify an aggregated icon image with this parameter and an   |
|                  |          |                |icon position for each icon.                                                                               |
+------------------+----------+----------------+-----------------------------------------------------------------------------------------------------------+
|iconPos           |String    |""              |The default icon position for child items. This parameter is especially useful when all or most of the     |
|                  |          |                |icons are the same.                                                                                        |
+------------------+----------+----------------+-----------------------------------------------------------------------------------------------------------+
|back              |String    |"Home"          |A label for the navigational control.                                                                      |
+------------------+----------+----------------+-----------------------------------------------------------------------------------------------------------+
|label             |String    |"My Application"|A title text of the heading.                                                                               |
+------------------+----------+----------------+-----------------------------------------------------------------------------------------------------------+
|single            |Boolean   |false           |If true, only one icon content can be opened at a time.                                                    |
+------------------+----------+----------------+-----------------------------------------------------------------------------------------------------------+

Lazy Loading of the contents
============================

Each icon content may consist of one or more dojo widgets. Loading of all the necessary dojo modules of all the icon contents at startup could slow down the startup time of the application. To improve the startup time performance, you can specify the lazy="true" parameter to IconItems. Then IconContainer loads dojo modules that are necessary for the icon content dynamically only when it is opened for the first time.

Below is an example of lazy loading of icon contents. Before the dojo parser runs, the data-dojo-type attributes of the lazy-load nodes are rewritten so that the specified modules (in this case, dijit.ColorPalette and dijit.ProgressBar) will not be be loaded by the parser. IconContainer loads them for you when you open icons.

Note that currently lazy loading is supported only in the sync mode, since lazy loading is performed synchronously using dojo.require.

.. html ::

  <ul data-dojo-type="dojox.mobile.IconContainer" transition="below" iconBase="images/icon-1.png">
    <li data-dojo-type="dojox.mobile.IconItem" label="Color Palette" lazy="true">
      <div data-dojo-type='dijit.ColorPalette'></div>
    </li>
    <li data-dojo-type="dojox.mobile.IconItem" label="Progress Bar" lazy="true">
      <div data-dojo-type='dijit.ProgressBar'></div>
    </li>
  </ul>

.. image :: IconContainer-lazy-17.png

Examples
========

Single / Below (transition="below" single="true")
-------------------------------------------------

In this example, icon content is shown below the icons, and only one icon content can be opened at a time.

.. html ::

  <h1 data-dojo-type="dojox.mobile.Heading">Icon Container (Single/Below)</h1>
  <ul data-dojo-type="dojox.mobile.IconContainer" transition="below" single="true" iconBase="images/icon-1.png">
    <li data-dojo-type="dojox.mobile.IconItem" label="Icon 1">
      <div data-dojo-type="dojox.mobile.RoundRect" shadow="true">
         App #1
      </div>
    </li>
    <li data-dojo-type="dojox.mobile.IconItem" label="Icon 2">
      <div data-dojo-type="dojox.mobile.RoundRect" shadow="true">
         App #2
      </div>
    </li>
  </ul>

.. image :: Icon-SingleBelow-anim.gif

Single / Flip (transition="flip" single="true")
-----------------------------------------------

In this example, icon content is shown below the icons, and multiple icon contents can be opened at a time.

.. html ::

  <h1 data-dojo-type="dojox.mobile.Heading">Icon Container (Single/Flip)</h1>
  <ul data-dojo-type="dojox.mobile.IconContainer" transition="flip" single="true" iconBase="images/icon-1.png">
    <li data-dojo-type="dojox.mobile.IconItem" label="Icon 1">
      <div data-dojo-type="dojox.mobile.RoundRect" shadow="true">
        App #1
      </div>
    </li>
    <li data-dojo-type="dojox.mobile.IconItem" label="Icon 2">
      <div data-dojo-type="dojox.mobile.RoundRect" shadow="true">
        App #2
      </div>
    </li>
  </ul>

.. image :: Icon-SingleFlip-anim.gif

Multi / Below (transition="below" single="false")
-------------------------------------------------

In this example, selecting an icon causes a flip transition to show the icon content. Only one icon content can be opened at a time.

.. html ::

  <h1 data-dojo-type="dojox.mobile.Heading">Icon Container (Multi/Below)</h1>
  <ul data-dojo-type="dojox.mobile.IconContainer" transition="below" iconBase="images/icon-1.png">
    <li data-dojo-type="dojox.mobile.IconItem" label="Icon 1">
      <div data-dojo-type="dojox.mobile.RoundRect" shadow="true">
        App #1
      </div>
    </li>
    <li data-dojo-type="dojox.mobile.IconItem" label="Icon 2">
      <div data-dojo-type="dojox.mobile.RoundRect" shadow="true">
        App #2
      </div>
    </li>
  </ul>

.. image :: Icon-MultiBelow-anim.gif

Multi / Flip (transition="flip" single="false")
-----------------------------------------------

In this example, selecting an icon causes a flip transition to show the icon content. Multiple icon contents can be opened at a time.

.. html ::

  <h1 data-dojo-type="dojox.mobile.Heading">Icon Container (Multi/Flip)</h1>
  <ul data-dojo-type="dojox.mobile.IconContainer" transition="flip" iconBase="images/icon-1.png">
    <li data-dojo-type="dojox.mobile.IconItem" label="Icon 1">
      <div data-dojo-type="dojox.mobile.RoundRect" shadow="true">
        App #1
      </div>
    </li>
    <li data-dojo-type="dojox.mobile.IconItem" label="Icon 2">
      <div data-dojo-type="dojox.mobile.RoundRect" shadow="true">
        App #2
      </div>
    </li>
  </ul>

.. image :: Icon-MultiFlip-anim.gif
