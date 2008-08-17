#format #dojo_rst

dojo.fx.wipeIn examples
=======================

.. contents::
    :depth: 3

:Status: Draft
:Version: 1.2

Wiping in a node with "display: none; height: 200px; position: absolute;"
-------------------------------------------------------------------------

.. cv-compound::

  .. cv::javascript::

    <script type="text/javascript">
    dojo.require("dojo.fx");

    function wipeInOne(){
      dojo.fx.wipeIn({node: "wipeDisplayNode"})
    }
    </script>

  .. cv::html::

    <button dojoType="dijit.form.Button" onClick="wipeInOne">Wipe in</button>
    <div id="wipeDisplayNode" style="height: 200px; position: absolute; background: #ccc; padding: 10px; display: none;">Hi friends</div>
