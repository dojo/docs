.. _dijit/CheckedMenuItem:

=====================
dijit.CheckedMenuItem
=====================

.. contents::
    :depth: 2

:Status: Draft
:Version: 1.2
:Authors:

The CheckedMenuItem is a checkbox-like menu item for toggling on/off. Every time the user clicks the widget, it changes state between checked and unchecked. By default, the state of the widget is unchecked. User can optionally change the default state of the widget and also disable the widget as well. A user defined event function, onChange, is used to handle check/uncheck events.

To change the default state of the menu item to “checked”,

.. js ::

    var cItem = new dijit.CheckedMenuItem({label:"ToolBar", checked:"true"});

The menu item can be disabled as follows:

.. js ::

   var cItem = new dijit.CheckedMenuItem({label:"Checked Menu Item", disable:"true"});

This widget is helpful in cases where the user has to toggle particular column/row, on/off as and when it is required. The examples below illustrate the usage of the widget.


Examples
========

Programmatic example
--------------------

.. code-example ::

  .. js ::
  
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
		var cItem = new dijit.CheckedMenuItem({label:"Navigation bar", onChange: toolkit});
		pMenu.addChild(cItem);
		pMenu.addChild(new dijit.MenuItem({
                         label:"Status bar",
                         onClick:function(){alert("you clicked status bar")}
                }));
		
		pMenuBar.addChild(new dijit.PopupMenuBarItem({label:"View", popup:pMenu}));
		pMenuBar.placeAt("menubar");
	        pMenuBar.startup();
		
		pToolBar = new dijit.MenuBar({}, "toolbar");
		pToolBar.addChild(new dijit.MenuBarItem({label:"Back", onClick:function(){alert("I go nowhere!! just a clickable item")}}));
		pToolBar.addChild(new dijit.MenuBarItem({label:"Forward", onClick:function(){alert("No way to go..")}}));
		pToolBar.addChild(new dijit.MenuBarItem({label:"Refresh", onClick:function(){alert("Refresh button clicked!!")}}));
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
	
  .. html ::
  
    <div id="menubar"></div>
    <div id="toolbar"></div>
	
Declarative example
-------------------

.. code-example ::

  .. js ::
  
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
	
  .. html ::
  
	  <div data-dojo-type="dijit.MenuBar">
	        <div data-dojo-type="dijit.PopupMenuBarItem">
	                <span>View</span>
	                <div data-dojo-type="dijit.Menu">
				<div data-dojo-type="dijit.CheckedMenuItem" data-dojo-props="onChange:function(){toolBar(arguments[0])}">Navigation bar</div>
	                        <div data-dojo-type="dijit.MenuItem" data-dojo-props="onClick:function(){alert('Status bar clicked')}">Status bar</div>
	                </div>
	        </div>
	</div>
	<div data-dojo-type="dijit.MenuBar" id="tools">
		<div data-dojo-type="dijit.MenuBarItem" data-dojo-props="onClick:function(){alert('Back button clicked.')}">Back</div>
		<div data-dojo-type="dijit.MenuBarItem" data-dojo-props="onClick:function(){alert('Forward button clicked')}">Forward</div>
		<div data-dojo-type="dijit.MenuBarItem" data-dojo-props="onClick:function(){alert('Refresh button clicked!')}">Refresh</div>
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

See :ref:`dijit.Menu <dijit/Menu>`.
