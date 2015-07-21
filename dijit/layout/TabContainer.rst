.. _dijit/layout/TabContainer:

=========================
dijit/layout/TabContainer
=========================

:Authors: Becky Gibson, Peter Higgins, Bill Keese, Nikolai Onken, Marcus Reimann
:Developers: ?-
:since: V?
:jsDoc: http://dojotoolkit.org/api/dijit/layout/TabContainer

.. contents ::
    :depth: 2

A TabContainer is a container that has multiple panes, but shows only one pane at a time.
There are a set of tabs corresponding to each pane, where each tab has the title (aka label) of the pane, and optionally a close button.


Usage
=====

You can use tabs in your own application and style them as you want, but they also fit perfectly into the dijit.layout system.


Examples
========

Programmatic example
--------------------

First, we'll demonstrate a programmatic TabContainer creation.
Note that the tabs all have a fixed height.

.. code-example::
  :type: inline
  :toolbar: versions, themes, dir
  :width: 400
 
  .. js ::

    require(["dijit/layout/TabContainer", "dijit/layout/ContentPane", "dojo/domReady!"], function(TabContainer, ContentPane){
        var tc = new TabContainer({
            style: "height: 100%; width: 100%;"
        }, "tc1-prog");

        var cp1 = new ContentPane({
             title: "Food",
             content: "We offer amazing food"
        });
        tc.addChild(cp1);

        var cp2 = new ContentPane({
             title: "Drinks",
             content: "We are known for our drinks."
        });
        tc.addChild(cp2);

        tc.startup();
    });

  The HTML is very simple:

  .. html ::

    <div style="width: 350px; height: 290px">
        <div id="tc1-prog"></div>
    </div>


Declarative example
-------------------

Here are some markup examples:

.. code-example::
  :type: dialog
  :toolbar: versions, themes, dir
  :djConfig: parseOnLoad: true

  This is a plain TabContainer with three tabs and fixed height. The third tab is closable

  .. js ::

    require(["dojo/parser", "dijit/layout/TabContainer", "dijit/layout/ContentPane"]);

  The HTML is very simple

  .. html ::

    <div style="width: 350px; height: 300px">
        <div data-dojo-type="dijit/layout/TabContainer" style="width: 100%; height: 100%;">
            <div data-dojo-type="dijit/layout/ContentPane" title="My first tab" data-dojo-props="selected:true">
                Lorem ipsum and all around...
            </div>
            <div data-dojo-type="dijit/layout/ContentPane" title="My second tab">
                Lorem ipsum and all around - second...
            </div>
            <div data-dojo-type="dijit/layout/ContentPane" title="My last tab" data-dojo-props="closable:true">
                Lorem ipsum and all around - last...
            </div>
        </div>
    </div>


A TabContainer with flexible height
-----------------------------------

This is a plain TabContainer with three tabs and flexible height using the doLayout="false" attribute.
The second tab is closable.

.. code-example::
  :type: dialog
  :toolbar: versions, themes, dir
  :djConfig: parseOnLoad: true

  .. js ::

    require(["dojo/parser", "dijit/layout/TabContainer", "dijit/layout/ContentPane"]);

  The HTML is very simple

  .. html ::
    
    <!-- this div is only for documentation purpose, in real development environments, just take it out -->
    <div style="height: 105px;">
        <div data-dojo-type="dijit/layout/TabContainer" style="width: 100%;" doLayout="false">
            <div data-dojo-type="dijit/layout/ContentPane" title="My first tab" data-dojo-props="selected:true">
                Lorem ipsum and all around...
            </div>
            <div data-dojo-type="dijit/layout/ContentPane" title="My second tab" data-dojo-props="closable:true">
                Lorem ipsum and all around - second...<br />
                Hmmm expanding tabs......
            </div>
            <div data-dojo-type="dijit/layout/ContentPane" title="My last tab">
                Lorem ipsum and all around - last...<br />
                <br />
                <br />
                Hmmm even more expanding tabs......
            </div>
        </div>
    </div>


Selecting another Tab
---------------------

Normally, TabContainer will show the first Tab.
But it's also possible to automatically open another Tab with giving one of the ContentPanes the argument selected:
true (if programmatically created) or the attribute selected="true" (if declaratively created).

.. code-example::
  :type: dialog
  :toolbar: versions, themes, dir
 
  .. js ::

    require(["dijit/layout/TabContainer", "dijit/layout/ContentPane", "dojo/domReady!"], function(TabContainer, ContentPane){
        var tc = new TabContainer({
            style: "height: 100%; width: 100%;"
        }, "tc1-prog");

        var cp1 = new ContentPane({
            title: "First Tab",
            content: "We offer amazing food"
        });
        tc.addChild(cp1);

        var cp2 = new ContentPane({
            title: "Second Tab",
            content: "We are known for our drinks."
        });
        tc.addChild(cp2);

        var cp3 = new ContentPane({
            title: "Third Tab",
            content: "This Tab has the attribute 'selected: true' set.",
            selected: true
        });
        tc.addChild(cp3);

        tc.startup();
    });

  The HTML is very simple:

  .. html ::

    <div style="width: 350px; height: 300px">
        <div id="tc1-prog"></div>
    </div>


More examples
=============

There are several more examples of basic use cases :ref:`available <dijit/layout/TabContainer-examples>`

Like :ref:`dijit/layout/StackContainer <dijit/layout/StackContainer>`, TabContainer works by using a simple ``.addChild``, ``.removeChild``, and ``.selectChild`` API, all accepting a widget to be acted upon.

Manipulating Children
---------------------

