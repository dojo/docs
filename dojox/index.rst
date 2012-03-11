.. _dojox/index:

=====
DojoX
=====

DojoX is an area for development of extensions to the Dojo toolkit. It is a repository for more stable and mature extensions and also acts as an incubator for experimental code, a testbed for additions to the main toolkit. Unlike Dojo and Dijit, DojoX is managed by subprojects, each of which has at least one module, a sponsor and a mission statement.


* :ref:`About DojoX <dojox/info>`

These sections cover the available projects shipped with the Dojo Toolkit:

* :ref:`dojox.analytics <dojox/analytics>`

  An analytic and client monitoring system

  * :ref:`dojox.analytics.Urchin <dojox/analytics/Urchin>`

* :ref:`dojox.app <dojox/app>`

  Implements the application framework using dojox.mvc for web application on desktop and mobile platforms

* :ref:`dojox.atom <dojox/atom>`

  Implements the Atom Syndication Format and Atom Publishing Protocol

  * :ref:`dojox.atom.io.model <dojox/atom/io/model>`

    A JavaScript model of an ATOM feed

  * :ref:`dojox.atom.io.Connection <dojox/atom/io/Connection>`

    A IO class for performing APP (ATOM Publishing Protocol) styled IO actions with a server

* :ref:`dojox.av <dojox/av>`

  Brings audio and video capabilities to the Open Web

  * :ref:`dojox.av.FLAudio <dojox/av/FLAudio>`

    Provides the ability of implementing MP3 sounds into your dojo applications


  * :ref:`dojox.av.FLVideo <dojox/av/FLVideo>`

    Provides the ability to play Flash movie files (FLVs) within the dojo environment


  * :ref:`dojox.av.widget <dojox/av/widget>`

    Provides base player control widgets for building a media player

* :ref:`dojox.calendar <dojox/calendar>`

  Provides a widget to display events in time using several views

* :ref:`dojox.charting <dojox/charting>`

  A charting library

* :ref:`dojox.collections <dojox/collections>`

  Offers methods to handle common collections, like ArrayLists or Dictionaries

* :ref:`dojox.color <dojox/color>`

  Extends dojo.color/dojo.Color and adds advanced color model/matching functionality

  * :ref:`dojox.color.Palette <dojox/color/Palette>`

    A color palette generator and handler (used extensively in :ref:`dojox.charting <dojox/charting>`)

* :ref:`dojox.cometd <dojox/cometd>`

  A cometd client written in Dojo

