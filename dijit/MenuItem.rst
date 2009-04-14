#format dojo_rst

dijit.MenuItem
==============

.. contents::
    :depth: 2

:Status: Draft
:Version: 1.3
:Authors: Bill Keese

These are the line items in a Menu Widget. The display for the MenuItem consists of 3 columns namely Label, Icon and the Accelerator key.

A programatically created MenuItem
-----------------------------------

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.MenuBar");
    dojo.require("dijit.MenuItem");
    var pMenuBar;
    function fClickOne() {alert("You clicked on Menu Item #1")};
    function fClickTwo() {alert("You clicked on Menu Item #2")};
    dojo.addOnLoad(function(){
    ExampleMenu = new dijit.Menu({id:"SampleM"});
    ExampleMenu.addChild(new dijit.MenuItem({label:"Always Visible Menu", disabled:true}));
    ExampleMenu.addChild(new dijit.MenuItem({label:"Item #1", onClick:fClickOne,  accelKey:"Shift+O"}));
    ExampleMenu.addChild(new dijit.MenuItem({label:"Item #2", onClick:fClickTwo, disabled:true, accelKey:"Shift+T"}));
    ExampleMenu.placeAt("wrapper");
    ExampleMenu.startup();
    });
    </script>

  .. cv:: html

     <div id="wrapper"></div>

Creation from markup is even easier.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
	dojo.require("dijit.MenuBar");
	dojo.require("dijit.PopupMenuBarItem");
	dojo.require("dijit.Menu");
	dojo.require("dijit.MenuItem");
    </script>

  .. cv:: html

	<div id="menubar" dojoType="dijit.MenuBar">
	    <div dojoType="dijit.PopupMenuBarItem" id="Item Menu">
	    <span>Items</span>
	        <div dojoType="dijit.Menu" id="fileMenu">
	            <div dojoType="dijit.MenuItem" onClick="alert('Item 1')">Item #1</div>
	            <div dojoType="dijit.MenuItem" onClick="alert('Item 2')">Item #2</div>
	            <div dojoType="dijit.MenuItem" onClick="alert('Item 3')" disabled="true">Item #3</div>
                </div>
            </div>
        </div>


Accessibility
=============

Keyboard
--------

==========================================    =================================================
Action                                        Key
==========================================    =================================================
Navigate menu items                        		Top and Down arrow keys
Activate a menu item                       		Spacebar or enter
==========================================    =================================================


Implementation Notes
====================

See `dijit.Menu <dijit/Menu>`_.
