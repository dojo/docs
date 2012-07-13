.. _dojox/atom/widget/FeedViewer:

============================
dojox.atom.widget.FeedViewer
============================

The FeedViewer actually defines several sample dojox.atom widgets that show how to display data from an Atom feed.

.. contents ::
  :depth: 2

======================
Example - in isolation
======================

The following example shows how to create a FeedViewer:

.. code-example ::
  .. css ::

    	@import "{{baseUrl}}dojox/atom/widget/templates/css/EntryHeader.css";
	@import "{{baseUrl}}dojox/atom/widget/templates/css/HtmlFeedViewer.css";
	@import "{{baseUrl}}dojox/atom/widget/templates/css/HtmlFeedViewerGrouping.css";
	@import "{{baseUrl}}dojox/atom/widget/templates/css/HtmlFeedViewerEntry.css";
	@import "{{baseUrl}}dojox/atom/widget/templates/css/HtmlFeedEntryViewer.css";
  .. js ::

     dojo.require("dojox.atom.widget.FeedViewer");

  .. html ::

      <div> 
		<div dojoType="dojox.atom.widget.FeedViewer" 
			 widgetId="fv1"
			 url="{{baseUrl}}dojox/atom/tests/widget/samplefeed.xml"
			 entrySelectionTopic="atomfeed/entry/topic">
		</div>
      </div>  

As the example shows, the FeedViewer sample in isolation can retrieve and display entries from the feed, but it does not display the contents of the entries. Instead, when a user clicks an entry, the FeedViewer publishes the event to the topic specified in entrySelectionTopic: in this case, atomfeed/entry/topic. It is up to the developer to subscribe to the topic in a meaningful way. The FeedEntryViewer gives an example.