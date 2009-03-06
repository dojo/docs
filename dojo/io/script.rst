#format dojo_rst

dojox.io.script
===============

:Status: Contributed, Draft
:Version: 1.0
:Available: since V0.9

.. contents::
  :depth: 2

============
Introduction
============

This is an alternate IO mechanism to `dojo.xhrGet <dojo/xhrGet>`_ that has the capability of doing cross-site data access.  It accomplishes this feat by doing an IO call via a dynamically inserted <SCRIPT> tag into your web page.  

=====
JSONP
=====

Aside from being able to do cross-site data access, this implementation provides support for `JSONP <http://en.wikipedia.org/wiki/JSON#JSONP>`_ which is a way callback names can be added to a script return and executed appropriately.  Not all services that provide script-tag data formats support JSONP, but many do and it makes it vert flexible.

===========
Limitations
===========

* The dojo.io.script package can only make requests that are effectively 'GET' style requests with query parameters.  It does not support any other HTTP verb, such as POST, PUT, and DELETE.
* Since dojo.io.script relies on dynamic script tags, it cannot be done in a synchronous fashion (unlike dojo.xhrGet).  Therefore, any usage of this function must be async aware and async safe.

=====
Usage
=====

To make an IO call using a script tag (for instance, for cross-domain JSONP calls), dojo.require("dojo.io.script"), and use:

* dojo.io.script.get()

Specific arguments for dojo.io.script calls:

* callbackParamName: "". String. 
  The URL parameter name that indicates the JSONP callback string. For instance, when using Yahoo JSONP calls it is normally, callbackParamName: "callback". For AOL JSONP calls it is normally callbackParamName: "c".
* checkString: "". String. 
  A string of JavaScript that when evaluated like so: "typeof(" + checkString + ") != 'undefined'" being true means that the script fetched has been loaded. Do not use this if doing a JSONP type of call (use callbackParamName instead).

Note: "handleAs" is NOT applicable to dojo.io.script.get() calls, since it is implied by the usage of "callbackParamName" (response will be a JSONP call returning JSON) or "checkString" (response is pure JavaScript defined in the body of the script that was attached). 

========
Examples
========

TODO
