#format dojo_rst


dijit._LayoutWidget
===================

In general, here is the contract for writing layout widgets:

0. Widget inherits from dijit.layout._LayoutWidget
1. Widget should contain a flat list of children which go into this.containerNode
2. At the time the widget is initialized (postCreate() etc.) the child widgets do not yet exist.   Thus some setup has to occur in startup().
2. addChild() and removeChild() must work before or 
3. 
