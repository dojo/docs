#format dojo_rst

More TabContainer Examples
==========================

:Status: Draft
:Version: 1.2


Tab Strip
---------
This is a plain TabContainer with three tabs, fixed height and a tab strip. The tabstrip is especially useful when the TabContainer is child of a BorderContainer.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.layout.TabContainer");
    dojo.require("dijit.layout.ContentPane");
    </script>

  The html is very simple

  .. cv :: html

    <div dojoType="dijit.layout.TabContainer" style="width: 400px; height: 100px;" tabStrip="true">
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


Right Tabs
----------
Tabs at the right, no strip 

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.layout.TabContainer");
    dojo.require("dijit.layout.ContentPane");
    </script>

  notice the tabPosition attribute

  .. cv :: html

    <div dojoType="dijit.layout.TabContainer" style="width: 400px; height: 100px;" tabPosition="right-h">
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

Left Tabs
---------
Tabs at the left, with a strip.   Note that left, right, and bottom tabs don't work in conjunction with doLayout=false.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.layout.TabContainer");
    dojo.require("dijit.layout.ContentPane");
    </script>

  notice the tabPosition attribute

  .. cv :: html

    <div dojoType="dijit.layout.TabContainer" style="width: 400px; height: 100px;" tabPosition="left-h" tabStrip="true">
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

Bottom Tabs
-----------
Tabs at the bottom,with a strip.   Note that left, right, and bottom tabs don't work in conjunction with doLayout=false.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.layout.TabContainer");
    dojo.require("dijit.layout.ContentPane");
    </script>

  notice the tabPosition attribute

  .. cv :: html

    <div dojoType="dijit.layout.TabContainer" style="width: 400px; height: 100px;" tabPosition="bottom" tabStrip="true">
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
    <div rel="dijit.layout.TabContainer" style="width: 400px; height: 100px;">
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

Programmatic Example
--------------------
Here's an example that parses existing DOM and creates tabs,
similar to what the parser does:

.. cv-compound::
 
  As a simple example, we'll use `dojo.query <dojo/query>`_ to find and create the ContentPanes used in the TabContainer

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.layout.TabContainer");
    dojo.require("dijit.layout.ContentPane");
    dojo.addOnLoad(function(){
        dojo.query(".tc1cp").forEach(function(n){
            new dijit.layout.ContentPane({
                // just pass a title: attribute, this, we're stealing from the node
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

    <div id="tc1-prog" style="width: 400px; height: 100px;">
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

Nested tabs
-----------
Often sites will have two levels of tabs.  This is supported by using two TabContainer widgets.   Remember that although a TabContainer's children are often ContentPanes, they can be any layout widget, including another TabContainer:

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.layout.TabContainer");
    dojo.require("dijit.layout.ContentPane");
    </script>

  The html is very simple

  .. cv :: html

    <div dojoType="dijit.layout.TabContainer" style="width: 400px; height: 100px;">
      <div dojoType="dijit.layout.TabContainer" title="Tab 1" nested="true">
        <div dojoType="dijit.layout.ContentPane" title="My first inner tab" selected="true">
          Lorem ipsum and all around...
        </div>
        <div dojoType="dijit.layout.ContentPane" title="My second inner tab">
          Lorem ipsum and all around - second...
        </div>
        <div dojoType="dijit.layout.ContentPane" title="My last inner tab">
          Lorem ipsum and all around - last...
        </div>
      </div>
      <div dojoType="dijit.layout.TabContainer" title="Tab 2" nested="true">
        <div dojoType="dijit.layout.ContentPane" title="My first inner tab" selected="true">
          Lorem ipsum and all around...
        </div>
        <div dojoType="dijit.layout.ContentPane" title="My second inner tab">
          Lorem ipsum and all around - second...
        </div>
        <div dojoType="dijit.layout.ContentPane" title="My last inner tab">
          Lorem ipsum and all around - last...
        </div>
      </div>
    </div>

When you have nested tabs you should set the nested parameter to true, to make the formatting distinctive from the outer TabContainer.
