.. _dojo/NodeList-dom:

=================
dojo/NodeList-dom
=================

:since: V 1.7

This module contains extension to dojo/NodeList to provide capability of manipulating DOM nodes.

Click on a method name to see a documentation page for it.

::ref:`attr <dojo/NodeList/attr>`:
  Attribute getter/setter for this list of nodes. Mimics :ref:`dojo.attr <dojo/attr>`, excluding the node passed.

::ref:`removeAttr <dojo/NodeList/removeAttr>`:
  **New in 1.4** - Forcefully remove the passed attribute from a node. Mimics :ref:`dojo.removeAttr <dojo/removeAttr>`.

:style:
  Get or set styles to the nodes in this list. For more information see :ref:`dojo.style <dojo/style>`

:addClass:
  Add the passed class to the nodes in this list. For more information see :ref:`dojo.addClass <dojo/addClass>`

:removeClass:
  Remove the passed class to the nodes in this list. For more information see :ref:`dojo.removeClass <dojo/removeClass>`

:toggleClass:
  Add the passed class to the nodes in this list, if the class is not present, otherwise removes it. For more information see :ref:`dojo.toggleClass <dojo/toggleClass>`

:place:
  Places elements of this node list relative to the first element matched by queryOrNode. Returns the original NodeList. For more information, see :ref:`dojo.place <dojo/place>`

:orphan:
  Removes elements in this list that match the filter from their parents and returns them as a new NodeList.

:adopt:
  Places any/all elements in queryOrListOrNode at a position relative to the first element in this list. Returns a dojo.NodeList of the adopted elements.

:addContent:
  Add a node, NodeList or some HTML as a string to every item in the list.  Returns the original list.

:empty:
  Empties the content of the nodes in this list, leaving the nodes in place. see :ref:`dojo.empty <dojo/empty>`

:coords:
  Partially "deprecated", using NodeList.position is recommended in Dojo 1.4 and higher. Returns the coordinate values
  of all the nodes in this list.

:position:
  Returns the coordinate values of all the nodes in this list.
