#format dojo_rst

dojox.cometd
============

:Status: Draft
:Version: beta
:Authors: Bryan Forbes, Kris Zyp, James Burke

scriptFrame.js - Uses an iframe for dojo.io.script requests. Useful in some
long-polling comet situations in Firefox and Opera. Those browsers execute scripts
in DOM order, not network-receive order, so a long-polling script will block other
dynamically appended scripts from running until it completes. By using an iframe
for the dojo.io.script requests, this issue can be avoided.
xhrMultiPart.js - Constructs multi-part mime XHR requests. Useful when wanting
multi-part requests but not using a form with a file input. Note that it does not
allow you to send files from local disks -- a form with a file input is required
for that use case. xhrMultipart is not useful in that use case.
xhrPlugins.js - An adapter registry for having multiple XHR handlers (like
	XDomainRequest, CS-XHR, proxy, and window.name)
windowName.js - Cross-domain transport using window.name
xhrWindowNamePlugin.js - window.name plugin for XHR adapter registry
httpParse.js - HTTP message parser. Parses to an XHR like interface.
