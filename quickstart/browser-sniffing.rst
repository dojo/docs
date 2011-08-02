#format dojo_rst

Browser Sniffing
================

:Status: Draft
:Version: 1.0
:Authors: Peter Higgins, Ben Lowery

.. contents::
    :depth: 2

You should try to use feature detection (see dojo/has() api in 1.7) (See general overview http://dev.opera.com/articles/view/using-capability-detection/) whenever possible to write forward-compatible code branches. 
When feature detection is an option, Dojo provides a number of ``is`` variables for browser detection, defined at runtime based that provide access to the current user agent (these are set based on parsing the current user agent string).
As of Dojo 1.7, the user agent sniffing code has been split out into a separate module, "dojo/_base/sniff" so that when used with AMD loaders it will only be loaded in situations when it's needed.  These are the user agent properties available upon loading the "dojo/_base/sniff" module.  Note that if pre-1.7 style sync loading is used, the following api's are automatically made available to applications:

* dojo.isIE
* dojo.isMozilla
* dojo.isFF
* dojo.isOpera
* dojo.isSafari
* dojo.isKhtml
* dojo.isAIR - true if running within the Adobe AIR enviroment
* dojo.isQuirks - is the browser in Quirks-Mode
* dojo.isBrowser (not typically needed when only targeting browsers)
* dojo.isWebKit (1.3+)
* dojo.isChrome (1.3+)

Each variable is only defined if the specified browser is being used. For example, if you're using Internet Explorer, only dojo.isIE is defined; all the other variables are undefined. The variable holds the browser version number as a Number, so you can easily perform version checks. Additionally, since undefined always evaluates as false in if statements, you can use code like this to check for a certain browser version:

.. code-block:: javascript
  :linenos:
  
  // NOTE: This example uses Dojo pre-1.7 style sync api.  See Example 1 below for new 1.7 style api example.
  if(dojo.isIE <= 6){ // only IE6 and below
    ...
  }

  if(dojo.isFF < 3){ // only Firefox 2.x and lower
    ...
  }

  if(dojo.isIE == 7){ // only IE7
    ...
  }

======================================
Example 1 - Dojo 1.7-style UA sniffing
======================================

Here's a live sample to show how it works:

.. code-block:: html
  :linenos:

  <script type="text/javascript">
  require("dojo/_base/sniff",// alias sniffing api to 'UA'
          "dojo/_base/Array",// alias array api to 'Array'
          "dojo/dom", // alias DOM api to 'DOM'
       function (UA, Array, DOM){ 

    function makeFancyAnswer(who){
      if(UA["is" + who]){
        return "Yes, it's version " + UA["is" + who];
      }else{ 
        return "No";
      }
    }

    function makeAtLeastAnswer(who, version) {
      var answer = (UA["is" + who] >= version) ? "Yes" : "No";
      DOM.byId("isAtLeast" + who + version).innerHTML = answer;
    }

    Array.forEach(["IE", "Mozilla", "FF", "Opera", "WebKit", "Chrome"],function(n) {
      DOM.byId("answerIs" + n).innerHTML = makeFancyAnswer(n);
    });    
    makeAtLeastAnswer("IE", 7);
    makeAtLeastAnswer("FF", 3);
    makeAtLeastAnswer("Opera", 9);

  });
  </script>
  <dl>
    <dt>Is this Internet Explorer?</dt>
    <dd id="answerIsIE"></dd>
    <dt>Is this Firefox?</dt>
    <dd id="answerIsFF"></dd>
    <dt>Is this Mozilla?</dt>
    <dd id="answerIsMozilla"></dd>
    <dt>Is this Opera?</dt>
    <dd id="answerIsOpera"></dd>
    <dt>Is this WebKit? (Dojo 1.3)</dt>
    <dd id="answerIsWebKit"></dd>
    <dt>Is this Chrome? (Dojo 1.3)</dt>
    <dd id="answerIsChrome"></dd>
  </dl>
  <dl>
    <dt>Is this at least IE 7?</dt>
    <dd id="isAtLeastIE7"></dd>
    <dt>Is this at least Firefox 3?</dt>
    <dd id="isAtLeastFF3"></dd>
    <dt>Is this at least Opera 9?</dt>
    <dd id="isAtLeastOpera9"></dd>
  </dl>

==========================================
Example 2 - Pre Dojo 1.7-style UA sniffing
==========================================

.. code-block:: html
  :linenos:

  <script type="text/javascript">
  function makeFancyAnswer(who){
    if(dojo["is" + who]){
      return "Yes, it's version " + dojo["is" + who];
    }else{ 
      return "No";
    }
  }

  function makeAtLeastAnswer(who, version) {
    var answer = (dojo["is" + who] >= version) ? "Yes" : "No";
    dojo.byId("isAtLeast" + who + version).innerHTML = answer;
  }

  dojo.addOnLoad(function(){
    dojo.forEach(["IE", "Mozilla", "FF", "Opera", "WebKit", "Chrome"],
                 function(n) {
                   dojo.byId("answerIs" + n).innerHTML = makeFancyAnswer(n);
                 });    
    makeAtLeastAnswer("IE", 7);
    makeAtLeastAnswer("FF", 3);
    makeAtLeastAnswer("Opera", 9);
    
  });
  </script>
  <dl>
    <dt>Is this Internet Explorer?</dt>
    <dd id="answerIsIE"></dd>
    <dt>Is this Firefox?</dt>
    <dd id="answerIsFF"></dd>
    <dt>Is this Mozilla?</dt>
    <dd id="answerIsMozilla"></dd>
    <dt>Is this Opera?</dt>
    <dd id="answerIsOpera"></dd>
    <dt>Is this WebKit? (Dojo 1.3)</dt>
    <dd id="answerIsWebKit"></dd>
    <dt>Is this Chrome? (Dojo 1.3)</dt>
    <dd id="answerIsChrome"></dd>
  </dl>
  <dl>
    <dt>Is this at least IE 7?</dt>
    <dd id="isAtLeastIE7"></dd>
    <dt>Is this at least Firefox 3?</dt>
    <dd id="isAtLeastFF3"></dd>
    <dt>Is this at least Opera 9?</dt>
    <dd id="isAtLeastOpera9"></dd>
  </dl>


========
See also
========

* `dojo._base.loader, the bootstrap module and home of the discussed variables <dojo/base/loader>`_
