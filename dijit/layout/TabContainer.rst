#format dojo_rst

dijit.layout.TabContainer
=========================

A TabContainer is a container that has multiple panes, but shows only one pane at a time. There are a set of tabs corresponding to each pane, where each tab has the title (aka label) of the pane, and optionally a close button.

Examples
--------

.. cv-compund::

  This is a plain TabContaienr with three tabs

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.layout.TabContainer");
    dojo.require("dijit.layout.ContentPane");
    </script>

  The html ir very simple

  .. cv :: html

    <div dojoType="dijit.layout.TabContainer">
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
