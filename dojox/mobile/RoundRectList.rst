.. _dojox/mobile/RoundRectList:

==========================
dojox/mobile/RoundRectList
==========================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.5

.. contents ::
    :depth: 2

Introduction
============

RoundRectList is a rounded rectangle list, which can be used to display a group of items. Each item must be :ref:`dojox/mobile/ListItem <dojox/mobile/ListItem>`.

.. image :: RoundRectList.png

Constructor Parameters
======================

+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default  |Description                                                                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|transition    |String    |"slide"  |The default animated transition effect for child items. If a child item does not have its own transition   |
|              |          |         |parameter specified, this value is used as its animated transition type. You can choose from the standard  |
|              |          |         |transition types, "slide", "fade", "flip", or from the extended transition types, "cover", "coverv",       |
|              |          |         |"dissolve", "reveal", "revealv", "scaleIn", "scaleOut", "slidev", "swirl", "zoomIn", "zoomOut", "cube",    |
|              |          |         |and "swap". If "none" is specified, transition occurs immediately without animation.                       |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|iconBase      |String    |""       |The default icon path for child items. If a child item does not have its own icon parameter specified,     |
|              |          |         |this value is used as its icon path. This parameter is especially useful when all or most of the icons are |
|              |          |         |the same, or you use CSS sprite icons, where you specify an aggregated icon image with this parameter and  |
|              |          |         |an icon position for each icon.                                                                            |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|iconPos       |String    |""       |The default icon position for child items. This parameter is especially useful when all or most of the     |
|              |          |         |icons are the same.                                                                                        |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|select        |String    |""       |Selection mode of the list. The check mark is shown for the selected list item(s). The value can be        |
|              |          |         |"single", "multiple", or "". If "single", there can be only one selected item at a time. If "multiple",    |
|              |          |         |there can be multiple selected items at a time. If "", the checkmark is not shown.                         |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|stateful      |Boolean   |false    |If true, the last selected item remains highlighted.                                                       |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|syncWithViews |Boolean   |false    |If true, this widget listens to view transition events to be synchronized with view's visibility.          |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|editable      |Boolean   |false    |If true, the list can be re-ordered.                                                                       |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|tag           |String    |"ul"     |A name of html tag to create as domNode.                                                                   |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+

Examples
========

Declarative example
-------------------

In this example, <ul> and <li> are used just because they are typically used to create a list in html. You can use <div> instead.

.. js ::

  require([
    "dojox/mobile",
    "dojox/mobile/parser"
  ]);

.. html ::

  <ul data-dojo-type="dojox/mobile/RoundRectList">
    <li data-dojo-type="dojox/mobile/ListItem"
        data-dojo-props='icon:"images/i-icon-3.png",
                         rightText:"Off",
                         moveTo:"view1"'>Wi-Fi</li>
    <li data-dojo-type="dojox/mobile/ListItem"
        data-dojo-props='icon:"images/i-icon-4.png",
                         rightText:"VPN",
                         moveTo:"view2"'>VPN</li>
  </ul>

.. image :: RoundRectList-example1.png

CSS sprite example
------------------

In this example, an aggregated icon image as below is used for each list item icon. This way the number of requests to the server can be reduced and thus the performance could be improved.

.. image :: all-icons.png

(all-icons.png)

.. html ::

  <ul data-dojo-type="dojox/mobile/RoundRectList"
      data-dojo-props='iconBase:"images/i-icon-all.png"'>
    <li data-dojo-type="dojox/mobile/ListItem"
        data-dojo-props='iconPos:"0,0,29,29"'>Airplane Mode
        <div class="mblItemSwitch" data-dojo-type="dojox/mobile/Switch"></div></li>
    <li data-dojo-type="dojox/mobile/ListItem"
        data-dojo-props='iconPos:"0,29,29,29",
                         rightText:"mac",
                         href:"test_IconContainer.html"'>Wi-Fi</li>
    <li data-dojo-type="dojox/mobile/ListItem"
        data-dojo-props='iconPos:"0,58,29,29",
                         rightText:"AcmePhone",
                         moveTo:"general"'>Carrier</li>
  </ul>

.. image :: RoundRectList-example2.png

Selection mode example
----------------------

.. html ::

  <h2 data-dojo-type="dojox/mobile/RoundRectCategory">Single Select</h2>
  <ul data-dojo-type="dojox/mobile/RoundRectList" data-dojo-props='select:"single"'>
    <li data-dojo-type="dojox/mobile/ListItem" data-dojo-props='checked:true'>Cube</li>
    <li data-dojo-type="dojox/mobile/ListItem">Dissolve</li>
    <li data-dojo-type="dojox/mobile/ListItem">Ripple</li>
  </ul>

  <h2 data-dojo-type="dojox/mobile/RoundRectCategory">Multiple Select</h2>
  <ul data-dojo-type="dojox/mobile/RoundRectList" data-dojo-props='select:"multiple"'>
    <li data-dojo-type="dojox/mobile/ListItem" data-dojo-props='checked:true'>Cube</li>
    <li data-dojo-type="dojox/mobile/ListItem">Dissolve</li>
    <li data-dojo-type="dojox/mobile/ListItem" data-dojo-props='checked:true'>Ripple</li>
  </ul>

