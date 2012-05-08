
.. _dojox/mobile/IconItem:

=====================
dojox.mobile.IconItem
=====================

:Authors: Yoshiroh Kamiyama, Atsushi Ono
:Developers: Yoshiroh Kamiyama
:since: V1.5

.. contents ::
    :depth: 2

Introduction
============

IconItem represents an item which has an application component and its icon image. You can tap the icon to open the corresponding application component. You can also use the icon to move to a different view by specifying either of the moveTo, href or url parameters.

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
|              |          |         |"scaleIn", "scaleOut", "slidev", "swirl", "zoomIn", "zoomOut", "cube", and "swap". If "none" is specified, |
|              |          |         |transition occurs immediately without animation.                                                           |
|              |          |         |In case of this IconItem widget, "below" can be also specified to open the icon content below the icons in |
|              |          |         |the current view without transition animation.                                                             |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|transitionDir |Number    |1        |The transition direction. If 1, transition forward. If -1, transition backward. For example, the slide     |
|              |          |         |transition slides the view from right to left when transitionDir == 1, and from left to right when         |
|              |          |         |transitionDir == -1.                                                                                       |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|icon          |String    |""       |An icon to display at the left of the item. The value can be either a path for an image file or a class    |
|              |          |         |name of a DOM button. If icon is not specified, the iconBase parameter of the parent widget is used.       |
|              |          |         |Default icon size for List Items is 29px wide by 29px height.                                              |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|iconPos       |String    |""       |The position of an aggregated icon. IconPos is comma separated values like top,left,width,height           |
|              |          |         |(ex. "0,0,29,29"). If iconPos is not specified, the iconPos parameter of the parent widget is used.        |
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
|url           |String    |""       |A URL of an html fragment page or JSON data that represents a new view content. The                        |
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

+--------------+----------+-----------------------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default                |Description                                                                                                |
+--------------+----------+-----------------------+-----------------------------------------------------------------------------------------------------------+
|lazy          |Boolean   |false                  |If true, the content of the item, which includes dojo markup, is instantiated lazily. That is, only when   |
|              |          |                       |the icon is opened by the user, the required modules are loaded and dojo widgets are instantiated.         |
|              |          |                       |This option works only in the sync loader mode. In dojo-1.8, it works in the async loader mode as well.    |
+--------------+----------+-----------------------+-----------------------------------------------------------------------------------------------------------+
|requires      |String    |""                     |Comma-separated required module names to be lazily loaded. This property is effective only when lazy=true. |
|              |          |                       |All the modules specified with data-dojo-type and their depending modules are automatically loaded by the  |
|              |          |                       |IconItem when it is opened. However, if you need other extra modules to be loaded, use this parameter.     |
|              |          |                       |This option works only in the sync loader mode. In dojo-1.8, it works in the async loader mode as well.    |
+--------------+----------+-----------------------+-----------------------------------------------------------------------------------------------------------+
|timeout       |Number    |10                     |Duration of highlight in seconds.                                                                          |
+--------------+----------+-----------------------+-----------------------------------------------------------------------------------------------------------+
|content       |String    |""                     |An html fragment to embed as icon content.                                                                 |
+--------------+----------+-----------------------+-----------------------------------------------------------------------------------------------------------+
|badge         |String    |""                     |A text to show in a badge. (ex. "55")                                                                      |
+--------------+----------+-----------------------+-----------------------------------------------------------------------------------------------------------+
|badgeClass    |String    |"mblDomButtonRedBadge" |A class name of a DOM button for a badge.                                                                  |
+--------------+----------+-----------------------+-----------------------------------------------------------------------------------------------------------+
|deletable     |Boolean   |true                   |If true, you can delete this IconItem by clicking on the delete icon during edit mode. If false, the delete|
|              |          |                       |icon is not displayed during edit mode so that it cannot be deleted.                                       |
+--------------+----------+-----------------------+-----------------------------------------------------------------------------------------------------------+
|deleteIcon    |String    |""                     |A delete icon to display at the top left corner of the item during edit mode. The value can be either a    |
|              |          |                       |path for an image file or a class name of a DOM button.                                                    |
+--------------+----------+-----------------------+-----------------------------------------------------------------------------------------------------------+
|tag           |String    |"li"                   |A name of html tag to create as domNode.                                                                   |
+--------------+----------+-----------------------+-----------------------------------------------------------------------------------------------------------+

.. image :: IconItem-badge-deleteIcon.png

Examples
========

See :ref:`dojox.mobile.IconContainer <dojox/mobile/IconContainer>` for various examples.
