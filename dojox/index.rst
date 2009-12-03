#format dojo_rst

DojoX
=====

DojoX is an area for development of extensions to the Dojo toolkit. It is a repository for more stable and mature extensions and also acts as an incubator for experimental code, a testbed for additions to the main toolkit. Unlike Dojo and Dijit, DojoX is managed by subprojects, each of which has at least one module, a sponsor and a mission statement.


* `About DojoX <dojox/info>`_

These sections cover the available projects shipped with the Dojo Toolkit:

* `dojox.analytics <dojox/analytics>`_

  An analytic and client monitoring system

  * `dojox.analytics.Urchin <dojox/analytics/Urchin>`_

* `dojox.atom <dojox/atom>`_

  Implements the Atom Syndication Format and Atom Publishing Protocol

  * `dojox.atom.io.model <dojox/atom/io/model>`_

    A JavaScript model of an ATOM feed

  * `dojox.atom.io.Connection <dojox/atom/io/Connection>`_

    A IO class for performing APP (ATOM Publishing Protocol) styled IO actions with a server

* `dojox.av <dojox/av>`_

  Brings audio and video capabilities to the Open Web

  * `dojox.av.FLAudio <dojox/av/FLAudio>`_

    Provides the ability of implementing MP3 sounds into your dojo applications


  * `dojox.av.FLVideo <dojox/av/FLVideo>`_

    Provides the ability to play Flash movie files (FLVs) within the dojo environment


  * `dojox.av.widget <dojox/av/widget>`_

    Provides base player control widgets for building a media player

* `dojox.charting <dojox/charting>`_

  Amazing charting library

* `dojox.collections <dojox/collections>`_

  Offers methods to handle common collections, like ArrayLists or Dictionaries

