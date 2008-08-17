#format dojo_rst

dojo.fx.wipeIn examples
=======================

:Status: Draft
:Version: 1.2

.. contents::
    :depth: 3

Wiping in a node with "display: none; position: absolute;"
----------------------------------------------------------

When you are trying to wipe in a node to a fixed height or width you have to use `dojox.fx.wipeTo <dojox/fx/wipeTo>`_.
 
Note that the padding of the content which gets wiped in is set on s separate inner node. This ensures that you don't get weird x-browser behaviour.

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

    function wipeOutOne(){
      dojo.fx.wipeOut({
        node: "wipeDisplayNode", 
        duration: 300
      }).play();
    }
    </script>

  .. cv:: html

    <div style="height: 110px;">
      <button dojoType="dijit.form.Button" onClick="wipeInOne">Wipe in</button>
      <button dojoType="dijit.form.Button" onClick="wipeOutOne">Wipe out</button>
      <div id="wipeDisplayNode" style="position: absolute; top: 50px; background: #ccc; display: none;">
        <div style=" padding: 10px;">Hi friends<br />We like dojofx. don't we?</div>
      </div>
    </div>
