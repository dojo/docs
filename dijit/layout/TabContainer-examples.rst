.. _dijit/layout/TabContainer-examples:

===============================================
dijit/layout/TabContainer - additional examples
===============================================

.. contents ::
    :depth: 2

Tab Strip
=========

This is a plain TabContainer with three tabs, fixed height and a tab strip.
The tabstrip is especially useful when the TabContainer is child of a BorderContainer.
The tabstrip is supported in the tundra, nihilo, and soria themes, but not the claro theme.

.. code-example ::
  :theme: tundra

  The HTML is very simple

  .. html ::

    <div data-dojo-type="dijit/layout/TabContainer" style="width: 400px; height: 100px;" tabStrip="true">
      <div data-dojo-type="dijit/layout/ContentPane" title="My first tab" selected="true">
        Lorem ipsum and all around...
      </div>
      <div data-dojo-type="dijit/layout/ContentPane" title="My second tab">
        Lorem ipsum and all around - second...
      </div>
      <div data-dojo-type="dijit/layout/ContentPane" title="My last tab">
        Lorem ipsum and all around - last...
      </div>
    </div>

The doLayout attribute currently only works for top tabs, left/bottom/right tabs don't support it.
You can set a tab strip on every tab type though.
The following examples show left/bottom/right tabs, some using tabstrips.


Right Tabs
==========

Tabs at the right, no strip.
Note that right tabs don't work in conjunction with doLayout=false.

.. code-example ::

  notice the tabPosition attribute

  .. html ::

    <div data-dojo-type="dijit/layout/TabContainer" style="width: 400px; height: 100px;" tabPosition="right-h">
      <div data-dojo-type="dijit/layout/ContentPane" title="My first tab" selected="true">
        Lorem ipsum and all around...
      </div>
      <div data-dojo-type="dijit/layout/ContentPane" title="My second tab">
        Lorem ipsum and all around - second...
      </div>
      <div data-dojo-type="dijit/layout/ContentPane" title="My last tab">
        Lorem ipsum and all around - last...
      </div>
    </div>

Left Tabs
=========

Tabs at the left, with a strip.
Note that left tabs don't work in conjunction with doLayout=false.

.. code-example ::

  notice the tabPosition attribute

  .. html ::

    <div data-dojo-type="dijit/layout/TabContainer" style="width: 400px; height: 100px;" tabPosition="left-h" tabStrip="true">
      <div data-dojo-type="dijit/layout/ContentPane" title="My first tab" selected="true">
        Lorem ipsum and all around...
      </div>
      <div data-dojo-type="dijit/layout/ContentPane" title="My second tab">
        Lorem ipsum and all around - second...
      </div>
      <div data-dojo-type="dijit/layout/ContentPane" title="My last tab">
        Lorem ipsum and all around - last...
      </div>
    </div>

Bottom Tabs
===========

Tabs at the bottom, with a strip.
Note that bottom tabs don't work in conjunction with doLayout=false.

.. code-example ::

  notice the tabPosition attribute

  .. html ::

    <div data-dojo-type="dijit/layout/TabContainer" style="width: 400px; height: 100px;" tabPosition="bottom" tabStrip="true">
      <div data-dojo-type="dijit/layout/ContentPane" title="My first tab" selected="true">
        Lorem ipsum and all around...
      </div>
      <div data-dojo-type="dijit/layout/ContentPane" title="My second tab">
        Lorem ipsum and all around - second...
      </div>
      <div data-dojo-type="dijit/layout/ContentPane" title="My last tab">
        Lorem ipsum and all around - last...
      </div>
    </div>


Programmatic Example
====================

Here's an example that parses existing DOM and creates tabs,
similar to what the parser does:

