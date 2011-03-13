#format dojo_rst

dojox.mobile.ListItem
=====================

:Status: Draft
:Version: 1.0
:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:Available: since V1.5

.. contents::
    :depth: 2

ListItem represents an item of either RoundRectList or EdgeToEdgeList. There are three ways to move to a different view, moveTo, href, and url. You can choose only one of them.

.. image:: ListItem.png

======================
Constructor Parameters
======================

+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default  |Description                                                                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|transition    |String    |slide    |A type of animated transition effect. "slide", "fade", "flip", or "none".                                  |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|transitionDir |Number    |1        |The transition direction. If 1, transition forward. If -1, transition backward. For example, the slide     |
|              |          |         |transition slides the view from right to left when dir == 1, and from left to right when dir == -1.        |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|icon          |String    |         |The icon path for the item. If icon is not specified, the iconBase parameter of the parent widget is used. |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|iconPos       |String    |         |The position of an aggregated icon. IconPos is comma separated values like top,left,width,height           |
|              |          |         |(ex. "0,0,29,29"). If iconPos is not specified, the iconPos parameter of the parent widget is used.        |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|moveTo        |String    |         |The id of the transition destination view which resides in the current page. If you add the hash sign ('#')|
|              |          |         |before the id, the view transition updates the hash in the browser URL so that the user can bookmark the   |
|              |          |         |destination view. The user can also use the browser's back/forward button to navigate through the views in |
|              |          |         |the browser history.                                                                                       |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|href          |String    |         |A URL of another web page to go to.                                                                        |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|hrefTarget    |String    |         |A target that specifies where to open a page specified by href. The value will be passed to the 2nd        |
|              |          |         |argument of window.open().                                                                                 |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|url           |String    |         |A URL of an html fragment page or JSON data that represents a new view content (See examples below). The   |
|              |          |         |view content is loaded with XHR and inserted in the current page. Then a view transition occurs to the     |
|              |          |         |newly created view. The view is cached so that subsequent requests would not load the content again.       |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|callback      |Function  |         |A callback function that is called when the transition has been finished. A function reference, or name of |
|              |          |         |a function in context.                                                                                     |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|sync          |Boolean   |true     |If true, XHR for the view content specified with the url parameter is performed synchronously. If false, it|
|              |          |         |is done asynchronously and the progress indicator is displayed while loading the content. This parameter is|
|              |          |         |effective only when the url parameter is used.                                                             |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|label         |String    |         |A label of the item. If the label is not specified, innerHTML is used as a label.                          |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|rightText     |String    |         |A text to display at the right hand side of the item.                                                      |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|btnClass      |String    |         |A button class name to display at the right of the item. Button classes are defined in                     |
|              |          |         |dojox/mobile/themes/buttons.css. (ex. "mblBluePlusButton")                                                 |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|anchorLabel   |Boolean   |false    |If true, the label text becomes a clickable anchor text. When the user clicks on the text, the             |
|              |          |         |onAnchorLabelClicked handler is called. You can override or connect to the handler and implement any       |
|              |          |         |action. The handler has no default action.                                                                 |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|noArrow       |Boolean   |false    |If true, the right hand side arrow is not displayed.                                                       |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+

========
Examples
========

Example of view html fragment
-----------------------------

.. code-block :: html

  <div dojoType="dojox.mobile.View">
      <h1 dojoType="dojox.mobile.Heading" back="Home" moveTo="foo">view1.html</h1>
      <ul dojoType="dojox.mobile.EdgeToEdgeList">
	  <li dojoType="dojox.mobile.ListItem">
	      Jack Coleman
	  </li>
	  <li dojoType="dojox.mobile.ListItem">
	      James Evans
	  </li>
	  <li dojoType="dojox.mobile.ListItem">
	      Jason Griffin
	  </li>
      </ul>
  </div>

Example of view JSON data
-------------------------

.. code-block :: javascript

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
