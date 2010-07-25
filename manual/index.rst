#format dojo_rst

Reference Guide
===============

:Status: Draft
:Version: 1.0

.. contents::
   :depth: 2

====
Dojo
====

Dojo is divided into two parts: Dojo Base, and Dojo Core. Dojo Base is the functionality provided for by just including ``dojo.js``, and Dojo Core is comprised of stable additional (optional) components. Typically, if a function or Class exists within the dojo namespace directly (eg: dojo.require(), dojo.addOnLoad()) it is part of Base Dojo. If the function or Class exists beneath the dojo namespace (eg: dojo.dnd.Mover), you will need to require the appropriate module (eg: dojo.require("dojo.dnd.Mover");) 

These pages cover both cases, and indicate how they are provided. 

Dojo Base
---------

Dojo Base is the functionality you get by just including dojo.js or dojo.xd.js in your page.

* `dojo <dojo>`_

* `dojo._base <dojo/base>`_

  * `dojo._base._loader <dojo/base/loader>`_

    Dojo's Bootstrap

    * `djConfig <djConfig>`_

      Configuring Dojo with djConfig

    * `dojo.addOnLoad <dojo/addOnLoad>`_

      Call functions after the DOM has finished loading and widgets declared in markup have been instantiated

    * `dojo.addOnUnload <dojo/addOnUnload>`_

      Call functions when the page unloads

    * `dojo.addOnWindowUnload <dojo/addOnWindowUnload>`_

      Call functions when window.onunload fires

    * `dojo.attr <dojo/attr>`_

      Modifying DOM node attributes

    * `dojo.deprecated <dojo/deprecated>`_

      Log a debug message to indicate that a behavior has been deprecated

    * `dojo.exists <dojo/exists>`_

      Determine if an object supports a given method

    * `dojo.getObject <dojo/getObject>`_

      Get a property from a dot-separated string, such as "A.B.C"

    * `dojo.global <dojo/global>`_

      Alias for the global scope

    * `dojo.mixin <dojo/mixin>`_

      Multiple inheritance

    * `dojo.place <dojo/place>`_

      Place DOM nodes relative to others

    * `dojo.registerModulePath <dojo/registerModulePath>`_

      Maps module name to a path

    * `dojo.require <dojo/require>`_

      Loads a Javascript module from the appropriate URI

    * `dojo.setObject <dojo/setObject>`_

      Set a property from a dot-separated string, such as "A.B.C"

    * `dojo.version <dojo/version>`_

      The current version number of Dojo

    * `dojo.windowUnloaded <dojo/windowUnloaded>`_

      Signal fired by impending window destruction

  * `dojo._base.array <dojo/_base/array>`_

    Array utilities.
    Details on dojo.every, dojo.filter, dojo.forEach, dojo.indexOf, dojo.lastIndexOf, dojo.map, and dojo.some.

    * `dojo.forEach <dojo/forEach>`_

      Invokes a callback function for every item in array

    * `dojo.map <dojo/map>`_

      Applies a callback to each element of arr and returns an Array with the results

  * `dojo._base.Color <dojo/_base/Color>`_

    Functions for setting Colors

  * `dojo._base.connect <dojo/_base/connect>`_

    Functions for connecting methods to events and to subscribe and publish events

    * `dojo.connect <dojo/connect>`_

      Connects events to methods

    * `dojo.disconnect <dojo/disconnect>`_

      Disconnects methods from linked topics

    * `dojo.subscribe <dojo/subscribe>`_

      Linked a listener to a named topic

    * `dojo.unsubscribe <dojo/unsubscribe>`_

      Remove a topic listener

    * `dojo.publish <dojo/publish>`_

      Publish an event to all subscribers of a topic

    * `dojo.connectPublisher <dojo/connectPublisher>`_

      Ensure that everytime an event is called, a message is published on the topic.

  * `dojo._base.declare <dojo/_base/declare>`_

    Defining Classes

    * `dojo.declare <dojo/declare>`_

      Creates a constructor using a compact notation for inheritance and prototype extension

  * `dojo._base.Deferred <dojo/_base/Deferred>`_

    Managing Callbacks

    * `dojo.Deferred <dojo/Deferred>`_

      Communication between threads

  * `dojo._base.event <dojo/_base/event>`_

    DOM Events

  * `dojo._base.fx <dojo/_base/fx>`_

    Dojo animation effects

    * `dojo.animateProperty <dojo/animateProperty>`_

      A very useful method for animating CSS properties

  * `dojo._base.html <dojo/_base/html>`_

    Basic DOM handling functions

    * `dojo.byId <dojo/byId>`_

      Select a DOM node by 'id'

    * `dojo.style <dojo/style>`_

      A getter/setter for styles on a DOM node

  * `dojo._base.json <dojo/_base/json>`_

    JSON helpers

    * `dojo.fromJson <dojo/fromJson>`_

      Parses a JSON string to return a JavaScript object

    * `dojo.toJson <dojo/toJson>`_

      Returns a JSON serialization of an object

  * `dojo._base.lang <dojo/_base/lang>`_

    Support for Polymorphism

    * `dojo.isString <dojo/isString>`_

      Checks if the parameter is a String

    * `dojo.isArray <dojo/isArray>`_

      Checks if the parameter is an Array

    * `dojo.isFunction <dojo/isFunction>`_

      Checks if the parameter is a Function

    * `dojo.isObject <dojo/isObject>`_

      Checks if the parameter is a Object

    * `dojo.isArrayLike <dojo/isArrayLike>`_

      Checks if the parameter is like an Array

    * `dojo.isAlien <dojo/isAlien>`_

      Checks if the parameter is a built-in function

  * `dojo._base.NodeList <dojo/_base/NodeList>`_

    Syntactic sugar for chaining, common iteration operations, animation, and node manipulation

    * `dojo.NodeList <dojo/NodeList>`_

      A class to handle a list of DOM nodes

  * `dojo._base.query <dojo/_base/query>`_

    A relatively full-featured CSS3 query library

    * `dojo.query <dojo/query>`_

      The swiss army knife of DOM node manipulation in Dojo

  * `dojo._base.window <dojo/_base/window>`_

    Functions for dealing with the document-wide DOM and context related stuff

    * `dojo.doc <dojo/doc>`_

      Alias for the current document

    * `dojo.body <dojo/body>`_

      Return the body element of the document

    * `dojo.setContext <dojo/setContext>`_

      Changes the behavior of many core Dojo functions that deal with namespace and DOM lookup

    * `dojo.withGlobal <dojo/withGlobal>`_

      Call callback with globalObject as dojo.global and globalObject.document as dojo.doc

    * `dojo.withDoc <dojo/withDoc>`_

      Call callback with documentObject as dojo.doc

  * `dojo._base.xhr <dojo/_base/xhr>`_

    AJAX I/O transports and utility methods

    * `dojo.formToJson <dojo/formToJson>`_
    * `dojo.formToObject <dojo/formToObject>`_
    * `dojo.formToQuery <dojo/formToQuery>`_
    * `dojo.objectToQuery <dojo/objectToQuery>`_
    * `dojo.queryToObject <dojo/queryToObject>`_
    * `dojo.xhrDelete <dojo/xhrDelete>`_
    * `dojo.xhrGet <dojo/xhrGet>`_
    * `dojo.rawXhrPost <dojo/rawXhrPost>`_
    * `dojo.rawXhrPut <dojo/rawXhrPut>`_