.. image :: RoundRectList-check.png

.. _dojox/mobile/RoundRectList#editable-list-example:

Editable list example
---------------------

This is an example of 'editable' parameter for re-ordering the list and deleting an list item. (See test_RoundRectList-editable.html in the dojox/mobile/tests folder for complete example.)

.. js ::

  require([
    "dojo/_base/connect",
    "dojo/dom-class",
    "dojo/ready",
    "dijit/registry"
  ], function(connect, domClass, ready, registry){
    var delItem, handler, btn1, list1;

    function showDeleteButton(item){
      hideDeleteButton();
      delItem = item;
      item.rightIconNode.style.display = "none";
      if(!item.rightIcon2Node){
        item.set("rightIcon2", "mblDomButtonMyRedButton_0");
        item.rightIcon2Node.firstChild.innerHTML = "Delete";
      }
      item.rightIcon2Node.style.display = "";
      handler = connect.connect(list1.domNode, "onclick", onDeleteItem);
    }
    function hideDeleteButton(){
      if(delItem){
        delItem.rightIconNode.style.display = "";
        delItem.rightIcon2Node.style.display = "none";
        delItem = null;
      }
      connect.disconnect(handler);
    }
    function onDeleteItem(e){
      var item = registry.getEnclosingWidget(e.target);
      if(domClass.contains(e.target, "mblDomButtonMyRedButton_0")){
        setTimeout(function(){
          item.destroy();
        }, 0);
      }
      hideDeleteButton();
    }

    connect.subscribe("/dojox/mobile/deleteListItem", function(item){
      showDeleteButton(item);
    });

    onClickEdit = function(){
      list1.startEdit();
    }
    onClickDone = function(){
      hideDeleteButton();
      list1.endEdit();
    }

    ready(function(){
      btn1 = registry.byId("btn1");
      list1 = registry.byId("list1");
    });
  });

