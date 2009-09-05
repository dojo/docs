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

=====
Usage
=====

TODO: how to use the component/class/method

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


.. code-example::
  :version: 1.3.2-2.0

  Load the Portlet and GridContainer JavaScript.

  .. javascript::

    <script type="text/javascript">

      dojo.require("dijit.dijit");
      dojo.require("dojox.widget.Portlet");
      dojo.require("dojox.widget.FeedPortlet");
      dojo.require("dojox.layout.GridContainer");
    </script>


  .. css::

    <style type="text/css">
      @import "{{ baseUrl }}dojox/widget/Portlet/Portlet.css";
      @import "{{ baseUrl }}dojox/layout/resources/GridContainer.css";

      .dndDropIndicator {
        border: 2px dashed #99BBE8;
        cursor:default;
        margin-bottom:5px;
      }
    </style>

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

* TODO: links to other related articles
