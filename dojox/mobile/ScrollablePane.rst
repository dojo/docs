.. _dojox/mobile/ScrollablePane:

===========================
dojox/mobile/ScrollablePane
===========================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.8

.. contents ::
    :depth: 2

Introduction
============

The dojox/mobile/ScrollablePane widget is a pane that has the touch-scrolling capability. Unlike :ref:`dojox/mobile/ScrollableView <dojox/mobile/ScrollableView>`, ScrollablePane is not a view. ScrollablePane can be placed in a view to create a partial scrolling area.

.. image :: ScrollablePane.png

Constructor Parameters
======================

+---------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|Parameter      |Type      |Default  |Description                                                                                                |
+---------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|roundCornerMask|Boolean   |false    |If true, create a rounded corner mask to clip corners of a child widget or dom node. Works only on         |
|               |          |         |WebKit-based browsers.                                                                                     |
+---------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|radius         |Number    |0        |Radius of the rounded corner mask.                                                                         |
+---------------+----------+---------+-----------------------------------------------------------------------------------------------------------+
|height         |String    |""       |Explicitly specified height of the widget (ex. "300px"). If "inherit" is specified, the height is inherited|
|               |          |         |from its offset parent (see `Inheriting height from a parent div`_). If "auto" is specified, the content   |
|               |          |         |height, which could be smaller than the entire screen height, is used. If nothing is specified, the entire |
|               |          |         |screen height is used.                                                                                     |
+---------------+----------+---------+-----------------------------------------------------------------------------------------------------------+

Examples
========

Declarative example
-------------------

.. js ::

  require([
    "dojox/mobile",
    "dojox/mobile/parser",
    "dojox/mobile/ScrollablePane"
  ]);

.. html ::

  <div data-dojo-type="dojox/mobile/View" style="height:100px">
    <div data-dojo-type="dojox/mobile/ScrollablePane" 
         data-dojo-props='height:"inherit"'
         style="background-color:yellow;color:black;">
      hello<br>
      hello<br>
      hello<br>
      hello<br>
      hello<br>
      hello<br>
      hello<br>
      hello<br>
      hello<br>
      hello<br>
      hello<br>
      hello<br>
    </div>
  </div>

.. image :: ScrollablePane-example1.png

Rounded corner mask example
---------------------------

.. js ::

  require([
    "dojox/mobile",
    "dojox/mobile/parser",
    "dojox/mobile/ScrollablePane",
    "dojox/mobile/ContentPane"
  ]);

.. html ::

  <div data-dojo-type="dojox/mobile/View">
    <div data-dojo-type="dojox/mobile/ScrollablePane"
         data-dojo-props='height:"100px",
                          roundCornerMask:true,
                          radius:"5"'>
      <div data-dojo-type="dojox/mobile/ContentPane"
           style="margin:5px 9px 7px 9px;padding:8px;
                  background-color:white;color:black;">
        Hello<br>
        Hello<br>
        Hello<br>
        Hello<br>
        Hello<br>
        Hello<br>
        Hello<br>
        Hello<br>
      </div>
    </div>
  </div>

.. image :: ScrollablePane-example2.png

Inheriting height from a parent div
-----------------------------------

When setting the height of a ScrollablePane to the value ``inherit``, remember that the height is inherited from the offset parent. If you're using a wrapper DIV element as parent of a ScrollablePane in order to specify the height to ``inherit``, remember that the position of the wrapper DIV element should be set to either ``relative``, ``absolute`` or ``fixed`` for the wrapper to be the offset parent of the ScrollablePane.

Here is an example with two scrollable panes, in a same View, that uses wrapper DIV elements for sizing:

.. html::

	<div data-dojo-type="dojox/mobile/View" data-dojo-props="selected: true">
		<h1 data-dojo-type="dojox/mobile/Heading">Test ScrollablePane</h1>
		<div style="width:600px; height:250px; margin: 25px auto; position: relative;">
			<div data-dojo-type="dojox/mobile/ScrollablePane" data-dojo-props="height: 'inherit'">
				<!-- Add content here -->
			</div>
		</div>
		
		<div style="width:600px; height:250px; margin: 25px auto; position: relative;">
			<div data-dojo-type="dojox/mobile/ScrollablePane" data-dojo-props="height: 'inherit'">
				<!-- Add content here -->
			</div>
		</div>
	
	</div>
