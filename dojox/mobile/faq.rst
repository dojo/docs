.. _dojox/mobile/faq:

==========================
Frequently Asked Questions
==========================

:Authors: Yoshiroh Kamiyama

.. contents ::
    :depth: 2

dojox.mobile.parser
===================

dojox.mobile.parser is an extremely small subset of dojo.parser. It has no extended features, so there is no reason you have to use dojox.mobile.parser instead of dojo.parser. However, if dojox.mobile.parser's capability is enough for your application, using it could reduce the code size.

What is the difference between dojox.mobile.parser and dojo.parser?
-------------------------------------------------------------------

Some of the advanced features of dojo.parser, such as <script type="dojo/method"> and <script type="dojo/connect">, are missing. Basic features are compatible with dojo.parser.

How is the code size of dojox.mobile.parser compared to dojo.parser?
--------------------------------------------------------------------

As of dojo-1.7 beta3, the size of dojox.mobile.parser is 1KB (built and gzipped), while dojo.parser (plus its dependent modules that are not required by the dojox.mobile base) is 10KB.

Do I have to use dojox.mobile.parser for dojox.mobile applications?
-------------------------------------------------------------------

No, you don't have to. dojox.mobile.parser is a subset of dojo.parser. Usage and how it works are basically the same. It has no mobile specific features. dojox.mobile.parser's ONLY advantage over dojo.parser is its smaller code size. If your application unfortunately does not work with dojox.mobile.parser, you can replace it with dojo.parser.

Can I use dojox.mobile.parser for desktop dojo applications?
------------------------------------------------------------

Yes. Use of dojox.mobile.parser is not limited to mobile. It has enough capability to bootstrap simple dojo applications. This may sound strange, but dojox.mobile.parser has no dependency on dojox.mobile. (And dojox.mobile has no dependency on dojox.mobile.parser either.) So you can pick up only dojox.mobile.parser and use it for your desktop applications. Actually, this parser was originally developed for very lightweight desktop dojo applications a few years before dojox.mobile was born.

In 1.7 or older, however, dojox.mobile.parser cannot be used for applications that contain ContentPane subclasses
with nested widgets, since those nested widgets will try to be instantiated twice.   For example:

.. html ::

    <div data-dojo-type="dijit.Dialog">
        ...
        <button id="btn1" data-dojo-type="dijit.form.Button">OK</button>
    </div>

You will get "Tried to register widget with id==btn1 but that id is already registered" error. In 1.8, this problem does not exist.

Also note that loading some desktop widgets may implicitly load dojo.parser.

Android Issues
==============

I can't seem to run Dojo Mobile pages on Android devices when using libraries like PhoneGap, what am I doing wrong?
-------------------------------------------------------------------------------------------------------------------

