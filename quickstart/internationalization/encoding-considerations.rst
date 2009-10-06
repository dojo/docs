#format dojo_rst

Encoding considerations
=======================

:Status: Draft
:Version: 1.0
:Authors: Adam Peller
:Available: since V?

.. contents::
   :depth: 2


===============
Proper encoding
===============

The two most important aspects of internationalization are insuring that the inputs and the outputs are in the proper encoding. Thankfully, UTF-8 encoding can be used exclusively on the wire in modern web applications to make this interaction extremely simple. Once read into memory, JavaScript treats all strings as a series of double-byte characters and encoding is irrelevant. Dojo makes no attempt to implement any encoding or decoding algorithms in JavaScript; this is the responsibility of the browser.

Other encodings should be used with great care. 


========
META tag
========

A user agent such as one of the current generation browsers infers the encoding of a page using the content-type header provided by a server or it may be picked up from a meta tag in the head of a document, such as the following:

.. code-block :: html

 <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />

The most common means of specifying the encoding in a page is to use the META tag. Note that the META tag only works in pages loaded directly by browsers or IFRAMEs and may not function when used in other situations, such as in a document referenced by HREF in `dijit.layout.ContentPane <dijit/layout/ContentPane>`_. UTF-8 is the detault encoding used by XML documents exchanged by the `XMLHTTP request object <quickstart/ajax>`_ and also is the encoding that is used internally by Dojo APIs. We recommend using UTF-8 as the encoding for all of your applications.


============
Form Widgets
============

It is important to properly specify the encoding of the page when forms or form widgets are present as the page's encoding is used to properly encode data that is sent back to a server.
