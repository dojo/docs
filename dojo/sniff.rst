.. _dojo/sniff:

=============================
Browser (User Agent) Sniffing
=============================

:Authors: Peter Higgins, Ben Lowery

.. contents ::
    :depth: 2

You should always try to use feature detection (See general overview `Using Capability Detection <http://dev.opera.com/articles/view/using-capability-detection/>`_) whenever possible to write forward-compatible code branches.  The `dojo/has <dojo/has>`_ API is designed to help in this endeavor.

For when feature detection is not an option, Dojo provides dojo provides user agent sniffing code in the module, ``dojo/sniff``.   The sniff module augments the basic set of has() tests (see :ref:`dojo/has <dojo/has>`) with additional user agent based tests, so you can use the base has() api to test for browser environment and versions, just like you do for other features.  Using this approach in conjunction with an optimizing compiler at build time, it is possible to optimize out unwanted code paths for specific browsers.

The sniff module defines the following has-features:

* has("host-browser")
* has("ie")
* has("mozilla")
* has("ff")
* has("opera")
* has("safari")
* has("khtml")
* has("air") - true if running within the Adobe AIR environment
* has("quirks") - is the browser in Quirks-Mode
* has("host-browser") (not typically needed when only targeting browsers)
* has("webkit") (1.3+)
* has("chrome") (1.3+)

Each variable is only defined if the specified browser is being used. For example, if you're using Internet Explorer, only dojo.isIE is defined; all the other variables are undefined. The variable holds the browser version number as a Number, so you can easily perform version checks. Additionally, since undefined always results in a false result in greater-than or less-than comparisons, you can use code like this to check for a certain browser version:

.. js ::

  require(["dojo/has", "dojo/_base/sniff"], function(has){
    if(has("ie") <= 6){ // only IE6 and below
      ...
    }

    if(has("ff") < 3){ // only Firefox 2.x and lower
      ...
    }

    if(has("ie") == 7){ // only IE7
      ...
    }
  });


Example 1 - UA sniffing in Dojo 1.7 with AMD and the has API
============================================================

Here's a live sample to show how it works, when using AMD and minimal base dependencies rather than all modules that get implicitly loaded by the dojo package, so that we can show how the sniff module's return values can be mapped to has() to detect the current browser with a small amount of loaded code:

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

      require(["dojo/has", // alias has API to "has"
              "dojo/_base/array", // alias array api to "arrayUtil"
              "dojo/dom", // alias DOM api to "dom"
              "dojo/_base/sniff", // load browser-related has feature tests
              "dojo/domReady!"], // wait until DOM is loaded
           function(has, arrayUtil, dom){

        function makeFancyAnswer(who){
          if(has(who)){
            return "Yes, it's version " + has(who);
          }else{
            return "No";
          }
        }

        function makeAtLeastAnswer(who, version){
          var answer = (has(who) >= version) ? "Yes" : "No";
          dom.byId("isAtLeast" + who + version).innerHTML = answer;
        }

        arrayUtil.forEach(["ie", "mozilla", "ff", "opera", "webkit", "chrome"], function(n){
          dom.byId("answerIs" + n).innerHTML = makeFancyAnswer(n);
        });
        makeAtLeastAnswer("ie", 7);
        makeAtLeastAnswer("ff", 3);
        makeAtLeastAnswer("opera", 9);

      });

  .. html ::

      <dl>
        <dt>Is this Internet Explorer?</dt>
        <dd id="answerIsie"></dd>
        <dt>Is this Firefox?</dt>
        <dd id="answerIsff"></dd>
        <dt>Is this Mozilla?</dt>
        <dd id="answerIsmozilla"></dd>
        <dt>Is this Opera?</dt>
        <dd id="answerIsopera"></dd>
        <dt>Is this WebKit? (Dojo 1.3)</dt>
        <dd id="answerIswebkit"></dd>
        <dt>Is this Chrome? (Dojo 1.3)</dt>
        <dd id="answerIschrome"></dd>
      </dl>
      <dl>
        <dt>Is this at least IE 7?</dt>
        <dd id="isAtLeastie7"></dd>
        <dt>Is this at least Firefox 3?</dt>
        <dd id="isAtLeastff3"></dd>
        <dt>Is this at least Opera 9?</dt>
        <dd id="isAtLeastopera9"></dd>
      </dl>
