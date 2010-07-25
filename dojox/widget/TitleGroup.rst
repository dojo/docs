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
        dojo.require("dijit.form.Button");
    </script>

  .. html::

    <div id="titleGroup" dojoType="dojox.widget.TitleGroup">
        <div dojoType="dijit.TitlePane" open="true" title="Pane 1">Lorem</div>
        <div dojoType="dijit.TitlePane" open="false" title="Pane 2">Lorem <br> <div dojoType="dijit.form.Button">click</div></div>
        <div dojoType="dijit.TitlePane" open="false" title="Pane 3"><p>Lorem<</p><p>lorem</p>/div>
        <div dojoType="dijit.TitlePane" open="false" title="Pane 4"><p>Lorem</p></div>    
    </div>


See Also:
=========

* `dijit.TitlePane <dijit/TitlePane>`_
* `dijit.layout.AccordionContainer <dijit/layout/AccordionContainer>`_
* `The original blog and motivation <http://www.sitepen.com/blog/2008/10/21/quick-fixes-and-dojo-support/>`_
