#format dojo_rst

dojo.dnd.Moveable
=================

:Status: Draft
:Version: 1.2

.. contents::
  :depth: 3

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.form.Button"); // this we only require to make the demo look fancy
    dojo.require("dojo.dnd.Moveable");

    function makeMoveable(node){
      dojo.dnd.Moveable(dojo.byId(node));
    }
    </script>

  .. cv:: html

    <div id="dndOne">Hi, I am moveable when you want to.</div>
    <p><button dojoType="dijit.form.Button" onClick="makeMoveable('dndOne')">Make moveable</button>

  .. cv:: css

    <style type="text/css">
    #dndOne {
      width: 200px;
      height: 200px;
      padding: 10px;
      border: 1px solid #000;
      background: red;
    } 
    </style>
