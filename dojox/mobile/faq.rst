#format dojo_rst

Frequently Asked Questions
==========================

:Authors: Yoshiroh Kamiyama

.. contents::
    :depth: 2

===================
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
