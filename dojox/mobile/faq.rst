.. _dojox/mobile/faq:

==========================
Frequently Asked Questions
==========================

:Authors: Yoshiroh Kamiyama

.. contents ::
    :depth: 2

dojox.mobile.parser
===================

dojox.mobile.parser is an extremely small subset of dojo.parser. It has no extended features, so there is no reason you have to use dojox.mobile.parser instead of dojo.parser. However, if dojox.mobile.parser's capability is enough for your application, use of it could reduce the code size.

What is the difference between dojox.mobile.parser and dojo.parser?
-------------------------------------------------------------------

Some of the advanced features of dojo.parser, such as <script type="dojo/method"> and <script type="dojo/connect">, are missing. Basic features are compatible with dojo.parser.

How is the size of dojox.mobile.parser compared to dojo.parser?
---------------------------------------------------------------

As of dojo-1.7 beta3, the size of dojox.mobile.parser is 1KB (built & gzipped), while dojo.parser (plus its dependent modules that are not required by the dojox.mobile base) is 10KB.

Do I have to use dojox.mobile.parser for dojox.mobile applications?
-------------------------------------------------------------------

No, you don't have to. dojox.mobile.parser is a subset of dojo.parser. Usage and how it works are basically the same. If your application unfortunately does not work with dojox.mobile.parser, you can replace it with dojo.parser.

Can I use dojox.mobile.parser for desktop dojo applications?
------------------------------------------------------------

Yes. Use of dojox.mobile.parser is not limited to mobile. It has enough capability to bootstrap simple dojo applications. This may sound strange, but dojox.mobile.parser has no dependency on dojox.mobile. (And dojox.mobile has no dependency on dojox.mobile.parser either.) So you can pick up only dojox.mobile.parser and use it for your desktop applications. Actually, this parser was originally developed for very lightweight desktop dojo applications a few years before dojox.mobile was born.

However, dojox.mobile.parser cannot be used for applications that contain ContentPane subclasses
with nested widgets, since those nested widgets will try to be instantiated twice.   For example:

.. html ::

    <div data-dojo-type="dijit.Dialog">
        ...
        <button data-dojo-type="dijit.form.Button">OK</button>
    </div>

Also note that loading some desktop widgets may implicitly load the dojo.parser.

Android Issues
==============

I can't seem to run Dojo Mobile pages on Android devices when using libraries like PhoneGap, what am I doing wrong?
-------------------------------------------------------------------------------------------------------------------

There is a known bug in the Android WebKit browser implementation that does not allow files starting with an underscore '_' character to be loaded from local file system (for example when using Dojo Mobile in conjunction with PhoneGap to create a native app).  The way around this problem is to create a built version of your files (you'll want to do this anyway for performance).

mblAlwaysHideAddressBar does not work on my Android device. What's going on?
----------------------------------------------------------------------------

mblAlwaysHideAddressBar does not work on some Android devices when overflow:hidden style is applied to html and body tags. This overflow:hidden style is used in some test cases including test_ScrollableMixin-custom.html for desktop browsers not to show scroll bar, but you can remove it for mobile browsers so that you can hide address bar.

Miscellaneous
=============

Why does <body> in many of tests html files have style="visibility:hidden;"?
----------------------------------------------------------------------------

It is to prevent raw HTML rendering result from being shown before dojo's rendering finishes. The visibility will be restored by the initialization code in dojox.mobile.common.
