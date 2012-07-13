.. _dijit/getEnclosingWidget:

========================
dijit.getEnclosingWidget
========================

.. contents ::
    :depth: 2
    
Example
=======

Obtain a widget reference by determining the immediate-most parent widget from some passed Node.
It will walk up the DOM tree testing for a widget using :ref:`dijit.byNode <dijit/byNode>` until an appropriate widget is found:

.. js ::

  dojo.query("#bar").onclick(function(e){
       var aWidget = dijit.getEnclosingWidget(e.target); // pass a domNode
       if(aWidget){
           // found something!
           aWidget.set("value", "clicked!!!");
       }
  });

