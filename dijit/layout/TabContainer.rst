## page was renamed from 1.2/dijit/layout/TabContainer
#format dojo_rst

dijit.layout.TabContainer
=========================

:Authors: Becky Gibson, Peter Higgins, Bill Keese, Nikolai Onken, Marcus Reimann
:Developers: ?-
:Available: since V?
:jsDoc: http://api.dojotoolkit.org/jsdoc/HEAD/dijit.layout.TabContainer

.. contents::
    :depth: 2

A TabContainer is a container that has multiple panes, but shows only one pane at a time. There are a set of tabs corresponding to each pane, where each tab has the title (aka label) of the pane, and optionally a close button.


=====
Usage
=====

You can use tabs in your own application and style them as you want, but they also fit perfectly into the dijit.layout system. 


========
Examples
========

Programmatic example
--------------------

First, we'll demonstrate a programatic TabContainer creation.
Note that the tabs all have a fixed height.

.. code-example::
  :type: inline
  :toolbar: versions, themes, dir
 
  .. javascript::

    <script type="text/javascript">
    dojo.require("dijit.layout.TabContainer");
    dojo.require("dijit.layout.ContentPane");
    dojo.addOnLoad(function(){
        var tc = new dijit.layout.TabContainer({
            style: "height: 100%; width: 100%;"
        },"tc1-prog");
  
        var cp1 = new dijit.layout.ContentPane({
             title: "Food",
             content: "We offer amazing food"
        });
        tc.addChild(cp1);
  
        var cp2 = new dijit.layout.ContentPane({
             title: "Drinks",
             content: "We are known for our drinks."
        });
        tc.addChild(cp2);
  
        tc.startup(); 
    });
    </script>

  The html is very simple

  .. html::

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

  .. javascript::

    <script type="text/javascript">
    dojo.require("dijit.layout.TabContainer");
    dojo.require("dijit.layout.ContentPane");
    </script>

  The html is very simple

  .. html::

    <div style="width: 350px; height: 300px">
        <div dojoType="dijit.layout.TabContainer" style="width: 100%; height: 100%;">
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
    </div>


A TabContainer with flexible height
-----------------------------------

This is a plain TabContainer with three tabs and flexible height using the doLayout="false" attribute. The second tab is closable.

.. code-example::
  :type: dialog
  :toolbar: versions, themes, dir
  :djConfig: parseOnLoad: true

  .. javascript::

    <script type="text/javascript">
    dojo.require("dijit.layout.TabContainer");
    dojo.require("dijit.layout.ContentPane");
    </script>

  The html is very simple

  .. html::
    
    <!-- this div is only for documentation purpose, in real development environments, just take it out -->
    <div style="height: 105px;">

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


Selecting another Tab
---------------------

Normally, TabContainer will show the first Tab. But it's also possible to automatically open another Tab with giving one of the ContentPanes the argument selected: true (if programmatically created) or the attribute selected="true" (if declaratively created).

.. code-example::
  :type: dialog
  :toolbar: versions, themes, dir
 
  .. javascript::

    <script type="text/javascript">
    dojo.require("dijit.layout.TabContainer");
    dojo.require("dijit.layout.ContentPane");
    dojo.addOnLoad(function(){
        var tc = new dijit.layout.TabContainer({
            style: "height: 100%; width: 100%;"
        },"tc1-prog");
  
        var cp1 = new dijit.layout.ContentPane({
             title: "First Tab",
             content: "We offer amazing food"
        });
        tc.addChild(cp1);
  
        var cp2 = new dijit.layout.ContentPane({
             title: "Second Tab",
             content: "We are known for our drinks."
        });
        tc.addChild(cp2);

        var cp3 = new dijit.layout.ContentPane({
             title: "Third Tab",
             content: "This Tab has the attribute 'selected: true' set.",
             selected: true
        });
        tc.addChild(cp3);

  
        tc.startup(); 
    });
    </script>

  The html is very simple

  .. html::

    <div style="width: 350px; height: 300px">
        <div id="tc1-prog"></div>
    </div>


=============
More examples
=============

There are several more examples of basic use cases `available <dijit/layout/TabContainer-examples>`_ 

Like `dijit.layout.StackContainer <dijit/layout/StackContainer>`_, TabContainer works by using a simple ``.addChild``, ``.removeChild``, and ``.selectChild`` API, all accepting a widget to be acted upon. 

Manipulating Children
---------------------