Dojo Core
---------

* `dojo.AdapterRegistry <dojo/AdapterRegistry>`_

  A registry to make contextual calling/searching easier

* `dojo.back <dojo/back>`_

  Browser history management resources (Back button functionality)

* `dojo.behavior <dojo/behavior>`_

  Utility for unobtrusive/progressive event binding, DOM traversal, and manipulation

* `dojo.cldr <dojo/cldr>`_

  A Common Locale Data Repository (CLDR) implementation

* `dojo.colors <dojo/colors>`_

  CSS color manipulation functions

* `dojo.cookie <dojo/cookie>`_

  Simple HTTP cookie manipulation

* `dojo.currency <dojo/currency>`_

  Localized formatting and parsing routines for currency data

* `dojo.data <dojo/data>`_

  A uniform data access layer

  * `dojo.data.api <dojo/data/api>`_ 
  * `dojo.data.api.Read <dojo/data/api/Read>`_
  * `dojo.data.api.Write <dojo/data/api/Write>`_
  * `dojo.data.api.Identity <dojo/data/api/Identity>`_
  * `dojo.data.api.Notification <dojo/data/api/Notification>`_
  * `dojo.data.ItemFileReadStore <dojo/data/ItemFileReadStore>`_
  * `dojo.data.ItemFileWriteStore <dojo/data/ItemFileWriteStore>`_

* `dojo.date <dojo/date>`_

  Date manipulation utilities

  * `dojo.date.locale.format <dojo/date/locale/format>`_

