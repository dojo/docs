#format dojo_rst

dojox.widget.TitleGroup
=======================

:since: 1.6.0
:author: dante

A container widget which delegates a connection between children `TitlePanes <dijit/TitlePane>`_. Behaves similarly to an `AccordionContainer <dijit/layout/AccordionContainer>`_ though has a variable overall height and does not "dock" to other layout widgets, such as a `BorderContainer <dijit/layout/BorderContainer>`_. 

Examples
========

A simple declarative example:

.. code-example::
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
        setTimeout(function(){ dojo.parser.parse(); }, 200);
    </script>

  .. html::

    <h2>Content before</h2>
    <div id="titleGroup" dojoType="dojox.widget.TitleGroup">
        <div dojoType="dijit.TitlePane" open="true" title="Pane 1">Lorem</div>
        <div dojoType="dijit.TitlePane" open="false" title="Pane 2">Lorem <br> <div dojoType="dijit.form.Button">click</div></div>
        <div dojoType="dijit.TitlePane" open="false" title="Pane 3"><p>Lorem</p><p>lorem</p></div>
        <div dojoType="dijit.TitlePane" open="false" title="Pane 4"><p>Lorem</p></div>    
    </div>
    <h2>Content after</h2>

Adding and removing children:


.. code-example::
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
        setTimeout(function(){ dojo.parser.parse(); }, 200);
    </script>

  .. html::

    <h2>Content before</h2>
    <div dojoType="dijit.form.Button">
       click to add
       <script type="dojo/method" event="onClick">
            var group = dijit.byId("titleGroup);
            var tp = new dijit.TitlePane({ opan:false, title: "Added " + dijit.registry.length });
            group.addChild(tp);
       </script>
    </div>
    <div dojoType="dijit.form.Button">
        pop one off
        <script type="dojo/method" event="onClick">
            var pane = dijit.registry.byClass("dijit.TitlePane")[0]; 
            dijit.byId("titleGroup").removeChild(pane);
            pane.placeAt("graveyard");
        </script>
    </div>
    <div id="titleGroup" style="width:300px" dojoType="dojox.widget.TitleGroup">
        <div dojoType="dijit.TitlePane" open="true" title="Pane 1">
            Pane 1
        </div>
    </div>
    <h2>Content after</h2>
    <div id="graveyard"></div>


See Also:
=========

* `dijit.TitlePane <dijit/TitlePane>`_
* `dijit.layout.AccordionContainer <dijit/layout/AccordionContainer>`_
* `The original blog and motivation <http://www.sitepen.com/blog/2008/10/21/quick-fixes-and-dojo-support/>`_
