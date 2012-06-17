.. _dojo/hccss:

==========
dojo/hccss
==========

:since: v1.8

.. contents ::
    :depth: 2

Provides "High Contrast" feature detection for accessibility purposes.

Introduction
============

By doing a ``require()`` of ``dojo/hccss``, the ``dj_a11y`` CSS class will be added to your document's ``<body>`` tag 
if the machine is in high contrast mode.  Dijit's styling is aware of this class and will not display background 
images.  This is useful for Internet Explorer and Firefox running on Windows.  It doesn't apply to Chrome or Safari (on 
mobile, mac, or desktop), which always display background images.

``dojo/hccss`` will also set the ``has("highcontrast")`` flag so code can check directly whether or not it is in high contrast mode and branch appropriately.

Usage
=====

Simply require the module:

.. js ::

  require(["dojo/hccss"]);

And then reference the class name from CSS rules, etc.:

.. css ::

  .myTitlePane .label {
       /* normally hide the label in preference to the icon */
       display: none;
  }
  .dj_a11y .myTitlePane .label {
       /* but display the label in high contrast mode, since the icon won't appear */
       display: block;
   }

Execution Time
==============

Note that the ``dojo/domReady!`` dependency (if present) will resolve before the CSS class is added. Thus if your 
widget has JavaScript sizing code, it may not be sufficient to wait for ``dojo/domReady!``. Rather, the widget should 
be instantiated inside of a ready() call:

.. js ::


  require(["dojo/ready", "dojo/hccss"], function(ready){
       ready(function(){      // wait for DOMReady and for hccss code to execute
          new MyTitlePane(...);
       });
  });
