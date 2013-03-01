.. _dijit/_CssStateMixin:

====================
dijit._CssStateMixin
====================

:Authors: Bill Keese
:Project owner: Bill Keese
:since: V1.5

.. contents ::
    :depth: 2

Introduction
============

_CssStateMixin is a mixin for widgets that set CSS classes on their nodes depending on hover/active/focused state, and also semantic state (checked, selected, disabled, etc.).

_CssStateMixin serves two functions:

   - workaround IE6/7 issues where :hover and :active don't work on certain nodes
   - semantic state updating (disabled, checked, selected, etc.)


Examples
========

_CssStateMixin will, for example, set classes dijitCheckboxHover if a checkbox is hovered, or dijitCheckboxChecked if the widget is checked.   It will also set dijitCheckboxDisabled (if the widget is disabled).

More complicated widgets also set class names on sub nodes when they are hovered/pressed/focused.
For example, the Slider widget has hover and active effects on the left/right arrows and the slider handle itself.

Usage
=====

To use this mixin in custom widgets:

1. mix it in to the widget:
    
.. js ::

    require(["dojo/_base/declare", "dijit/_CssStateMixin"], function(declare, _CssStateMixin){
        declare(myWidget, [ ..., _CssStateMixin], ...
    });

*Note that most dijits already extend _CssStateMixin, so they should skip this step.*


2. set baseClass if not already set *(most widgets already set baseClass)*
    
.. js ::

    baseClass: "dijitSlider",

3. (if you want CSS class settings on widget subnodes, like the up/down buttons on the slider, then) set cssStateNodes attribute:
    
.. js ::

    cssStateNodes: {
       incrementButton: "dijitSliderIncrementButton",
       decrementButton: "dijitSliderDecrementButton",
       focusNode: "dijitSliderThumb"
    }

The left side (ex: incrementButton) is the data-dojo-attach-point name, and the right side ("dijitSliderIncrementButton") is used to construct the CSS class name to apply to the node.

After the steps above, CSS classes will automatically be applied to the slider domNode (dijitSliderHover, dijitSliderFocused etc.) in addition to the specified sub nodes (this.incrementButton --> "dijitSliderIncrementButtonActive" CSS class etc.).

Note that there's no event handling code for hover/active/focus CSS needed in the widget template
