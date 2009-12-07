#format dojo_rst

dojox.layout.RotatorContainer
=============================

:Status: Draft
:Version: 1.0
:Project owner: Chris Barber
:Available: since V1.2

.. contents::
   :depth: 2

dojox.layout.RotatorContainer is an extended StackContainer that automatically crossfades between child panes and display navigation in the form of tabs or a pager.

============
Introduction
============

The RotatorContainer cycles through the child panes with a crossfade transition.

This widget is on the verge of being deprecated. It has been replaced by the `dojox.widget.AutoRotator <dojox/widget/AutoRotator>`_, a lightweight version that has more features and doesn't require dijit.

=====
Usage
=====

Since the RotatorContainer is a layout widget, it's children must be a layout widget such as a `dijit.layout.ContentPane <dijit/layout/ContentPane>`_.

====================  =======  ========================================================================================
Parameter             Type     Description
====================  =======  ========================================================================================
showTabs              boolean  Sets the display of the tabs. The tabs are actually a StackController. The child's title is used for the tab's label. The default value is "true".
transitionDelay       int      The delay in milliseconds before transitioning to the next child. The default value is 5000.
transition            string   The type of transition to perform when switching children. A null transition will transition instantly. The default value is "fade".
transitionDuration    int      The duration of the transition in milliseconds. The default value is 1000.
autoStart             boolean  Starts the timer to transition children upon creation. The default value is "true".
suspendOnHover        boolean  Pause the rotator when the mouse hovers over it. The default value is "false".
pauseOnManualChange   boolean  Pause the rotator when the tab is changed or the pager's next/previous buttons are clicked.
reverse               boolean  Causes the rotator to rotate in reverse order. The default value is "false".
pagerId               string   ID the pager widget.
cycles                int      Number of cycles before pausing.
pagerClass            string   The declared Class of the Pager used for this widget. The default value is "dojox.layout.RotatorPager".
====================  =======  ========================================================================================

========
Examples
========

Declarative example
-------------------

.. code-block :: html
 :linenos:
 
 <script type="text/javascript">
   dojo.require("dojox.layout.RotatorContainer");
   dojo.require("dijit.layout.ContentPane");
 </script>
 
 <div dojoType="dojox.layout.RotatorContainer" id="myRotator" showTabs="true" autoStart="true" transitionDelay="5000">
   <div id="pane1" dojoType="dijit.layout.ContentPane" title="1">
     Pane 1!
   </div>
   <div id="pane2" dojoType="dijit.layout.ContentPane" title="2">
     Pane 2!
   </div>
   <div id="pane3" dojoType="dijit.layout.ContentPane" title="3" transitionDelay="10000">
     Pane 3 with overrided transitionDelay!
   </div>
 </div>

========
See also
========

* `dojox.widget.AutoRotator <dojox/widget/AutoRotator>`_ is a replacement widget for the RotatorContainer that is more lightweight and has more features.
