## page was renamed from 1.2/dijit/layout/BorderContainer
#format dojo_rst

dijit.layout.BorderContainer
============================

:Status: Contributed, Draft
:Version: 1.0

This widget is a container partitioned into up to five regions: left (or leading), right (or trailing), top, and bottom with a mandatory center to fill in any remaining space. Each edge region may have an optional splitter user interface for manual resizing. Note that there can be at most one child marked for each region.

Sizes are specified for the edge regions in pixels or percentage using CSS -- height to top and bottom, width for the sides. You might specify a top region of height:100px and a left region of width:50%. The center typically does not have any dimensions specified in CSS and resizes automatically to fill the remaining space.

BorderContainer operates in a choice of two layout modes: the design attribute may be set to "headline" (by default) or "sidebar". With the "headline" layout, the top and bottom sections extend the entire width of the box and the remaining regions are placed in the middle. With the "sidebar" layout, the side panels take priority, extending the full height of the box.

Examples
--------

.. cv-compound::

  Lets specify a simple BorderContainer with a left and center region

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.layout.ContentPane");
      dojo.require("dijit.layout.BorderContainer");
    </script>

  The markup has to look as follows
  
  .. cv:: html
    :label: A dijit button
    
    <div style="position: relative; width: 100%; height: 400px; border: 1px #ccc solid;">
      <div dojoType="dijit.layout.BorderContainer" design="sidebar" gutters="true" liveSplitters="true" id="borderContainer">
        <div dojoType="dijit.layout.ContentPane" splitter="true" region="leading" style="width: 100px;">Hi</div>
        <div dojoType="dijit.layout.ContentPane" splitter="true" region="center">Hi, I'm center</div>
      </div>
    </div>

  .. cv:: css
    :label: A simple set of css rules

    <style type="text/css">
      #borderContainer {
        width: 100%;
        height: 100%;
      }
    </style>

Lets take a look at a more advanced example of using BorderContainer and other layout widgets.
This example uses two BorderContainers to allow to, left and right content areas. 
Note the tabStrip attribute on the TabContainer.

.. cv-compound::

  .. cv:: javascript
    :label: The dojo requires

    <script type="text/javascript">
      dojo.require("dijit.layout.ContentPane");
      dojo.require("dijit.layout.BorderContainer");
      dojo.require("dijit.layout.TabContainer");
      dojo.require("dijit.layout.AccordionContainer");
    </script>

  The markup has to look as follows
  
  .. cv:: html
    :label: The markup

    <div style="position: relative; width: 100%; height: 400px; border: 1px #ccc solid;">
    <div dojoType="dijit.layout.BorderContainer" gutters="true" id="borderContainerTwo" >
      <div dojoType="dijit.layout.ContentPane" region="top" splitter="false">
        Hi, usually here you would have important information, maybe your company logo, or functions you need to access all the time..  
      </div>	
      <div dojoType="dijit.layout.BorderContainer" liveSplitters="false" design="sidebar" region="center" id="mainSplit">
        <div dojoType="dijit.layout.AccordionContainer" minSize="20" style="width: 300px;" id="leftAccordion" region="leading" splitter="true">
          <div dojoType="dijit.layout.AccordionPane" title="One fancy Pane">
          </div>
          <div dojoType="dijit.layout.AccordionPane" title="Another one">
          </div>
          <div dojoType="dijit.layout.AccordionPane" title="Even more fancy" selected="true">
          </div>
          <div dojoType="dijit.layout.AccordionPane" title="Last, but not least">
          </div>
        </div><!-- end AccordionContainer -->
        <div dojoType="dijit.layout.TabContainer" region="center" tabStrip="true">
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
    </div>
    </div>

  .. cv:: css
    :label: A few simple css rules

    <style type="text/css">
      #borderContainerTwo {
        width: 100%;
        height: 100%;
      }
    </style>

TODO: Open questions
====================
from #dojo: 

* Is it safe to allow the region="top" to determine it's own size?
  Seems to work but when the content is updated the layout overlaps.
  Should the top, left, etc regions always explicitly set their size?

* like the comment above, what are the special CSS size and position constraints on the content panes for the various regions?  Are there any specific CSS properties (or restrictions on properties) that need to be set on the parent node that the BorderContainer is added to, so that it appears properly?
