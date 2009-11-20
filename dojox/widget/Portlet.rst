#format dojo_rst

dojox.widget.Portlet
====================

:Status: Draft
:Version: 1.0
:Project owner: Shane O'Sullivan
:Available: since 1.3.2

.. contents::
   :depth: 2

The dojox.widget.Portlet is an enhanced version of the dijit.TitlePane widget, designed to be used in the dojox.layout.GridContainer.


============
Introduction
============

The Portlet widget adds enhanced features to the dijit.TitlePane widget. It adds the ability to close (remove) the widget from a GridContainer, and also to have configurable settings.

The settings types included are
 * dojox.widget.PortletSettings
   The base settings widget. Places the settings at the top of the Portlet, which slide into view when the settings icon is pressed.
 * dojox.widget.PortletDialogSettings
   Displays the settings is a pop up modal dialog.
 * dojox.widget.PortletFeedSettings
   The settings widget to be used with the dojox.widget.FeedPortlet.  It can be a simple text input displaying the URL to an Atom or RSS feed, or a select node displaying multiple feeds to load.

It is worth noting that this widget just implements one possible front end of a Portlet.  The
`JSR-168 standard <http://jcp.org/aboutJava/communityprocess/review/jsr168>`_ for Portlets contains a lot more than this.  A full Portlet implementation requires both server side and client side code.  This widget only serves to present the Portlet on the client side.

=====
Usage
=====

.. code-block :: javascript
 :linenos:

 <div dojoType="dojox.widget.Portlet" title="My Flickr">

   <div dojoType="dojox.widget.PortletSettings">
     <div dojoType="dojox.layout.TableContainer" cols="1">
       <div dojoType="dijit.form.TextBox" title="Option 3"></div>
       <div dojoType="dijit.form.TextBox" title="Option 4"></div>
     </div>
   </div>

   <div>
     The Contents of the portlet go here  
   </div>
 </div>




========
Examples
========

Basic Portlet
--------------------

This example shows a very simplistic Portlet, with just a simple PortletSettings widget and text content.

.. code-example::
  :version: 1.3.2-2.0

  Load the Portlet JavaScript.

  .. javascript::

    <script type="text/javascript">

      dojo.require("dijit.dijit");
      dojo.require("dojox.widget.Portlet");
    </script>

  .. html::
   
      <div dojoType="dojox.widget.Portlet" title="A Simple Portlet">
	<div dojoType="dojox.widget.PortletSettings">
          This is a simple settings widget.
          Put whatever you like in here       
	</div>

	<div style="height: 100px;">
	  The contents of the portlet go in here.
          Try clicking the settings icon in the title bar to see the settings. 
            
	</div>
    </div>

  .. css::

    <style type="text/css">
      @import "{{ baseUrl }}dojox/widget/Portlet/Portlet.css"
    </style>

Basic Feed Portlet
------------------

This example shows a FeedPortlet with a single URL.  A FeedPortlet is an extension of Portlet, and can be used to load an 
'Atom <http://en.wikipedia.org/wiki/Atom_(standard)>'_ or 'RSS <http://en.wikipedia.org/wiki/RSS>'_ feed and display it as a list.
The FeedPortlet displays the titles of the feed items, and shows the contents of each item, or story, in a tooltip when the mouse hovers over it.

.. code-example::
  :version: 1.3.2-2.0

  Load the Portlet JavaScript.

  .. javascript::

    <script type="text/javascript">

      dojo.require("dijit.dijit");
      dojo.require("dojox.widget.Portlet");
      dojo.require("dojox.widget.FeedPortlet");
    </script>

  .. html::
   
      <div dojoType="dojox.widget.FeedPortlet" title="Todays News" 
	id="todaysNews"
	url="http://news.google.com/news?hl=en&topic=t&output=atom"
	maxResults="5"
	>
	<div dojoType="dojox.widget.PortletFeedSettings"></div>

	<div>
	This is a FeedPortlet with a single feed.
	Click the settings icon in the title bar to enter a
	different feed to load.  Hovering over a news item shows a summary
	of it in a tooltip.
	</div>
      </div>

  .. css::

    <style type="text/css">
      @import "{{ baseUrl }}dojox/widget/Portlet/Portlet.css"
    </style>


Expandable Feed Portlet With Multiple URLs
------------------------------------------

An ExpandableFeedPortlet is an extenstion of FeedPortlet.  Like FeedPortlet it can load an Atom or RSS feed from a URL, however it displays the feed items in a list with an icons placed to the left of each item.  When an icon is clicked, the content of the item, or story, is shown.  This is different from the FeedPortlet, which displays the content in a tooltip.

This example also shows the dojox.widget.PortletFeedSettings widget being used with multiple URLs.  If the PortletFeedSettings is created as a SELECT node, it will display multiple URLs to the user, along with labels which are more readable than URLs.