.. code-block :: javascript 
  :linenos:

  var tabs = dijit.byId("myTabContainer");
  var pane = new dijit.layout.ContentPane({ title:"Remote Content", href:"remote.html" });
  tabs.addChild(pane);

A Tab doesn't get displayed unless you call ``.selectChild``

.. code-block :: javascript 
  :linenos:

  var tabs = dijit.byId("myTabContainer");
  var pane = new dijit.layout.ContentPane({ title:"Remote Content", href:"remote.html" });
  tabs.addChild(pane);
  tabs.selectChild(pane);

the ``addChild`` method accepts a position index, telling where in the order to add the new pane:

.. code-block :: javascript 
  :linenos:

  var tabs = dijit.byId("myTabContainer");
  var pane = new dijit.layout.ContentPane({ title:"Remote Content", href:"remote.html" });
  tabs.addChild(pane,1);

This will add the new remote pane after the first pane (0).

Closing A Tab 
-------------

A common action for ``closable`` tabs is to register an ``onClose`` function on the child, returning true or false to indicate whether or not the closing should take place:

.. code-example::

  .. javascript::

    <script type="text/javascript">
    dojo.require("dijit.layout.TabContainer");
    dojo.require("dijit.layout.ContentPane");
    dojo.addOnLoad(function(){
        var tabs = dijit.byId("onClose-ex");
        var closablePane = new dijit.layout.ContentPane({
            title:"Close Me",
            closable: true, 
            onClose: function(){
               // confirm() returns true or false, so return that.
               return confirm("Do you really want to Close this?");
            }
        });
        tabs.addChild(closablePane);
    });
    </script>

  You can, of course, attach the onClose function directly on a pane as well:

  .. html::
    
    <div style="height: 100px;">

      <div id="onClose-ex" dojoType="dijit.layout.TabContainer" style="width: 100%;" doLayout="false">
        <div dojoType="dijit.layout.ContentPane" title="My first tab" selected="true">
          Lorem ipsum and all around...
        </div>
        <div dojoType="dijit.layout.ContentPane" title="Other Closable" closable="true" onClose="return confirm('really?');">
            ... I have an in-line onClose
        </div>
      </div>

    </div>


TabContainer Events
-------------------

There are two methods of observing TabContainer *shenanigans*. The first, by using `dojo.subscribe <dojo/subscribe>`_. Each TabContainer `publishes <dojo/publish>`_ notices based on the *id* of the Container. Several different actions are tracked this way:

.. code-block :: javascript
  :linenos:

  // assuming our tabContainer has id="bar"
  dojo.subscribe("bar-selectChild", function(child){ 
      console.log("A new child was selected:", child); 
  });

  dojo.subscribe("bar-addChild", function(child){
      console.log("A child was added:", child);
  });

  dojo.subscribe("bar-removeChild", function(child){
      console.log("Child is gone: ", child); // but not destroyed!
  });

the -selectChild subscription will not execute if the selected child is already the visible Pane. It will only publish when a *different* child is selected. Notice how this differs from our other method of wiring up TabContainer events, via `dojo.connect <dojo/connect>`_:

.. code-block :: javascript
  :linenos:

  // assuming the same id="bar" TabContainer
  var tabs = dijit.byId("bar");
  
  dojo.connect(tabs,"selectChild",function(child){ 
      console.log("called anytime selectChild is");
  });
  dojo.connect(tabs,"addChild",function(child){
      console.log("just added: ", child);
  });


This simply uses dojo.connect to listen to the native function calls. 

A common request for ``selectChild`` functionality is to know both the *new* and *old* widgets being transitioned. The easiest way to accomplish this is connect to the "private" ``_transition`` method of a TabContainer:

.. code-block :: javascript
  :linenos:

  var tabs = dijit.byId("tabs");
  dojo.connect(tabs,"_transition", function(newPage, oldPage){ 
      console.log("I was showing: ", oldPage || "nothing");
      console.log("I am now showing: ", newPage);
  });

It is worth noting: If you need a function to be called *absolutely every* time a child is added to a TabContainer (or StackContainer), you need to listen to the ``_setupChild`` function to ensure you are notified of the children already existing in markup. This is only relevant if you are subclassing for reason:

.. code-block :: javascript
  :linenos:
 
  dojo.declare("my.TabContainer", dijit.layout.TabContainer, {
      _setupChild: function(child){ 
           this.inherited(arguments);
           console.log("I've seen: ", child);
      }
  });
  
This is because ``addChild`` will not be called for existing panes (in markup).


=============
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
