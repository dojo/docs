## page was renamed from 1.2/dojo/html
#format dojo_rst

dojo.html
=========

:Status: Contributed, Draft
:Version: 1.0

As of version 1.2, dojo.html is home to a single public helper method: dojo.html.set(). Its use is to safely and conveniently replace an element's content, while providing some hooks and options for how the replacement should be handled.

Examples: 
---------

.. codeviewer::

    <script type="text/javascript">
    dojo.require("dojo.html");
    dojo.addOnLoad(function() {
      // the first argument can be a string id, or a node reference
      console.log("loaded");
      dojo.html.set("mycontent", "loaded!");
    })
    </script>

    <div id="mycontent">
      Loading...
    </div>
