.. _dojox/mobile/TabBarButton:

=========================
dojox.mobile.TabBarButton
=========================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.6

.. contents ::
    :depth: 2

TabBarButton is a button that is placed in the TabBar widget. It is a subclass of dojox.mobile._ItemBase just like ListItem or IconItem. So, unlike Button, it has similar capability as ListItem or IconItem, such as icon support, transition, etc.

.. image :: TabBarButton.png

Constructor Parameters
======================

Inherited from dojox.mobile._ItemBase
-------------------------------------

+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default  |Description                                                                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|transition    |String    |"none"   |A type of animated transition effect. You can choose from the standard transition types, "slide", "fade",  |
|              |          |         |"flip", or from the extended transition types, "cover", "coverv", "dissolve", "reveal", "revealv",         |
|              |          |         |"scaleIn", "scaleOut", "slidev", "swirl", "zoomIn", "zoomOut", "cube", and "swap". If "none" is specified, |
|              |          |         |transition occurs immediately without animation.                                                           |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|transitionDir |Number    |1        |The transition direction. If 1, transition forward. If -1, transition backward. For example, the slide     |
|              |          |         |transition slides the view from right to left when dir == 1, and from left to right when dir == -1.        |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|moveTo        |String    |""       |The id of the transition destination view which resides in the current page. If the value has a hash sign  |
|              |          |         |('#') before the id (e.g. #view1) and the dojo.hash module (=the dojox.mobile.bookmarkable module since    |
|              |          |         |V1.8) is loaded by the user application, the view transition updates the hash in the browser URL so that   |
|              |          |         |the user can bookmark the destination view. In this case, the user can also use the browser's back/forward |
|              |          |         |button to navigate through the views in the browser history. If null, transitions to a blank view. If '#', |
|              |          |         |returns to the previous view immediately without transition.                                               |
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
|              |          |         |effective only when the url parameter is used. In dojo-1.8, however, this property is no longer supported. |
|              |          |         |It always behaves in the async manner regardless of the value of this property.                            |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|label         |String    |""       |A label of the item. If the label is not specified, innerHTML is used as a label.                          |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|alt           |String    |""       |An alt text for the icon image.                                                                            |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|tabIndex      |String    |"0"      |Tabindex setting for the item so users can hit the tab key to focus on it.                                 |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+

Parameters from this widget
---------------------------

+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default  |Description                                                                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|icon1         |String    |         |A path for the unselected (typically dark) icon. If icon is not specified, the iconBase parameter of the   |
|              |          |         |parent widget is used.                                                                                     |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|icon2         |String    |         |A path for the selected (typically highlight) icon. If icon is not specified, the iconBase parameter of    |
|              |          |         |the parent widget or icon1 is used.                                                                        |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|iconPos1      |String    |         |The position of an aggregated unselected (typically dark) icon. IconPos1 is comma separated values like    |
|              |          |         |top,left,width,height (ex. "0,0,29,29"). If iconPos1 is not specified, the iconPos parameter of the parent |
|              |          |         |widget is used.                                                                                            |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|iconPos2      |String    |         |The position of an aggregated selected (typically highlight) icon. IconPos2 is comma separated values like |
|              |          |         |top,left,width,height (ex. "0,0,29,29"). If iconPos2 is not specified, the iconPos parameter of the parent |
|              |          |         |widget or iconPos1 is used.                                                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|selected      |Boolean   |false    |If true, the button is in the selected status. The default value is false.                                 |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|badge         |String    |""       |A string to show on a badget. (ex. "12")                                                                   |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+

Usage
=====

Use this widget as child widgets of the :ref:`dojox.mobile.TabBar <dojox/mobile/TabBar>` widget.

Examples
========

See the :ref:`dojox.mobile.TabBar <dojox/mobile/TabBar>` widget for various examples.