* `dojox.color <dojox/color>`_

  Extends dojo.color/dojo.Color and adds advanced color model/matching functionality

  * `dojox.color.Palette <dojox/color/Palette>`_

    A color palette generator and handler (used extensively in `dojox.charting <dojox/charting>`_

* `dojox.cometd <dojox/cometd>`_

  A cometd client written in Dojo

* `dojox.data <dojox/data>`_

  Additional data stores and data store helpers

  * `dojox.data.AndOrReadStore <dojox/data/AndOrReadStore>`_

    A clone of `dojo.data.ItemFileReadStore <dojo/data/ItemFileReadStore>`__, which supports more complex queries than the simple AND format property matching

  * `dojox.data.AndOrWriteStore <dojox/data/AndOrWriteStore>`_

    A clone of `dojo.data.ItemFileWriteStore <dojo/data/ItemFileWriteStore>`__, which supports more complex queries than the simple AND format property matching

  * `dojox.data.AtomReadStore <dojox/data/AtomReadStore>`_

    A store designed to provide read-only access to Atom XML documents

  * `dojox.data.ClientFilter <dojox/data/ClientFilter>`_

    An abstract data store module for adding updateable result set functionality to an existing data store class

  * `dojox.data.CouchDBRestStore <dojox/data/CouchDBRestStore>`_

    A datastore for connecting to the open source document-oriented database Apache CouchDB

  * `dojox.data.CssClassStore <dojox/data/CssClassStore>`_

    A read interface based on the `dojox.data.CssRuleStore <dojox/data/CssRuleStore>`_

  * `dojox.data.CssRuleStore <dojox/data/CssRuleStore>`_

    A read interface to the CSS rules loaded in the current page

  * `dojox.data.CsvStore <dojox/data/CsvStore>`_

    A read interface that works with CSV formated data files

  * `dojox.data.FileStore <dojox/data/FileStore>`_

    A lightweight data store implementation for accessing details about a remote FileSystem

  * `dojox.data.FlickrRestStore <dojox/data/FlickrRestStore>`_

    Provides access to the Flickr photo sharing site's REST API

  * `dojox.data.FlickrStore <dojox/data/FlickrStore>`_

    A wrapper to the public photo feed of the Flickr service

  * `dojox.data.GoogleFeedStore <dojox/data/GoogleFeedStore>`_

    A Google AJAX API powered data store for retrieving RSS and Atom feeds from Google

  * `dojox.data.GoogleSearchStore <dojox/data/GoogleSearchStore>`_

    Several data stores to interface Google's AJAX search services:

    * `dojox.data.GoogleWebSearchStore <dojox/data/GoogleWebSearchStore>`_

      A data store for retrieving search results from Google

    * `dojox.data.GoogleBlogSearchStore <dojox/data/GoogleBlogSearchStore>`_

      A data store for retrieving search results from Google Blogs

    * `dojox.data.GoogleLocalSearchStore <dojox/data/GoogleLocalSearchStore>`_

      A data store for retrieving search results from Google Location Search

    * `dojox.data.GoogleVideoSearchStore <dojox/data/GoogleVideoSearchStore>`_

      A data store for retrieving search results from Google Video

    * `dojox.data.GoogleNewsSearchStore <dojox/data/GoogleNewsSearchStore>`_

      A data store for retrieving search results from Google News

    * `dojox.data.GoogleBookSearchStore <dojox/data/GoogleBookSearchStore>`_

      A data store for retrieving search results from Google Book

    * `dojox.data.GoogleImageSearchStore <dojox/data/GoogleImageSearchStore>`_

      A data store for retrieving search results from Google Image

  * `dojox.data.HtmlStore <dojox/data/HtmlStore>`_

    An enhanced replacement for `dojox.data.HtmlTableStore <dojox/data/HtmlTableStore>`_ to work with HTML tables, lists, and collections of DIV and SPAN tags.

  * `dojox.data.HtmlTableStore <dojox/data/HtmlTableStore>`_ (*deprecated*)

    A read interface to work with HTML tables

  * `dojox.data.jsonPathStore <dojox/data/jsonPathStore>`_

    A local (in memory) store which can attach a dojo.data interface to each javascript object and uses jsonPath as the query language

  * `dojox.data.JsonRestStore <dojox/data/JsonRestStore>`_

    A lightweight data store implementation of a RESTful client

  * `dojox.data.KeyValueStore <dojox/data/KeyValueStore>`_

    An interface for reading property style files (key/value pairs)

  * `dojox.data.OpmlStore <dojox/data/OpmlStore>`_

    A read-only store to work with Opml formatted XML files

  * `dojox.data.PersevereStore <dojox/data/PersevereStore>`_

    An extension of `dojox.data.JsonRestStore <dojox/data/JsonRestStore>`_ to handle Persevere's special features

  * `dojox.data.PicasaStore <dojox/data/PicasaStore>`_

    A data store interface to one of the basic services of the Picasa service, the public photo feed

  * `dojox.data.QueryReadStore <dojox/data/QueryReadStore>`_

    A read-only store, which makes a request to the server for each sorting or query in order to work with big datasets

  * `dojox.data.S3Store <dojox/data/S3Store>`_

    An extension of `dojox.data.JsonRestStore <dojox/data/JsonRestStore>`_ to handle Amazon's S3 service using JSON data

  * `dojox.data.ServiceStore <dojox/data/ServiceStore>`_

    ServiceStore and it's subclasses are a generalized dojo.data implementation for any webservice

  * `dojox.data.SnapLogicStore <dojox/data/SnapLogicStore>`_

    A data store interface to use the SnapLogic framework

  * `dojox.data.WikipediaStore <dojox/data/WikipediaStore>`_

    An extension of `dojox.data.ServiceStore <dojox/data/ServiceStore>`_ to use Wikipedia's search service

  * `dojox.data.XmlStore <dojox/data/XmlStore>`_

    A read and write interface to basic XML data

  * `dojox.data.dom <dojox/data/dom>`_

    A set of DOM manipulation functions

* `dojox.date <dojox/date>`_

  A collection of date-related enhancements and utilities, including national calendars.

  * `dojox.date.buddhist <dojox/date/buddhist>`_

    A date-like class representing the Thai buddhist calendar

  * `dojox.date.hebrew <dojox/date/hebrew>`_

    A date-like class representing the Hebrew calendar

* `dojox.dtl <dojox/dtl>`_

  Django Template Language implementation

* `dojox.editor <dojox/editor>`_

  Extensions for dijit.Editor

* `dojox.embed <dojox/embed>`_

  Base code for embedding external objects like Flash, Quicktime

* `dojox.encoding <dojox/encoding>`_

  All sorts of string encoding algorithms, including compression, crypto and more.

* `dojox.flash <dojox/flash>`_

  Utilities to embed and communicate with Flash-based objects

* `dojox.form <dojox/form>`_

  Additional form-related widgets beyond `dijit.form <dijit/form>`_ functionality

  * `dojox.form.BusyButton <dojox/form/BusyButton>`_

    A new Button with progresss indicator built in, for indicating processing after you press the button

  * `dojox.form.CheckedMultiSelect <dojox/form/CheckedMultiSelect>`_

    A multi-select widget (similar to html select with multiple=true) that uses check boxes

  * `dojox.form.DateTextBox <dojox/form/DateTextBox>`_

    description?

  * `dojox.form.DropDownSelect <dojox/form/DropDownSelect>`_

    A styleable drop down select box (similar to html select element)

  * `dojox.form.DropDownStack <dojox/form/DropDownStack>`_

    A widget for enabling/disabling parts of a form based on a selection

  * `dojox.form.FileInput <dojox/form/FileInput>`_ (covers base, Auto, and Blind)

    A series of experimental Vanilla input type="file" widgets for uploading files. See also `FileUploader <dojox/form/FileUploader>`_

  * `dojox.form.FilePickerTextBox <dojox/form/FilePickerTextBox>`_

    A dijit._FormWidget that adds a dojox.widget.FilePicker to a text box as a dropdown

  * `dojox.form.FileUploader <dojox/form/FileUploader>`_

    A new multi-file uploader that shows progress as the files are uploading

  * `dojox.form.manager <dojox/form/manager/index>`__

    A package to manage complex event-driven dynamic forms

  * `dojox.form.Manager (widget) <dojox/form/Manager>`_

    A widget that uses `dojox.form.manager <dojox/form/manager>`_ to handle dynamic forms

  * `dojox.form.MultiComboBox <dojox/form/MultiComboBox>`_

    description?

  * `dojox.form.PasswordValidator <dojox/form/PasswordValidator>`_

    A widget that simplifies the "Old/New/Verify" password construct used on many web pages

  * `dojox.form.RadioStack <dojox/form/RadioStack>`_

    A widget for enabling/disabling parts of a form based on a selection

  * `dojox.form.RangeSlider <dojox/form/RangeSlider>`_

    description?

  * `dojox.form.Rating <dojox/form/Rating>`_

    A widget that allows users to rate items

  * `dojox.form.TimeSpinner <dojox/form/TimeSpinner>`_

    description?

* `dojox.fx <dojox/fx>`_

  Extension animations to the core dojo FX project

  * `dojox.fx.crossFade <dojox/fx/crossFade>`_

    Crossfade two nodes easily

  * `dojox.fx.highlight <dojox/fx/highlight>`_

    Animates the background color of a node, and returns it to the color it was

  * `dojox.fx.sizeTo <dojox/fx/sizeTo>`_

    Size a node about it's center to a new width/height

  * `dojox.fx.slideBy <dojox/fx/slideBy>`_

    Slide a node by a t,l offset

  * `dojox.fx.style <dojox/fx/style>`_

    Module to provide CSS animations

  * `dojox.fx.scroll <dojox/fx/scroll>`_

    Module to provide scroll-related FX

  * `dojox.fx.wipeTo <dojox/fx/wipeTo>`_

* `dojox.gfx <dojox/gfx>`_

  Cross-browser vector graphics API

* `dojox.gfx3d <dojox/gfx3d>`_

  A 3d API for dojox.gfx

* `dojox.grid <dojox/grid>`_

  Dojo Toolkits Grid Widgets

  * `dojox.grid.DataGrid <dojox/grid/DataGrid>`_

    A visual grid/table much like a spreadsheet

  * `dojox.grid.EnhancedGrid <dojox/grid/EnhancedGrid>`_

    An enhanced version of the base grid, which extends it in numerous useful ways

  * `dojox.grid.TreeGrid <dojox/grid/TreeGrid>`_

    A grid with support for collapsable rows and model-based (`dijit.tree.ForestStoreModel <dijit/tree/ForestStoreModel>`_) structure

  * the old dojox.grid.Grid

    This old version is only available for compatible reasons

  * `Grid Plugin API <dojox/grid/pluginAPI>`_

* `dojox.help <dojox/help>`_
* `dojox.highlight <dojox/highlight>`_

  A client-side syntax highlighting engine

* `dojox.html <dojox/html>`_

  Additional HTML helper functions

  * `dojox.html.format <dojox/html/format>`_

    A package which offers additional HTML helper functions for formatting HTML text

  * `dojox.html.set <dojox/html/set>`_

    A generic content setter, including adding new stylesheets and evaluating scripts (was part of ContentPane loaders, now separated for generic usage)

  * `dojox.html.metrics <dojox/html/metrics>`_

    Translate CSS values to pixel values, calculate scrollbar sizes and font resizes

  * `dojox.html.styles <dojox/html/styles>`_

    Insert, remove and toggle CSS rules as well as search document for style sheets

* `dojox.image <dojox/image>`_

  A collection of image-related widgets

  * `dojox.image.Badge <dojox/image/Badge>`_

    Attach images or background images, and let them loop

  * `dojox.image.FlickrBadge <dojox/image/FlickrBadge>`_

    An extension on dojox.image.Badge, using Flickr as a data provider

  * `dojox.image.Gallery <dojox/image/Gallery>`_

    A combination of a SlideShow and ThumbnailPicker

  * `dojox.image.Lightbox <dojox/image/Lightbox>`_

    A widget which shows a single image (or groups of images) in a Dialog

  * `dojox.image.Magnifier <dojox/image/Magnifier>`_

    A dojox.gfx-based version of the `MagnifierLite <dojox/image/MagnifierLite>`_ widget

  * `dojox.image.MagnifierLite <dojox/image/MagnifierLite>`_

    A simple hover behavior for images, showing a zoomed version of a size image

  * `dojox.image.SlideShow <dojox/image/SlideShow>`_

    A slideshow of images

  * `dojox.image.ThumbnailPicker <dojox/image/ThumbnailPicker>`_

    A dojo.data-powered ThumbnailPicker

* `dojox.io <dojox/io>`_

  Extensions to the Core dojo.io transports

* `dojox.json <dojox/json>`_

  DojoX JSON Modules

  * `dojox.json.query <dojox/json/query>`_

    A comprehensive object data query tool

  * `dojox.json.schema <dojox/json/schema>`_

    An object validation tool based on JSON Schema

  * `dojox.json.ref <dojox/json/ref>`_

    JSON Referencing capable serializer and deserializer

* `dojox.jsonPath <dojox/jsonPath>`_

  A query system for JavaScript objects

* `dojox.lang <dojox/lang>`_

  Implementation of common functional operations, and provisions, aspect-oriented helpers

  * `dojox.lang.observable <dojox/lang/observable>`_

    Provides construction of objects that such that property access and modification can be controlled

  * `dojox.lang.typed <dojox/lang/typed>`_

    Provides type checking for JavaScript classes, enforcing types on properties and method parameters using JSON Schema definitions

  * `dojox.lang.docs <dojox/lang/docs>`_

    Provides schemas on Dojo's classes from the API documentation

  * `dojox.lang.functional <dojox/lang/functional>`_

    Functional language constructs, including currying and lambda

* `dojox.layout <dojox/layout>`_

  Experimental and additional extensions to `Dijit Layout <dijit/layout>`__ Widgets

  * `dojox.layout.ContentPane <dojox/layout/ContentPane>`_

    An extension to dijit.layout.ContentPane providing script execution, among other things

  * `dojox.layout.DragPane <dojox/layout/DragPane>`_

    Provides drag-based scrolling for divs with overflow

  * `dojox.layout.ExpandoPane <dojox/layout/ExpandoPane>`_

    A self-collapsing widget for use in a `BorderContainer <dijit/layout/BorderContainer>`__

  * `dojox.layout.FloatingPane <dojox/layout/FloatingPane>`_

    An experimental floating window

  * `dojox.layout.GridContainer <dojox/layout/GridContainer>`_

    A panel-like layout mechanism, allowing Drag and Drop between regions

  * `dojox.layout.RadioGroup <dojox/layout/RadioGroup>`_

    A variety of `StackContainer <dijit/layout/StackContainer>`__ enhancements providing animated transitions

  * `dojox.layout.ResizeHandle <dojox/layout/ResizeHandle>`_

    A small widget to provide resizing of a parent node

  * `dojox.layout.RotatorContainer <dojox/layout/RotatorContainer>`_

    An extended StackContainer suited for presentational purposes

  * `dojox.layout.ScrollPane <dojox/layout/ScrollPane>`_

    An interesting UI, scrolling an overflowed div based on mouse position, either vertical or horizontal

  * `dojox.layout.TableContainer <dojox/layout/TableContainer>`_

    A simple layout widget that lays out its child widgets using a Table element.

  * `dojox.layout.ToggleSplitter <dojox/layout/ToggleSplitter>`_

    A custom Splitter for use in a BorderContainer, providing a lightweight way to collapse the associated child

* `dojox.math <dojox/math>`_

  A collection of various advanced math functions

* `dojox.off <dojox/off>`_
* `dojox.presentation <dojox/presentation>`_
* `dojox.resources <dojox/resources>`_
* `dojox.robot <dojox/robot>`_
* `dojox.rpc <dojox/rpc>`_

  Extended classes to communicate via Remote Procedure Calls (RPC) with Backend Servers

  * `dojox.rpc.SMDLibrary <dojox/rpc/SMDLibrary>`_
  * `dojox.rpc.Client <dojox/rpc/Client>`_
  * `dojox.rpc.JsonRest <dojox/rpc/JsonRest>`_
  * `dojox.rpc.JsonRPC <dojox/rpc/JsonRPC>`_
  * `dojox.rpc.LocalStorageRest <dojox/rpc/LocalStorageRest>`_
  * `dojox.rpc.OfflineRest <dojox/rpc/OfflineRest>`_
  * `dojox.rpc.ProxiedPath <dojox/rpc/ProxiedPath>`_
  * `dojox.rpc.Rest <dojox/rpc/Rest>`_
  * `dojox.rpc.Service <dojox/rpc/Service>`_

    The foundation of most dojox.RPC transportation

* `dojox.secure <dojox/secure>`_
* `dojox.sketch <dojox/sketch>`_
* `dojox.sql <dojox/sql>`_

  objects to support Dojo Offline (dojox.off)  DEPRECATED

* `dojox.storage <dojox/storage>`_

  Objects for mass storage within the browser

* `dojox.string <dojox/string>`_

  A collection of various objects for advanced string manipulation, including a Builder and a tokenizer

* `dojox.testing <dojox/testing>`_
* `dojox.timing <dojox/timing>`_

  A set of objects to perform advanced time-based tasks, including a basic Timer

* `dojox.uuid <dojox/uuid>`_

  Universally Unique Identifier (UUID) implementations, including an implementation of UUID 2

* `dojox.validate <dojox/validate>`_

  Additional input validation methods

* `dojox.widget <dojox/widget>`_

  A collection of un-categorized widgets, or code not requiring its own package

  * `dojox.widget.AnalogGauge <dojox/widget/AnalogGauge>`_

    A circular gauge with a variety of indicators, used to display numerical data

  * `dojox.widget.BarGauge <dojox/widget/BarGauge>`_

    A horizontal bar gauge with a few indicators, used to display numerical data

  * `dojox.widget.Calendar <dojox/widget/Calendar>`_

    An extended dijit._Calendar

  * `dojox.widget.CalendarFx <dojox/widget/CalendarFx>`_

    An extended dijit._Calendar with FX

  * `dojox.widget.ColorPicker <dojox/widget/ColorPicker>`_

    A HSV Color Picker, similar to PhotoShop

  * `dojox.widget.Dialog <dojox/widget/Dialog>`_

    An extension to `dijit.Dialog </dijit/Dialog>`__ which provides additional sizing options, animations, and styling

  * `dojox.widget.DocTester <dojox/widget/DocTester>`_

    A widget to run DocTests inside an HTML page

  * `dojox.widget.FilePicker <dojox/widget/FilePicker>`_

    A specialized version of RollingList that handles file informatione

  * `dojox.widget.FisheyeList <dojox/widget/FisheyeList>`_

    A OSX-style Fisheye Menu

  * `dojox.widget.FisheyeLite <dojox/widget/FisheyeLite>`_

    A more robust Fisheye Widget, which fish-eyes' any CSS property

  * `dojox.widget.Iterator <dojox/widget/Iterator>`_

    A basic array and data store iterator class

  * `dojox.widget.Loader <dojox/widget/Loader>`_

    A small experimental Ajax Activity indicator (deprecated, will be moved to dojo-c)

  * `dojox.widget.Pager <dojox/widget/Pager>`_

    A `dojo.data <dojo/data>`_ powered Pager Widget, displaying a few items in a horizontal or vertical UI

  * `dojox.widget.PlaceholderMenuItem <dojox/widget/PlaceholderMenuItem>`_

    A menu item that can be used as a placeholder.

  * `dojox.widget.Portlet <dojox/widget/Portlet>`_

    An enhanced TitlePane designed to be used with the dojox.layout.GridContainer.

  * `dojox.widget.FeedPortlet <dojox/widget/Portlet>`_

    An enhanced Portlet which can load both remote and local Atom and RSS feeds, displaying them as a list.

  * `dojox.widget.Roller <dojox/widget/Roller>`_

    An unobtrusive "roller", displaying one message from a list in a loop

  * `dojox.widget.RollingList <dojox/widget/RollingList>`_

    A rolling list that can be tied to a data store with children

  * `dojox.widget.SortList <dojox/widget/SortList>`_

    A small sortable unordered-list

  * `dojox.widget.Standby <dojox/widget/Standby>`_

    A small widget that can be used to mark sections of a page as busy, processing, unavailable, etc.

  * `dojox.widget.Toaster <dojox/widget/Toaster>`_

    A message display system, showing warnings, errors and other messages unobtrusively

  * `dojox.widget.Wizard <dojox/widget/Wizard>`_

    A simple widget providing a step-by-step wizard like UI

* `dojox.wire <dojox/wire>`_

  Declarative data binding and action tags for simplified MVC

* `dojox.xml <dojox/xml>`_

  XML utilities

* `dojox.xmpp <dojox/xmpp>`_

  XMPP (Jabber Client) Service implementation in pure javascript
