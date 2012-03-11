.. _dijit/hccss:

===========
dijit.hccss
===========

:since: v1.7

.. contents ::
    :depth: 2

Introduction
============

By doing a require() of "dijit/hccss", the "dijit_a11y" CSS class will be added to your document's <body> tag
if the machine is in high contrast mode, and thus the browser doesn't display background images.
This is useful for Internet Explorer and Firefox running on Windows.
It doesn't apply to Chrome or Safari (on mobile, mac, or desktop), which always display background images.

Usage
=====

Simply require the module:

.. js ::

  require(["dijit/hccss"]);
  
And then reference the class name from CSS rules, etc.:


.. css ::

  .myTitlePane .label {
       /* normally hide the label in preference to the icon */
       display: none;
  }
  .dijit_a11y .myTitlePane .label {
       /* but display the label in high contrast mode, since the icon won't appear */
       display: block;
   }

Execution Time
==============

Note that the dojo/domReady! dependency (if present) will resolve before the CSS class is added.
Thus if your widget has JavaScript sizing code, it's not sufficient to wait for dojo/domReady!.
Rather, the widget should be instantiated inside of a ready() call:

.. js ::


  require(["dojo/ready", "dijit/hccss"], function(ready){
       ready(function(){      // wait for DOMReady and for hccss code to execute
          new MyTitlePane(...);
       });
  });
