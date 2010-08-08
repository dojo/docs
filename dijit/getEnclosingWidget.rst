#format dojo_rst

dijit.getEnclosingWidget
========================

``FIXME:`` just inline the api reference info here

Obtain a widget reference by determining the immediate-most parent Widget from some passed Node:

.. code-block :: javascript

  dojo.query("#bar").onclick(function(e){
       var aWidget = dijit.getEnclosingWidget(e.target); // pass a domNode
       if(aWidget){
           // found something!
           aWidget.set("value", "clicked!!!");
       }
  });
