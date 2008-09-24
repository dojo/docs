#format dojo_rst

dojox.io.script
===============

:Status: Contributed, Draft
:Version: 1.0
:Available: since V0.9

.. contents::
  :depth: 2

====================
Script request/JSONP
====================

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
