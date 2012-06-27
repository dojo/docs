.. _dojox/mobile/IconMenuItem:

=========================
dojox.mobile.IconMenuItem
=========================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.8

.. contents ::
    :depth: 2

Introduction
============

IconMenuItem represents a menu item of :ref:`dojox.mobile.IconMenu <dojox/mobile/IconMenu>`. This widget inherits from dojox.mobile._ItemBase. Basic usage is same as the other subclasses such as :ref:`dojox.mobile.ListItem <dojox/mobile/ListItem>`.

.. image :: IconMenuItem.png

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

+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|Parameter     |Type      |Default  |Description                                                                                                |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|closeOnAction |Boolean   |false    |Calls the hide() method of the parent widget, which is typically a SimpleDialog.                           |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|tag           |String    |"li"     |A name of html tag to create as domNode.                                                                   |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+

Usage
=====

Use this widget as child widgets of the :ref:`dojox.mobile.IconMenu <dojox/mobile/IconMenu>` widget.

Examples
========

See the :ref:`dojox.mobile.IconMenu <dojox/mobile/IconMenu>` widget for various examples.
