.. _dojox/atom/widget/FeedEntryViewer:

=================================
dojox.atom.widget.FeedEntryViewer
=================================

The FeedEntryViewer defines a sample dojox.atom widget that shows how to display an individual entry from an Atom feed.

.. contents ::
  :depth: 2

.. api-inline :: dojox.atom.widget.FeedEntryViewer

=======================
Example with FeedViewer
=======================

The following example shows how to connect the sample FeedViewer to the sample FeedEntryViewer. When a user clicks an entry, its contents are displayed in the FeedEntryViewer:

.. code-example ::
  .. css ::

    	@import "{{baseUrl}}dojox/atom/widget/templates/css/EntryHeader.css";
	@import "{{baseUrl}}dojox/atom/widget/templates/css/HtmlFeedViewer.css";
	@import "{{baseUrl}}dojox/atom/widget/templates/css/HtmlFeedViewerGrouping.css";
	@import "{{baseUrl}}dojox/atom/widget/templates/css/HtmlFeedViewerEntry.css";
	@import "{{baseUrl}}dojox/atom/widget/templates/css/HtmlFeedEntryViewer.css";
  .. js ::

     dojo.require("dojox.atom.widget.FeedViewer");
     dojo.require("dojox.atom.widget.FeedEntryViewer");

  .. html ::

      <div> 
		<div dojoType="dojox.atom.widget.FeedViewer" 
			 widgetId="fv1"
			 url="{{baseUrl}}dojox/atom/tests/widget/samplefeed.xml"
			 entrySelectionTopic="atomfeed/entry/topic">
		</div>
      </div>
	
	<div dojoType="dojox.atom.widget.FeedEntryViewer" 
		 widgetId="feedEditor"
		 enableMenu="true"
		 enableMenuFade="true"
		 displayEntrySections="title,authors,summary"
		 entrySelectionTopic="atomfeed/entry/topic">
	</div>

As the example shows, the FeedViewer sample publishes to the atomfeed/entry/topic and the FeedEntryViewer subscribes to it. When a user clicks an entry, the subscribing FeedEntryViewer displays the published entry.