* :ref:`dojox.data <dojox/data>`

  Additional data stores and data store helpers

  * :ref:`dojox.data.AndOrReadStore <dojox/data/AndOrReadStore>`

    A clone of :ref:`dojo.data.ItemFileReadStore <dojo/data/ItemFileReadStore>`, which supports more complex queries than the simple AND format property matching

  * :ref:`dojox.data.AndOrWriteStore <dojox/data/AndOrWriteStore>`

    A clone of :ref:`dojo.data.ItemFileWriteStore <dojo/data/ItemFileWriteStore>`, which supports more complex queries than the simple AND format property matching

  * :ref:`dojox.data.AtomReadStore <dojox/data/AtomReadStore>`

    A store designed to provide read-only access to Atom XML documents

  * :ref:`dojox.data.ClientFilter <dojox/data/ClientFilter>`

    An abstract data store module for adding updateable result set functionality to an existing data store class

  * :ref:`dojox.data.CouchDBRestStore <dojox/data/CouchDBRestStore>`

    A datastore for connecting to the open source document-oriented database Apache CouchDB

  * :ref:`dojox.data.CssClassStore <dojox/data/CssClassStore>`

    A read interface based on the :ref:`dojox.data.CssRuleStore <dojox/data/CssRuleStore>`

  * :ref:`dojox.data.CssRuleStore <dojox/data/CssRuleStore>`

    A read interface to the CSS rules loaded in the current page

  * :ref:`dojox.data.CsvStore <dojox/data/CsvStore>`

    A read interface that works with CSV formatted data files

  * :ref:`dojox.data.FileStore <dojox/data/FileStore>`

    A lightweight data store implementation for accessing details about a remote FileSystem

  * :ref:`dojox.data.FlickrRestStore <dojox/data/FlickrRestStore>`

    Provides access to the Flickr photo sharing site's REST API

  * :ref:`dojox.data.FlickrStore <dojox/data/FlickrStore>`

    A wrapper to the public photo feed of the Flickr service

  * :ref:`dojox.data.GoogleFeedStore <dojox/data/GoogleFeedStore>`

    A Google AJAX API powered data store for retrieving RSS and Atom feeds from Google

  * :ref:`dojox.data.GoogleSearchStore <dojox/data/GoogleSearchStore>`

    Several data stores to interface Google's AJAX search services:

    * :ref:`dojox.data.GoogleWebSearchStore <dojox/data/GoogleWebSearchStore>`

      A data store for retrieving search results from Google

    * :ref:`dojox.data.GoogleBlogSearchStore <dojox/data/GoogleBlogSearchStore>`

      A data store for retrieving search results from Google Blogs

    * :ref:`dojox.data.GoogleLocalSearchStore <dojox/data/GoogleLocalSearchStore>`

      A data store for retrieving search results from Google Location Search

    * :ref:`dojox.data.GoogleVideoSearchStore <dojox/data/GoogleVideoSearchStore>`

      A data store for retrieving search results from Google Video

    * :ref:`dojox.data.GoogleNewsSearchStore <dojox/data/GoogleNewsSearchStore>`

      A data store for retrieving search results from Google News

    * :ref:`dojox.data.GoogleBookSearchStore <dojox/data/GoogleBookSearchStore>`

      A data store for retrieving search results from Google Book

    * :ref:`dojox.data.GoogleImageSearchStore <dojox/data/GoogleImageSearchStore>`

      A data store for retrieving search results from Google Image

  * :ref:`dojox.data.HtmlStore <dojox/data/HtmlStore>`

    An enhanced replacement for :ref:`dojox.data.HtmlTableStore <dojox/data/HtmlTableStore>` to work with HTML tables, lists, and collections of DIV and SPAN tags.

  * :ref:`dojox.data.HtmlTableStore <dojox/data/HtmlTableStore>` (*deprecated*)

    A read interface to work with HTML tables

  * :ref:`dojox.data.jsonPathStore <dojox/data/jsonPathStore>`

    A local (in memory) store which can attach a dojo.data interface to each JavaScript object and uses jsonPath as the query language

  * :ref:`dojox.data.JsonRestStore <dojox/data/JsonRestStore>`

    A lightweight data store implementation of a RESTful client

  * :ref:`dojox.data.KeyValueStore <dojox/data/KeyValueStore>`

    An interface for reading property style files (key/value pairs)

  * :ref:`dojox.data.OpmlStore <dojox/data/OpmlStore>`

    A read-only store to work with Opml formatted XML files

  * :ref:`dojox.data.PersevereStore <dojox/data/PersevereStore>`

    An extension of :ref:`dojox.data.JsonRestStore <dojox/data/JsonRestStore>` to handle Persevere's special features

  * :ref:`dojox.data.PicasaStore <dojox/data/PicasaStore>`

    A data store interface to one of the basic services of the Picasa service, the public photo feed

  * :ref:`dojox.data.QueryReadStore <dojox/data/QueryReadStore>`

    A read-only store, which makes a request to the server for each sorting or query in order to work with big datasets

  * :ref:`dojox.data.S3Store <dojox/data/S3Store>`

    An extension of :ref:`dojox.data.JsonRestStore <dojox/data/JsonRestStore>` to handle Amazon's S3 service using JSON data

  * :ref:`dojox.data.ServiceStore <dojox/data/ServiceStore>`

    ServiceStore and it's subclasses are a generalized dojo.data implementation for any webservice

  * :ref:`dojox.data.SnapLogicStore <dojox/data/SnapLogicStore>`

    A data store interface to use the SnapLogic framework

  * :ref:`dojox.data.WikipediaStore <dojox/data/WikipediaStore>`

    An extension of :ref:`dojox.data.ServiceStore <dojox/data/ServiceStore>` to use Wikipedia's search service

  * :ref:`dojox.data.XmlStore <dojox/data/XmlStore>`

    A read and write interface to basic XML data

  * :ref:`dojox.data.dom <dojox/data/dom>`

    A set of DOM manipulation functions

