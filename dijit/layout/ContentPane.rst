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

Accessibility
-------------

The developer is responsible for determining if the ContentPane should be in the tab order of the page or not. If the ContentPane is not likely to have a focusable item within the contents, the developer may want to add tabindex=""0" onto the ContentPane element. This will put the ContentPane into the tab order so if someone is using the tab key to navigate through the elements on the page, the ContentPane itself will get focus. Having focus go to the ContentPane itself can be helpful for users of assistive technology to be able to navigate to an area that may not have any focusable elements within it such as a preview pane for mail messages or a page footer containing important information.