* `dojo.DeferredList <dojo/DeferredList>`_

  Event handling for a group of Deferred objects

* `dojo.dnd <dojo/dnd>`_

  Drag and Drop

  * `dojo.dnd.Moveable <dojo/dnd/Moveable>`_

* `dojo.fx <dojo/fx>`_

  Effects library on top of Base animations

* `dojo.gears <dojo/gears>`_

  Google Gears

* `dojo.html <dojo/html>`_

  Inserting contents in HTML nodes

* `dojo.i18n <dojo/i18n>`_

  Utility classes to enable loading of resources for internationalization

* `dojo.io <dojo/io>`_

  Additional AJAX I/O transports

  * `dojo.io.iframe <dojo/io/iframe>`_

    Sends an AJAX I/O call using an IFrame

  * `dojo.io.script <dojo/io/script>`_

    Sends a JSONP request using a script tag

* `dojo.jaxer <dojo/jaxer>`_

* `dojo.NodeList-fx <dojo/NodeList-fx>`_

  Adds dojo.fx animation support to dojo.query()

* `dojo.NodeList-html <dojo/NodeList-html>`_

  Adds a chainable html method to dojo.query()

* `dojo.number <dojo/number>`_

  Localized formatting and parsing methods for number data

* `dojo.parser <dojo/parser>`_

  The Dom/Widget parsing package

* `dojo.regexp <dojo/regexp>`_

  Regular expressions and Builder resources

* `dojo.robot <dojo/robot>`_

  experimental module for DOH users

* `dojo.robotx <dojo/robotx>`_

  experimental module for DOH users

* `dojo.rpc <dojo/rpc>`_

  Communicate via Remote Procedure Calls (RPC) with Backend Servers

  * `dojo.rpc.JsonpService <dojo/rpc/JsonpService>`_

    Generic JSONP service

  * `dojo.rpc.JsonService <dojo/rpc/JsonService>`_

    JSON RPC service

  * `dojo.rpc.RpcService <dojo/rpc/RpcService>`_

    RPC service class

* `dojo.string <dojo/string>`_

  String utilities for Dojo


=====
Dijit
=====

Dijit is Dojo's UI Library, and lives as a separate namespace ``dijit``. Dijit requires Dojo Core. Each of the widgets and functionality provided by Dijit is describe in the following sections, though the aforementioned `quickstart <quickstart/>`_ guides cover some basics.  

* `dijit <dijit>`_

  * `a11y  <dijit-a11y>`_

    * `a11y Strategy <dijit-a11y-strategy>`_
    * `a11y Resources <dijit-a11y-resources>`_
    * `Creating Accessible Widgets <quickstart/writingWidgets/a11y>`_
    * `Testing for Accessibility <quickstart/writingWidgets/a11yTesting>`_
    * `a11y Requirements <dijit-a11y-req>`_
    * `a11y Statement <dijit-a11y-statement>`_

* `dijit.Calendar <dijit/Calendar>`_
* `dijit.ColorPalette <dijit/ColorPalette>`_
* `dijit.Dialog <dijit/Dialog>`_
* `dijit.Editor <dijit/Editor>`_
* `dijit.InlineEditBox <dijit/InlineEditBox>`_
* `dijit.Menu <dijit/Menu>`_
* `dijit.ProgressBar <dijit/ProgressBar>`_
* `dijit.TitlePane <dijit/TitlePane>`_
* `dijit.Tooltip <dijit/Tooltip>`_
* `dijit.TooltipDialog <dijit/TooltipDialog>`_
* `dijit.Tree <dijit/Tree>`_

  * `Model <dijit/tree/Model>`_
  * `TreeStoreModel <dijit/tree/ForestStoreModel>`_
  * `ForestStoreModel <dijit/tree/ForestStoreModel>`_


Form handling
-------------

