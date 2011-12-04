.. _dijit/MenuBarItem:

=================
dijit.MenuBarItem
=================

.. contents::
    :depth: 2

:Status: Draft
:Version: 1.3
:Authors: Bill Keese

These are the items in the Menubar that may be clickable but does not spawn a submenu when pressed or hovered over.

Examples
========

A programmatically created MenuBarItem
--------------------------------------

.. code-example ::

  .. js ::

    dojo.require("dijit.MenuBar");
    dojo.require("dijit.MenuBarItem");
    var pMenuBar;
    function fClickItem(){alert("Clicked on first item")};
    function fClickAnotherItem(){alert("Clicked on the second Item!")};
    dojo.ready(function(){
        pMenuBar = new dijit.MenuBar({id:"SampleMenu"});
        pMenuBar.addChild(new dijit.MenuBarItem({label:"MenuBarItem#1 ", disabled:true, onClick:fClickItem}));
        pMenuBar.addChild(new dijit.MenuBarItem({label:"MenubarItem#2 ", onClick:fClickAnotherItem}));
        pMenuBar.placeAt("wrapper");
        pMenuBar.startup();
    });


  .. html ::

     <div id="wrapper"></div>

Creation from markup is simpler and more structured.

.. code-example ::

  .. js ::

    dojo.require("dijit.MenuBar");
    dojo.require("dijit.Menu");
    dojo.require("dijit.MenuBarItem");

  .. html ::

    <div id="menubar" data-dojo-type="dijit.MenuBar">
        <div data-dojo-type="dijit.MenuBarItem" data-dojo-props="onClick:function(){alert('Clicked on BarMenuItem');}">
            Click me!
        </div>
        <div data-dojo-type="dijit.MenuBarItem" data-dojo-props="disabled:true">
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
