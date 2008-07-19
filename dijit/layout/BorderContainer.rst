#format dojo_rst

dijit.layout.BorderContainer
============================

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
    
    <div style="position: absolute; width: 100%; height: 400px; border: 1px #ccc solid;">
      <div dojoType="dijit.layout.BorderContainer" design="sidebar" gutters="true" liveSplitters="true" id="borderContainer">
        <div dojoType="dijit.layout.ContentPane" splitter="true" region="leading" style="width: 100px;">Hi</div>
        <div dojoType="dijit.layout.ContentPane" splitter="true" region="center">Hi</div>
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
