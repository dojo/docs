.. _dijit/MenuBar:

=============
dijit/MenuBar
=============

:Author: Bill Keese

.. contents ::
    :depth: 2

The MenuBar widget models a typical menu bar like the quintessential "File" menu on (virtually?) all programs.


Introduction
============

PopupMenuBarItem widgets are the actual items in the menu, and like PopupMenuItem it displays a submenu or other widget below it.
A PopupMenuBarItem always has two child nodes: a tag with the displayed label (usually in a SPAN tag), and a widget to be popped up, typically a dijit.Menu widget.

There's also a :ref:`dijit/MenuBarItem <dijit/MenuBarItem>` widget if you need an entry in your MenuBar that *doesn't* have a drop down.


Examples
========

Programmatic example
--------------------

.. code-example ::
  :djConfig: async: true

  .. js ::

    require(["dojo/ready", "dijit/MenuBar", "dijit/PopupMenuBarItem", "dijit/Menu", "dijit/MenuItem", "dijit/DropDownMenu"], function(ready, MenuBar, PopupMenuBarItem, Menu, MenuItem, DropDownMenu){
        ready(function(){
            var pMenuBar = new MenuBar({});

            var pSubMenu = new DropDownMenu({});
            pSubMenu.addChild(new MenuItem({
                label: "File item #1"
            }));
            pSubMenu.addChild(new MenuItem({
                label: "File item #2"
            }));
            pMenuBar.addChild(new PopupMenuBarItem({
                label: "File",
                popup: pSubMenu
            }));

            var pSubMenu2 = new DropDownMenu({});
            pSubMenu2.addChild(new MenuItem({
                label: "Edit item #1"
            }));
                pSubMenu2.addChild(new MenuItem({
                label: "Edit item #2"
            }));
            pMenuBar.addChild(new PopupMenuBarItem({
                label: "Edit",
                popup: pSubMenu2
            }));

            pMenuBar.placeAt("wrapper");
            pMenuBar.startup();
        });
    });

  .. html ::

     <div id="wrapper"></div>


Declarative markup
------------------

Creation from markup is even easier.

.. code-example ::
  :djConfig: async: true, parseOnLoad: true

  .. js ::

    require(["dojo/parser", "dijit/MenuBar", "dijit/PopupMenuBarItem", "dijit/DropDownMenu", "dijit/MenuItem"]);

  .. html ::

    <div data-dojo-type="dijit/MenuBar" id="navMenu">
        <div data-dojo-type="dijit/PopupMenuBarItem">
            <span>File</span>
            <div data-dojo-type="dijit/DropDownMenu" id="fileMenu">
                <div data-dojo-type="dijit/MenuItem" data-dojo-props="onClick:function(){alert('file 1');}">File #1</div>
                <div data-dojo-type="dijit/MenuItem" data-dojo-props="onClick:function(){alert('file 2');}">File #2</div>
            </div>
        </div>
        <div data-dojo-type="dijit/PopupMenuBarItem">
            <span>Edit</span>
            <div data-dojo-type="dijit/DropDownMenu" id="editMenu">
                <div data-dojo-type="dijit/MenuItem" data-dojo-props="onClick:function(){alert('edit 1');}">Edit #1</div>
                <div data-dojo-type="dijit/MenuItem" data-dojo-props="onClick:function(){alert('edit 2');}">Edit #2</div>
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
Navigate into/out of a MenuBar                Tab or shift-tab
Navigate menubar items                        Left and right arrow keys
Activate a menubar item                       Spacebar or enter
Open a submenu                                Down arrow
Close a submenu                               Esc, or use right arrow to navigate to next menu
==========================================    =================================================


See also
========

* See :ref:`dijit/DropDownMenu <dijit/DropDownMenu>`.
