.. _dojo/has:

========
dojo/has
========

:Authors: Chris Mitchell, Pete Higgins
:Project owner: Kris Zyp
:since: 1.7

.. contents ::
  :depth: 2

**dojo/has** provides standardized feature detection with an extensible API.  It is based on the conventions in the `has.js project <https://github.com/phiggins42/has.js>`_.

Introduction
============

Browser sniffing and feature inference are flawed techniques for detecting browser support in client side JavaScript. 
The ``dojo/has`` API is useful for adding new feature tests the result of which can be used later when features need to 
be detected. The goal of the ``dojo/has`` API is to provide a standard feature testing and feature detection module for 
use in Dojo modules.  Although the signature of the ``dojo/has`` API conforms to the has.js implementation and feature 
names, Dojo modules implement their own version of ``dojo/has`` tests, as some shortcuts and inferences are already 
available in the Toolkit.

``dojo/has`` feature detection is lazy instantiated, meaning that the code that determines if the feature is detected 
will not be executed until the feature is actually requested and the return value is then cached for future calls for 
the same feature.

Dojo Core and Dijit modules make use of ``dojo/has`` feature detection.  There are still a number of DojoX projects 
that continue to use ``dojo.isXXX`` user agent sniffing.  This conversion is an ongoing process.

``dojo/has`` can be used a loader plugin with a ternary conditional expression so that modules can be loaded 
conditionally.

The basic tests defined within the ``dojo/has`` module can be enhanced with other modules registering additional 
features and tests.  One frequently used module that extends ``dojo/has`` with additional tests and features is 
:ref:`dojo/sniff <dojo/sniff>`.

Using ``staticHasFeatures`` in a build configuration, along with the closure JavaScript complier can produce a build 
where dead code paths are removed.  See the :ref:`builder <build/index>` documentation for more information.

Usage
=====

In order to use this module, it must be added to your module's dependency list, for example:

.. js ::

  define(["dojo/has"], function(has){
    if(has("dom")){
      // Do something based on feature
    }
  });

The feature detection convention is to return a "truthy" value, meaning that if the feature is available, a value that 
would evaluate as ``true`` is returned.  If the feature is not present, ``dojo/has`` should return a ``false``.

The modules can be used as a loader plugin.  To do so, the plugin argument is a ternary logic expression where the 
first argument is the feature, the second is the module to load if it is true and the optional third is module to load 
if the feature is false:

.. js ::

  require(["dojo/has!feature?package/module:package/other"], function(featureModule){
    // If feature is true, package/module loaded
    // If feature is false, package/other loaded
  });

Features can be registered by providing a feature name and a test function:

.. js ::

  has.add("some-test-name", function(global, document, anElement){
    // Feature dection code, returning a truthy value if true
    return true;
  });

The test function should take up to three arguments:

========= =========================================
Argument  Description
========= =========================================
global    Reference to the global scope
document  Reference to the document object
anElement A generic element to be used if required
========= =========================================

*Note* any test function should clean up after itself.  Ensure there are no leaks!

You can register and run a test immediately by passing a truthy value after the test function:

.. js ::

  has.add("some-other-test", function(){
    return false; // Boolean
  }, true);

While it may seem logical to pass a non-wrapped function like the following, it is not advised:

.. js ::

 // this is not wrapped in a function, and should be:
 has.add("some-other-test", ("foo" in bar)); // or whatever

Without it being wrapped as a function, the execution takes place immediately instead of being lazy executed when the 
feature is actually required in a code path.

Feature Names
=============

The following feature tests are available in Dojo.  This table shows the module in which the feature test is added, and 
the name of the feature test.

=============================================================================== =================================
Module                                                                          Feature
=============================================================================== =================================
:ref:`dijit/_WidgetBase <dijit/_WidgetBase>`                                    dijit-legacy-requires
:ref:`dijit/form/_ExpandingTextAreaMixin <dijit/form/_ExpandingTextAreaMixin>`  textarea-needs-help-shrinking
:ref:`dojo/_base/browser <dojo/_base/browser>`                                  config-selectorEngine
:ref:`dojo/_base/connect <dojo/_base/connect>`                                  events-keypress-typed
:ref:`dojo/_base/kernel <dojo/_base/kernel>`                                    extend-dojo

                                                                                dojo-config-require

                                                                                dojo-guarantee-console

                                                                                dojo-debug-messages

                                                                                dojo-modulePaths

                                                                                dojo-moduleUrl
:ref:`dojo/_base/lang <dojo/_base/lang>`                                        bug-for-in-skips-shadowed
:ref:`dojo/_base/loader <dojo/_base/loader>`                                    config-publishRequireResult
:ref:`dojo/_base/window <dojo/_base/window>`                                    quirks

                                                                                ie