There is a known bug in the Android WebKit browser implementation that does not allow files starting with an underscore '_' character to be loaded from local file system (for example, when using Dojo Mobile in conjunction with PhoneGap to create a native app).  The way around this problem is to create a built version of your files (you'll want to do this anyway for performance).

mblAlwaysHideAddressBar does not work on my Android device. What's going on?
----------------------------------------------------------------------------

mblAlwaysHideAddressBar does not work on some Android devices when overflow:hidden style is applied to html and body tags. This overflow:hidden style is used in some test cases, such as test_ScrollableMixin-custom.html, for desktop browsers to hide the scroll bar, but you can remove it for mobile browsers so that you can hide address bar.

Accessibility
=============

Are applications using Dojo Mobile accessible?
----------------------------------------------

Some Dojo Mobile widgets are accessible. For example, the ScrollableView can only be scrolled by using touch gestures. You must develop alternative ways, ex. buttons for scrolling, to ensure accessibility. Other examples requiring alternatives are SwapView flip and ListItems editing.

Is there a way to set an alternative text to images and DOM buttons?
--------------------------------------------------------------------

Yes, you can set the alt attribute for images and the title attribute for DOM buttons. See tests/test_a11y.html for examples.

Can you change the widget text size by changing the browser text size?
----------------------------------------------------------------------

No, we suggest that you use the page zoom function available on some browsers for this purpose.

How do I develop applications which support iOS VoiceOver?
----------------------------------------------------------

Make sure to set the alt, title and role attributes. VoiceOver will read widgets with these attributes set. See tests/test_a11y.html for examples. However, the value of a SpinWheel can not be read by VoiceOver in 1.8.

Are applications keyboard accessible on desktop browsers?
---------------------------------------------------------

Yes, except for ScrollableView and SwapView. These widgets require alternative ways to scroll and flip, ex. buttons.

Can you set the tab focus sequence for destop browsers?
-------------------------------------------------------

Yes, use the tabindex attribute for this purpose. IconItem, IconMenuItem, ListItem, TabBarButton and ToolBarButton all have the tabindex attribute initially set to 0 by default.

Miscellaneous
=============

Why does <body> in many of tests html files have style="visibility:hidden;"?
----------------------------------------------------------------------------

It is to prevent raw HTML rendering result from being shown before dojo's rendering finishes. The visibility will be restored by the initialization code in dojox.mobile.common.

Do all transition animations work on all the devices?
-----------------------------------------------------

Not all transition animations work on all the devices. The following table shows which transition animations work on which devices and browsers.

+---------------+--------------+----------------+--------------------------------+---------------------+---------------------------+---------------------------+
|Transition     |iPad 2 (iOS 5)|iPhone 4 (iOS 4)|Samsung Galaxy Tab (Android 2.2)|HTC Evo (Android 2.3)|Motorola Xoom (Android 3.1)|RIM BlackBerry  9800 (OS 6)|
+---------------+--------------+----------------+--------------------------------+---------------------+---------------------------+---------------------------+
|Slide	        |Yes           |Yes             |Yes                             |Yes                  |Yes*                       |Yes*                       |
+---------------+--------------+----------------+--------------------------------+---------------------+---------------------------+---------------------------+
|Flip           |Yes           |Yes             |Yes*                            |Yes*                 |Yes*                       |Yes*                       |
+---------------+--------------+----------------+--------------------------------+---------------------+---------------------------+---------------------------+
|Fade           |Yes           |Yes             |Yes                             |Yes                  |Yes                        |Yes*                       |
+---------------+--------------+----------------+--------------------------------+---------------------+---------------------------+---------------------------+
|Dissolve       |Yes           |Yes             |Yes                             |Yes                  |Yes                        |Yes*                       |
+---------------+--------------+----------------+--------------------------------+---------------------+---------------------------+---------------------------+
|Slide Vertical |Yes           |Yes             |Yes                             |Yes                  |Yes*                       |Yes*                       |
+---------------+--------------+----------------+--------------------------------+---------------------+---------------------------+---------------------------+
|Cover          |Yes           |Yes             |Yes                             |Yes                  |Yes*                       |Yes*                       |
+---------------+--------------+----------------+--------------------------------+---------------------+---------------------------+---------------------------+
|Cover Vertical |Yes           |Yes             |Yes                             |Yes                  |Yes*                       |Yes*                       |
+---------------+--------------+----------------+--------------------------------+---------------------+---------------------------+---------------------------+
|Reveal         |Yes           |Yes             |Yes                             |Yes                  |Yes*                       |Yes*                       |
+---------------+--------------+----------------+--------------------------------+---------------------+---------------------------+---------------------------+
|Reveal Vertical|Yes           |Yes             |Yes                             |Yes                  |Yes*                       |Yes*                       |
+---------------+--------------+----------------+--------------------------------+---------------------+---------------------------+---------------------------+
|Zoom In/Out    |Yes           |Yes             |Yes                             |Yes                  |Yes*                       |Yes*                       |
+---------------+--------------+----------------+--------------------------------+---------------------+---------------------------+---------------------------+
|Scale In/Out   |Yes           |Yes             |Yes                             |Yes                  |Yes*                       |Yes*                       |
+---------------+--------------+----------------+--------------------------------+---------------------+---------------------------+---------------------------+
|Swirl          |Yes           |Yes             |Yes                             |Yes                  |Yes*                       |Yes*                       |
+---------------+--------------+----------------+--------------------------------+---------------------+---------------------------+---------------------------+
|Swap           |Yes           |Yes             |Yes                             |Yes                  |Yes*                       |Yes*                       |
+---------------+--------------+----------------+--------------------------------+---------------------+---------------------------+---------------------------+
|Cube           |Yes           |Yes             |No                              |No                   |Yes*                       |Yes*                       |
+---------------+--------------+----------------+--------------------------------+---------------------+---------------------------+---------------------------+

+---------------+---------+--------+-------------------+----------------+
|Transition     |Chrome 17|Safari 5|FireFox 11 (Compat)|IE 8 (Compat)   |
+---------------+---------+--------+-------------------+----------------+
|Slide	        |Yes      |Yes     |Yes                |Yes             |
+---------------+---------+--------+-------------------+----------------+
|Flip           |Yes      |Yes     |Yes                |Yes             |
+---------------+---------+--------+-------------------+----------------+
|Fade           |Yes      |Yes     |Yes                |Yes             |
+---------------+---------+--------+-------------------+----------------+
|Dissolve       |Yes      |Yes     |Fade**             |Fade**          |
+---------------+---------+--------+-------------------+----------------+
|Slide Vertical |Yes      |Yes     |Yes                |Yes             |
+---------------+---------+--------+-------------------+----------------+
|Cover          |Yes      |Yes     |Slide**            |Slide**         |
+---------------+---------+--------+-------------------+----------------+
|Cover Vertical |Yes      |Yes     |Slide Vertical**   |Slide Vertical**|
+---------------+---------+--------+-------------------+----------------+
|Reveal         |Yes      |Yes     |Slide**            |Slide**         |
+---------------+---------+--------+-------------------+----------------+
|Reveal Vertical|Yes      |Yes     |Fade**             |Fade**          |
+---------------+---------+--------+-------------------+----------------+
|Zoom In/Out    |Yes      |Yes     |Fade**             |Fade**          |
+---------------+---------+--------+-------------------+----------------+
|Scale In/Out   |Yes      |Yes     |Fade**             |Fade**          |
+---------------+---------+--------+-------------------+----------------+
|Swirl          |Yes      |Yes     |Fade**             |Fade**          |
+---------------+---------+--------+-------------------+----------------+
|Swap           |Yes      |Yes     |Fade**             |Fade**          |
+---------------+---------+--------+-------------------+----------------+
|Cube           |Yes      |Yes     |Fade**             |Fade**          |
+---------------+---------+--------+-------------------+----------------+

Note: * Transition animation may not be smooth or may not function.
** Substitute animation

Does Dojo Mobile support viewport scaling using the viewport meta tag?
----------------------------------------------------------------------

Dojo Mobile is designed to fit into the default viewport size. It does not support viewport scaling using the viewport meta tag (ex. user-scalable, target-densitydpi, etc).

One known issue when using viewport scaling is that the device screen size may be detected as a tablet even if it's a phone. By default, Dojo Mobile detects a tablet device when both its screen width and height are larger than "500px". When you scale the viewport to make it high density, it might exceed that threshold even if it's a phone. You can resolve this by changing the threshold value as described in the following code snippet:

.. js ::

    require(["dojox/mobile"], function(dm){
        dm.tabletSize = 700;  // threshold value to determine whether it is a phone or a tablet (pixel)
        dm.detectScreenSize(true); // re-try screen size detection with the new threshold value above
    });

How do I avoid the margin-collapsing problem?
---------------------------------------------

If you make a view transition when you have a view whose first child element has a top margin, the top positions of the source view and the destination view may not align as you expected.

.. image :: faq-margin-collapsing.png

This undesired result is caused by the so-called "vertical margin collapsing".
See http://www.w3.org/TR/CSS2/box.html#collapsing-margins for details.

A workaround to avoid margin-collapsing is to give the view node a minimal 1 pixel transparent top border.

.. html ::

  <div data-dojo-type="dojox.mobile.View" style="border-top:1px solid transparent">

If you want to apply it to all the views at once, you could set css style as below.

.. js ::

  .mblView {
    border-top: 1px solid transparent;
  }

Is dojox.mobile.app still alive?
--------------------------------

dojox.mobile.app is no longer actively developed.
It has been superseded by dojox.app, which targets both desktop and mobile platforms
(see :ref:`dojox.app <dojox/app>`).

How should I use dojox.mobile.deviceTheme? Are there changes in Dojo 1.8 with this respect?
-------------------------------------------------------------------------------------------

Yes, Dojo 1.8 brings improvements that allow to safely load the deviceTheme with a script tag, and for overriding the theme styles.
See :ref:`dojox.mobile.deviceTheme <dojox/mobile/deviceTheme>` for details.