* `dijit.form <dijit/form>`_

  * text boxes

    * `dijit.form.CurrencyTextBox <dijit/form/CurrencyTextBox>`_

      A specialized input widget for monetary values, much like the currency type in spreadsheet programs

    * `dijit.form.DateTextBox <dijit/form/DateTextBox>`_

      An easy-to-use date entry control which allows either typing or choosing a date from any calendar widget

    * `dijit.form.NumberSpinner <dijit/form/NumberSpinner>`_

      A input widget which restricts input to numeric input and offers down and up arrow buttons to "spin" the number up and down

    * `dijit.form.NumberTextBox <dijit/form/NumberTextBox>`_

      A input widget which restricts input to numeric input

    * `dijit.form.SimpleTextarea <dijit/form/SimpleTextarea>`_

      A simple wrapper of <textarea>; equivalent functionality

    * `dijit.form.Textarea <dijit/form/Textarea>`_

      An auto expanding/contracting <textarea>

    * `dijit.form.TextBox <dijit/form/TextBox>`_

      A basic <input type="text">-style form control

    * `dijit.form.TimeTextBox <dijit/form/TimeTextBox>`_

      A time input control which allows either typing or choosing a time from any time-picker widget

    * `dijit.form.ValidationTextBox <dijit/form/ValidationTextBox>`_
 
  * select type widgets

    * `dijit.form.ComboBox <dijit/form/ComboBox>`_

      A "auto complete", which allows the user to type any value and just gives suggested completions

    * `dijit.form.MultiSelect <dijit/form/MultiSelect>`_

      The MultiSelect widget allows the selection of multiple items

    * `dijit.form.FilteringSelect <dijit/form/FilteringSelect>`_

      Similar to a <select> but with type-ahead filtering of the drop down list

  * buttons

    * `dijit.form.Button <dijit/form/Button>`_

      A representation of a normal <button> or <input type="submit/reset/button" />

    * `dijit.form.ComboButton <dijit/form/ComboButton>`_

      A button with an arrow to show a drop down (often a menu)

    * `dijit.form.DropDownButton <dijit/form/DropDownButton>`_

      A button which displays a menu or some other popup when you press it

    * `dijit.form.ToggleButton <dijit/form/ToggleButton>`_

      A cross between a Button and a Checkbox widget

  * other controls

    * `dijit.form.CheckBox <dijit/form/CheckBox>`_

      Nearly the same as an HTML checkbox, but with fancy styling

    * `dijit.form.Form <dijit/form/Form>`_

      Corresponds to a <form> itself; wraps other widgets

    * `dijit.form.RadioButton <dijit/form/RadioButton>`_

      To select one choice from a list

    * `dijit.form.Slider <dijit/form/Slider>`_

      A scale with a handle you can drag up/down or left/right to select a value

Layout
------

* `dijit.layout <dijit/layout>`_

  * `dijit.layout.AccordionContainer <dijit/layout/AccordionContainer>`_
  * `dijit.layout.BorderContainer <dijit/layout/BorderContainer>`_
  * `dijit.layout.ContentPane <dijit/layout/ContentPane>`_
  * `dijit.layout.StackContainer <dijit/layout/StackContainer>`_
  * `dijit.layout.TabContainer <dijit/layout/TabContainer>`_


=====
DojoX
=====

DojoX serves many purposes, and by design is difficult to document. Here, we have an ongoing effort to document the most used, stable, reliable and powerful aspects of DojoX. DojoX contains code in alpha and experimental states, so your assistance in testing and documenting are especially helpful. 

These sections cover the available projects shipped with the Dojo Toolkit

* `dojox <dojox>`_
* `dojox.analytics <dojox/analytics>`_

  * `dojox.analytics.Urchin <dojox/analytics/Urchin>`_

* `dojox.av <dojox/av>`_
* `dojox.charting <dojox/charting>`_
* `dojox.collections <dojox/collections>`_
* `dojox.color <dojox/color>`_
* `dojox.cometd <dojox/cometd>`_
* `dojox.data <dojox/data>`_

  Additional data stores and data store helpers

  * `dojox.data.AndOrReadStore <dojox/data/AndOrReadStore>`_

    A clone of `dojo.data.ItemFileReadStore <dojo.data.ItemFileReadStore>`__, which supports more complex queries than the simple AND format property matching

  * `dojox.data.AndOrWriteStore <dojox/data/AndOrWriteStore>`_

    A clone of `dojo.data.ItemFileWriteStore <dojo.data.ItemFileWriteStore>`__, which supports more complex queries than the simple AND format property matching

  * `dojox.data.AtomReadStore <dojox/data/AtomReadStore>`_

    A store designed to provide read-only access to Atom XML documents

  * `dojox.data.ClientFilter <dojox/data/ClientFilter>`_

    An abstract data store module for adding updateable result set functionality to an existing data store class

  * `dojox.data.CouchDBRestStore <dojox/data/CouchDBRestStore>`_

    An extension of `dojox.data.JsonRestStore <dojox/data/JsonRestStore>`_ to handle CouchDB's idiosyncrasies, special features, and deviations from standard HTTP Rest

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