:ref:`dojo/dojo <dojo/dojo>`                                                    host-node

                                                                                host-rhino

                                                                                dojo-xhr-factory

                                                                                dojo-force-activex-xhr

                                                                                native-xhr

                                                                                dojo-gettext-api

                                                                                dojo-loader-eval-hint-url

                                                                                ie-event-behavior
:ref:`dojo/dom-class <dojo/dom-class>`                                          dom-classList
:ref:`dojo/has <dojo/has>`                                                      host-browser

                                                                                dom

                                                                                dojo-dom-ready-api

                                                                                dojo-sniff

                                                                                dom-addeventlistener

                                                                                touch

                                                                                device-width

                                                                                dom-attributes-explicit

                                                                                dom-attributes-specified-flag
:ref:`dojo/hccss <dojo/hccss>`                                                  highcontrast
:ref:`dojo/i18n <dojo/i18n>`                                                    dojo-preload-i18n-Api

                                                                                dojo-v1x-i18n-Api
:ref:`dojo/json <dojo/json>`                                                    json-parse

                                                                                json-stringify
:ref:`dojo/mouse <dojo/mouse>`                                                  dom-quirks

                                                                                events-mouseenter

                                                                                events-mousewheel
:ref:`dojo/on <dojo/on>`                                                        jscript

                                                                                event-orientationchange

                                                                                event-stopimmediatepropagation
:ref:`dojo/query <dojo/query>`                                                  array-extensible
:ref:`dojo/ready <dojo/ready>`                                                  dojo-config-addOnLoad
:ref:`dojo/request/handlers <dojo/request/handlers>`                            activex
:ref:`dojo/request/script <dojo/request/script>`                                script-readystatechange
:ref:`dojo/request/xhr <dojo/request/xhr>`                                      native-xhr
                                                                                dojo-force-activex-xhr
                                                                                native-xhr2
                                                                                native-formdata
:ref:`dojo/selector/_loader <dojo/selector/_loader>`                            dom-qsa2.1

                                                                                dom-qsa3
:ref:`dojo/selector/lite <dojo/selector/lite>`                                  dom-matches-selector

                                                                                dom-qsa
:ref:`dojo/sniff <dojo/sniff>`                                                  air

                                                                                khtml

                                                                                webkit

                                                                                chrome

                                                                                safari

                                                                                mac

                                                                                quirks

                                                                                ios

                                                                                android

                                                                                opera

                                                                                mozilla

                                                                                ff

                                                                                ie

                                                                                wii
:ref:`dojox/form/uploader/Base <dojox/form/uploader/Base>`                      FormData

                                                                                xhr-sendAsBinary

                                                                                file-multiple
:ref:`dojox/app/main <dojox/app/main>`                                          app-log-api
:ref:`dojox/mobile/Audio <dojox/mobile/Audio>`                                  mobile-embed-audio-video-support
:ref:`dojox/mobile/common <dojox/mobile/common>`                                mblAndroidWorkaround

                                                                                mblAndroid3Workaround
:ref:`dojox/mobile/scrollable <dojox/mobile/scrollable>`                        translate3d
:ref:`dojox/mobile/sniff <dojox/mobile/sniff>`                                  bb

                                                                                android

                                                                                iphone

                                                                                touch
:ref:`dojox/mvc/_InlineTemplateMixin <dojox/mvc/_InlineTemplateMixin>`          dom-qsa
:ref:`dojox/mvc/parserExtension <dojox/mvc/parserExtension>`                    dom-qsa

                                                                                dojo-parser

                                                                                dojo-mobile-parser
:ref:`dojox/mvc/sync <dojox/mvc/sync>`                                          mvc-bindings-log-api
:ref:`util/build/main <util/build/main>`                                        is-windows
=============================================================================== =================================

Examples
========

.. code-example ::

  This example uses the ``dojo/has`` module as both a normal module and as a plugin.  It detects if you have a touch 
  capable device or not.

  .. js ::

    require(["dojo/has", "dojo/has!touch?dojo/touch:dojo/mouse", "dojo/dom", "dojo/domReady!"], 
    function(has, hid, dom){
      if(has("touch")){
        dom.byId("output").innerHTML = "You have a touch capable device and so I loaded <code>dojo/touch</code>.";
      }else{
        dom.byId("output").innerHTML = "You do not have a touch capable device and so I loaded <code>dojo/mouse</code>.";
      }
    });

  .. html ::

    <div id="output"></div>

See Also
========

* `has.js Project <https://github.com/phiggins42/has.js>`_ - You can find standard tests and feature names.

* `dojo/sniff <dojo/sniff>` - The modules that provides browser detection by building on top of ``dojo/has``.

Some portions of this document were copied with permission from has.js Project.  Thanks to the has.js team for this 
work!
