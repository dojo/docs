.. _dojox/mobile/ListItem:

=====================
dojox.mobile.ListItem
=====================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.5

.. contents ::
    :depth: 2

ListItem represents an item of either RoundRectList or EdgeToEdgeList. There are three ways to move to a different view, moveTo, href, and url. You can choose only one of them.

.. image :: ListItem.png

.. image :: ListItem-desc.png

Constructor Parameters
======================

Inherited from dojox.mobile._ItemBase
-------------------------------------

+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default  |Description                                                                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|transition    |String    |"slide"  |A type of animated transition effect. You can choose from the standard transition types, "slide", "fade",  |
|              |          |         |"flip", or from the extended transition types, "cover", "coverv", "dissolve", "reveal", "revealv",         |
|              |          |         |"scaleIn", "scaleOut", "slidev", "swirl", "zoomIn", "zoomOut". If "none" is specified, transition occurs   |
|              |          |         |immediately without animation.                                                                             |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|transitionDir |Number    |1        |The transition direction. If 1, transition forward. If -1, transition backward. For example, the slide     |
|              |          |         |transition slides the view from right to left when dir == 1, and from left to right when dir == -1.        |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|icon          |String    |""       |An icon to display at the left of the item. The value can be either a path for an image file or a class    |
|              |          |         |name of a DOM button. If icon is not specified, the iconBase parameter of the parent widget is used.       |
|              |          |         |Default icon size for List Items is 29px wide by 29px height.                                              |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|iconPos       |String    |""       |The position of an aggregated icon. IconPos is comma separated values like top,left,width,height           |
|              |          |         |(ex. "0,0,29,29"). If iconPos is not specified, the iconPos parameter of the parent widget is used.        |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|moveTo        |String    |""       |The id of the transition destination view which resides in the current page. If the value has a hash sign  |
|              |          |         |('#') before the id (e.g. #view1) and the dojo.hash module is loaded by the user application, the view     |
|              |          |         |transition updates the hash in the browser URL so that the user can bookmark the destination view. In this |
|              |          |         |case, the user can also use the browser's back/forward button to navigate through the views in the browser |
|              |          |         |history. If null, transitions to a blank view. If '#', returns immediately without transition.             |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|href          |String    |""       |A URL of another web page to go to.                                                                        |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|hrefTarget    |String    |""       |A target that specifies where to open a page specified by href. The value will be passed to the 2nd        |
|              |          |         |argument of window.open().                                                                                 |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|url           |String    |""       |A URL of an html fragment page or JSON data that represents a new view content (See examples below). The   |
|              |          |         |view content is loaded with XHR and inserted in the current page. Then a view transition occurs to the     |
|              |          |         |newly created view. The view is cached so that subsequent requests would not load the content again.       |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|urlTarget     |String    |""       |Node id under which a new view will be created according to the url parameter. If not specified, The new   |
|              |          |         |view will be created as a sibling of the current view.                                                     |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|callback      |Function  |         |A callback function that is called when the transition has been finished. A function reference, or name of |
|              |String    |         |a function in context.                                                                                     |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|sync          |Boolean   |true     |If true, XHR for the view content specified with the url parameter is performed synchronously. If false, it|
|              |          |         |is done asynchronously and the progress indicator is displayed while loading the content. This parameter is|
|              |          |         |effective only when the url parameter is used.                                                             |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|label         |String    |""       |A label of the item. If the label is not specified, innerHTML is used as a label.                          |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+

Parameters from this widget
---------------------------

+--------------+----------+-------------------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default            |Description                                                                                                |
+--------------+----------+-------------------+-----------------------------------------------------------------------------------------------------------+
|rightText     |String    |""                 |A right-aligned text to display on the item.                                                               |
+--------------+----------+-------------------+-----------------------------------------------------------------------------------------------------------+
|rightIcon     |String    |""                 |An icon to display at the right hand side of the item. The value can be either a path for an image file or |
|              |          |                   |a class name of a DOM button.                                                                              |
+--------------+----------+-------------------+-----------------------------------------------------------------------------------------------------------+
|rightIcon2    |String    |""                 |An icon to display at the left of the rightIcon. The value can be either a path for an image file or a     |
|              |          |                   |class name of a DOM button.                                                                                |
+--------------+----------+-------------------+-----------------------------------------------------------------------------------------------------------+
|anchorLabel   |Boolean   |false              |If true, the label text becomes a clickable anchor text. When the user clicks on the text, the             |
|              |          |                   |onAnchorLabelClicked handler is called. You can override or connect to the handler and implement any       |
|              |          |                   |action. The handler has no default action.                                                                 |
+--------------+----------+-------------------+-----------------------------------------------------------------------------------------------------------+
|noArrow       |Boolean   |false              |If true, the right hand side arrow is not displayed.                                                       |
+--------------+----------+-------------------+-----------------------------------------------------------------------------------------------------------+
|selected      |Boolean   |false              |If true, the item is highlighted to indicate it is selected.                                               |
+--------------+----------+-------------------+-----------------------------------------------------------------------------------------------------------+
|checked       |Boolean   |false              |If true, a check mark is displayed at the right of the item.                                               |
+--------------+----------+-------------------+-----------------------------------------------------------------------------------------------------------+
|arrowClass    |String    |"mblDomButtonArrow"|An icon to display as an arrow. The value can be either a path for an image file or a class name of a DOM  |
|              |          |                   |button.                                                                                                    |
+--------------+----------+-------------------+-----------------------------------------------------------------------------------------------------------+
|checkClass    |String    |"mblDomButtonCheck"|An icon to display as a check mark. The value can be either a path for an image file or a class name of a  |
|              |          |                   |DOM button.                                                                                                |
+--------------+----------+-------------------+-----------------------------------------------------------------------------------------------------------+
|variableHeight|Boolean   |false              |If true, the height of the item varies according to its content. In dojo 1.6 or older, the                 |
|              |          |                   |"mblVariableHeight" class was used for this purpose. In dojo 1.7, adding the mblVariableHeight class still |
|              |          |                   |works for backward compatibility.                                                                          |
+--------------+----------+-------------------+-----------------------------------------------------------------------------------------------------------+

Examples
========

Declarative example
-------------------

In this example, no view transition is specified, but if you specify the one, moveTo="view1" for example, an arrow icon is displayed at the position of the rightIcon even if rightIcon is specified. In this case, if you want to change the arrow icon to another, you can use the arrowClass property instead of rightIcon.

.. html ::

  <ul data-dojo-type="dojox.mobile.RoundRectList">
      <li data-dojo-type="dojox.mobile.ListItem"
          icon="mblDomButtonRedCircleMinus"
          label="Label"
          rightText="rightText"
          rightIcon2="mblDomButtonSilverCircleDownArrow"
          rightIcon="mblDomButtonBlueCircleArrow">
      </li>
  </ul>

.. image :: ListItem-desc.png

View content examples
---------------------

A new view can be created from external html fragment or JSON data specified with the url property. Below are examples of such view content. The first one is an html fragment, and the second one is equivalent JSON. They make the same view.

Note that the JSON format cannot have duplicate keys at the same level, while the html format has no such limitation.

html fragment:

.. html ::

  <div data-dojo-type="dojox.mobile.View">
      <h1 data-dojo-type="dojox.mobile.Heading" back="Home" moveTo="foo">view1.html</h1>
      <ul data-dojo-type="dojox.mobile.EdgeToEdgeList">
      <li data-dojo-type="dojox.mobile.ListItem">
          Jack Coleman
      </li>
      <li data-dojo-type="dojox.mobile.ListItem">
          James Evans
      </li>
      <li data-dojo-type="dojox.mobile.ListItem">
          Jason Griffin
      </li>
      </ul>
  </div>

JSON data:

.. js ::

  {
    "dojox.mobile.View": {
      "dojox.mobile.Heading": {
        "@back": "Home",
        "@moveTo": "foo",
        "@label": "view1.json"
      },
      "dojox.mobile.EdgeToEdgeList": {
        "dojox.mobile.ListItem": [{
          "@label": "Jack Coleman"
        }, {
          "@label": "James Evans"
        }, {
          "@label": "Jason Griffin"
        }]
      }
    }
  }
