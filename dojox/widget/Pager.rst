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

  .. cv:: javascript

    <script type="text/javascript">
        dojo.require("dojo.data.ItemFileReadStore");
        dojo.require("dojox.widget.Pager");
    </script>

    <script type="text/javascript">     
        dojo.addOnLoad(function(){
            var pagerStore = new dojo.data.ItemFileReadStore({
                url: "http://docs.dojocampus.org/moin_static163/js/dojo/trunk/dojox/widget/tests/_pager-data.json"
            });
        });
    </script>

  .. cv:: html

    <h2>Horizontal Pager</h2>

    <div style="padding:8px">
        <div dojoType="dojox.widget.Pager" id="dojoxMenu1" 
            store="pagerStore" style="width: 410px; height: 150px"></div>
    </div>
    <div style="padding:8px">
        <div dojoType="dojox.widget.Pager" id="dojoxMenu2" itemsPage="4" 
            store="pagerStore" statusPos="trailing" style="width: 410px; height: 150px"></div>
    </div>
    <div style="padding:8px">
        <div dojoType="dojox.widget.Pager" id="dojoxMenu1s" store="pagerStore" pagerPos="none" 
            style="width: 410px; height: 150px"></div>
    </div>
    <div style="padding:8px">
        <div dojoType="dojox.widget.Pager" id="dojoxMenu2s" itemsPage="4" pagerPos="none" 
            store="pagerStore" statusPos="trailing" style="width: 410px; height: 150px"></div>
    </div>
