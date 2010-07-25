#format dojo_rst

dojox.widget.TitleGroup
=======================

:since: 1.6.0
:author: dante

A container widget which delegates a connection between children `TitlePanes <dijit/TitlePane>`_. Behaves similarly to an `AccordionContainer <dijit/layout/AccordionContainer>`_ though has a variable overall height and does not "dock" to other layout widgets, such as a `BorderContainer <dijit/layout/BorderContainer>`_. 

Examples
========

.. code-example::
  :type: inline
  :height: 600
  :version: local

  .. css::

     <style type="text/css"> 
        @import "{{baseUrl}}dojox/widget/TitleGroup/TitleGroup.css";
     </style>

  .. javascript::

    <script>
        dojo.require("dojox.widget.TitleGroup");
        dojo.require("dijit.TitlePane");
    <script>
    <script>
        dojo.addOnLoad(function(){
            console.warn("in ready");
            var thegroup = new dojox.widget.TitleGroup({}, "titleGroup");
            console.wanr(thegroup);
            new dijit.TitlePane({ title:"Pane 1", open:true }).placeAt(thegroup);
            new dijit.TitlePane({ title:"Pane 2", open:false }).placeAt(thegroup);
            new dijit.TitlePane({ title:"Pane 3", open:false }).placeAt(thegroup);
        });
    </script>

  .. html::

    <div id="titleGroup"></div>


See Also:
=========

* `dijit.TitlePane <dijit/TitlePane>`_
* `dijit.layout.AccordionContainer <dijit/layout/AccordionContainer>`_
* `The original blog and motivation <http://www.sitepen.com/blog/2008/10/21/quick-fixes-and-dojo-support/>`_
