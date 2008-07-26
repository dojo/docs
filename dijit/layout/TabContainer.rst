#format dojo_rst

dijit.layout.TabContainer
=========================

A TabContainer is a container that has multiple panes, but shows only one pane at a time. There are a set of tabs corresponding to each pane, where each tab has the title (aka label) of the pane, and optionally a close button.

Examples
--------

.. cv-compound::

  This is a plain TabContainer with three tabs and fixed height

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.layout.TabContainer");
    dojo.require("dijit.layout.ContentPane");
    </script>

  The html is very simple

  .. cv :: html

    <div dojoType="dijit.layout.TabContainer" style="width: 100%; height: 100px;">
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

.. cv-compound::

  This is a plain TabContainer with three tabs and flexible height using the doLayout="false" attribute

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.layout.TabContainer");
    dojo.require("dijit.layout.ContentPane");
    </script>

  The html is very simple

  .. cv :: html

    <div dojoType="dijit.layout.TabContainer" style="width: 100%;" doLayout="false">
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

.. cv-compound::

  This is a plain TabContainer with three tabs, fixed height and a tab strip. The tabstrip is especially useful when the TabContainer is child of a BorderContainer.

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
