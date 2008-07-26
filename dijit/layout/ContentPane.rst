#format dojo_rst

dijit.layout.ContentPane
========================

A Content Pane is the most basic layout tile. Conceptually, it's like the content boxes in portals like MyYahoo. A content pane resembles an iframe, but contains extra design features, fits in with the current theme, and renders widgets properly.

You can use content panes by themselves, but usually you will place content panes inside of a layout container. For example, in a tabbed layout, content pane tags surround each tab of information. 

Examples
--------

.. cv-compound::

  .. cv:: javascript

    <script type="text/jscript">
    dojo.require("dijit.layout.ContentPane");
    </script>

  .. cv:: html

    <div dojoType="dijit.layout.ContentPane">
      Hi, pretty boring huh?
    </div>