* `dojox.date <dojox/date>`_
* `dojox.dtl <dojox/dtl>`_
* `dojox.editor <dojox/editor>`_
* `dojox.embed <dojox/embed>`_
* `dojox.encoding <dojox/encoding>`_
* `dojox.flash <dojox/flash>`_
* `dojox.form <dojox/form>`_

  Additional form-related widgets beyond `dijit.form <dijit/form>`_ functionality

  * `dojox.form.BusyButton <dojox/form/BusyButton>`_

    A new Button with progresss indicator built in, for indicating processing after you press the button

  * `dojox.form.Rating <dojox/form/Rating>`_

  * `dojox.form.FileUploader <dojox.form.FileUploader>`_

    A new multi-file uploader that shows progress as the files are uploading

* `dojox.fx <dojox/fx>`_

  * `dojox.fx.wipeTo <dojox/fx/wipeTo>`_

* `dojox.gfx <dojox/gfx>`_
* `dojox.gfx3d <dojox/gfx3d>`_
* `dojox.grid <dojox/grid>`_
* `dojox.help <dojox/help>`_
* `dojox.highlight <dojox/highlight>`_
* `dojox.html <dojox/html>`_

  Additional HTML helper functions

  * `dojox.html.set <dojox/html/set>`_

    A generic content setter, including adding new stylesheets and evaluating scripts (was part of ContentPane loaders, now separated for generic usage)

  * `dojox.html.metrics <dojox/html/metrics>`_

    Translate CSS values to pixel values, calculate scrollbar sizes and font resizes

  * `dojox.html.styles <dojox/html/styles>`_

    Insert, remove and toggle CSS rules as well as search document for style sheets

* `dojox.image <dojox/image>`_

  Provides a number of image-related widgets

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
* `dojox.json <dojox/json>`_
* `dojox.jsonPath <dojox/jsonPath>`_
* `dojox.lang <dojox/lang>`_
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

  * `dojox.layout.ToggleSplitter <dojox/layout/ToggleSplitter>`_

    A custom Splitter for use in a BorderContainer, providing a lightweight way to collapse the associated child

* `dojox.math <dojox/math>`_
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

* `dojox.secure <dojox/secure>`_
* `dojox.sql <dojox/sql>`_
* `dojox.storage <dojox/storage>`_
* `dojox.string <dojox/string>`_
* `dojox.testing <dojox/testing>`_
* `dojox.timing <dojox/timing>`_
* `dojox.uuid <dojox/uuid>`_
* `dojox.validate <dojox/validate>`_
* `dojox.widget <dojox/widget>`_

  * `dojox.widget.Calendar <dojox/widget/Calendar>`_

    An extended dijit._Calendar

  * `dojox.widget.CalendarFx <dojox/widget/CalendarFx>`_

    An extended dijit._Calendar with FX

  * `dojox.widget.ColorPicker <dojox/widget/ColorPicker>`_

    A HSV Color Picker, similar to PhotoShop

  * `dojox.widget.Dialog <dojox/widget/Dialog>`_

    An extension to `dijit.Dialog </dijit/Dialog>`__

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

    A small experimental Ajax Activity indicator

  * `dojox.widget.Pager <dojox/widget/Pager>`_

    A `dojo.data <dojo/data>`_ powered Pager Widget, displaying a few items in a horizontal or vertical UI

  * `dojox.widget.PlaceholderMenuItem <dojox/widget/PlaceholderMenuItem>`_

    A menu item that can be used as a placeholder.

  * `dojox.widget.Roller <dojox/widget/Roller>`_

    An unobtrusive "roller", displaying one message from a list in a loop

  * `dojox.widget.RollingList <dojox/widget/RollingList>`_

    A rolling list that can be tied to a data store with children

  * `dojox.widget.SortList <dojox/widget/SortList>`_

    A small sortable unordered-list

  * `dojox.widget.Toaster <dojox/widget/Toaster>`_

    A message display system, showing warnings, errors and other messages unobtrusively

  * `dojox.widget.Wizard <dojox/widget/Wizard>`_

    A simple widget providing a step-by-step wizard like UI

* `dojox.wire <dojox/wire>`_
* `dojox.xml <dojox/xml>`_
* `dojox.xmpp <dojox/xmpp>`_



----

=====
DojoC
=====

DojoC is an svn repository used by DojoCampus for a variety of widgets, tutorials, sandbox, and other demos. You are welcome to explore and contribute, though absolutely nothing is guaranteed to work. DojoC is meant as a community workshop, and code comes and goes frequently, often times 'promoted' to `DojoX projects <dojox>`_. 

* `More about DojoC <dojoc>`_
