#format dojo_rst

CSS Styleguide
===============

:Status: Draft

.. contents::
   :depth: 2

This styleguide will give you in depth information on how Dojo and Dijits CSS Classes are used, and how you can create your own themes.

============
Introduction
============

Dijit comes with a very powerful theming system.

baseClass
---------
All dijit widgets have a baseClass attribute which can be specified (overridden) as an initialization parameter.  For example,

.. code-block :: html

  <div dojoType="dijit.layout.TabContainer" baseClass="myTabContainer"></div>

This lets the designer completely override the style of the widget because none of the CSS rules in dijit.css, tundra.css etc. are applied, since the patterns reference .dijitTabContainer.


======
Layout
======

Nesting
---------

Layout widgets set special classes on their children.   For example, when having a BorderContainer with a ContentPane inside, the ContentPane will have `dijitBorderContainer-dijitContentPane` set on its domNode, in addition to dijitContentPane.

This allows special styling for children, specifically doing things like adding borders on ContentPanes inside of BorderContainers.

Note that BorderContainer expects the panes it contains to have borders; the draggable splitters between the panes don't have borders, although visually it seems that way (due to the borders on the panes).

TODO: in the future BorderContainer will also set a dijitBorderContainer-child class on all its children.


==================
Form Widget States
==================
A form widget like spinner will have various classes applied to its domNode depending on its state.  For example:

  - dijitSpinner
  - dijitSpinnerDisabled
  - dijitSpinnerHover  (mouse is over it)
  - dijitSpinnerFocused

It even has combinations of those for special styling needs, like:

  - dijitSpinnerFocusedHover  (TODO: check this)


Button type-widgets have an active state when they are being depressed:

  - dijitComboButtonActive

Note that we don't use :hover and :active since on IE they only work on <button> and <a> nodes.

=========================
Buttons inside of widgets
=========================

When looking at a numberspinner you will see two buttons at the right of the numberspinner.

In the current code, clicking one of the buttons will change the class of the NumberSpinner domNode itself, to something like .dijitNumberSpinnerUpArrowActive.

However, we plan to change this so it just sets a class on the button node itself. 

========
See also
========

* http://dojotoolkit.org/book/dijit-functional-spec/dijit-styling-theming
