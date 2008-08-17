#format dojo_rst

dojo.fx.wipeIn examples
=======================

.. contents::
    :depth: 3

:Status: Draft
:Version: 1.2

Wiping in a node with "display: none; height: 200px; position: absolute;"
-------------------------------------------------------------------------

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dojox.fx");
    dojo.require("dijit.form.Button");

    function wipeInOne(){
      dojox.fx.wipeTo({
        node: "wipeDisplayNode", 
        duration: 300, 
        height: 200,
        beforeBegin: function(node){
          console.log(node);
        },
      }).play();
    }
    </script>

  .. cv:: html

    <div style="height: 250px;">
      <button dojoType="dijit.form.Button" onClick="wipeInOne">Wipe in</button>
      <div id="wipeDisplayNode" style="height: 200px; position: absolute; top: 30px; background: #ccc; padding: 10px; display: none;">Hi friends</div>
    </div>
