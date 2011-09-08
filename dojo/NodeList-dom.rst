#format dojo_rst

dojo/NodeList-dom
=================

:Available: since V 1.7

This module contains extension to dojo/NodeList to provide capability of manipulating DOM nodes.

Click on a method name to see a documentation page for it.

:`attr <dojo/NodeList/attr>`_:
  Attribute getter/setter for this list of nodes. Mimics `dojo.attr <dojo/attr>`_, excluding the node passed.

:`removeAttr <dojo/NodeList/removeAttr>`_:
  **New in 1.4** - Forcefully remove the passed attribute from a node. Mimics `dojo.removeAttr <dojo/removeAttr>`_.

:style:
  Get or set styles to the nodes in this list. For more information see `dojo.style <dojo/style>`_

:addClass:
  Add the passed class to the nodes in this list. For more information see `dojo.addClass <dojo/addClass>`_

:removeClass:
  Remove the passed class to the nodes in this list. For more information see `dojo.removeClass <dojo/removeClass>`_

:toggleClass:
  Add the passed class to the nodes in this list, if the class is not present, otherwise removes it. For more information see `dojo.toggleClass <dojo/toggleClass>`_

:place:
  Places elements of this node list relative to the first element matched by queryOrNode. Returns the original NodeList. For more information, see `dojo.place <dojo/place>`_

:orphan:
  Removes elements in this list that match the filter from their parents and returns them as a new NodeList.

:adopt:
  Places any/all elements in queryOrListOrNode at a position relative to the first element in this list. Returns a dojo.NodeList of the adopted elements.

:addContent:
  Add a node, NodeList or some HTML as a string to every item in the list.  Returns the original list.

:empty:
  Empties the content of the nodes in this list, leaving the nodes in place. see `dojo.empty <dojo/empty>`_

:coords:
  Partially "deprecated", using NodeList.position is recommended in Dojo 1.4 and higher. Returns the coordinate values
  of all the nodes in this list. 

:position:
  Returns the coordinate values of all the nodes in this list. 
