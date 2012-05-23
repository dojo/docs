.. _dojox/data/QueryReadStore/example:

=========================
dojox.data.QueryReadStore
=========================

.. contents ::
  :depth: 2

The following example illustrates a client implementation of a QueryReadStore extension. It uses the QueryReadStore.php found in dojox/data/tests/stores/ as server-side data provider, and is a simplified version of the dojox/data/tests/QueryReadStore.html.

In order for it to work, place the following HTML in a file (call it qrs.html) on a web server that has PHP 5.2 or greater.

The directory structure should look like this when you are done:

--qrs.html

--dojo/

--dijit/

--dojox/

----data/

------tests/

--------stores/

----------QueryReadStore.php


Here is the content of the html file, including the QueryReadStore extension code.

**Example HTML**

.. html ::
 
  <html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>QueryReadStore Demo</title>
        <style type="text/css">
            @import "dojo/resources/dojo.css";
            @import "dijit/themes/tundra/tundra.css";
        </style>
        <script type="text/javascript" src="dojo/dojo.js" data-dojo-config="isDebug: true, parseOnLoad: true"></script>
        <script type="text/javascript">
            dojo.require("dijit.form.ComboBox");
            dojo.require("dijit.form.FilteringSelect");
            dojo.require("dojox.data.QueryReadStore");

            dojo.provide("ComboBoxReadStore");
            dojo.declare(
                "ComboBoxReadStore",
                dojox.data.QueryReadStore,
                {
                    fetch:function(request){
                        request.serverQuery = {q:request.query.name};
                        return this.inherited("fetch", arguments);
                    }
                }
            );
        </script>
    </head>
    <body class="tundra">
        <div data-dojo-type="ComboBoxReadStore" data-dojo-id="store"
             data-dojo-props="url:'dojox/data/tests/stores/QueryReadStore.php',
             requestMethod:'get'">
        </div>
        State: <input id="fs" data-dojo-type="dijit.form.FilteringSelect" data-dojo-props="store:store, pageSize:5" />
    </body>
  </html>
