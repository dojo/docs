#format dojo_rst

dijit.CheckedMenuItem
=====================

.. contents::
    :depth: 2

:Status: Draft
:Version: 1.2
:Authors: 

The CheckedMenuItem is a checkbox-like menu item for toggling on/off. Every time the user clicks the widget, it changes state between checked and unchecked. By default, the state of the widget is unchecked. User can optionally change the default state of the widget and also disable the widget as well. A user defined event function, onChange, is used to handle check/uncheck events.

To change the default state of the menu item to “checked”, 

.. code-block :: javascript

    var cItem = new dijit.CheckedMenuItem({label:"ToolBar", checked:"true"});

The menu item can be disabled as follows:

.. code-block :: javascript

   var cItem = new dijit.CheckedMenuItem({label:"Checked Menu Item", disable:"true"});

This widget is helpful in cases where the user has to toggle particular column/row, on/off as and when it is required. The examples below illustrate the usage of the widget.



Examples
========

Programmatic example
--------------------

.. cv-compound::

  .. cv:: javascript
  
	<script type="text/javascript">
  
	  dojo.require("dijit.MenuBar");
	  dojo.require("dijit.PopupMenuBarItem");
	  dojo.require("dijit.MenuBarItem");
	  dojo.require("dijit.Menu");
	  dojo.require("dijit.MenuItem");
	  dojo.require("dijit.CheckedMenuItem");
	  
	  var pMenuBar;
	  var pToolBar;
	  dojo.addOnLoad(function(){
		
		pMenuBar = new dijit.MenuBar({});
		var pMenu = new dijit.Menu({});
		var cItem = new dijit.CheckedMenuItem({label:"Checked Menuitem", onChange: toolkit});
		pMenu.addChild(cItem);
		pMenu.addChild(new dijit.MenuItem({
                         label:"Menu item", 
                         onClick:function(){alert("you clicked menu item")}
                }));
		
		pMenuBar.addChild(new dijit.PopupMenuBarItem({label:"View", popup:pMenu}));
		pMenuBar.placeAt("menubar");
	        pMenuBar.startup();
		
		pToolBar = new dijit.MenuBar({}, "toolbar");
		pToolBar.addChild(new dijit.MenuBarItem({label:"Item 1", onClick:function(){alert("Item 1 clicked")}}));
		pToolBar.addChild(new dijit.MenuBarItem({label:"Item 2", onClick:function(){alert("Item 2 clicked")}}));
		pToolBar.addChild(new dijit.MenuBarItem({label:"Item 3", onClick:function(){alert("Item 3 clicked")}}));
		pToolBar.startup();
	  
	  });
		function toolkit(/*Boolean*/ checked){
			var tools = dojo.byId("toolbar");
			if(checked){
				tools.style.display = "block";
			}else {
				tools.style.display = "none";
			}
		};
		dojo.addOnLoad(toolkit);

	</script>
	
  .. cv:: html
  
    <div id="menubar"></div>
    <div id="toolbar"></div>
	
Declarative example
-------------------

.. cv-compound::

  .. cv:: javascript
  
	<script type="text/javascript">
	  dojo.require("dijit.MenuBar");
	  dojo.require("dijit.PopupMenuBarItem");
	  dojo.require("dijit.MenuBarItem");
	  dojo.require("dijit.Menu");
	  dojo.require("dijit.MenuItem");
	  dojo.require("dijit.CheckedMenuItem");
	  
		function toolBar(checked){
			var tools = dojo.byId("tools");
			if(checked){
				tools.style.display = "block";
			}else {
				tools.style.display = "none";
			}
		};
		dojo.addOnLoad(toolBar);

	</script>
	
  .. cv:: html
  
	  <div dojoType="dijit.MenuBar">
	        <div dojoType="dijit.PopupMenuBarItem">
	                <span>View</span>
	                <div dojoType="dijit.Menu">
				<div dojoType="dijit.CheckedMenuItem" onChange="toolBar(arguments[0])">Checked Menuitem</div>
	                        <div dojoType="dijit.MenuItem" onClick="alert('you just clicked menu item')">Menu item</div>
	                </div>
	        </div>
	</div>
	<div dojoType="dijit.MenuBar" id="tools">
		<div dojoType="dijit.MenuBarItem" onClick="alert('Item 1 clicked')">Item 1</div>
		<div dojoType="dijit.MenuBarItem" onClick="alert('Item 2 clicked')">Item 2</div>
		<div dojoType="dijit.MenuBarItem" onClick="alert('Item 3 clicked')">Item 3</div>
	</div>
	
Accessibility
=============

Keyboard
--------

==========================================    =================================================
Action                                        Key
==========================================    =================================================
Navigate to menu item			      Up and down arrow keys
check/uncheck menu item			      Spacebar or enter
==========================================    =================================================


Implementation Notes
====================

See `dijit.Menu <dijit/Menu>`_.
