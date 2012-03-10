.. _dojo/has:

========
dojo/has
========

:Authors: Chris Mitchell, Pete Higgins
:Project owner: Kris Zyp
:since: 1.7.0

.. contents ::
  :depth: 2

About
========

Dojo 1.7 introduces a standard feature testing and detection api, based on conventions established by the awesome `has.js project <https://github.com/phiggins42/has.js>`_.

Browser sniffing and feature inference are flawed techniques for detecting browser support in client side JavaScript.
The has() API is useful for adding new feature tests the result of which can be used later when features need to be detected. The goal of the Dojo has() API is to provide a standard feature testing and feature detection module for use in Dojo modules.

Although the signature of the has() API conforms to the has.js implementation and feature names, Dojo modules implement their own version of has() tests, as some shortcuts and inferences are already available in the toolkit.

Dojo Core and Dijit modules make use of has() feature detection in 1.7.  There are still a number of dojox projects that continue to use dojo.isXXX ua sniffing.  These remaining projects will likely be converted to use has() in the 1.8 time frame.

Ternary has() conditional expressions can also be used during module loading for conditional loading of modules based on feature availability.  See the Dojo loader documentation for more details on this capability.

The basic tests within dojo/has module can be augmented with additional tests by any other module.  One frequently used module that extends dojo/has with additional tests is :ref:`dojo/sniff <dojo/sniff>`.

Usage
========

Dojo's implementation of has() is provided by the dojo/has.js module.  In order to use this module, it must be added to your module's define dependency list, for example:

.. js ::
 
  define(["dojo/has", "dojo/_base/kernel"], function(has, dojo){
   // Use has() and has.add() as in examples below...
  });
 

Currently, the testing convention is `has('somefeature')` returns Boolean, e.g.:

.. js ::
 
 if(has("function-bind")){
    // your environment has a native Function.prototype.bind
 }else{
    // you'll have to workaround or degrade because the feature's not available in your environment.
 }
    
In the real world, this may translate into something like:

.. js ::
 
 mylibrary.trim = has("string-trim") ? function(str){
     return (str || "").trim();
 } : function(str){
     /* do the regexp based string trimming you feel like using */
 }

By using this approach, we can easily defer to browser-native versions of common functions and can also isolate non-standard codepaths. As browsers change over time (hopefully converging on standard api's), non-standard codepaths can more easily be pruned by build tools.
Using this approach also simplifies the ability to prune browser-specific codepaths.  For example, if you're only interested in webkit environments, non-webkit feature paths can more easily be stripped out in a build, resulting in smaller more targeted code being sent to clients.

Running `has()` is a one-time cost, deferred until needed. After first run, subsequent `has()` checks are cached and return immediately.

There are also groups working on server-side has() optimizations, to precompute the cache of tests to reduce startup times.

Testing Registration
--------------------

Each test is self-contained. Register a test with `has.add()`:

.. js ::
 
 has.add("some-test-name", function(global, document, anElement){
   // global is a reference to global scope, document is the same
   // anElement only exists in browser environments, and can be used
   // as a common element from which to do DOM working.
   // ALWAYS CLEAN UP AFTER YOURSELF in a test. No leaks, thanks.
   // return a Boolean from here.
   return true;
 });
    
You can register and run a test immediately by passing a truthy value after the test function:

.. js ::
 
 has.add("some-other-test", function(){
   return false; // Boolean
 }, true)

This is preferred over what would seem a much more effective version:

.. js ::
 
 // this is not wrapped in a function, and should be:
 has.add("some-other-test", ("foo" in bar)); // or whatever
    
By forcing a function wrapper around the test logic we are able to defer execution until needed, as well as provide a normalized way for each test to have its own execution context. This way, we can remove some or all the tests we do not need in whatever upstream library should adopt _has_.


Dojo 1.7 Feature Names
======================

The following feature tests are available in Dojo 1.7.  This table shows the module in which the feature test is added, and the name of the feature test.  View the source code of each module to understand exactly how the test is performed (explicit testing, inference, user agent sniff etc.)

.. js ::
 
  dojo/_base/browser.js , config-selectorEngine
  dojo/_base/config.js , dojo-sniff
  dojo/_base/connect.js , events-keypress-typed
  dojo/_base/event.js , dom-addeventlistener
  dojo/_base/kernel.js , config-* // All djConfig properties are added dynamically
  dojo/_base/kernel.js , dojo-guarantee-console
  dojo/_base/kernel.js , bug-for-in-skips-shadowed
  dojo/_base/kernel.js , dojo-debug-messages
  dojo/_base/kernel.js , dojo-moduleUrl
  dojo/_base/loader.js , config-publishRequireResult
  dojo/_base/sniff.js , opera
  dojo/_base/sniff.js , air
  dojo/_base/sniff.js , khtml
  dojo/_base/sniff.js , webkit
  dojo/_base/sniff.js , chrome
  dojo/_base/sniff.js , mac
  dojo/_base/sniff.js , safari
  dojo/_base/sniff.js , mozilla
  dojo/_base/sniff.js , ie
  dojo/_base/sniff.js , ff
  dojo/_base/sniff.js , quirks
  dojo/_base/sniff.js , ios
  dojo/_base/sniff.js , vml
  dojo/_base/xhr.js , native-xhr
  dojo/dojo.js , host-node
  dojo/dojo.js , host-rhino
  dojo/dojo.js , config-* // All djConfig properties are added dynamically
  dojo/dojo.js , dojo-force-activex-xhr
  dojo/dojo.js , native-xhr
  dojo/dojo.js , ie-event-behavior
  dojo/dom/class.js , dom-classList
  dojo/has.js , host-browser
  dojo/has.js , dom
  dojo/has.js , dojo-dom-ready-api
  dojo/has.js , dojo-sniff
  dojo/has.js , dom-addeventlistener
  dojo/has.js , touch
  dojo/has.js , device-width
  dojo/has.js , agent-ios
  dojo/has.js , agent-android
  dojo/i18n.js , dojo-v1x-i18n-Api
  dojo/json.js , json-parse
  dojo/json.js , json-stringify
  dojo/main.js , dojo-load-firebug-console
  dojo/main.js , dojo-config-require
  dojo/mouse.js , dom-quirks
  dojo/mouse.js , events-mouseenter
  dojo/on.js , jscript
  dojo/on.js , event-orientationchange
  dojo/ready.js , dojo-config-addOnLoad
  dojo/selector/_loader.js , dom-qsa2.1
  dojo/selector/_loader.js , dom-qsa3
  dojo/selector/lite.js , dom-matches-selector
  dojo/selector/lite.js , dom-qsa
  util/build/main.js , is-windows

Note: The above list was generated automatically with the following script in the root of the src dir, and edited manually:

.. js ::
 
  grep -r --include=*.js "has.add(\"" * | awk -F"[ \t\":,]+" '{ print " ",$1,",", $3}'


See Also
========

* `has.js standard feature test names (this page can be also used to test your browser's capabilities) <http://dante.dojotoolkit.org/hasjs/tests/runTests.html>`_
* `has.js project (here you'll find standard tests and feature names) <https://github.com/phiggins42/has.js>`_

Some portions of this document were copied with permission from has.js project.  Thanks to the has.js team for this work!
