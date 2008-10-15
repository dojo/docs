#format dojo_rst

Browser Sniffing
================

:Status: Draft
:Version: 1.0
:Authors: Peter Higgins, Ben Lowery

.. contents::
    :depth: 2

Dojo provides a number of ``is`` variables, defined at runtime based on the users current browser.

* dojo.isIE
* dojo.isMozilla
* dojo.isFF
* dojo.isOpera
* dojo.isSafari
* dojo.isKhtml
* dojo.isAIR - true if running within the Adobe AIR enviroment
* dojo.isQuirks - is the browser in Quirks-Mode
* dojo.isBrowser (not typically needed when only targeting browsers)

Each variable is only defined if the specified browser is being used. For example, if you're using Internet Explorer, only dojo.isIE is defined; all the other variables are undefined. The variable holds the browser version number as a Number, so you can easily perform version checks. Additionally, since undefined always evaluates as false in if statements, you can use code like this to check for a certain browser version:

.. code-block:: javascript
  :linenos:
  
  if(dojo.isIE <= 6){ // only IE6 and below
    ...
  }

  if(dojo.isFF < 3){ // only Firefox 2.x and lower
    ...
  }

  if(dojo.isIE == 7){ // only IE7
    ...
  }


========
Examples
========

Here's a live sample to show how it works:

.. codeviewer::

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
    dojo.forEach(["IE", "Mozilla", "FF", "Opera"],
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