* :ref:`dojox.date <dojox/date>`

  A collection of date-related enhancements and utilities, including national calendars.

  * :ref:`dojox.date.buddhist <dojox/date/buddhist>`

    A date-like class representing the Thai buddhist calendar

  * :ref:`dojox.date.hebrew <dojox/date/hebrew>`

    A date-like class representing the Hebrew calendar

  * :ref:`dojox.date.islamic <dojox/date/islamic>`

    A date-like class representing the Islamic or Hijri calendar

* :ref:`dojox.drawing <dojox/drawing>`

  Vector graphics drawing editor

* :ref:`dojox.dtl <dojox/dtl>`

  Django Template Language implementation

* :ref:`dojox.editor <dojox/editor>`

  Extensions for dijit.Editor

* :ref:`dojox.embed <dojox/embed>`

  Base code for embedding external objects like Flash, Quicktime

* :ref:`dojox.encoding <dojox/encoding>`

  All sorts of string encoding algorithms, including compression, crypto and more.

* :ref:`dojox.flash <dojox/flash>`

  Utilities to embed and communicate with Flash-based objects

* :ref:`dojox.form <dojox/form>`

  Additional form-related widgets beyond :ref:`dijit.form <dijit/form>` functionality

  * :ref:`dojox.form.BusyButton <dojox/form/BusyButton>`

    A new Button with progress indicator built in, for indicating processing after you press the button

  * :ref:`dojox.form.CheckedMultiSelect <dojox/form/CheckedMultiSelect>`

    A multi-select widget (similar to html select with multiple=true) that uses check boxes

  * :ref:`dojox.form.DateTextBox <dojox/form/DateTextBox>`

    description?

  * :ref:`dojox.form.DropDownSelect <dojox/form/DropDownSelect>`

    A styleable drop down select box (similar to html select element). Moved to dijit.form.Select. See also :ref:`dijit.form.Select <dijit/form/Select>`

  * :ref:`dojox.form.DropDownStack <dojox/form/DropDownStack>`

    A widget for enabling/disabling parts of a form based on a selection

  * :ref:`dojox.form.FileInput <dojox/form/FileInput>` (covers base, Auto, and Blind)

    A series of experimental Vanilla input type="file" widgets for uploading files. See also :ref:`dojox.form.Uploader <dojox/form/Uploader>`

  * :ref:`dojox.form.FilePickerTextBox <dojox/form/FilePickerTextBox>`

    A dijit._FormWidget that adds a dojox.widget.FilePicker to a text box as a dropdown

  * :ref:`dojox.form.FileUploader <dojox/form/FileUploader>`

    Deprecated old multi-file uploader that shows progress as the files are uploading. Use :ref:`dojox.form.Uploader <dojox/form/Uploader>` instead.

  * :ref:`dojox.form.ListInput <dojox/form/ListInput>`

    The ListInput widget allows you to create a list of elements.

  * :ref:`dojox.form.manager <dojox/form/manager/index>`

    A package to manage complex event-driven dynamic forms

  * :ref:`dojox.form.Manager (widget) <dojox/form/Manager>`

    A widget that uses :ref:`dojox.form.manager <dojox/form/manager/index>` to handle dynamic forms

  * :ref:`dojox.form.MultiComboBox <dojox/form/MultiComboBox>`

    Extension to ComboBox to allow "tag" style input using a datastore using a delimiter.

  * :ref:`dojox.form.PasswordValidator <dojox/form/PasswordValidator>`

    A widget that simplifies the "Old/New/Verify" password construct used on many web pages

  * :ref:`dojox.form.RadioStack <dojox/form/RadioStack>`

    A widget for enabling/disabling parts of a form based on a selection

  * :ref:`dojox.form.RangeSlider <dojox/form/RangeSlider>`

    A widget that allows a range of values to be selected along a scale

  * :ref:`dojox.form.Rating <dojox/form/Rating>`

    A widget that allows users to rate items

  * :ref:`dojox.form.TimeSpinner <dojox/form/TimeSpinner>`

    This widget is the same as dijit.form.NumberSpinner, but for the time component of a date object instead

  * :ref:`dojox.form.Uploader <dojox/form/Uploader>`

    A widget that adds functionality to a standard HTML file input. It hides the actual uploader and substitutes a dijit.form.Button.

