#format dojo_rst

dojox.data.QueryReadStore
=========================

.. contents::
  :depth: 2



**Example HTML Usage** 

::

  <html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>QueryReadStore Demo</title>
        <style type="text/css">
            @import "dojo/resources/dojo.css";
            @import "dijit/themes/tundra/tundra.css";
        </style>
        <script type="text/javascript" src="dojo/dojo.js" djConfig="isDebug: true, parseOnLoad: true"></script>
        <script type="text/javascript">
            dojo.require("dijit.form.ComboBox");
            dojo.require("dijit.form.FilteringSelect");
            dojo.require("dojox.data.QueryReadStore");

            dojo.provide("ComboBoxReadStore");
            dojo.declare(
                "ComboBoxReadStore",
                dojox.data.QueryReadStore,
                {
                    fetch:function(request) {
                        request.serverQuery = {q:request.query.name};
                        return this.inherited("fetch", arguments);
                    }
                }
            );
        </script>
    </head>
    <body class="tundra">
        <div dojoType="ComboBoxReadStore" jsId="store"
             url="dojox/data/stores/QueryReadStore.php"
             requestMethod="get">
        </div>
        State: <input id="fs" dojoType="dijit.form.FilteringSelect" store="store" pageSize="5" />
    </body>
  </html>
