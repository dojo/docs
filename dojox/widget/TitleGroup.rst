.. _dojox/widget/TitleGroup:

=======================
dojox.widget.TitleGroup
=======================

:since: 1.6.0

.. contents ::
    :depth: 2

A container widget which delegates a connection between children :ref:`TitlePanes <dijit/TitlePane>`. Behaves similarly to an :ref:`AccordionContainer <dijit/layout/AccordionContainer>` though has a variable overall height and does not "dock" to other layout widgets, such as a :ref:`BorderContainer <dijit/layout/BorderContainer>`.

Examples
========

A simple declarative example
----------------------------

.. code-example::

  .. css ::

        @import "{{baseUrl}}dojox/widget/TitleGroup/TitleGroup.css";

  .. js ::

        dojo.require("dojox.widget.TitleGroup");
        dojo.require("dijit.TitlePane");
        dojo.require("dijit.form.Button");

  .. html ::

    <h2>Content before</h2>
    <div id="titleGroupA" data-dojo-type="dojox.widget.TitleGroup">
        <div data-dojo-type="dijit.TitlePane" open="true" title="Pane 1">Lorem</div>
        <div data-dojo-type="dijit.TitlePane" open="false" title="Pane 2">Lorem <br> <div data-dojo-type="dijit.form.Button">click</div></div>
        <div data-dojo-type="dijit.TitlePane" open="false" title="Pane 3"><p>Lorem</p><p>lorem</p></div>
        <div data-dojo-type="dijit.TitlePane" open="false" title="Pane 4"><p>Lorem</p></div>
    </div>
    <h2>Content after</h2>

Adding and removing children
----------------------------

.. code-example::

  .. css ::

        @import "{{baseUrl}}dojox/widget/TitleGroup/TitleGroup.css";

  .. js ::

        dojo.require("dojox.widget.TitleGroup");
        dojo.require("dijit.TitlePane");
        dojo.require("dijit.form.Button");

  .. html ::

    <h2>Content before</h2>
    <div data-dojo-type="dijit.form.Button">
       click to add
       <script type="dojo/method" data-dojo-event="onClick">
            var group = dijit.byId("titleGroupB");
            var tp = new dijit.TitlePane({ open:false, title: "Added " + dijit.registry.length });
            group.addChild(tp);
       </script>
    </div>
    <div data-dojo-type="dijit.form.Button">
        pop one off
        <script type="dojo/method" data-dojo-event="onClick">
            dijit.registry.byClass("dijit.TitlePane").some(function(widget){
                  dijit.byId("titleGroupB").removeChild(widget);
                  widget.destroy();
                  return true; // only once
            });
        </script>
    </div>
    <div id="titleGroupB" style="width:500px" data-dojo-type="dojox.widget.TitleGroup">
        <div data-dojo-type="dijit.TitlePane" open="true" title="Pane 1">
            Pane 1
        </div>
    </div>
    <h2>Content after</h2>
    <div id="graveyard"></div>

See Also
========

* :ref:`dijit.TitlePane <dijit/TitlePane>`
* :ref:`dijit.layout.AccordionContainer <dijit/layout/AccordionContainer>`
* `The original blog and motivation <http://www.sitepen.com/blog/2008/10/21/quick-fixes-and-dojo-support/>`_
