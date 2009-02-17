#format dojo_rst

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

* `dojox.io.httpParse <dojox/io/httpParse>`_

  HTTP message parser. Parses to an XHR like interface.

* `dojox.io.OAuth <dojox/io/OAuth>`_

  Helper class to assemble OAuth URL parameters.

* `dojox.io.scriptFrame <dojox/io/scriptFrame>`_

  Uses an iframe for dojo.io.script requests. Useful in some long-polling comet situations in Firefox and Opera. Those browsers execute scripts in DOM order, not network-receive order, so a long-polling script will block other dynamically appended scripts from running until it completes. By using an iframe for the dojo.io.script requests, this issue can be avoided.

* `dojox.io.windowName <dojox/io/windowName>`_

  Cross-domain transport using window.name

* `dojox.io.xhrMultiPart <dojox/io/xhrMultiPart>`_

  Constructs multi-part mime XHR requests. Useful when wanting multi-part requests but not using a form with a file input. Note that it does not allow you to send files from local disks -- a form with a file input is required for that use case. xhrMultipart is not useful in that use case.

* `dojox.io.xhrPlugins <dojox/io/xhrPlugins>`_

  An adapter registry for having multiple XHR handlers (like XDomainRequest, CS-XHR, proxy, and window.name)

* `dojox.io.xhrWindowNamePlugin <dojox/io/xhrWindowNamePlugin>`_

  window.name plugin for XHR adapter registry
