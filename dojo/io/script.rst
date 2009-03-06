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

Aside from being able to do cross-site data access, this implementation provides support for `JSONP <http://en.wikipedia.org/wiki/JSON#JSONP>`_ which is a way callback names can be added to a script return and executed appropriately.  Not all services that provide script-tag data formats support JSONP, but many do and it makes it very flexible.

===========
Limitations
===========

* The dojo.io.script package can only make requests that are effectively 'GET' style requests with query parameters.  It does not support any other HTTP verb, such as POST, PUT, and DELETE.
* Since dojo.io.script relies on dynamic script tags, it cannot be done in a synchronous fashion (unlike dojo.xhrGet).  Therefore, any usage of this function must be async aware and async safe.

=====
Usage
=====

To make an IO call using a script tag (for instance, for cross-domain JSONP calls), dojo.require("dojo.io.script"), and use:

* dojo.io.script.get() with a JavaScript Object parameter.  The JavaScript object supports the following properties:

dojo.io.script.get() supported object properties
------------------------------------------------

+----------------------+------------------------------------------------------------------------------------------------------------------------+
|**url**               |The URL to request data from.                                                                                           |
+----------------------+------------------------------------------------------------------------------------------------------------------------+
|**callbackParamName** |The URL parameter name that indicates the JSONP callback string. For instance, when using Yahoo JSONP calls it is       |
|                      |normally callbackParamName: "c".                                                                                        |
+----------------------+------------------------------------------------------------------------------------------------------------------------+
|**checkString**       |A string of JavaScript that when evaluated like so: "typeof(" + checkString + ") != 'undefined'" being true means that  |
|                      |the script fetched has been loaded. Do not use this if doing a JSONP type of call (use callbackParamName instead).      |
+----------------------+------------------------------------------------------------------------------------------------------------------------+

**Note:** "handleAs" is NOT applicable to dojo.io.script.get() calls, since it is implied by the usage of "callbackParamName" (response will be a JSONP call returning JSON) or "checkString" (response is pure JavaScript defined in the body of the script that was attached). 

========
Examples
========

Example 1: dojo.io.scriot call to fetch data from the Google Search API (JSONP)
-------------------------------------------------------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      function searchGoogle() {
        //Look up the node we'll stick the text under.
        var targetNode = dojo.byId("results");

        //The parameters to pass to xhrGet, the url, how to handle it, and the callbacks.
        var jsonpArgs = {
          url: "http://ajax.googleapis.com/ajax/services/search/web",
          callbackParamName: "callback",
          content: {
            v: "1.0",
            q: "dojo toolkit"
          },
          load: function(data){
            //Replace newlines with nice HTML tags.
            targetNode.innerHTML = dojo.toJson(data, true);
          }
          error: function(error){
            targetNode.innerHTML = "An unexpected error occurred: " + error;
          }
        }
        dojo.io.script.get(jsonpArgs);
      }
      dojo.addOnLoad(searchGoogle);
    </script>

  .. cv :: html 

    <b>Google Search Results for 'dojo toolkit':</b>
    <div id="results" style="height: 200px;"></div>
