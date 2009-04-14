#format dojo_rst

dijit.MenuBarItem
=================

.. contents::
    :depth: 2

:Status: Draft
:Version: 1.3
:Authors: Bill Keese

These are the items in the Menubar that may be clickable but does not spawn a submenu when pressed or hovered over.

A programatically created MenuBarItem
-------------------------------------

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.MenuBar");
    dojo.require("dijit.MenuBarItem");
    var pMenuBar;
    function fClickItem() {alert("Clicked on first item")};
    function fClickAnotherItem() {alert("Clicked on the second Item!")};
    dojo.addOnLoad(function(){
    pMenuBar = new dijit.MenuBar({id:"SampleMenu"});
    pMenuBar.addChild(new dijit.MenuBarItem({label:"MenuBarItem#1", disabled:true, onClick:fClickItem}));
    pMenuBar.addChild(new dijit.MenuBarItem({label:"MenubarItem#2", onClick:fClickAnotherItem}));
    pMenuBar.placeAt("wrapper");
    pMenuBar.startup();
    });
    </script>

  .. cv:: html

     <div id="wrapper"></div>

Creation from markup is more simpler and structured.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.MenuBar");
    dojo.require("dijit.Menu");
    dojo.require("dijit.MenuBarItem");
    </script>

  .. cv:: html

	<div id="menubar" dojoType="dijit.MenuBar">
		<div dojoType="dijit.MenuBarItem" onclick="alert('Clicked on BarMenuItem');">
			Click me!
		</div>
		<div dojoType="dijit.MenuBarItem" disabled = "true" onclick="alert('Disabled');">
			Disabled item
		</div>
	</div>


Accessibility
=============

Keyboard
--------

==========================================    =================================================
Action                                        Key
==========================================    =================================================
Navigate menu bar items                        		Left and right arrow keys
Activate a menu item                       		Spacebar or enter
==========================================    =================================================


Implementation Notes
====================

See `dijit.Menu <dijit/Menu>`_.
