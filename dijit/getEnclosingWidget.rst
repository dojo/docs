#format dojo_rst

dijit.getEnclosingWidget
========================

`this is the kind of stub that just needs pulled from the API. not much to see here`

Obtain a widget reference by determining the immediate-most parent Widget from some passed Node:

.. code-block :: javascript

  dojo.query("#bar").onclick(function(e){
       var aWidget = dijit.getEnclosingWidget(e.target); // pass a domNode
       if(aWidget){
           // found something!
           aWidget.set("value", "clicked!!!");
       }
  });
