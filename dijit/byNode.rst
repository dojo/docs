#format dojo_rst

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

* `The dijit registry <dijit/registry>`_
* `dijit.getEnclosingWidget <dijit/getEnclosingWidget>`_
