#format dojo_rst

dojox.io
========

:Status: Draft
:Version: 1.0
:Authors: Nikolai Onken
:Developers: Bryan Forbes, Kris Zyp, James Burke
:Available: since V?

.. contents::
    :depth: 2

========
Features
========

* dojox.io.httpParse

  HTTP message parser. Parses to an XHR like interface.


* dojox.io.scriptFrame

  Uses an iframe for dojo.io.script requests. Useful in some long-polling comet situations in Firefox and Opera. Those browsers execute scripts in DOM order, not network-receive order, so a long-polling script will block other dynamically appended scripts from running until it completes. By using an iframe for the dojo.io.script requests, this issue can be avoided.

* dojox.io.windowName

  Cross-domain transport using window.name

* dojox.io.xhrMultiPart

  Constructs multi-part mime XHR requests. Useful when wanting multi-part requests but not using a form with a file input. Note that it does not allow you to send files from local disks -- a form with a file input is required for that use case. xhrMultipart is not useful in that use case.

* dojox.io.xhrPlugins

  An adapter registry for having multiple XHR handlers (like XDomainRequest, CS-XHR, proxy, and window.name)

* dojox.io.xhrWindowNamePlugin

  window.name plugin for XHR adapter registry

* dojox.io.OAuth 

  Helper class to assemble OAuth URL parameters.
