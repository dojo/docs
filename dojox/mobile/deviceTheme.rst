.. _dojox/mobile/deviceTheme:

========================
dojox.mobile.deviceTheme
========================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.7

.. contents ::
    :depth: 2

Introduction
============

deviceTheme is an automatic theme loader.
It can be enabled by simply requiring dojox.mobile.deviceTheme from your application.
It detects the user agent of the browser and loads the appropriate theme files.
dojox.mobile provides five pre-defined themes, android, blackberry, iphone, ipad, and custom.
If the iPhone device is detected, for example, the deviceTheme loads the iphone theme.

You can also pass an additional query parameter string, theme={theme id} to force a specific theme through the browser url input. The available theme ids are Android, BlackBerry, Custom, iPhone, and iPad. They are case sensitive. If the given id does not match, the iphone theme is used.

.. html ::

  http://your.server.com/yourapp.html // automatic detection
  http://your.server.com/yourapp.html?theme=Android // android theme
  http://your.server.com/yourapp.html?theme=BlackBerry // blackberry theme
  http://your.server.com/yourapp.html?theme=Custom // custom theme
  http://your.server.com/yourapp.html?theme=iPhone // iphone theme
  http://your.server.com/yourapp.html?theme=iPad // ipad theme

To simulate a particular device, the user agent may be overridden by setting djConfig.mblUserAgent.

Examples
========

By default, an all-in-one theme file (e.g. themes/iphone/iphone.css) is
loaded. The all-in-one theme files contain style sheets for all the
dojox.mobile widgets regardless of whether they are used in your
application or not.

If you want to choose what theme files to load, you can specify them
via djConfig as shown in the following example:

.. html ::

  djConfig="parseOnLoad:true, mblThemeFiles:['base','Button']"

Or you may want to use dojox.mobile.themeFiles as follows to get the
same result. Note that the assignment has to be done before loading
deviceTheme.js.

.. js ::

  dojo.require("dojox.mobile");
  dojox.mobile.themeFiles = ['base','Button'];
  dojo.require("dojox.mobile.deviceTheme");

In the case of this example, if iphone is detected, for example, the
following files will be loaded:

.. html ::

  dojox/mobile/themes/iphone/base.css
  dojox/mobile/themes/iphone/Button.css

If you want to load style sheets for your own custom widgets, you can
specify a package name along with a theme file name in an array.

.. html ::

  ['base',['com.acme','MyWidget']]

In this case, the following files will be loaded.

.. html ::

  dojox/mobile/themes/iphone/base.css
  com/acme/themes/iphone/MyWidget.css

If you specify '@theme' as a theme file name, it will be replaced with
the theme folder name (e.g. 'iphone'). For example,

.. html ::

  ['@theme',['com.acme','MyWidget']]

will load the following files.

.. html ::

  dojox/mobile/themes/iphone/iphone.css
  com/acme/themes/iphone/MyWidget.css

Note that loading of the theme files is performed asynchronously by
the browser, so you cannot assume that the load has been completed
when your application is initialized. For example, if some widget in
your application uses node dimensions that cannot be determined
without CSS styles being applied to them to calculate its layout at
initialization, the layout calculation may fail.
This timing issue could lead to annoying initialization problems.

A possible workaround for this problem is to use dojo.require to load
deviceTheme.js and place it in a separate <script> block immediately
below the script tag that loads dojo.js as below. However, this may or may
not solve the problem.

.. html ::

  <script src="dojo.js"></script>
  <script>
	  dojo.require("dojox.mobile.deviceTheme");
  </script>
  <script>
	  dojo.require("dojox.mobile");
	  ....

Enhancements in 1.8
===================

Loading deviceTheme with a script tag
-------------------------------------

In 1.8, there is another option available to avoid the loading problem above. It is to use deviceTheme.js as a non-dojo JavaScript code.
You load deviceTheme.js prior to loading dojo.js using the
script tag as follows.

.. html ::

  <script src="dojox/mobile/deviceTheme.js"
     djConfig="mblThemeFiles:['base','Button']"></script>
  <script src="dojo/dojo.js" djConfig="parseOnLoad: true"></script>

In this case, if the detected device is an iPhone, for example, the following files will be loaded by the deviceTheme.

.. html ::

  dojox/mobile/themes/iphone/base.css
  dojox/mobile/themes/iphone/Button.css

Using the script tag as above is the recommended way to load the deviceTheme in 1.8. One drawback, however, is that the deviceTheme.js cannot be included in a build.

Overriding the theme styles
---------------------------

With 1.8 deviceTheme, you can simply override the given theme styles in your html file like this:

.. html ::

  <style>
  .mblButton {
      font-size: 16px;
  }
  </style>

With 1.7 deviceTheme, unfortunately this is ignored and has no effects because <link> tags are appended as the last children of the <head> element, and thus they supersede your custom styles. The new 1.8 deviceTheme prepends <link> tags to the <head> to solve this issue.
