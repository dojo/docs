.. _dojox/mobile/cross-browser-support:

=====================
Cross-browser Support
=====================

:Authors: Yoshiroh Kamiyama

.. contents ::
    :depth: 2

dojox/mobile supports not only webkit-based mobile browsers, but also non-CSS3 desktop PC browsers such as IE and (older) Firefox. A CSS3 compatibility module (dojox/mobile/compat) is provided to support non-CSS3 browsers. dojox/mobile/compat is not necessary for webkit-based browsers, hence, it does not degrade the performance of mobile browsers.

Typical Use
===========

In Dojo 1.7 or later, using AMD loading you can now simply require dojox/mobile/compat as follows:

.. js ::

  require(["dojox/mobile", "dojox/mobile/compat"], function(mobile, compat){
      // Do something with dojo mobile...
  });

In previous versions, typical usage would be to conditionally load using dojo.requireIf() as follows. The code below is an alternative way to load dojox.mobile.compat only when dojo.isWebKit is not true and using the pre 1.7-style synchronous loader:

.. js ::

  dojo.require("dojox.mobile");
  dojo.requireIf(!dojo.isWebKit, "dojox.mobile.compat");

Once dojox/mobile/compat is loaded, it replaces some of the methods of dojox.mobile widgets, without any subclassing. This way your applications do not need to be changed, and HTML pages remain the same regardless of whether this compatibility module is used or not.

dojox/mobile/compat simply uses traditional HTML/CSS techniques, rather than modern approaches using CSS3. For example, images are used for buttons, gradient colors, rounded corners, etc. For transition animations, dojo/fx (JavaScript animation package) is used.

When running on a non WebKit-based browser, dojox/mobile/compat automatically loads the compatibility CSS files for theme CSS files. It searches the current page for <link> elements or @import directives in a <style> element, and tries to load the corresponding -compat.css files. For example, if it finds .../mobile/themes/iphone/iphone.css, it loads .../mobile/themes/iphone/iphone-compat.css. (Note: dojox.mobile.compat in Dojo 1.5 searches only for <link> elements, but in Dojo 1.6 or later it searches for @import as well.)

Note that, in Dojo 1.7, compat was divided into two pieces, compat.js and _compat.js. _compat.js includes all the implementation code, and compat.js is simply a loader of _compat.js. compat.js loads _compat.js only when the current browser is not WebKit-based. compat.js is such a tiny piece of code that it does not affect mobile performance even if it is in a build. This way, on WebKit-based browsers, performance does not degrade since _compat.js will never be loaded. On non-WebKit browsers, _compat.js is loaded automatically, and Dojo Mobile works in the compat mode.

Also, note that, by default, compatibility CSS files are only loaded for CSS files located in a directory containing a "mobile/themes" path. For that, a matching is done using the default pattern "/\\/mobile\\/themes\\/.*\\.css$/". If a custom theme is not located in a directory containing this path, the data-dojo-config needs to specify a custom pattern using the "mblLoadCompatPattern" configuration parameter, for instance:

.. js ::

  data-dojo-config="mblLoadCompatPattern: /\/mycustomtheme\/.*\.css$/"
