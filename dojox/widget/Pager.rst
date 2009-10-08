#format dojo_rst

dojox.widget.Pager
==================

:Status: Draft
:Version: beta
:Authors: Nikolai Onken


========
Examples
========

Horizontal Pager
----------------

.. cv-compound::

  .. cv:: css

    <style type="text/css">
        @import "http://docs.dojocampus.org/moin_static163/js/dojo/trunk/dojox/widget/Pager/Pager.css";
    </style>


  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dojo.data.ItemFileReadStore");
        dojo.require("dojox.widget.Pager");
    </script>

  .. cv:: html

    <!-- the datastore -->
    <div dojoType="dojo.data.ItemFileReadStore" jsId="pagerStore" id="pagerStore" 
        url="http://docs.dojocampus.org/moin_static163/js/dojo/trunk/dojox/widget/tests/_pager-data.json"></div>

    <h2>Horizontal Pager</h2>

    <div style="padding:8px">
        <div dojoType="dojox.widget.Pager" id="dojoxMenu1" 
            store="pagerStore" style="width: 410px; height: 150px"></div>
    </div>