* :ref:`dojox.fx <dojox/fx>`

  Extension animations to the core dojo FX project

  * :ref:`dojox.fx.crossFade <dojox/fx/crossFade>`

    Crossfade two nodes easily

  * :ref:`dojox.fx.highlight <dojox/fx/highlight>`

    Animates the background color of a node, and returns it to the color it was

  * :ref:`dojox.fx.sizeTo <dojox/fx/sizeTo>`

    Size a node about it's center to a new width/height

  * :ref:`dojox.fx.slideBy <dojox/fx/slideBy>`

    Slide a node by a t,l offset

  * :ref:`dojox.fx.style <dojox/fx/style>`

    Module to provide CSS animations

  * :ref:`dojox.fx.scroll <dojox/fx/scroll>`

    Module to provide scroll-related FX

  * :ref:`dojox.fx.wipeTo <dojox/fx/wipeTo>`

* :ref:`dojox.gantt <dojox/gantt>`

  A project and resource management tool

* :ref:`dojox.dgauges <dojox/dgauges>`

  The new Gauges module provides a framework of classes for creating custom gauges as well as predefined, ready to use gauge widgets. Both circular and rectangular gauges (horizontal and vertical) are supported.

* :ref:`dojox.gauges <dojox/gauges>`

  A collection of gauge widgets used to display numerical data

  * :ref:`dojox.gauges.AnalogGauge <dojox/gauges/AnalogGauge>`

    A circular gauge with a variety of indicators, used to display numerical data

  * :ref:`dojox.gauges.BarGauge <dojox/gauges/BarGauge>`

    A horizontal bar gauge with a few indicators, used to display numerical data

  * :ref:`dojox.gauges.GlossyCircularGauge <dojox/gauges/GlossyCircularGauge>`

    A circular gauge.

  * :ref:`dojox.gauges.GlossySemiCircularGauge <dojox/gauges/GlossySemiCircularGauge>`

    A semi circular gauge.

  * :ref:`dojox.gauges.GlossyHorizontalGauge <dojox/gauges/GlossyHorizontalGauge>`

    An horizontal gauge.

* :ref:`dojox.geo <dojox/geo>`

  A module to display geographical content

* :ref:`dojox.gesture <dojox/gesture>`

  Provides gesture events that can run well across a wide range of devices

* :ref:`dojox.gfx <dojox/gfx>`

  Cross-browser vector graphics API

* :ref:`dojox.gfx3d <dojox/gfx3d>`

  A 3d API for dojox.gfx

* :ref:`dojox.grid <dojox/grid/index>`

  Dojo Toolkit's Grid Widgets

  * :ref:`dojox.grid.DataGrid <dojox/grid/DataGrid>`

    A visual grid/table much like a spreadsheet

  * :ref:`dojox.grid.EnhancedGrid <dojox/grid/EnhancedGrid>`

    An enhanced version of the base grid, which extends it in numerous useful ways

  * :ref:`dojox.grid.TreeGrid <dojox/grid/TreeGrid>`

    A grid with support for collapsible rows and model-based (:ref:`dijit.tree.ForestStoreModel <dijit/tree/ForestStoreModel>`) structure

  * :ref:`dojox.grid.LazyTreeGrid <dojox/grid/LazyTreeGrid>`

    An extended version of TreeGrid that can lazy load and virtual scroll nested levels of huge children rows.

  * the old dojox.grid.Grid

    This old version is only available for compatible reasons

  * :ref:`Grid Plugin API <dojox/grid/pluginAPI>`

* :ref:`dojox.help <dojox/help>`
* :ref:`dojox.highlight <dojox/highlight>`

  A client-side syntax highlighting engine

* :ref:`dojox.html <dojox/html>`

  Additional HTML helper functions

  * :ref:`dojox.html.format <dojox/html/format>`

    A package which offers additional HTML helper functions for formatting HTML text

  * :ref:`dojox.html.set <dojox/html/set>`

    A generic content setter, including adding new stylesheets and evaluating scripts (was part of ContentPane loaders, now separated for generic usage)

  * :ref:`dojox.html.metrics <dojox/html/metrics>`

    Translate CSS values to pixel values, calculate scrollbar sizes and font resizes

  * :ref:`dojox.html.styles <dojox/html/styles>`

    Insert, remove and toggle CSS rules as well as search document for style sheets

