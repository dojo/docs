#format dojo_rst

dijit.form.ComboButton
======================

:Status: Draft
:Version: 1.2

The dijit.form.ComboButton widget has a regular button on the left, and on the right has an arrow to show a drop down (often a menu).

Examples
--------

The first example shows how to create a menu and combo button programmatically.

.. cv-compound::

  .. cv:: javascript

	<script type="text/javascript">
          dojo.require("dijit.form.Button");
          dojo.require("dijit.Menu");
          dojo.addOnLoad(function(){
            var menu = new dijit.Menu({ style: "display: none;"});
            var menuItem1 = new dijit.MenuItem({
                label: "Yahoo",
                onClick: function(){ alert('hi'); }
            });
            menu.addChild(menuItem1);

            var menuItem2 = new dijit.MenuItem({
                label: "Google",
                onClick: function(){ alert('ho'); }
            });
            menu.addChild(menuItem2);

            var button = new dijit.form.ComboButton({
                label: "get all mail",
                dropDown: menu
            });
            console.log(button);
            dojo.byId("container").appendChild(button.domNode);
	 });
       </script>

  .. cv:: html

    <div id="container"></div>

As usual you can create the ComboButton widget declaratively using the dojoType attribute.
When created declaratively the DropDownButton node has two children, one for the label of the button,
and the other for the drop-down widget that's displayed when you press the button.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.form.Button");
      dojo.require("dijit.Menu");
    </script>

  .. cv:: html

    <div dojoType="dijit.form.ComboButton">
      <span>get all mail</span>
      <div dojoType="dijit.Menu">
        <div dojoType="dijit.MenuItem" onClick="console.log('hi!')">Yahoo</div>
        <div dojoType="dijit.MenuItem" onClick="console.log('ho!')">Google</div>
      </div>
    </div>

.
