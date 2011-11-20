.. _dojox/io:

dojox.io
========

:Status: Draft
:Version: 1.0
:Developers: Bryan Forbes, Kris Zyp, James Burke, Tom Trenka
:Available: since V?

.. contents::
    :depth: 2

========
Features
========

* :ref:`dojox.io.httpParse <dojox/io/httpParse>`

  HTTP message parser. Parses to an XHR like interface.

* :ref:`dojox.io.OAuth <dojox/io/OAuth>`

  Helper class to assemble OAuth URL parameters.

* :ref:`dojox.io.scriptFrame <dojox/io/scriptFrame>`

  Uses an iframe for dojo.io.script requests. Useful in some long-polling comet situations in Firefox and Opera. Those browsers execute scripts in DOM order, not network-receive order, so a long-polling script will block other dynamically appended scripts from running until it completes. By using an iframe for the dojo.io.script requests, this issue can be avoided.

* :ref:`dojox.io.windowName <dojox/io/windowName>`

  Cross-domain transport using window.name

* :ref:`dojox.io.xhrMultiPart <dojox/io/xhrMultiPart>`

  Constructs multi-part mime XHR requests. Useful when wanting multi-part requests but not using a form with a file input. Note that it does not allow you to send files from local disks -- a form with a file input is required for that use case. xhrMultipart is not useful in that use case.

* :ref:`dojox.io.xhrPlugins <dojox/io/xhrPlugins>`

  An adapter registry for having multiple XHR handlers (like XDomainRequest, CS-XHR, proxy, and window.name)

* :ref:`dojox.io.xhrWindowNamePlugin <dojox/io/xhrWindowNamePlugin>`

  window.name plugin for XHR adapter registry
