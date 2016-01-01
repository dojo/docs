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

``dojo/has`` can be used as a loader plugin with a ternary conditional expression so that modules can be loaded 
conditionally.

The basic tests defined within the ``dojo/has`` module can be enhanced with other modules registering additional 
features and tests.  One frequently used module that extends ``dojo/has`` with additional tests and features is 
:ref:`dojo/sniff <dojo/sniff>`.

Using ``staticHasFeatures`` in a build configuration, along with the closure JavaScript compiler can produce a build
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

.. csv-table:: 
 :header: "Module", "Feature", "Description"
 :widths: 15, 10, 30

 `dojo/_base/browser`,config-selectorEngine,"Pre-configured selector engine to use in dojo/query, defaults to dojo/selector/acme."
 :ref:`dojo/_base/connect <dojo/_base/connect>`,events-keypress-typed, Keypresses should only occur a printable character is hit
 :ref:`dojo/_base/kernel <dojo/_base/kernel>`,extend-dojo, "Defined Dojo modules should push their definitions into the dojo object. In 2.0, it will likely be unusual to augment another object as a result of defining a module. This has feature gives a way to force 2.0 behavior as the code is migrated."
 :ref:`dojo/_base/kernel <dojo/_base/kernel>`, dojo-guarantee-console, "Ensure that console.log, console.warn, etc. methods are defined"
 :ref:`dojo/_base/kernel <dojo/_base/kernel>`, console-as-object, "Determine if console is reported as object rather than function (IE9 known issue)"
 :ref:`dojo/_base/kernel <dojo/_base/kernel>`, dojo-debug-messages, "Log internal debug messages generated by Dojo, these include deprecated/experimental warnings along with parser auto-required module names."
 :ref:`dojo/_base/kernel <dojo/_base/kernel>`, dojo-modulePaths, "Consume module paths defined in config.modulePaths."
 :ref:`dojo/_base/kernel <dojo/_base/kernel>`, dojo-moduleUrl, "Expose dojo.moduleUrl method, returns a URL relative to a module. Deprecated in 2.0, should use require.toUrl()"
 :ref:`dojo/_base/lang <dojo/_base/lang>`, bug-for-in-skips-shadowed, Test for bug where the for-in iterator skips object properties that exist in Object's prototype (IE6 - ?).
 :ref:`dojo/_base/loader <dojo/_base/loader>`, dojo-fast-sync-require, "All dojoRequireCallbacks can be released when all *non-dojo/require!, dojo/loadInit!* modules are either executed, not requested, or arrived. Potential weakness of this algorithm is that dojo/require will not execute callbacks until *all* dependency trees are ready."
 :ref:`dojo/_base/loader <dojo/_base/loader>`, config-publishRequireResult, "Publish resolved module values, resulting from a require call, as JavaScript objects referenced by module identifiers in the global namespace."
 :ref:`dojo/_base/window <dojo/_base/window>`, quirks, Browser is running in *Quirks-Mode*
 :ref:`dojo/dojo <dojo/dojo>`, host-node, Environment is running on the the NodeJS platform
 :ref:`dojo/dojo <dojo/dojo>`, host-rhino, Environment is running on the Rhino platform
 :ref:`dojo/dojo <dojo/dojo>`, dojo-xhr-factory,
 :ref:`dojo/dojo <dojo/dojo>`, dojo-force-activex-xhr, Force XHR provider to use ActiveX API (MSXMLHTTP).
 :ref:`dojo/dojo <dojo/dojo>`,native-xhr, "Browser has native XHR API, XMLHttpRequest."
 :ref:`dojo/dojo <dojo/dojo>`,dojo-gettext-api, Dojo provides API for retrieving text resource contents from a URL.
 :ref:`dojo/dojo <dojo/dojo>`,dojo-loader-eval-hint-url, Module location should be used as source hint during eval rather than module identifier.
 :ref:`dojo/dojo <dojo/dojo>`,ie-event-behavior, Browser supports legacy IE event behaviour API (attachEvent versus attachEventListener).
 :ref:`dojo/dom <dojo/dom>`, dom-contains, Existence of 'DOMNode.contains()' API
 :ref:`dojo/dom <dojo/dom>`, css-user-select, Existence of CSS 'user-select' property
 :ref:`dojo/has <dojo/has>`, host-browser, Environment is running on the browser platform
 :ref:`dojo/has <dojo/has>`, dom, Document Object Module API supported on the current platform
 :ref:`dojo/has <dojo/has>`, dojo-dom-ready-api, "DOMReady API supported on the current platform, allowing listeners to be notified when the DOM has loaded"
 :ref:`dojo/has <dojo/has>`, dojo-sniff, User-agent sniffing support on the current platform
 :ref:`dojo/has <dojo/has>`, dom-addeventlistener, Standard DOM event API (addEventListener) supported on the current platform.
 :ref:`dojo/has <dojo/has>`, touch, Touch events are supported on the current platform
 :ref:`dojo/has <dojo/has>`, device-width, Amount of horizontal space in pixels available on the window
 :ref:`dojo/has <dojo/has>`, dom-attributes-explicit, "DOM node attributes array only lists explicitly user specified attributes, (W3C standard)"
 :ref:`dojo/has <dojo/has>`, dom-attributes-specified-flag, "DOM node attribute values provide *specified* flag to skip attributes user didn't specify, (IE8)"
 :ref:`dojo/hccss <dojo/hccss>`, highcontrast, "Browser is in 'high-contrast' mode"
 :ref:`dojo/i18n <dojo/i18n>`, dojo-preload-i18n-Api, "Define the preload localizations machinery, allow loading of special rollup modules which contain one or more flattened, localized bundles."
 :ref:`dojo/i18n <dojo/i18n>`, dojo-v1x-i18n-Api, "Define legacy (v1.x) i18n functions"
 :ref:`dojo/json <dojo/json>`, json-parse, Platform supports parsing JSON text to JavaScript objects through native API
 :ref:`dojo/json <dojo/json>`, json-stringify, "Platform supports 'stringify' method on native JSON API, allowing serialisation of JavaScript objects to JSON text."
 :ref:`dojo/mouse <dojo/mouse>`, dom-quirks, Browser is running in *Quirks-Mode*
 :ref:`dojo/mouse <dojo/mouse>`, events-mouseenter, Browser supports the *onmouseenter* DOM event
 :ref:`dojo/mouse <dojo/mouse>`, events-mousewheel, Browser supports the *onmousewheel* DOM event
 :ref:`dojo/on <dojo/on>`, jscript, "JavaScript environment provided by the JScript platform, dialect of ECMAScript standard that is used in Microsoft's Internet Explorer."
 :ref:`dojo/on <dojo/on>`, event-orientationchange, "Browser supports the *orientationchange* DOM event, used to detect orientation changes in the target device."
 :ref:`dojo/on <dojo/on>`, event-stopimmediatepropagation, "Browser supports the *stopImmediatePropagation* method on DOM events, used to prevent other event listeners being called."
 :ref:`dojo/query <dojo/query>`, array-extensible, "Native array implementation supports manual extension (not supported in older versions of IE)."
 :ref:`dojo/ready <dojo/ready>`, dojo-config-addOnLoad, "Consume *addOnLoad* configuration property."
 :ref:`dojo/request/handlers <dojo/request/handlers>`, activex, "Browser platform has ActiveX API methods, provided by Internet Explorer"
 :ref:`dojo/request/script <dojo/request/script>`, script-readystatechange, "DOM supports *onreadystatechange* event, fired when document.readyState changes"
 :ref:`dojo/request/xhr <dojo/request/xhr>`, native-xhr, "Browser has native XHR API, XMLHttpRequest"
 :ref:`dojo/request/xhr <dojo/request/xhr>`, dojo-force-activex-xhr, "Force XHR provider to use ActiveX API (MSXMLHTTP)."
 :ref:`dojo/request/xhr <dojo/request/xhr>`, native-xhr2, "Browser's native XHR implementation supports XHR Level 2 API"
 :ref:`dojo/request/xhr <dojo/request/xhr>`, native-formdata, "Browser has a native FormData implementation, letting user compile set of key/value pairs to send using XMLHttpRequest"
 :ref:`dojo/selector/_loader <dojo/selector/_loader>`, dom-qsa2.1, "Browser supports the DOM QuerySelectorAll method available, with Level 2.1 CSS selectors"
 :ref:`dojo/selector/_loader <dojo/selector/_loader>`, dom-qsa3, "Browser supports DOM QuerySelectorAll method, with Level 3 CSS selectors"
 :ref:`dojo/selector/lite <dojo/selector/lite>`, dom-matches-selector, "Browser supports the *matchesSelector* method for testing selector queries directly against DOM nodes."
 :ref:`dojo/selector/lite <dojo/selector/lite>`, dom-qsa, "Browsers supports the DOM QuerySelectorAll method."
 :ref:`dojo/sniff <dojo/sniff>`, air, "Environment is running on the Adobe Air platform"
 :ref:`dojo/sniff <dojo/sniff>`, khtml, "Environment is running on the Konqueror-based platform"
 :ref:`dojo/sniff <dojo/sniff>`, webkit, "Environment is running on the WebKit rendering engine platform"
 :ref:`dojo/sniff <dojo/sniff>`, chrome, "Environment is running on the Chrome browser platform"
 :ref:`dojo/sniff <dojo/sniff>`, safari, "Environment is running on the Safari browser platform"
 :ref:`dojo/sniff <dojo/sniff>`, mac, "Environment is running on the Mac OS X platform"
 :ref:`dojo/sniff <dojo/sniff>`, quirks, "Browser is running in *Quirks-Mode*"
 :ref:`dojo/sniff <dojo/sniff>`, ios, "Environment is running on the iOS mobile operating system"
 :ref:`dojo/sniff <dojo/sniff>`, android, "Environment is running on the Android mobile operating system"
 :ref:`dojo/sniff <dojo/sniff>`, bb, "Environment is running on the Blackberry mobile operating system"
 :ref:`dojo/sniff <dojo/sniff>`, trident, "Browser is running the Trident rendering engine (e.g. IE11)"
 :ref:`dojo/sniff <dojo/sniff>`, svg, "Browser implements the SVG specification"
 :ref:`dojo/sniff <dojo/sniff>`, opera, "Environment is running on the Opera browser platform through version 14"
 :ref:`dojo/sniff <dojo/sniff>`, opr, "Environment is running on the Opera browser platform version 15+"
 :ref:`dojo/sniff <dojo/sniff>`, mozilla, "Environment is running on the Mozilla browser platform"
 :ref:`dojo/sniff <dojo/sniff>`, ff, "Environment is running on the Firefox browser platform"
 :ref:`dojo/sniff <dojo/sniff>`, ie, "Environment is running on the Microsoft Internet Explorer browser platform through version 10"
 :ref:`dojo/sniff <dojo/sniff>`, edge, "Environment is running on the Edge browser platform version 12+"
 :ref:`dojo/sniff <dojo/sniff>`, wii, "Environment is running on the Nintendo Wii browser platform"
 
 :ref:`dijt/BackgroundIframe <dijit/BackgroundIframe>`,config-bgIframe,"Flag to create background iframe behind popups like Menus and Dialog.  A background iframe prevents problems with popups appearing behind applets/pdf viewers, and also prevents the bleed through select problem on IE6 and IE7."
 :ref:`dijit/_WidgetBase <dijit/_WidgetBase>`, dijit-legacy-requires, "Make dijit load modules the application didn't explicitly require, e.g. dijit/_base/manager, backwards compatibility in non-async mode."
 :ref:`dijit/form/_ExpandingTextAreaMixin <dijit/form/_ExpandingTextAreaMixin>`,  textarea-needs-help-shrinking, "Browser platform's <textarea> element needs manual help to shrink as content changes."
 `dojox/form/uploader/Base`, FormData, "Browser has a native FormData implementation, letting user compile set of key/value pairs to send using XMLHttpRequest"
 `dojox/form/uploader/Base`, xhr-sendAsBinary, "Browser's native XHR implementation supports the *sendAsBinary* method, for sending binary data over XHR."
 `dojox/form/uploader/Base`, file-multiple, "Browser supports file input DOM element with multiple file selection attribute, allowing user to select more than one file."
 :ref:`dojox/mobile/Audio <dojox/mobile/Audio>`, mobile-embed-audio-video-support, "Platform supports creating embed tags with audio and video elements."
 `dojox/mobile/common`, mblAndroidWorkaround, "Test for Android 2.X transition animation flicker issue"
 `dojox/mobile/common`, mblAndroid3Workaround, "Test for Android 3.X transition animation flicker issue"
 :ref:`dojox/mobile/scrollable <dojox/mobile/scrollable>`, translate3d, "Browser supports the WebKit-specific CSS transform property, translate3d."
 :ref:`dojox/mobile/sniff <dojox/mobile/sniff>`, iphone, "Deprecated. Environment is running on the iPhone mobile browser platform"
 :ref:`dojox/mobile/_maskUtils <dojox/mobile/_maskUtils>`, mask-image-css, "Browser supports the webkitMaskImage style property and implements document.getCSSCanvasContext API"
 :ref:`dojox/mobile/_maskUtils <dojox/mobile/_maskUtils>`, mask-image, "Browser supports image mask (either via css mask image or svg)"
 :ref:`dojox/mvc/_InlineTemplateMixin <dojox/mvc/_InlineTemplateMixin>`, dom-qsa, "Browser supports the DOM QuerySelectorAll method"
 :ref:`dojox/mvc/parserExtension <dojox/mvc/parserExtension>`, dom-qsa, "Browser supports the DOM QuerySelectorAll method"
 :ref:`dojox/mvc/parserExtension <dojox/mvc/parserExtension>`, dojo-parser, "Browser has loaded the dojo/parser module"
 :ref:`dojox/mvc/parserExtension <dojox/mvc/parserExtension>`, dojo-mobile-parser, "Browser has loaded the dojox/mobile/parser module"
 :ref:`dojox/mvc/sync <dojox/mvc/sync>`, mvc-bindings-log-api, "Enable debugging messages for MVC module."

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
