.. _dojo/sniff:

==========
dojo/sniff
==========

:Authors: Peter Higgins, Ben Lowery

.. contents ::
    :depth: 2

**dojo/sniff** is the main Dojo module for browser feature detection.  Feature detection is an important consideration 
when writing code.  It allows more maintainable code, better user experience, forward-compatibility and more 
performant code.  The :ref:`dojo/has <dojo/has>` API is the main Dojo mechanism for accomplishing this and 
``dojo/sniff`` leverages this.

When leveraged with :ref:`Dojo's Builder <build/index>`, unused code can be removed for non-targeted browsers. This 
reduces the size and increases the performance of your code.

Usage
=====

The module can be used in two ways, because the module adds features to ``dojo/has`` and returns ``dojo/has`` as 
its return value. Both examples below are functionally equivalent:

.. js ::

  require(["dojo/sniff"], function(sniff){
    if(sniff("ie"){
      // Do something specific for IE.
    });
  });

.. js ::

  require(["dojo/has", "dojo/sniff"], function(has){
    if(has("ie")){
      // Do something specific for IE.
    }
  });

The module defines the following has-features:

=========== ============================================
Feature     Notes
=========== ============================================
``air``     Detects Adobe AIR Environments
``khtml``
``webkit``  Detects Webkit based environments 1.3+
``mac``     Detects if the platform is Mac OSX
``quirks``  If the browser is running in "quirks" mode
``ios``     Detects iOS devices
``android`` Detects Android devices
``bb``      Detects BlackBerry devices
``chrome``  Detects Google Chrome 1.3+ browser
``safari``  Detects Safari browser
``opera``   Detects Opera browser
``mozilla`` Detects Mozilla browser
``ff``      Detects Firefox browser.
``ie``      Detects Internet Explorer browser.
``wii``     Detects if running on a Nintendo Wii
``svg``     Detects SVG support
=========== ============================================

Each feature will only return a truthy value if the specified browser is being used.  For example if you are using 
Internet Explorer ``has("ie")`` will only return a truthy value, where as ``has("chrome")`` will return false.

The value returned, where appropriate, will provide the version number of the browser, so specific code checks can be 
done for versions. For example:

.. js ::

  require(["dojo/has", "dojo/sniff"], function(has){
    if(has("ie") <= 6){ // only IE6 and below
      // ...
    }

    if(has("ff") < 3){ // only Firefox 2.x and lower
      // ...
    }

    if(has("ie") == 7){ // only IE7
      // ...
    }
  });

Examples
========

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  Basic browser detection example.

  .. js ::

    require(["dojo/has", // alias has API to "has"
        "dojo/_base/array", // alias array API to "arrayUtil"
        "dojo/dom", // alias DOM API to "dom"
        "dojo/sniff", // load browser-related has features
        "dojo/domReady!" // wait until DOM is loaded
    ], function(has, array, dom){

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

      array.forEach(["ie", "mozilla", "ff", "opera", "webkit", "chrome"], function(n){
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

See Also
========

* :ref:`dojo/has <dojo/has>` - The main feature detection module of Dojo.