* :ref:`dojox.image <dojox/image>`

  A collection of image-related widgets

  * :ref:`dojox.image.Badge <dojox/image/Badge>`

    Attach images or background images, and let them loop

  * :ref:`dojox.image.FlickrBadge <dojox/image/FlickrBadge>`

    An extension on dojox.image.Badge, using Flickr as a data provider

  * :ref:`dojox.image.Gallery <dojox/image/Gallery>`

    A combination of a SlideShow and ThumbnailPicker

  * :ref:`dojox.image.Lightbox <dojox/image/Lightbox>`

    A widget which shows a single image (or groups of images) in a Dialog

  * :ref:`dojox.image.LightboxNano <dojox/image/LightboxNano>`

    Similar to a Lightbox, though much lighter weight, and animated to center from position in page.

  * :ref:`dojox.image.Magnifier <dojox/image/Magnifier>`

    A dojox.gfx-based version of the :ref:`MagnifierLite <dojox/image/MagnifierLite>` widget

  * :ref:`dojox.image.MagnifierLite <dojox/image/MagnifierLite>`

    A simple hover behavior for images, showing a zoomed version of a size image

  * :ref:`dojox.image.SlideShow <dojox/image/SlideShow>`

    A slideshow of images

  * :ref:`dojox.image.ThumbnailPicker <dojox/image/ThumbnailPicker>`

    A dojo.data-powered ThumbnailPicker

* :ref:`dojox.io <dojox/io>`

  Extensions to the Core dojo.io transports

* :ref:`dojox.json <dojox/json>`

  DojoX JSON Modules

  * :ref:`dojox.json.query <dojox/json/query>`

    A comprehensive object data query tool

  * :ref:`dojox.json.schema <dojox/json/schema>`

    An object validation tool based on JSON Schema

  * :ref:`dojox.json.ref <dojox/json/ref>`

    JSON Referencing capable serializer and deserializer

* :ref:`dojox.jsonPath <dojox/jsonPath>`

  A query system for JavaScript objects

* :ref:`dojox.lang <dojox/lang/index>`

  JavaScript language extensions for supporting AOP, FP and other language constructs

  * :ref:`dojox.lang.aspect <dojox/lang/aspect>`

    Provides a framework for aspect-oriented programming.

  * :ref:`dojox.lang.async <dojox/lang/async>`

    Provides helpers for event-driven programming.

  * :ref:`dojox.lang.docs <dojox/lang/docs>`

    Provides schemas on Dojo's classes from the API documentation

  * :ref:`dojox.lang.functional <dojox/lang/functional>`

    Functional language constructs, including currying and lambda

  * :ref:`dojox.lang.observable <dojox/lang/observable>`

    Provides construction of objects such that property access and modification can be controlled, i.e. provides a form of getters/setters

  * :ref:`dojox.lang.oo <dojox/lang/oo>`

    Provides mixers to support traits and mixins for object-oriented programming.

  * :ref:`dojox.lang.typed <dojox/lang/typed>`

    Provides type checking for JavaScript classes, enforcing types on properties and method parameters using JSON Schema definitions.

