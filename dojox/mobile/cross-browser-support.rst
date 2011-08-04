#format dojo_rst

Cross-browser Support
=====================

:Authors: Yoshiroh Kamiyama

.. contents::
    :depth: 2

dojox.mobile supports not only webkit-based mobile browsers, but also non-CSS3 desktop PC browsers such as IE and (older) Firefox. A CSS3 compatibility module (dojox.mobile.compat) is provided to support non-CSS3 browsers. dojox.mobile.compat is not necessary for webkit-based browsers, hence, it does not degrade performance of mobile browsers. Typical usage would be to do conditional loading with dojo.requireIf() as follows. The code below loads dojox.mobile.compat only when dojo.isWebKit is true.

.. code-block :: javascript

  dojo.require("dojox.mobile");
  dojo.requireIf(!dojo.isWebKit, "dojox.mobile.compat");

In dojo-1.7, however, you can simply require dojox.mobile.compat without the condition, because the code has been moved from dojox.mobile.compat to dojox.mobile._compat, and dojox.mobile.compat conditionally loads dojox.mobile._compat for you.

If dojox.mobile.compat is loaded, it directly replaces some of the methods of the dojox.mobile widgets instead of subclassing. This way, your applications do not need to be changed, and thus html pages remains the same regardless of whether this compatibility module is used or not.

dojox.mobile.compat simply uses traditional techniques. For example, images are used for buttons, gradient colors, rounded corners, etc. For transition animations, dojo.fx is used.

dojox.mobile.compat automatically loads the compatibility CSS files. It searches the current page for <link> elements or @import directives in a <style> element, and tries to load corresponding -compat.css files. For example, if it finds .../themes/iphone/iphone.css, it loads .../themes/iphone/iphone-compat.css. (Note: dojox.mobile.compat in dojo-1.5 searches only for <link> elements, but the one in dojo-1.6 or later searches for @import as well.)
