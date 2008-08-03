## page was renamed from 1.2/dijit/layout/TabContainer
#format dojo_rst

dijit.layout.TabContainer
=========================

:Status: Contributed, Draft
:Version: 1.0

A TabContainer is a container that has multiple panes, but shows only one pane at a time. There are a set of tabs corresponding to each pane, where each tab has the title (aka label) of the pane, and optionally a close button.

Basic Examples
--------------

First, We'll demonstrate a programatic TabContainer creation from existing markup:

.. cv-compound::
 
  As a simple example, we'll use `dojo.query <dojo/query>`_ to find and create the ContentPanes used in the TabContainer

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.layout.TabContainer");
    dojo.require("dijit.layout.ContentPane");
    dojo.addOnLoad(function(){
        dojo.query(".tc1cp").forEach(function(n){
            new dijit.layout.ContentPane({
                title: dojo.attr(n,"title") 
            }, n);
        });
        var tc = new dijit.layout.TabContainer({
            style: dojo.attr("tc1-prog", "style") 
        },"tc1-prog");
        tc.startup(); 
    });
    </script>

  The html is very simple

  .. cv:: html

    <div id="tc1-prog" style="width: 100%; height: 100px;">
      <div class="tc1cp" title="My first tab">
        Lorem ipsum and all around...
      </div>
      <div class="tc1cp" title="My second tab">
        Lorem ipsum and all around - second...
      </div>
      <div class="tc1cp" title="My last tab">
        Lorem ipsum and all around - last...
      </div>
    </div>


The `parser <dojo/parser>`_ does a lot of the heavy lifting seen above in the programatic method, finding attributes on the node and passing them to the Widget being created. By using a dojoType to identify these nodes, our initial creation is very easy, as seen in the remainder of these examples: 

.. cv-compound::

  This is a plain TabContainer with three tabs and fixed height. The third tab is closable

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.layout.TabContainer");
    dojo.require("dijit.layout.ContentPane");
    </script>

  The html is very simple

  .. cv:: html

    <div dojoType="dijit.layout.TabContainer" style="width: 100%; height: 100px;">
      <div dojoType="dijit.layout.ContentPane" title="My first tab" selected="true">
        Lorem ipsum and all around...
      </div>
      <div dojoType="dijit.layout.ContentPane" title="My second tab">
        Lorem ipsum and all around - second...
      </div>
      <div dojoType="dijit.layout.ContentPane" title="My last tab" closable="true">
        Lorem ipsum and all around - last...
      </div>
    </div>

This is a plain TabContainer with three tabs and flexible height using the doLayout="false" attribute. The second tab is closable.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.layout.TabContainer");
    dojo.require("dijit.layout.ContentPane");
    </script>

  The html is very simple

  .. cv :: html
    
    <!-- this div is only for documentation purpose, in real development environments, just take it out -->
    <div style="height: 100px;">

      <div dojoType="dijit.layout.TabContainer" style="width: 100%;" doLayout="false">
        <div dojoType="dijit.layout.ContentPane" title="My first tab" selected="true">
          Lorem ipsum and all around...
        </div>
        <div dojoType="dijit.layout.ContentPane" title="My second tab" closable="true">
          Lorem ipsum and all around - second...
          <br />
          Hmmm expanding tabs......
        </div>
        <div dojoType="dijit.layout.ContentPane" title="My last tab">
          Lorem ipsum and all around - last...
          <br />
          <br />
          <br />
          Hmmm even more expanding tabs......
        </div>
      </div>

    <!-- end of the div -->
    </div>

