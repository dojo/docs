#format dojo_rst

dijit/focus
===========

:Author: Colin Snover
:Version: 1.7

.. contents::
   :depth: 2

============
Introduction
============

dijit/focus is a utility module that is used to manage focused nodes and widgets on a page. It can be used to track changes to the currently focused node/widget, register and unregister handlers for detecting focus changes in windows and inline frames, and programmatically focus nodes.

Until Dojo 2.0, requiring dijit/focus will also create a ``dijit.focus`` function with the same semantics as ``focus.focus``.

=====
Usage
=====

Focusing an element
-------------------

.. code-block :: javascript
 :linenos:

  require([ "dijit/focus", "dojo/dom", "dojo/domReady!" ], function(focusUtil, dom){
    focusUtil.focus(dom.byId("foo"));
  });

Note that this function only accepts DOM nodes, not widget instances. The element to focus must also be focusable (a form element, or another element with a tabindex).

Unfocusing an element
---------------------

.. code-block :: javascript
 :linenos:

  require([ "dijit/focus" ], function(focusUtil){
    focusUtil.curNode && focusUtil.curNode.blur();
  });

Determining the currently focused element
-----------------------------------------

.. code-block :: javascript
 :linenos:

  require([ "dijit/focus" ], function(focusUtil){
    var activeElement = focusUtil.curNode; // returns null if there is no focused element
  });

Watching for focus changes
--------------------------

Listening for focus changes in iframes
--------------------------------------