.. css ::

  /* inline custom DOM Button */
  .mblDomButtonMyRedButton_0 {
    position: relative;
    height: 29px;
    line-height: 29px;
    padding: 0px 8px;
    color: white;
    font-family: Helvetica;
    font-size: 13px;
    font-weight: bold;
    border: 1px outset #9cacc0;
    border-radius: 5px;
    background: -webkit-gradient(linear, left top, left bottom, from(#d3656d), to(#bc1320),
                                   color-stop(0.5, #c9404b), color-stop(0.5, #bc1421));
    background-color: #c9404b;
    text-align: center;
  }

.. html ::

  <ul id="list1" data-dojo-type="dojox/mobile/RoundRectList" data-dojo-props='editable:true'>
    <li id="item1" data-dojo-type="dojox/mobile/ListItem"
     data-dojo-props='icon:"images/i-icon-1.png"'>Slide</li>
    <li id="item2" data-dojo-type="dojox/mobile/ListItem"
     data-dojo-props='icon:"images/i-icon-2.png"'>Flip</li>
    <li id="item3" data-dojo-type="dojox/mobile/ListItem"
     data-dojo-props='icon:"images/i-icon-3.png"'>Fade</li>
    <li id="item4" data-dojo-type="dojox/mobile/ListItem"
     data-dojo-props='icon:"images/i-icon-4.png"'>Cover</li>
    <li id="item5" data-dojo-type="dojox/mobile/ListItem"
     data-dojo-props='icon:"images/i-icon-5.png"'>Reveal</li>
  </ul>
  <button onclick="onClickEdit()">Edit</button>
  <button onclick="onClickDone()">Done</button>

.. image :: RoundRectList-editable.gif


**Note:** you have to implement a delete action if you want the delete button to have an action. To do so, 
you can either subscribe to the "/dojox/mobile/deleteListItem" topic like in the example above or connect to the
onDeleteItem callback as described below.


You can also handle events when edit mode starts/ends or when children ListItems are moved/deleted.
The example below handles those events by connecting to the callback functions of the RoundRectList widget. (See test_RoundRectList-connect.html in the dojox/mobile/tests folder for a complete example.)

.. js ::

    require([
        "dojo/_base/connect",
        "dojo/dom-class",
        "dojo/ready",
        "dijit/registry",
    ], function(connect, domClass, ready, registry){
        var delItem, handler, btn1, list1;

        function showDeleteButton(item){
            hideDeleteButton();
            delItem = item;
            item.rightIconNode.style.display = "none";
            if(!item.rightIcon2Node){
                item.set("rightIcon2", "mblDomButtonMyRedButton_0");
                item.rightIcon2Node.firstChild.innerHTML = "Delete";
            }
            item.rightIcon2Node.style.display = "";
            handler = connect.connect(list1.domNode, "onclick", onDeleteItem);
        }
        function hideDeleteButton(){
            if(delItem){
                delItem.rightIconNode.style.display = "";
                delItem.rightIcon2Node.style.display = "none";
                delItem = null;
            }
            connect.disconnect(handler);
        }
        function onDeleteItem(e){
            var item = registry.getEnclosingWidget(e.target);
            if(domClass.contains(e.target, "mblDomButtonMyRedButton_0")){
                setTimeout(function(){
                    item.destroy();
                }, 0);
            }
            hideDeleteButton();
        }

        connect.subscribe("/dojox/mobile/deleteListItem", function(item){
            showDeleteButton(item);
        });

        onClickEdit = function(){
            list1.startEdit();
        }
        onClickDone = function(){
            hideDeleteButton();
            list1.endEdit();
        }

        ready(function(){
            btn1 = registry.byId("btn1");
            list1 = registry.byId("list1");
            connect.connect(list1, "onStartEdit", null, function(){
                console.log("StartEdit");
            });
            connect.connect(list1, "onEndEdit", null, function(){
                console.log("EndEdit");
            });
            connect.connect(list1, "onDeleteItem", null, function(widget){
                console.log("DeleteIconItem: " + widget.label);
            });
            connect.connect(ic, "onMoveItem", null, function(widget, from, to){
                console.log("MoveIconItem: " + widget.label + " (" + from + " -> " + to + ")");
            });
        });
    });		
		

Synchronized list example
-------------------------

This is an example of 'syncWithViews' parameter to synchronize the selected item with active view.

.. js ::

  require([
    "dojox/mobile",
    "dojox/mobile/parser",
    "dojox/mobile/FixedSplitter"
  ]);

.. html ::

  <div data-dojo-type="dojox/mobile/FixedSplitter" data-dojo-props='orientation:"H"'>

    <div data-dojo-type="dojox/mobile/Container" style="width:300px;border-right:1px solid black;">
      <div id="settings" data-dojo-type="dojox/mobile/View">
        <h1 data-dojo-type="dojox/mobile/Heading">Settings</h1>
        <!-- RoundRectList to be synchronized with the right side view's visibility --> 
        <ul data-dojo-type="dojox/mobile/RoundRectList"
            data-dojo-props='transition:"flip", stateful:true, syncWithViews:true'>
          <li data-dojo-type="dojox/mobile/ListItem"
              data-dojo-props='icon:"images/i-icon-1.png", moveTo:"wifi"'>Wi-Fi</li>
          <li data-dojo-type="dojox/mobile/ListItem"
              data-dojo-props='icon:"images/i-icon-2.png", moveTo:"bright"'>Brightness &amp; Wallpaper</li>
          <li data-dojo-type="dojox/mobile/ListItem"
              data-dojo-props='icon:"images/i-icon-3.png", moveTo:"picture"'>Picture Frame</li>
        </ul>
      </div>
    </div>

    <div data-dojo-type="dojox/mobile/Container">
      <div id="wifi" data-dojo-type="dojox/mobile/View">
        <h1 data-dojo-type="dojox/mobile/Heading">Wi-Fi Networks</h1>
        <ul data-dojo-type="dojox/mobile/RoundRectList">
          <li data-dojo-type="dojox/mobile/ListItem"
              data-dojo-props='moveTo:"bright"'>Next View</li>
          <li data-dojo-type="dojox/mobile/ListItem"
              data-dojo-props='moveTo:"picture", transitionDir:-1'>Previous View</li>
        </ul>
      </div>
      <div id="bright" data-dojo-type="dojox/mobile/View">
        <h1 data-dojo-type="dojox/mobile/Heading">Brightness &amp; Wallpaper</h1>
        <ul data-dojo-type="dojox/mobile/RoundRectList">
          <li data-dojo-type="dojox/mobile/ListItem"
              data-dojo-props='moveTo:"picture"'>Next View</li>
          <li data-dojo-type="dojox/mobile/ListItem"
              data-dojo-props='moveTo:"wifi", transitionDir:-1'>Previous View</li>
        </ul>
      </div>
      <div id="picture" data-dojo-type="dojox/mobile/View">
        <h1 data-dojo-type="dojox/mobile/Heading">Picture Frame</h1>
        <ul data-dojo-type="dojox/mobile/RoundRectList">
          <li data-dojo-type="dojox/mobile/ListItem"
              data-dojo-props='moveTo:"wifi"'>Next View</li>
          <li data-dojo-type="dojox/mobile/ListItem"
              data-dojo-props='moveTo:"bright", transitionDir:-1'>Previous View</li>
        </ul>
      </div>
    </div>

  </div>

.. image :: RoundRectList-sync.gif

Filtered list example
---------------------

See :ref:`FilteredListMixin <dojox/mobile/FilteredListMixin#declarative-example-filtered-roundrectlist>`.
