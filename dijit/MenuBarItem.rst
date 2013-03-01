.. _dijit/MenuBarItem:

=================
dijit.MenuBarItem
=================

.. contents ::
    :depth: 2

:Authors: Bill Keese

This is an item in a Menubar that may be clickable but does not spawn a submenu when pressed or hovered over.

Examples
========

A programmatically created MenuBarItem
--------------------------------------

.. code-example ::

  .. js ::

    require([
        "dijit/MenuBar",
        "dijit/MenuBarItem",
        "dojo/domReady!"
    ], function(MenuBar, MenuBarItem){
        var pMenuBar = new MenuBar({});

        pMenuBar.addChild(new MenuBarItem({
            label: "Click me"
        }));

        pMenuBar.placeAt("wrapper");
        pMenuBar.startup();
    });



  .. html ::

     <div id="wrapper"></div>

Creation from markup is simpler and more structured.

.. code-example ::

  .. html ::

    <div id="menubar" data-dojo-type="dijit/MenuBar">
        <div data-dojo-type="dijit/MenuBarItem" data-dojo-props="onClick:function(){alert('Clicked on BarMenuItem');}">
            Click me!
        </div>
        <div data-dojo-type="dijit/MenuBarItem" data-dojo-props="disabled:true">
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
Navigate menu bar items                       Left and right arrow keys
Activate a menu item                          Spacebar or enter
==========================================    =================================================


Implementation Notes
====================

See :ref:`dijit.MenuBar <dijit/MenuBar>`.
