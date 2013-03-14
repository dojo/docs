.. _dojox/mobile/deviceTheme:

========================
dojox/mobile/deviceTheme
========================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.7

.. contents ::
    :depth: 2

Introduction
============

deviceTheme is a convenient utility module that automatically loads appropriate 
theme CSS files according to the detected user agent of the browser.

It can be enabled by simply including the dojox/mobile/deviceTheme script in 
your application as follows:

.. html ::

  <script src="dojox/mobile/deviceTheme.js"></script>
  <script src="dojo/dojo.js" data-dojo-config="parseOnLoad: true"></script>

Using the script tag as above is the recommended way to load the deviceTheme. 
Trying to load it using the AMD loader can lead to styles being applied too late, because the 
loading of the theme files would be performed asynchronously by the browser, so you could 
not assume that the loading has been completed when your widgets are initialized.
However, loading deviceTheme using the script tag has the drawback that 
deviceTheme.js cannot be included in a build.

deviceTheme detects the user agent of the browser and loads the appropriate theme files.
dojox/mobile provides five predefined themes, android, holodark, blackberry, iphone, ipad, and custom.
If the iPhone device is detected, for example, deviceTheme loads the iphone theme.

You can also pass an additional query parameter string: theme={theme id} to force a specific 
theme through the browser URL input. The available theme ids are Android, BlackBerry, Holodark, 
Custom, iPhone, and iPad. The theme names are case sensitive. If the given id does not match, 
the iphone theme is used.

.. html ::

  http://your.server.com/yourapp.html // automatic detection
  http://your.server.com/yourapp.html?theme=Android // forces android theme
  http://your.server.com/yourapp.html?theme=Holodark // forces holodark theme
  http://your.server.com/yourapp.html?theme=BlackBerry // forces blackberry theme
  http://your.server.com/yourapp.html?theme=Custom // forces custom theme
  http://your.server.com/yourapp.html?theme=iPhone // forces iphone theme
  http://your.server.com/yourapp.html?theme=iPad // forces ipad theme

To simulate a particular device from the application code, the user agent can be 
forced by setting dojoConfig.mblUserAgent as follows:


.. html ::

  <script src="dojox/mobile/deviceTheme.js" data-dojo-config="mblUserAgent: 'Holodark'"></script>
  <script src="dojo/dojo.js" data-dojo-config="parseOnLoad: true"></script>


Loading specific files
======================

By default, an all-in-one theme file (e.g. themes/iphone/iphone.css) is
loaded. The all-in-one theme files contain style sheets for all the
dojox/mobile widgets regardless of whether they are used in your
application or not.

If you want to choose what theme files to load, you can specify them
via dojoConfig or data-dojo-config as shown in the following example:

.. html ::

  <script src="dojox/mobile/deviceTheme.js"
     data-dojo-config="mblThemeFiles:['base','Button']"></script>
  <script src="dojo/dojo.js" data-dojo-config="parseOnLoad: true"></script>


In the case of this example, if iphone is detected, for example, the
following files will be loaded:

.. html ::

  dojox/mobile/themes/iphone/base.css
  dojox/mobile/themes/iphone/Button.css

If you want to load style sheets for your own custom widgets, you can
specify a package name along with a theme file name in an array.

.. html ::

  ['base',['com.acme','MyWidget']]

In this case, the following files will be loaded:

.. html ::

  dojox/mobile/themes/iphone/base.css
  com/acme/themes/iphone/MyWidget.css

If you specify '@theme' as a theme file name, it will be replaced with
the theme folder name (e.g. 'iphone'). For example,

.. html ::

  ['@theme',['com.acme','MyWidget']]

will load the following files:

.. html ::

  dojox/mobile/themes/iphone/iphone.css
  com/acme/themes/iphone/MyWidget.css


Overriding the theme styles
===========================

Theme styles can be overridden in an HTML file as follows:

.. html ::

  <style>
  .mblButton {
      font-size: 16px;
  }
  </style>