* :ref:`dojox.layout <dojox/layout>`

  Experimental and additional extensions to :ref:`Dijit Layout <dijit/layout>` Widgets

  * :ref:`dojox.layout.ContentPane <dojox/layout/ContentPane>`

    An extension to dijit.layout.ContentPane providing script execution, among other things

  * :ref:`dojox.layout.DragPane <dojox/layout/DragPane>`

    Provides drag-based scrolling for divs with overflow

  * :ref:`dojox.layout.ExpandoPane <dojox/layout/ExpandoPane>`

    A self-collapsing widget for use in a :ref:`BorderContainer <dijit/layout/BorderContainer>`

  * :ref:`dojox.layout.FloatingPane <dojox/layout/FloatingPane>`

    An experimental floating window

  * :ref:`dojox.layout.GridContainer <dojox/layout/GridContainer>`

    A panel-like layout mechanism, allowing Drag and Drop between regions

  * :ref:`dojox.layout.RadioGroup <dojox/layout/RadioGroup>`

    A variety of :ref:`StackContainer <dijit/layout/StackContainer>` enhancements providing animated transitions

  * :ref:`dojox.layout.ResizeHandle <dojox/layout/ResizeHandle>`

    A small widget to provide resizing of a parent node

  * :ref:`dojox.layout.RotatorContainer <dojox/layout/RotatorContainer>`

    An extended StackContainer suited for presentational purposes

  * :ref:`dojox.layout.ScrollPane <dojox/layout/ScrollPane>`

    An interesting UI, scrolling an overflowed div based on mouse position, either vertical or horizontal

  * :ref:`dojox.layout.TableContainer <dojox/layout/TableContainer>`

    A simple layout widget that lays out its child widgets using a Table element.

  * :ref:`dojox.layout.ToggleSplitter <dojox/layout/ToggleSplitter>`

    A custom Splitter for use in a BorderContainer, providing a lightweight way to collapse the associated child

* :ref:`dojox.math <dojox/math>`

  A collection of various advanced math functions

* :ref:`dojox.mdnd <dojox/mdnd>`

  Experimental coordinates based moveable drag and drop. Use stable `dojo.dnd <dojo/dnd>` instead.

* :ref:`dojox.mobile <dojox/mobile>`

  A collection of utilities to get native look&feel on web apps for iPhone/iPad/Android

* :ref:`dojox.mvc <dojox/mvc>`

  A collection of features for enabling Model-View-Controller (MVC) patterns in Dojo

* :ref:`dojox.NodeList <dojox/NodeList>` - Additional extensions to :ref:`dojo.NodeList <dojo/NodeList>`
* :ref:`dojox.off <dojox/off>`
* :ref:`dojox.presentation <dojox/presentation>`
* :ref:`dojox.resources <dojox/resources>`
* :ref:`dojox.robot <dojox/robot>`
* :ref:`dojox.rpc <dojox/rpc>`

  Extended classes to communicate via Remote Procedure Calls (RPC) with Backend Servers

  * :ref:`dojox.rpc.SMDLibrary <dojox/rpc/SMDLibrary>`
  * :ref:`dojox.rpc.Client <dojox/rpc/Client>`
  * :ref:`dojox.rpc.JsonRest <dojox/rpc/JsonRest>`
  * :ref:`dojox.rpc.JsonRPC <dojox/rpc/JsonRPC>`
  * :ref:`dojox.rpc.LocalStorageRest <dojox/rpc/LocalStorageRest>`
  * :ref:`dojox.rpc.OfflineRest <dojox/rpc/OfflineRest>`

    Provides automatic offline capabilities to the JsonRest/JsonRestStore modules

  * :ref:`dojox.rpc.ProxiedPath <dojox/rpc/ProxiedPath>`
  * :ref:`dojox.rpc.Rest <dojox/rpc/Rest>`

    Provides a HTTP REST service with full range REST verbs include GET, PUT, POST and DELETE

  * :ref:`dojox.rpc.Service <dojox/rpc/Service>`

    The foundation of most dojox.RPC transportation

* :ref:`dojox.secure <dojox/secure>`
* :ref:`dojox.sketch <dojox/sketch>`
* :ref:`dojox.sql <dojox/sql>`

  objects to support Dojo Offline (dojox.off)  DEPRECATED

* :ref:`dojox.storage <dojox/storage>`

  Objects for mass storage within the browser

* :ref:`dojox.string <dojox/string>`

  A collection of various objects for advanced string manipulation, including a Builder and a tokenizer

* :ref:`dojox.testing <dojox/testing>`
* :ref:`dojox.timing <dojox/timing>`

  A set of objects to perform advanced time-based tasks, including a basic Timer

* :ref:`dojox.treemap <dojox/treemap>`

  A treemap widget to display data as a set of colored, potentially nested, rectangular cells from a dojo.store

* :ref:`dojox.uuid <dojox/uuid>`

  Universally Unique Identifier (UUID) implementations, including an implementation of UUID 2

* :ref:`dojox.validate <dojox/validate>`

  Additional input validation methods