.. js ::

  require(["dijit/registry", "dijit/layout/ContentPane"], function(registry, ContentPane){
      var tabs = registry.byId("myTabContainer");
      var pane = new ContentPane({ title:"Remote Content", href:"remote.html" });
      tabs.addChild(pane);
  });

A Tab doesn't get displayed unless you call ``.selectChild``

.. js ::

  require(["dijit/registry", "dijit/layout/ContentPane"], function(registry, ContentPane){
      var tabs = registry.byId("myTabContainer");
      var pane = new ContentPane({ title:"Remote Content", href:"remote.html" });
      tabs.addChild(pane);
      tabs.selectChild(pane);
  });

the ``addChild`` method accepts a position index, telling where in the order to add the new pane:

.. js ::

  require(["dijit/registry", "dijit/layout/ContentPane"], function(registry, ContentPane){
      var tabs = registry.byId("myTabContainer");
      var pane = new ContentPane({ title:"Remote Content", href:"remote.html" });
      tabs.addChild(pane, 1);
  });

This will add the new remote pane after the first pane (0).

Closing A Tab
-------------

A common action for ``closable`` tabs is to register an ``onClose`` function on the child, returning true or false to indicate whether or not the closing should take place:

.. code-example::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require(["dojo/parser", "dijit/layout/TabContainer", "dijit/layout/ContentPane", "dojo/domReady!"],
            function(parser, TabContainer, ContentPane){

        parser.parse();

        var closablePane = new ContentPane({
            title:"Close Me",
            closable: true,
            onClose: function(){
               // confirm() returns true or false, so return that.
               return confirm("Do you really want to Close this?");
            }
        });

        onCloseEx.addChild(closablePane);
    });

  You can, of course, attach the onClose function directly on a pane as well:

  .. html ::
    
    <div style="height: 100px;">
        <div data-dojo-id="onCloseEx" data-dojo-type="dijit/layout/TabContainer" style="width: 100%;" doLayout="false">
            <div data-dojo-type="dijit/layout/ContentPane" title="My first tab" data-dojo-props="selected:true">
                Lorem ipsum and all around...
            </div>
            <div data-dojo-type="dijit/layout/ContentPane" title="Other Closable" data-dojo-props="closable:true, onClose:function(){return confirm('really?');}">
                ... I have an in-line onClose
            </div>
        </div>
    </div>


Disabling Tabs
--------------
You can disable tabs by setting the disabled property of the pane:

.. js ::

    pane.set("disabled", true);

Disabling a pane disables the tab button for that pane.
However, it doesn't disable the pane from being programatically selected.
Also, the results of disabling the currently selected pane are undefined.


.. code-example::

  .. html ::

    <div data-dojo-type="dijit/layout/TabContainer" style="width: width: 350px; height: 200px">
        <div data-dojo-type="dijit/layout/ContentPane" title="My first tab" data-dojo-props="selected:true">
            Lorem ipsum and all around...
        </div>
        <div data-dojo-type="dijit/layout/ContentPane" id="second" title="My second tab">
            Lorem ipsum and all around - second...
        </div>
        <div data-dojo-type="dijit/layout/ContentPane" title="My last tab" data-dojo-props="closable:true">
            Lorem ipsum and all around - last...
        </div>
    </div>

    <script type="dojo/require">
        registry: "dijit/registry"
    </script>
    <button type=button onclick="registry.byId('second').set('disabled', !registry.byId('second').get('disabled'));">
        toggle tab #2 disabled
    </button>


TabContainer Events
-------------------

To monitor when a pane is selected (and the previous pane is deselected), the preferred method is to use watch():

.. js ::

   myTabContainer.watch("selectedChildWidget", function(name, oval, nval){
       console.log("selected child changed from ", oval, " to ", nval);
   });

To monitor when children are added/deleted, use dojo/aspect or dojo.connect:

.. js ::

  require(["dijit/registry"], function(registry){
      // assuming the same id="bar" TabContainer
      var tabs = registry.byId("bar");
  
      dojo.connect(tabs, "addChild", function(child){
          console.log("just added: ", child);
      });
  });


It is worth noting: if you need a function to be called *absolutely every* time a child is added to a TabContainer
(or StackContainer), you need to listen to the :ref:`setupChild` function
to ensure you are notified of the children already existing in markup.
This is only relevant if you are subclassing, for example:

.. js ::

  require(["dojo/_base/declare", "dijit/layout/TabContainer"], function(declare, TabContainer){
      declare("my.TabContainer", TabContainer, {
          _setupChild: function(child){
               this.inherited(arguments);
               console.log("I've seen: ", child);
          }
      });
  });
  
This is because ``addChild`` will not be called for the initial panes, specified in markup.


Accessibility
=============

Keyboard
--------

==========================================    =================================================
Action                                        Key
==========================================    =================================================
Navigate to next tab button                   Right arrow
Navigate to previous tab button               Left arrow
Navigate to first tab button                  Home
Navigate to last tab button                   End
Navigate into page                            Tab
Navigate to next page                         Ctrl + page down, ctrl + tab (FF and IE6 only)
Navigate to previous page                     Ctrl + page up, ctrl + shift + tab (FF and IE6 only)
Delete a tab                                  With focus on the tab title of the tab to delete, press Delete or ctrl + w. Note that the tab must have been created with deletion enabled via the closable attribute. For 1.1 and later releases, pressing shift-F10 with focus on the tab title or right mouse clicking on the tab title will bring up a context menu with the option to Close the tab. This provides a mechanism to determine if the tab is closable.
==========================================    =================================================
