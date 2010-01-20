#format dojo_rst

dijit.MenuBar
=============

:Authors: Bill Keese

.. contents::
    :depth: 2

The MenuBar widget models a typical menu bar like the quintessential "File" menu on (virtually?) all programs.


============
Introduction
============

PopupMenuBarItem widgets are the actual items in the menu, and like PopupMenuItem it displays a submenu or other widget below it. A PopupMenuBarItem always has two child nodes: a tag with the displayed label (usually in a SPAN tag), and a widget to be popped up, typically a dijit.Menu widget.

There's also a MenuBarItem widget if you need an entry in your MenuBar that *doesn't* have a drop down.


========
Examples
========

Programmatic example
--------------------

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.MenuBar");
      dojo.require("dijit.MenuBarItem");
      dojo.require("dijit.PopupMenuBarItem");
      dojo.require("dijit.Menu");
      dojo.require("dijit.MenuItem");
      dojo.require("dijit.PopupMenuItem");

      var pMenuBar;
      dojo.addOnLoad(function(){
            pMenuBar = new dijit.MenuBar({});

            var pSubMenu = new dijit.Menu({});
            pSubMenu.addChild(new dijit.MenuItem({
                label:"File item #1"
            }));
            pSubMenu.addChild(new dijit.MenuItem({
                label:"File item #2"
            }));
            pMenuBar.addChild(new dijit.PopupMenuBarItem({
                label:"File",
                popup:pSubMenu
            }));

            var pSubMenu2 = new dijit.Menu({});
            pSubMenu2.addChild(new dijit.MenuItem({
                label:"Edit item #1"
            }));
            pSubMenu2.addChild(new dijit.MenuItem({
                label:"Edit item #2"
            }));
            pMenuBar.addChild(new dijit.PopupMenuBarItem({
                label:"Edit",
                popup:pSubMenu2
            }));

             pMenuBar.placeAt("wrapper");
             pMenuBar.startup();
        });
    </script>

  .. cv:: html

     <div id="wrapper"></div>


Declarative markup
------------------

Creation from markup is even easier.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.MenuBar");
      dojo.require("dijit.PopupMenuBarItem");
      dojo.require("dijit.Menu");
      dojo.require("dijit.MenuItem");
      dojo.require("dijit.PopupMenuItem");
    </script>

  .. cv:: html

	<div dojoType="dijit.MenuBar" id="navMenu">
		<div dojoType="dijit.PopupMenuBarItem">
			<span>File</span>
			<div dojoType="dijit.Menu" id="fileMenu">
				<div dojoType="dijit.MenuItem" onClick="alert('file 1')">File #1</div>
				<div dojoType="dijit.MenuItem" onClick="alert('file 2')">File #2</div>
			</div>
		</div>
		<div dojoType="dijit.PopupMenuBarItem">
			<span>Edit</span>
			<div dojoType="dijit.Menu" id="editMenu">
				<div dojoType="dijit.MenuItem" onClick="alert('edit 1')">Edit #1</div>
				<div dojoType="dijit.MenuItem" onClick="alert('edit 2')">Edit #2</div>
			</div>
		</div>
	</div>


=============
Accessibility
=============

Keyboard
--------

==========================================    =================================================
Action                                        Key
==========================================    =================================================
Navigate into/out of a MenuBar                Tab or shift-tab
Navigate menubar items                        Left and right arrow keys
Activate a menubar item                       Spacebar or enter
Open a submenu                                Down arrow
Close a submenu                               Esc, or use right arrow to navigate to next menu
==========================================    =================================================


========
See also
========

* See `dijit.Menu <dijit/Menu>`_.
