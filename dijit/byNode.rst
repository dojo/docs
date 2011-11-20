.. _dijit/byNode:

dijit.byNode
============

Finds a Dijit instance reference by a passed node reference.

.. javascript::

    var widget = dijit.byNode( dojo.byId("foo") );
    if(widget){
       // we found that node!
    } 

See Also:
=========

* :ref:`The dijit registry <dijit/registry>`
* :ref:`dijit.getEnclosingWidget <dijit/getEnclosingWidget>`
