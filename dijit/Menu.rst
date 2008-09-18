#format dojo_rst

dijit.Menu
==========

.. contents::
    :depth: 2

:Status: Draft
:Version: 1.2
:Authors: Bill Keese

The Menu widget models a context menu, otherwise known as a right-click or popup menu, and they also appear in ComboButton and DropDownButton widgets.

MenuItem widgets are the actual items in the menu. The PopupMenuItem is like a MenuItem, but displays a submenu or other widget to the right . A PopupMenuItem always has two child nodes: a tag with the displayed label (usually in a SPAN tag), and a widget to be popped up, typically a dijit.Menu widget.

A programatically created menu
------------------------------

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.Menu");

      var pMenu;
      dojo.addOnLoad(function(){
            console.log("in addOnLoad");

            pMenu = new dijit.Menu({targetNodeIds:["prog_menu"], id:"progMenu"});
            console.log("pMenu is", pMenu);
            pMenu.addChild(new dijit.MenuSeparator());
            pMenu.addChild(new dijit.MenuItem({label:"Simple menu item", }));
            pMenu.addChild(new dijit.MenuItem({label:"Disabled menu item", disabled:true}));
            pMenu.addChild(new dijit.MenuItem({
                label:"Menu Item With an icon",
                iconClass:"dijitEditorIcon dijitEditorIconCut",
                onClick: function(){alert('i was clicked')}
            }));
            pMenu.addChild(new dijit.CheckedMenuItem({label:"checkable menu item"}););

            var pSubMenu = new dijit.Menu({parentMenu:pMenu, id:"progSubMenu"});
            pSubMenu.addChild(new dijit.MenuItem({label:"Submenu item"}));
            pSubMenu.addChild(new dijit.MenuItem({label:"Submenu item"}));
            pMenu.addChild(new dijit.PopupMenuItem({label:"Submenu", popup:pSubMenu, id:"progPopupMenuItem"}));

            pMenu.startup();
        });
    </script>

  .. cv:: html

    <span id="prog_menu">Right click me to get a menu</span>
