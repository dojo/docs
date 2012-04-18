.. _dojox/mobile/ToolBarButton:

==========================
dojox.mobile.ToolBarButton
==========================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.6

.. contents ::
    :depth: 2

Introduction
============

ToolBarButton is a button which is typically placed in the Heading widget. It is a subclass of dojox.mobile._ItemBase just like ListItem or IconItem. So, unlike :ref:`dojox.mobile.Button <dojox/mobile/Button>`, it has almost the same capability as ListItem or IconItem, such as icon support, transition, etc.

.. image :: ToolbarButton.png

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
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|iconPos       |String    |""       |The position of an aggregated icon. IconPos is comma separated values like top,left,width,height           |
|              |          |         |(ex. "0,0,29,29"). If iconPos is not specified, the iconPos parameter of the parent widget is used.        |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|moveTo        |String    |""       |The id of the transition destination view which resides in the current page. If the value has a hash sign  |
|              |          |         |('#') before the id (e.g. #view1) and the dojo.hash module is loaded by the user application, the view     |
|              |          |         |transition updates the hash in the browser URL so that the user can bookmark the destination view. In this |
|              |          |         |case, the user can also use the browser's back/forward button to navigate through the views in the browser |
|              |          |         |history. If null, transitions to a blank view. If '#', returns to the previous view immediately without    |
|              |          |         |transition.                                                                                                |
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
|back          |Boolean   |false    |If true, history.back() is called when clicked.                                                            |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|callback      |Function  |         |A callback function that is called when the transition has been finished. A function reference, or name of |
|              |String    |         |a function in context.                                                                                     |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|toggle        |Boolean   |false    |If true, the item acts like a toggle button.                                                               |
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
|selected      |Boolean   |false    |If true, the button is in the selected status.                                                             |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|arrow         |String    |""       |Specifies "right" or "left" to be an arrow button.                                                         |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|light         |Boolean   |true     |If true, this widget produces only a single <span> node when it has only an icon or only a label, and has  |
|              |          |         |no arrow. In that case, you cannot have both icon and label, or arrow even if you try to set them.         |
+--------------+----------+---------+-----------------------------------------------------------------------------------------------------------+

Usage
=====

Use this widget as child widgets of the :ref:`dojox.mobile.Heading <dojox/mobile/Heading>` widget.

In dojo-1.8, this widget can also be placed outside the Heading widget. See the navigation button example below.

Examples
========

See the :ref:`dojox.mobile.Heading <dojox/mobile/Heading>` widget for various examples.

Navigation button example
-------------------------

This is an example of arrow buttons that are placed outside the Heading widget and used as navigation buttons.

.. js ::

  require([
    "dojox/mobile",
    "dojox/mobile/parser"
  ]);

.. html ::

  <div id="view2" data-dojo-type="dojox.mobile.View">
    <div data-dojo-type="dojox.mobile.RoundRect" data-dojo-props='shadow:true'>
      Dojo saves you time, delivers powerful performance,
      and scales with your development process.
      It's the toolkit experienced developers turn to
      for building superior desktop and mobile web experiences.
    </div>
    <span data-dojo-type="dojox.mobile.ToolBarButton"
          data-dojo-props='arrow:"left",
                           moveTo:"view3",
                           transition:"slide"'>Back</span>
    <span data-dojo-type="dojox.mobile.ToolBarButton"
          data-dojo-props='arrow:"right",
                           moveTo:"view1",
                           transition:"slide",
                           transitionDir:-1'>Next</span>
  </div>

.. image :: ToolbarButton-example1.png