.. code-example ::

  As a simple example, we'll use :ref:`dojo/query <dojo/query>` to find and create the ContentPanes used in the TabContainer

  .. js ::

    require([
        "dojo/dom-attr", "dojo/query",
        "dijit/layout/TabContainer", "dijit/layout/ContentPane",
        "dojo/domReady!"
    ], function(attr, query, TabContainer, ContentPane){

        query(".tc1cp").forEach(function(n){
            new ContentPane({
                // just pass a title: attribute, this, we're stealing from the node
                title: attr.get(n, "title")
            }, n);
        });
        var tc = new TabContainer({
            style: attr.get("tc1-prog", "style")
        }, "tc1-prog");
        tc.startup();
    });

  The HTML is very simple

  .. html ::

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
===========

Often sites will have two levels of tabs.
This is supported by using two TabContainer widgets.
Remember that although a TabContainer's children are often ContentPanes, they can be any layout widget, including another TabContainer:

.. code-example ::

  The HTML is very simple

  .. html ::

    <div data-dojo-type="dijit/layout/TabContainer" style="width: 400px; height: 100px;">
      <div data-dojo-type="dijit/layout/TabContainer" title="Tab 1" nested="true">
        <div data-dojo-type="dijit/layout/ContentPane" title="My first inner tab" selected="true">
          Lorem ipsum and all around...
        </div>
        <div data-dojo-type="dijit/layout/ContentPane" title="My second inner tab">
          Lorem ipsum and all around - second...
        </div>
        <div data-dojo-type="dijit/layout/ContentPane" title="My last inner tab">
          Lorem ipsum and all around - last...
        </div>
      </div>
      <div data-dojo-type="dijit/layout/TabContainer" title="Tab 2" nested="true">
        <div data-dojo-type="dijit/layout/ContentPane" title="My first inner tab" selected="true">
          Lorem ipsum and all around...
        </div>
        <div data-dojo-type="dijit/layout/ContentPane" title="My second inner tab">
          Lorem ipsum and all around - second...
        </div>
        <div data-dojo-type="dijit/layout/ContentPane" title="My last inner tab">
          Lorem ipsum and all around - last...
        </div>
      </div>
    </div>

When you have nested tabs you should set the nested parameter to true, to make the formatting distinctive from the outer TabContainer.

Programmatic Nested tabs
========================

This an example of nested tabs created programmatically.
If there is no nested tab in a tab, content pane is inserted instead.

.. code-example ::

  .. js ::

    require([
        "dojo/_base/array",
        "dijit/layout/TabContainer", "dijit/layout/ContentPane",
        "dojo/domReady!"
    ], function(array, TabContainer, ContentPane){

        var tabs = [{
            title: 'Tab 1',
            sub: [{
                title: 'My 1st inner',
                content: 'Lorem ipsum dolor sit amet'
            }, {
                title: 'My 2nd inner',
                content: 'Consectetur adipiscing elit'
            }]
        }, {
            title: 'Tab 2',
            sub: [{
                title: 'My 3rd inner',
                content: 'Vivamus orci massa rhoncus a lacinia'
            }, {
                title: 'My 4th inner',
                content: 'Fusce sed orci magna, vitae aliquet quam'
            }]
        }, {
            title: 'Tab 3',
            sub: []
        }];
        var tabContainer = new TabContainer({
            doLayout: false
        }, 'tabContainer');
        array.forEach(tabs, function(tab){
            if(!tab.sub.length){
                var cp = new ContentPane({
                    title: tab.title,
                    content: 'No sub tabs'
                });
                tabContainer.addChild(cp);
                return;
            }
            var subTab = new TabContainer({
                title: tab.title,
                doLayout: false,
                nested: true
            });
            array.forEach(tab.sub, function(sub){
                var cp = new ContentPane({
                    title: sub.title,
                    content: sub.content
                });
                subTab.addChild(cp);
            });
            tabContainer.addChild(subTab);
        });
        // _Container widgets will call startup on their children already
        tabContainer.startup();
    });

  .. html ::

    <div id='tabContainer'> </div>
