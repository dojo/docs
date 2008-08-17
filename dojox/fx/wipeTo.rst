#format dojo_rst

dojo.fx.wipeIn
==============

.. contents::
    :depth: 3

:Status: Draft
:Version: 1.2

Dojox.fx.wipeTo lets you wipe the size of a node to a defined size. 

Wiping in a node with "display: none; position: absolute;"
----------------------------------------------------------

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dojox.fx");
    dojo.require("dijit.form.Button");

    function wipeInOne(){
      dojox.fx.wipeTo({
        node: "wipeDisplayNode", 
        duration: 300, 
        height: 200
      }).play();
    }

    function wipeOutOne(){
      dojox.fx.wipeOut({
        node: "wipeDisplayNode", 
        duration: 300
      }).play();
    }
    </script>

  .. cv:: html

    <div style="height: 250px;">
      <button dojoType="dijit.form.Button" onClick="wipeInOne">Wipe in</button>
      <button dojoType="dijit.form.Button" onClick="wipeOutOne">Wipe in</button>
      <div id="wipeDisplayNode" style="height: 200px; position: absolute; top: 30px; width: 500px; background: #ccc; padding: 10px; display: none;">Hi friends</div>
    </div>
