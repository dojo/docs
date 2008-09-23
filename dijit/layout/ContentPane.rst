## page was renamed from 1.2/dijit/layout/ContentPane
#format dojo_rst

dijit.layout.ContentPane
========================

:Status: Contributed, Draft
:Version: 1.0

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

Href
----
One big use for ContentPanes is to load content dynamically through an href (see the href parameter).
However, note that the href must access data on the same domain since it's served via XHR.