.. code-example::
  :version: 1.3.2-2.0

  Load the Portlet JavaScript.

  .. javascript::

    <script type="text/javascript">

      dojo.require("dijit.dijit");
      dojo.require("dojox.widget.Portlet");
      dojo.require("dojox.widget.FeedPortlet");
    </script>

  .. html::
   
      <div dojoType="dojox.widget.ExpandableFeedPortlet" title="Dojo News" 
	id="todaysNews"
	maxResults="5"
	>
	<select dojoType="dojox.widget.PortletFeedSettings">
          <option value="http://shaneosullivan.wordpress.com/category/dojo/feed/">Dojo Blatherings</option>
          <option value="http://www.dojotoolkit.org/aggregator/rss">Planet Dojo</option>
          <option value="http://feeds2.feedburner.com/ajaxian">Ajaxian</option>
        </select>

	<div>
	This is a FeedPortlet with a multiple feeds.
	Click the settings icon in the title bar to choose a
	different feed to load.
	</div>
      </div>

  .. css::

    <style type="text/css">
      @import "{{ baseUrl }}dojox/widget/Portlet/Portlet.css"
    </style>

Portlets In A Grid Container
----------------------------
This examples shows Portlets as they are intended to be used, inside a dojox.layout.GridContainer.  It shows three Portlets, all of which can be dragged around the page.

.. code-example::
  :version: 1.3.2-2.0

  Load the Portlet and GridContainer JavaScript.

  .. javascript::

    <script type="text/javascript">

      dojo.require("dijit.dijit");
      dojo.require("dojox.widget.Portlet");
      dojo.require("dojox.widget.FeedPortlet");
      dojo.require("dojox.layout.GridContainer");
      dojo.require("dojox.widget.Calendar");
    </script>

  Include the CSS for the Portlet, the GridContainer, and the Calendar widgets.

  .. css::

    <style type="text/css">
      @import "{{ baseUrl }}dojox/widget/Portlet/Portlet.css";
      @import "{{ baseUrl }}dojox/layout/resources/GridContainer.css";
      @import "{{ baseUrl }}dojox/widget/Calendar/Calendar.css";

      .dndDropIndicator {
        border: 2px dashed #99BBE8;
        cursor:default;
        margin-bottom:5px;
      }
    </style>

  This example includes three Portlets in a GridContainer.  The GridContainer lays out the widgets in a grid enables dragging them around.
  The GridContainer in this example has two columns, set using the 'nbZones' attribute.  This example also shows the Calendar Portlet containing another Dojo widget, the dojox.widget.Calendar.

  .. html::
   
    <div dojoType="dojox.layout.GridContainer"
	id="gc1"
	acceptTypes="dojox.widget.Portlet, dojox.widget.FeedPortlet,dojox.widget.ExpandableFeedPortlet"
	hasResizableColumns="false"
	opacity="0.3"
	nbZones="2"
	allowAutoScroll="true" 
	withHandles="true"
	handleClasses="dijitTitlePaneTitle"
	region="center"
	minChildWidth="200"
	minColWidth="40">

        <div dojoType="dojox.widget.Portlet" title="First Portlet">

          <div dojoType="dojox.widget.PortletSettings">
            Put whatever settings you like in here
          </div>
          <div>
             Drag me around by clicking on my title bar
          </div>
        </div>


        <div dojoType="dojox.widget.ExpandableFeedPortlet" title="Dojo News" 
          id="todaysNews"
          maxResults="5">
          <select dojoType="dojox.widget.PortletFeedSettings">
            <option value="http://shaneosullivan.wordpress.com/category/dojo/feed/">Dojo Blatherings</option>
            <option value="http://www.dojotoolkit.org/aggregator/rss">Planet Dojo</option>
            <option value="http://feeds2.feedburner.com/ajaxian">Ajaxian</option>
          </select>

	  <div>
	    This is a FeedPortlet with a multiple feeds.
            Click the settings icon in the title bar to choose different feed to load.
          </div>
        </div>
      
        
        <div dojoType="dojox.widget.Portlet" title="Calendar Portlet">
          <div dojoType="dojox.widget.PortletSettings">
            Put whatever settings you like in here
          </div>
          <div>
             Drag me around by clicking on my title bar.
          </div>
          <div dojoType="dojox.widget.Calendar">
            <script type="dojo/connect" event="onValueSelected" args="date">
              dojo.byId("dateGoesHere").innerHTML = "Date Selected: " + date.toString();
            </script>
          </div>
          <div id="dateGoesHere">

          </div>
        </div>

      </div>



========
See also
========

* `dojox.layout.GridContainer <dojox/layout/GridContainer>`_