This is a plain TabContainer with three tabs, fixed height and a tab strip. The tabstrip is especially useful when the TabContainer is child of a BorderContainer.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.layout.TabContainer");
    dojo.require("dijit.layout.ContentPane");
    </script>

  The html is very simple

  .. cv :: html

    <div dojoType="dijit.layout.TabContainer" style="width: 100%; height: 100px;" tabStrip="true">
      <div dojoType="dijit.layout.ContentPane" title="My first tab" selected="true">
        Lorem ipsum and all around...
      </div>
      <div dojoType="dijit.layout.ContentPane" title="My second tab">
        Lorem ipsum and all around - second...
      </div>
      <div dojoType="dijit.layout.ContentPane" title="My last tab">
        Lorem ipsum and all around - last...
      </div>
    </div>

The doLayout attribute currently only works for top tabs, left/bottom/right tabs don't support it. You can set a tab strip on every tab type though. Following a few examples with left/bottom/right tabs using tabStrip here and there.

There are several more examples of basic use cases `available <-examples>`_ 

Tabs at the right, no strip 

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.layout.TabContainer");
    dojo.require("dijit.layout.ContentPane");
    </script>

  notice the tabPosition attribute

  .. cv :: html

    <div dojoType="dijit.layout.TabContainer" style="width: 100%; height: 100px;" tabPosition="right-h">
      <div dojoType="dijit.layout.ContentPane" title="My first tab" selected="true">
        Lorem ipsum and all around...
      </div>
      <div dojoType="dijit.layout.ContentPane" title="My second tab">
        Lorem ipsum and all around - second...
      </div>
      <div dojoType="dijit.layout.ContentPane" title="My last tab">
        Lorem ipsum and all around - last...
      </div>
    </div>

Tabs at the left, with a strip 

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.layout.TabContainer");
    dojo.require("dijit.layout.ContentPane");
    </script>

  notice the tabPosition attribute

  .. cv :: html

    <div dojoType="dijit.layout.TabContainer" style="width: 100%; height: 100px;" tabPosition="left-h" tabStrip="true">
      <div dojoType="dijit.layout.ContentPane" title="My first tab" selected="true">
        Lorem ipsum and all around...
      </div>
      <div dojoType="dijit.layout.ContentPane" title="My second tab">
        Lorem ipsum and all around - second...
      </div>
      <div dojoType="dijit.layout.ContentPane" title="My last tab">
        Lorem ipsum and all around - last...
      </div>
    </div>

Tabs at the bottom,with a strip 

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.layout.TabContainer");
    dojo.require("dijit.layout.ContentPane");
    </script>

  notice the tabPosition attribute

  .. cv :: html

    <div dojoType="dijit.layout.TabContainer" style="width: 100%; height: 100px;" tabPosition="bottom" tabStrip="true">
      <div dojoType="dijit.layout.ContentPane" title="My first tab" selected="true">
        Lorem ipsum and all around...
      </div>
      <div dojoType="dijit.layout.ContentPane" title="My second tab">
        Lorem ipsum and all around - second...
      </div>
      <div dojoType="dijit.layout.ContentPane" title="My last tab">
        Lorem ipsum and all around - last...
      </div>
    </div>

One technique to allow validation, and still use the parser would be to simply decorate the node with a dojoType attribute (after onLoad) and parse the parent node. For ease, we'll store the class name for our inner widgets in a rel="" attribute.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.layout.TabContainer");
    dojo.require("dijit.layout.ContentPane");
    dojo.require("dojo.parser");
    dojo.addOnLoad(function(){
        dojo.query("div[rel]").forEach(function(n){
            var className = dojo.attr(n,"rel");
            // now set it
            dojo.attr(n, "dojoType", className);
        });
        dojo.parser.parse("progtabwrapper");
    });
    </script>


  .. cv :: html

    <div id="progtabwrapper">
    <div rel="dijit.layout.TabContainer" style="width: 100%; height: 100px;">
      <div rel="dijit.layout.ContentPane" title="My first tab">
        Lorem ipsum and all around...
      </div>
      <div rel="dijit.layout.ContentPane" title="My second tab">
        Lorem ipsum and all around - second...
      </div>
      <div rel="dijit.layout.ContentPane" title="My last tab">
        Lorem ipsum and all around - last...
      </div>
    </div>
    </div>

 
