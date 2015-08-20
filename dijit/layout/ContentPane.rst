.. _dijit/layout/ContentPane:

========================
dijit/layout/ContentPane
========================

:Authors: Becky Gibson, Bill Keese, Nikolai Onken
:Developers: ?-
:since: V?

.. contents ::
    :depth: 2

A Content Pane is the most basic layout tile.
Conceptually, it's like the content boxes in portals like MyYahoo.
A content pane resembles an iframe, but contains extra design features, fits in with the current theme, and renders widgets properly.

Usage
=====

You can use content panes by themselves, but usually you will place content panes inside of a layout container.
For example, in a tabbed layout, content pane tags surround each tab of information.

Href
----

One big use for ContentPanes is to load content dynamically through an href (see the href parameter).
However, note that the href must access data on the same domain since it's served via XHR.
To change the content of the content pane without performing an Ajax load, the content attribute can be set to the new HTML values.

ContentPane acts as a base class for a number of widgets (such as :ref:`Dialog <dijit/Dialog>`).
These documents apply in most cases to all widgets that inherit this code.
For instance, Dialog's href="" attributes is identical to ContentPane.

Loading Message
---------------

The loading message that's displayed while content is being fetched can be changed by changing the loadingMessage attribute of the ContentPane.
The default value of the loadingMessage attribute is "<span class='dijitContentPaneLoading'>${loadingState}</span>",
so you can change the look of the message by applying CSS to the .dijitContentPaneLoading class.
 

Callbacks
---------
When content is loaded through href, a number of callbacks are available which can be configured.
These are executed at different phases of the loading of the content:

onDownloadStart
  Called before the download of the content begins.

onDownloadEnd
  Called when the content has completed loading.

onDownloadError(error)
  Called if there was an error with the download.

An example of using a callback might be as follows:

.. js ::

  var myCp= registry.byId("myContentPane");
  myCp.set("onDownloadEnd", function(){
      console.log("Download complete!");
  });
  myCp.set("href", "myHtml.html");


Examples
========

Declarative example
-------------------

.. code-example ::
  :djConfig: async: true, parseOnLoad: true

  .. js ::

    require(["dojo/parser", "dijit/layout/ContentPane"]);

  .. html ::

    <div data-dojo-type="dijit/layout/ContentPane">
        Hi, pretty boring huh?
    </div>


Programmatic example
--------------------

.. code-example ::
  
  Create a ContentPane from an existing DIV, and replace it's content:

  .. js ::

    require(["dijit/layout/ContentPane", "dojo/domReady!"], function(ContentPane){
        var cp = new ContentPane({
          content:"<p>Optionally set new content now</p>",
          style:"height:125px"
        }, "targetID");
        cp.startup();
    });

  .. html ::

    <div id="targetID">
        I get replaced.
    </div>


.. code-example ::

   Create an entirely new ContentPane from no DOM, and place inside another node (specified by id):

  .. js ::

    require(["dijit/layout/ContentPane"], function(ContentPane){
        var cp = new ContentPane({
          content:"<p>I am initial content</p>",
          style:"height:125px"
        })
        cp.placeAt("targetID2");
        cp.startup();
    });

  .. html ::

    <div id="targetID2">
        A contentPane will appear here:
    </div>

Executing JavaScript inside ContentPane
---------------------------------------

You can also execute scripts with dijit/layout/ContentPane in the content pane definition via dojo/method:

.. html ::

    <div id="foo" data-dojo-type="dijit/layout/ContentPane" href="/some/page.html">
        <script type="dojo/method">
            alert ('Hello World!');
        </script>
    </div>

For extended script execution there is an extension of ContentPane ``dojox/layout/ContentPane`` which provides script
execution, among other things.

Accessibility
=============

The developer is responsible for determining if the ContentPane should be in the tab order of the page or not.
If the ContentPane is not likely to have a focusable item within the contents, the developer may want to add tabindex="0" onto the ContentPane element.
This will put the ContentPane into the tab order so if someone is using the tab key to navigate through the elements on the page, the ContentPane itself will get focus.
Having focus go to the ContentPane itself can be helpful for users of assistive technology to be able to navigate to an area that may not have any focusable elements within it such as a preview pane for mail messages or a page footer containing important information.

See also
========

* :ref:`dojox/layout/ContentPane <dojox/layout/ContentPane>` - extension of dijit/layout/ContentPane
