#format dojo_rst

dojo.fx.wipeIn examples
=======================

.. contents::
    :depth: 3

:Status: Draft
:Version: 1.2

Wiping in a node with "display: none; position: absolute;"
----------------------------------------------------------

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dojo.fx");
    dojo.require("dijit.form.Button");

    function wipeInOne(){
      dojo.fx.wipeIn({
        node: "wipeDisplayNode", 
        duration: 300
      }).play();
    }
    </script>

  .. cv:: html

    <div style="height: 110px;">
      <button dojoType="dijit.form.Button" onClick="wipeInOne">Wipe in</button>
      <div id="wipeDisplayNode" style="position: absolute; top: 50px; background: #ccc; display: none;">
        <div style=" padding: 10px;">Hi friends<br />We like dojofx. don't we?</div>
      </div>
    </div>
