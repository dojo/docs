#format dojo_rst

dojox.layout.RotatorContainer
=============================

:Status: Draft
:Version: 1.0
:Project owner: ?--
:Available: since V?

.. contents::
   :depth: 2

dojox.layout.RotatorContainer is an extended StackContainer that automatically crossfades between child panes and display navigation in the form of tabs or a pager.

============
Introduction
============

The RotatorContainer cycles through the child panes with a crossfade transition.

If you're looking for a more lightweight and powerful rotator, please check out the `dojox.widget.AutoRotator <dojox/widget/AutoRotator>`_.

=====
Usage
=====

TODO: how to use the component/class/method

========
Examples
========

Programmatic example
--------------------

TODO: example

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
