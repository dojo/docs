## page was renamed from 1.2/dijit/layout/ContentPane
#format dojo_rst

dijit.layout.ContentPane
========================

:Status: Draft
:Version: 1.0
:Authors: Becky Gibson, Bill Keese, Nikolai Onken
:Developers: ?-
:Available: since V?

.. contents::
    :depth: 2

A Content Pane is the most basic layout tile. Conceptually, it's like the content boxes in portals like MyYahoo. A content pane resembles an iframe, but contains extra design features, fits in with the current theme, and renders widgets properly.

=====
Usage
=====

You can use content panes by themselves, but usually you will place content panes inside of a layout container. For example, in a tabbed layout, content pane tags surround each tab of information. 

Href
----

One big use for ContentPanes is to load content dynamically through an href (see the href parameter).
However, note that the href must access data on the same domain since it's served via XHR.  To change the content of the content pane without performing an Ajax load, the content attribute can be set to the new HTML values.

ContentPane acts as a base class for a number of widgets (such as `Dialog <dijit/Dialog>`_). These documents apply in most cases to all widgets that inherit this code. For instance, Dialog's href="" attributes is identical to ContentPane.

Loading Message
---------------

The loading message that's displayed while content is being fetched can be changed by changing the loadingMessage attribute of the ContentPane.  The default value of the loadingMessage attribute is "<span class='dijitContentPaneLoading'>${loadingState}</span>" so, you can change the look of the message by applying css to the .dijitContentPaneLoading class. 
 

Callbacks
---------
When content is loaded through href, a number of callbacks are available which can be configured.  These are executed at different phases of the loading of the content:

onDownloadStart
  Called before the download of the content begins.

onDownloadEnd
  Called when the content has completed loading.

onDownloadError(error)
  Called if there was an error with the download.

An example of using a callback might be as follows:

.. code-block :: javascript

  var myCp= dijit.byId("myContentPane");
  myCp.attr("onDownloadEnd", function(){
    console.log("Download complete!");
  });
  myCp.attr("href", "myHtml.html");


========
Examples
========

Declarative example
-------------------

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.layout.ContentPane");
    </script>

  .. cv:: html

    <div dojoType="dijit.layout.ContentPane">
      Hi, pretty boring huh?
    </div>


Programmatic example
--------------------

.. cv-compound::
  
  Create a ContentPane from an existing DIV, and replace it's content:

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.layout.ContentPane");
      dojo.addOnLoad(function(){
          new dijit.layout.ContentPane({
              content:"<p>Optionally set new content now</p>",
              style:"height:125px"
          }, "targetID");
      });
    </script>

  .. cv:: html

    <div id="targetID">
      I get replaced.
    </div>


.. cv-compound::

   Create an entirely new ContentPane from no DOM, and place in Some node byID:

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.layout.ContentPane");
      dojo.addOnLoad(function(){
          new dijit.layout.ContentPane({
              content:"<p>I am initial content</p>",
              style:"height:125px"
          }).placeAt("targetIDtoo");
      });
    </script>

  .. cv:: html

    <div id="targetIDtoo">
      A contentPane will appear here:
    </div>


A content pane which loads the content remotely through href. 

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.layout.ContentPane");
      dojo.addOnLoad(function(){
          new dijit.layout.ContentPane({
              href:"http://docs.dojocampus.org/moin_static163/js/dojo/trunk/dijit/tests/layout/doc1.html",
              style:"height:125px",
			  onDownloadEnd: function(){
				console.log("Download complete!");}
          }).placeAt("cPane");
      });
    </script>

  .. cv:: html

    <div id="cPane">
      The contentPane loads the content remotely:
    </div>

=============
Accessibility
=============

The developer is responsible for determining if the ContentPane should be in the tab order of the page or not. If the ContentPane is not likely to have a focusable item within the contents, the developer may want to add tabindex=""0" onto the ContentPane element. This will put the ContentPane into the tab order so if someone is using the tab key to navigate through the elements on the page, the ContentPane itself will get focus. Having focus go to the ContentPane itself can be helpful for users of assistive technology to be able to navigate to an area that may not have any focusable elements within it such as a preview pane for mail messages or a page footer containing important information.
