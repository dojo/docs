.. _dojox/mobile/IconItem:

=====================
dojox.mobile.IconItem
=====================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.5

.. contents ::
    :depth: 2

IconItem represents an item that has an application component and its icon image. You can tap the icon to open the corresponding application component. You can also use the icon to move to a different view by specifying either of the moveTo, href or url parameters.

.. image :: IconItem.png

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
|icon          |String    |""       |An icon image to display. The value can be either a path for an image file or a class name of a DOM button.|
|              |          |         |If icon is not specified, the iconBase parameter of the parent widget is used.                             |
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

+--------------+----------+-----------------------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default                |Description                                                                                                |
+--------------+----------+-----------------------+-----------------------------------------------------------------------------------------------------------+
|lazy          |Boolean   |false                  |If true, the content of the item, which includes dojo markup, is instantiated lazily. That is, only when   |
|              |          |                       |the icon is opened by the user, the required modules are loaded and dojo widgets are instantiated.         |
|              |          |                       |This option works only in the sync loader mode.                                                            |
+--------------+----------+-----------------------+-----------------------------------------------------------------------------------------------------------+
|requires      |String    |""                     |Comma-separated required module names to be loaded. All the modules specified with data-dojo-type and their|
|              |          |                       |depending modules are automatically loaded by the IconItem. If you need other extra modules to be loaded,  |
|              |          |                       |use this parameter. If lazy is true, the specified required modules are loaded when the user opens the icon|
|              |          |                       |for the first time. This option works only in the sync loader mode.                                        |
+--------------+----------+-----------------------+-----------------------------------------------------------------------------------------------------------+
|timeout       |Number    |10                     |Duration of highlight in seconds.                                                                          |
+--------------+----------+-----------------------+-----------------------------------------------------------------------------------------------------------+
|closeBtnClass |String    |"mblDomButtonBlueMinus"|A class name of a DOM button to be used as a close button.                                                 |
+--------------+----------+-----------------------+-----------------------------------------------------------------------------------------------------------+

.. image :: IconItem-close-button.png

Examples
========

See examples of :ref:`dojox.mobile.IconContainer <dojox/mobile/IconContainer>`.
