.. _dojox/atom/widget/FeedEntryEditor:

=================================
dojox.atom.widget.FeedEntryEditor
=================================

The FeedEntryEditor sample extends the FeedEntryViewer sample to show how to RESTfully edit individual entries in an Atom feed.

.. contents ::
  :depth: 2

.. api-inline :: dojox.atom.widget.FeedEntryEditor

============================
Example with FeedEntryEditor
============================

The following example shows how to connect the sample FeedViewer to the sample FeedEntryEditor. When a user clicks an entry, its contents are displayed in the FeedEntryEditor.

.. code-example ::
  .. css ::

    	@import "{{baseUrl}}dojox/atom/widget/templates/css/EntryHeader.css";
	@import "{{baseUrl}}dojox/atom/widget/templates/css/HtmlFeedViewer.css";
	@import "{{baseUrl}}dojox/atom/widget/templates/css/HtmlFeedViewerGrouping.css";
	@import "{{baseUrl}}dojox/atom/widget/templates/css/HtmlFeedViewerEntry.css";
	@import "{{baseUrl}}dojox/atom/widget/templates/css/HtmlFeedEntryViewer.css";
  .. js ::

     dojo.require("dojox.atom.widget.FeedViewer");
     dojo.require("dojox.atom.widget.FeedEntryEditor");

  .. html ::

      <div> 
		<div dojoType="dojox.atom.widget.FeedViewer" 
			 widgetId="fv1"
			 url="{{baseUrl}}dojox/atom/tests/widget/samplefeedEdit.xml"
			 entrySelectionTopic="atomfeed/entry/topic">
		</div>
      </div>
	
	<div dojoType="dojox.atom.widget.FeedEntryEditor" 
		 widgetId="feedEditor"
		 enableMenu="true"
		 enableMenuFade="true"
		 enableEdit="true"
		 displayEntrySections="title,authors,summary"
		 entrySelectionTopic="atomfeed/entry/topic">
	</div>


When the user clicks an editable entry, the options to edit and delete it will appear in the editor. The FeedEntryEditor gives a sample UI for editing individual Atom entries. The Editor will attempt to update the feed RESTfully.