* :ref:`dojox.widget <dojox/widget>`

  A collection of un-categorized widgets, or code not requiring its own package

  * :ref:`dojox.widget.AnalogGauge <dojox/widget/AnalogGauge>`

    A circular gauge with a variety of indicators, used to display numerical data

  * :ref:`dojox.widget.AutoRotator <dojox/widget/AutoRotator>`

    A rotator that automatically transitions between child nodes

  * :ref:`dojox.widget.BarGauge <dojox/widget/BarGauge>`

    A horizontal bar gauge with a few indicators, used to display numerical data

  * :ref:`dojox.widget.Calendar <dojox/widget/Calendar>`

    An extended dijit._Calendar

  * :ref:`dojox.widget.CalendarFx <dojox/widget/CalendarFx>`

    An extended dijit._Calendar with FX

  * :ref:`dojox.widget.ColorPicker <dojox/widget/ColorPicker>`

    A HSV Color Picker, similar to PhotoShop

  * :ref:`dojox.widget.Dialog <dojox/widget/Dialog>`

    An extension to :ref:`dijit.Dialog <dijit/Dialog>` which provides additional sizing options, animations, and styling

  * :ref:`dojox.widget.DocTester <dojox/widget/DocTester>`

    A widget to run DocTests inside an HTML page

  * :ref:`dojox.widget.FeedPortlet <dojox/widget/Portlet>`

    An enhanced Portlet which can load both remote and local Atom and RSS feeds, displaying them as a list

  * :ref:`dojox.widget.FilePicker <dojox/widget/FilePicker>`

    A specialized version of RollingList that handles file information

  * :ref:`dojox.widget.FisheyeList <dojox/widget/FisheyeList>`

    A OSX-style Fisheye Menu

  * :ref:`dojox.widget.FisheyeLite <dojox/widget/FisheyeLite>`

    A more robust Fisheye Widget, which fish-eyes' any CSS property

  * :ref:`dojox.widget.Iterator <dojox/widget/Iterator>`

    A basic array and data store iterator class

  * :ref:`dojox.widget.Loader <dojox/widget/Loader>`

    A small experimental Ajax Activity indicator (deprecated, will be moved to dojo-c)

  * :ref:`dojox.widget.Pager <dojox/widget/Pager>`

    A :ref:`dojo.data <dojo/data>` powered Pager Widget, displaying a few items in a horizontal or vertical UI

  * :ref:`dojox.widget.PlaceholderMenuItem <dojox/widget/PlaceholderMenuItem>`

    A menu item that can be used as a placeholder.

  * :ref:`dojox.widget.Portlet <dojox/widget/Portlet>`

    An enhanced TitlePane designed to be used with the dojox.layout.GridContainer

  * :ref:`dojox.widget.Roller <dojox/widget/Roller>`

    An unobtrusive "roller", displaying one message from a list in a loop

  * :ref:`dojox.widget.RollingList <dojox/widget/RollingList>`

    A rolling list that can be tied to a data store with children

  * :ref:`dojox.widget.Rotator <dojox/widget/Rotator>`

    A widget for rotating through child nodes using transitions

  * :ref:`dojox.widget.SortList <dojox/widget/SortList>`

    A small sortable unordered-list

  * :ref:`dojox.widget.Standby <dojox/widget/Standby>`

    A small widget that can be used to mark sections of a page as busy, processing, unavailable, etc.

  * :ref:`dojox.widget.Toaster <dojox/widget/Toaster>`

    A message display system, showing warnings, errors and other messages unobtrusively

  * :ref:`dojox.widget.UpgradeBar <dojox/widget/UpgradeBar>`

    Shows the "yellow bar" at the top of the screen when the user is to be notified that they should upgrade their browser or a plugin.

  * :ref:`dojox.widget.Wizard <dojox/widget/Wizard>`

    A simple widget providing a step-by-step wizard like UI

* :ref:`dojox.wire <dojox/wire>`

  Declarative data binding and action tags for simplified MVC

* :ref:`dojox.xml <dojox/xml>`

  XML utilities

* :ref:`dojox.xmpp <dojox/xmpp>`

  XMPP (Jabber Client) Service implementation in pure JavaScript
