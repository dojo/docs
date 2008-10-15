#format dojo_rst

dojo._base.loader
=================

:Status: Draft
:Version: 1.0
:Available: since V?

.. contents::
    :depth: 2

**dojo._base.loader** is a bootstrap module which contains all of the package loading methods.

As with all dojo._base components, these functions are included within Dojo Base. You get this functionality by just including dojo.js or dojo.xd.js in your page.


========
Features
========

* `djConfig <djConfig>`_

  Configuring Dojo with djConfig

* `dojo.addOnLoad <dojo/addOnLoad>`_

  Call functions after the DOM has finished loading and widgets declared in markup have been instantiated

* `dojo.addOnUnload <dojo/addOnLoad>`_

  Call functions when the page unloads

* `dojo.addOnWindowUnload <dojo/addOnWindowUnload>`_

  Call functions when window.onunload fires

* `dojo.deprecated <dojo/deprecated>`_

  Log a debug message to indicate that a behavior has been deprecated

* `dojo.exists <dojo/exists>`_

  Determine if an object supports a given method

* `dojo.getObject <dojo/getObject>`_

  Get a property from a dot-separated string, such as "A.B.C"

* `dojo.global <dojo/global>`_

  Alias for the global scope

* `dojo.isBrowser <dojo/isBrowser>`_

  Returns true if the client is a web-browser

* `dojo.isChrome <dojo/isChrome>`_ (new in V1.3)

  Returns the version number of the browser, if the client is a Chrome-Browser, otherwise *undefined*

* `dojo.isFF <dojo/isFF>`_

  Returns the version number of the browser, if the client is a Mozilla FireFox-Browser, otherwise *undefined*

* `dojo.isIE <dojo/isIE>`_

  Returns the version number of the browser, if the client is a MS Internet Explorer-Browser, otherwise *undefined*

* `dojo.isKhtml <dojo/isKhtml>`_

  Returns the version number of the browser, if the client is a KHTML browser, otherwise *undefined*

* `dojo.isMozilla <dojo/isMozilla>`_

  Returns the version number of the browser, if the client is a Mozilla-based browser (Firefox, SeaMonkey), otherwise *undefined*

* `dojo.isOpera <dojo/isOpera>`_

  Returns the version number of the browser, if the client is a Opera-Browser, otherwise *undefined*

* `dojo.isSafari <dojo/isSafari>`_

  Returns the version number of the browser, if the client is is Safari or iPhone, otherwise *undefined*

* `dojo.isWebKit <dojo/isWebKit>`_ (new in V1.3)

  Returns the version number of the browser, if the client is a WebKit-derived browser (Konqueror, Safari, Chrome, etc.), otherwise *undefined*


* `dojo.mixin <dojo/mixin>`_

  Multiple inheritance

* `dojo.registerModulePath <dojo/registerModulePath>`_

  Maps module name to a path

* `dojo.require <dojo/require>`_

  Loads a Javascript module from the appropriate URI

* `dojo.setObject <dojo/setObject>`_

  Set a property from a dot-separated string, such as "A.B.C"

* `dojo.version <dojo/version>`_

  The current version number of Dojo

* `dojo.windowUnloaded <dojo/windowUnloaded>`_

  Signal fired by impending window destruction
