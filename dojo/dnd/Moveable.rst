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
      var dnd = new dojo.dnd.Moveable(dojo.byId(node));
    }
    </script>

  .. cv:: html

    <div id="dndArea">
      <div id="dndOne">Hi, I am moveable when you want to.</div>
    </div>
    <p><button dojoType="dijit.form.Button" onClick="makeMoveable('dndOne')">Make moveable</button>

  .. cv:: css

    <style type="text/css">
    #dndOne {
      width: 100px;
      height: 100px;
      padding: 10px;
      border: 1px solid #000;
      background: red;
    } 

    #dndArea {
      height: 200px;
      padding: 10px;
      border: 1px solid #000;
    }
    </style>
