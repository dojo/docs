.. _dojo/_base/loader:

=================
dojo._base.loader
=================

:since: V0.9

.. contents ::
    :depth: 2

**dojo._base.loader** is a bootstrap module which contains all of the package loading methods.

As with all dojo._base components, these functions are included within Dojo Base. You get this functionality by just including ``dojo.js`` in your page.


Features
========

* :ref:`dojoConfig <dojo/config>`

  Configuring Dojo with dojoConfig

* :ref:`dojo.ready <dojo/ready>`

  Call functions after the DOM has finished loading and widgets declared in markup have been instantiated

* :ref:`dojo.addOnUnload <dojo/addOnUnload>`

  Call functions when the page unloads

* :ref:`dojo.addOnWindowUnload <dojo/addOnWindowUnload>`

  Call functions when window.onunload fires

* :ref:`dojo.deprecated <dojo/deprecated>`

  Log a debug message to indicate that a behavior has been deprecated

* :ref:`dojo.exists <dojo/exists>`

  Determine if an object supports a given method

* :ref:`dojo.getObject <dojo/getObject>`

  Get a property from a dot-separated string, such as "A.B.C"

* :ref:`dojo.global <dojo/global>`

  Alias for the global scope

* :ref:`dojo.isBrowser <quickstart/browser-sniffing>`

  Returns true if the client is a web-browser

* :ref:`dojo.isChrome <quickstart/browser-sniffing>` (new in V1.3)

  Returns the version number of the browser, if the client is a Chrome-Browser, otherwise *undefined*

* :ref:`dojo.isFF <quickstart/browser-sniffing>`

  Returns the version number of the browser, if the client is a Mozilla FireFox-Browser, otherwise *undefined*

* :ref:`dojo.isIE <quickstart/browser-sniffing>`

  Returns the version number of the browser, if the client is a MS Internet Explorer-Browser, otherwise *undefined*

* :ref:`dojo.isKhtml <quickstart/browser-sniffing>`

  Returns the version number of the browser, if the client is a KHTML browser, otherwise *undefined*

* :ref:`dojo.isMozilla <quickstart/browser-sniffing>`

  Returns the version number of the browser, if the client is a Mozilla-based browser (Firefox, SeaMonkey), otherwise *undefined*

* :ref:`dojo.isOpera <quickstart/browser-sniffing>`

  Returns the version number of the browser, if the client is a Opera-Browser, otherwise *undefined*

* :ref:`dojo.isSafari <quickstart/browser-sniffing>`

  Returns the version number of the browser, if the client is is Safari or iPhone, otherwise *undefined*

* :ref:`dojo.isWebKit <quickstart/browser-sniffing>` (new in V1.3)

  Returns the version number of the browser, if the client is a WebKit-derived browser (Konqueror, Safari, Chrome, etc.), otherwise *undefined*


* :ref:`dojo.mixin <dojo/mixin>`

  Multiple inheritance

* :ref:`dojo.registerModulePath <dojo/registerModulePath>`

  Maps module name to a path

* :ref:`dojo.require <dojo/require>`

  Loads a Javascript module from the appropriate URI

* :ref:`dojo.setObject <dojo/setObject>`

  Set a property from a dot-separated string, such as "A.B.C"

* :ref:`dojo.version <dojo/version>`

  The current version number of Dojo

* :ref:`dojo.windowUnloaded <dojo/windowUnloaded>`

  Signal fired by impending window destruction
