#format dojo_rst

dijit.CheckedMenuItem
=====================

.. contents::
    :depth: 2

:Status: Draft
:Version: 1.2
:Authors:

The CheckedMenuItem is a checkbox-like menu item for toggling on/off. Every time the user clicks the widget, it changes state between checked and unchecked. By default, the state of the widget is unchecked. The default state of the widget can be changed to “checked” by specifying it explicitly. A user defined event function, onChange, is used to handle check/uncheck events. User can also optionally disable the widget.
This widget is helpful in cases where the user has to toggle particular column/row, on/off as and when it is required. It is used with Menu widget.

To optionally set the default state of the menu item to “checked”, 

.. code-block :: javascript

    var cItem = new dijit.CheckedMenuItem({label:"ToolBar", checked:"true"});

The menu item can be disabled as follows:

.. code-block :: javascript

   var cItem = new dijit.CheckedMenuItem({label:"Checked Menu Item", disable:"true"});




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
		var cItem = new dijit.CheckedMenuItem({label:"ToolBar", onChange: toolkit});
		pMenu.addChild(cItem);
		pMenu.addChild(new dijit.MenuItem({
                         label:"StatusBar", 
                         onClick:function(){alert("Nothing in the StatusBar!!!")}
                }));
		
		pMenuBar.addChild(new dijit.PopupMenuBarItem({label:"View", popup:pMenu}));
		pMenuBar.placeAt("menubar");
	        pMenuBar.startup();
		
		pToolBar = new dijit.MenuBar({}, "toolbar");
		pToolBar.addChild(new dijit.MenuBarItem({label:"Cut"}));
		pToolBar.addChild(new dijit.MenuBarItem({label:"Copy"}));
		pToolBar.addChild(new dijit.MenuBarItem({label:"Paste"}));
		pToolBar.startup();
	  
	  });
		function toolkit(checked){
			var tools = dojo.byId("toolbar");
			if(checked){
				tools.style.display = "block";
			}else {
				tools.style.display = "none";
			}
		};
		dojo.addOnLoad(toolBar);

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
				<div dojoType="dijit.CheckedMenuItem" onChange="toolBar(arguments[0])">ToolBar</div>
	                        <div dojoType="dijit.MenuItem" onClick="alert('Nothing in the StatusBar!!!')">StatusBar</div>
	                </div>
	        </div>
	</div>
	<div dojoType="dijit.MenuBar" id="tools">
		<div dojoType="dijit.MenuBarItem">Cut</div>
		<div dojoType="dijit.MenuBarItem">Copy</div>
		<div dojoType="dijit.MenuBarItem">Paste</div>
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
