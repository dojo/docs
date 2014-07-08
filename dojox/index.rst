.. _dojox/index:

=====
DojoX
=====

.. contents ::
  :depth: 2

Introduction
============

DojoX historically was an area for development of additional Dojo functionality.  Over the years, many of the sub-
packages and modules have taken dramatically different paths.  With some packages becoming very mature, some still 
being highly experimental and some being essentially abandoned.

In the future (Dojo 2.0), the DojoX package and namespace will removed.  Sub-Packages and modules will be either 
integrated into the Dojo Core, Dijit or separated as their own stand-alone package.  For the 1.X code stream though, 
in order to ensure backwards compatibility, all these packages are contained within the ``dojox`` namespace and 
package.

There are several different statuses for sub-packages and modules:

* **Mature** - This package or module is considered mature and is being actively developed and maintained by 
  committers within the Dojo Toolkit.  It is expected that it will persist into the foreseeable future.

* **Experimental** - This package or module is experimental, while it is being actively developed and maintained, the 
  API may change in the future and developers should be cautious about depending on the API remaining unchanged or the 
  code continuing to persist in the future.

* **Maintained** - This code is being actively maintained, but may or may not persist into Dojo 2.0.

* **Deprecated** - This code is being actively maintained for backwards compatibility purposes, but a decision has 
  been made that this package will not persist into Dojo 2.0.

* **Abandoned** - This code is not being actively maintained anymore.  End developers may have difficulty using this 
  code in current and future versions of the Dojo Toolkit.  Patches are usually welcome for bug fixes, but it is highly 
  unlikely new features or enhancements will be considered.

The following tables provides an overview of the sub-packages and modules in DojoX.  It is important to note though, 
that the definitive status of each part of the code is contained in the source codes ``README`` file within the 
sub-package's directory.

Website/WebApp Infrastructure
=============================

================================================================================== ============ ==============================================================
Package/Module                                                                     Status       Description
================================================================================== ============ ==============================================================
:ref:`dojox/analytics <dojox/analytics>`                                           Experimental Analytics and client monitoring system.  Including the base 
                                                                                                analytics system and any number of plugins enables logging of
                                                                                                different system data back to the server.
:ref:`dojox/app <dojox/app>`                                                       Mature       A small application framework providing a set of classes to
                                                                                                manage the the life-cycle and behavior of a single page 
                                                                                                application delivered to a mobile or desktop platform.
:ref:`dojox/collections <dojox/collections>`                                       Mature       Modules used to provide more functionality around common types
                                                                                                of collections.
`dojox/dnd`                                                                        Experimental Extending and augmenting ``dojo/dnd``.
:ref:`dojox/dtl <dojox/dtl>`                                                       Experimental The Dojo implementation of the Django Template Language
:ref:`dojox/gesture <dojox/gesture>`                                               Experimental Platform neutral gesture support.
:ref:`dojox/mdnd <dojox/mdnd>`                                                     Experimental An alternative Drag and Drop solution that does not use 
                                                                                                avatars when dragging items.
:ref:`dojox/mvc <dojox/mvc>`                                                       Experimental Abstraction classes to utilize a Method View Controller 
                                                                                                framework with Dojo.
:ref:`dojox/storage <dojox/storage>`                                               Abandoned    Provides persistent storage in the browser.
:ref:`dojox/wire <dojox/wire>`                                                     Abandoned    A framework for wiring visual objects to data.
:ref:`dojox/wire/ml <dojox/wire>`                                                  Abandoned    A markup language for wiring the objects to the data.
================================================================================== ============ ==============================================================

Mobile
======

================================================================================== ============ ==============================================================
Package/Module                                                                     Status       Description
================================================================================== ============ ==============================================================
:ref:`dojox/mobile <dojox/mobile>`                                                 Mature       A mobile framework built on top of Dojo and Dijit
:ref:`dojox/mobile/app <dojox/mobile/app>`                                         Deprecated   Use ``dojox/app`` instead.
================================================================================== ============ ==============================================================

Language/Programming
====================

================================================================================== ============ ==============================================================
Package/Module                                                                     Status       Description
================================================================================== ============ ==============================================================
:ref:`dojox/lang <dojox/lang/index>`                                               Maintained   Various language extensions.
:ref:`dojox/lang/aspect <dojox/lang/aspect>`                                       Maintained   More full featured aspect based programming not covered in 
                                                                                                ``dojo/aspect``.
:ref:`dojox/lang/async <dojox/lang/async>`                                         Maintained   Helpers for event driven programming
:ref:`dojox/lang/functional <dojox/lang/functional>`                               Maintained   Provides lambda functions and common functional operations
:ref:`dojox/lang/observable <dojox/lang/observable>`                               Deprecated   Covered by ``dojo/Stateful``
:ref:`dojox/lang/oo <dojox/lang/oo>`                                               Maintained   Provides mixers to support traits and mixins for object-
                                                                                                oriented programming.
`dojox/rails`                                                                      Abandoned    This is a dojo plugin for Rails 3.x UJS support.
================================================================================== ============ ==============================================================

Graphics and Effects
====================

================================================================================== ============ ==============================================================
Package/Module                                                                     Status       Description
================================================================================== ============ ==============================================================
:ref:`dojox/av <dojox/av>`                                                         Experimental Audio and video capabilities to the Open Web. Wraps common
                                                                                                media types (Flash and Quicktime) and provides easy to use 
                                                                                                objects to accomplish basic A/V tasks.
:ref:`dojox/drawing <dojox/drawing>`                                               Experimental A package that builds on top of ``dojox/gfx`` to be able to 
                                                                                                create and save vector based drawings.
:ref:`dojox/flash <dojox/flash>`                                                   Experimental Infrastructure for high-performance Flash/JavaScript 
                                                                                                communication
:ref:`dojox/fx/easing <dojox/fx>`                                                  Deprecated   Use ``dojo/fx/easing`` instead.
:ref:`dojox/fx/ext-dojo/complex <dojox/fx/ext-dojo/complex>`                       Maintained   Extends ``dojo/_base/fx::animateProperty()`` to be able to
                                                                                                handle more complex property adjustments, specifically those 
                                                                                                related to CSS3.
`dojox/fx/ext-dojo/NodeList-style`                                                 Maintained   Extends NodeList with the features of ``dojox/fx/style``.
:ref:`dojox/fx/ext-dojo/NodeList <dojox/fx/ext-dojo/NodeList>`                     Maintained   Extends NodeList with the features of the rest of 
                                                                                                ``dojox/fx``
:ref:`dojox/fx/ext-dojo/reverse <dojox/fx/ext-dojo/reverse>`                       Maintained   Extends ``dojo/_base/fx::Animation`` with the ability to 
                                                                                                easily reverse an animation.
:ref:`dojox/fx/flip <dojox/fx>`                                                    Experimental Animate a node flipping following a specific direction.
:ref:`dojox/fx/scroll <dojox/fx>`                                                  Experimental Returns an animation that will smooth-scroll to a node.
:ref:`dojox/fx/Shadow <dojox/fx>`                                                  Experimental Adds a drop-shadow to a node.
:ref:`dojox/fx/split <dojox/fx>`                                                   Maintained   Various animations that take a node, split it and animated it.
:ref:`dojox/fx/style <dojox/fx>`                                                   Experimental Allows for animations based on normalized CSS definitions.
:ref:`dojox/fx/text <dojox/fx>`                                                    Maintained   A set of animations used for animating text blocks.
:ref:`dojox/fx/Timeline <dojox/fx/Timeline>`                                       Maintained   Allow for a complex animations based on an array of
                                                                                                "keyframes".
:ref:`dojox/gfx <dojox/gfx>`                                                       Mature       The platform independent Dojo graphics libraries.
:ref:`dojox/gfx3d <dojox/gfx3d>`                                                   Experimental A simple portable 3D graphics library.
:ref:`dojox/image <dojox/image>`                                                   Maintained   Provides a common API for images
:ref:`dojox/image/Badge <dojox/image/Badge>`                                       Experimental A simple grid of Images that loops through thumbnails
:ref:`dojox/image/FlickrBadge <dojox/image/FlickrBadge>`                           Maintained   A simple grid of Images that loops through thumbnails from a 
                                                                                                Flickr account
:ref:`dojox/image/Gallery <dojox/image/Gallery>`                                   Abandoned    A gallery widget
:ref:`dojox/image/Lightbox <dojox/image/Lightbox>`                                 Experimental A dojo-based Lightbox implementation.
:ref:`dojox/image/LightboxNano <dojox/image/LightboxNano>`                         Experimental A simple "nano" version of the lightbox.
:ref:`dojox/image/Magnifier <dojox/image/Magnifier>`                               Maintained   Adds magnification on a portion of an image element, using 
                                                                                                ``dojox/gfx``
:ref:`dojox/image/MaginfierLite <dojox/image/MagnifierLite>`                       Experimental Adds magnification on a portion of an image element
:ref:`dojox/image/SlideShow <dojox/image/SlideShow>`                               Abandoned    A Slideshow Widget
:ref:`dojox/image/TumbnailPicker <dojox/image/ThumbnailPicker>`                    Abandoned    A scrolling Thumbnail Picker widget
`dojox/sketch`                                                                     Experimental A cross-browser drawing editor based on ``dojox/gfx``
================================================================================== ============ ==============================================================

Data Visualization
==================

================================================================================== ============ ==============================================================
Package/Module                                                                     Status       Description
================================================================================== ============ ==============================================================
:ref:`dojox/charting <dojox/charting>`                                             Mature       Charting capabilities built on top of ``dojox/gfx``.
:ref:`dojox/dgauges <dojox/dgauges>`                                               Mature       Gauges widget framework, deprecates ``dojox/gauges``.
:ref:`dojox/gantt <dojox/gantt>`                                                   Maintained   A gantt type charting widget.
:ref:`dojox/gauges <dojox/gauges>`                                                 Deprecated   Replaced by ``dojox/dgauges``.
:ref:`dojox/geo/charting <dojox/geo/charting>`                                     Experimental Map based ``dojox/charting`` type widgets.
:ref:`dojox/geo/openlayers <dojox/geo/openlayers>`                                 Experimental Modules for using OpenLayers mapping APIs.
:ref:`dojox/treemap <dojox/treemap>`                                               Experimental A data visualization widget.
================================================================================== ============ ==============================================================

DataStores
==========

================================================================================== ============ ==============================================================
Package/Module                                                                     Status       Description
================================================================================== ============ ==============================================================
:ref:`dojox/data <dojox/data>`                                                     Deprecated   The ``dojo/data`` API which all the ``dojox/data`` modules are
                                                                                                based off of is deprecated.  If these stores persist they will
                                                                                                be rewritten to work off of the ``dojo/store`` API.
:ref:`dojox/data/AndOrReadStore <dojox/data/AndOrReadStore>`                       Deprecated   Extends ItemFileReadStore to provide AND/OR query formats
:ref:`dojox/data/AndOrWriteStore <dojox/data/AndOrWriteStore>`                     Deprecated   Extends ItemFileWriteStore to provide AND/OR query formats
:ref:`dojox/data/AppStore <dojox/data/AppStore>`                                   Deprecated   A datastore that implements full read, write and identify APIs 
                                                                                                for working with ATOM documents.  The store uses the full APP 
                                                                                                protocol.
:ref:`dojox/data/AtomReadStore <dojox/data/AtomReadStore>`                         Deprecated   Reads Atom XML documents.
`dojox/data/CdfStore`                                                              Abandoned    Used for interfacing with Tibo GI and requires Tibco's JSX3
                                                                                                JavaScript Library
:ref:`dojox/data/ClientFilter <dojox/data/ClientFilter>`                           Deprecated   This is an abstract data store module for adding updatable 
                                                                                                result set functionality to an existing data store class.
:ref:`dojox/data/CouchDBRestStore <dojox/data/CouchDBRestStore>`                   Deprecated   Builds on JsonRestStore to provide connectivity to CouchDB
:ref:`dojox/data/CssClassStore <dojox/data/CssClassStore>`                         Deprecated   Allows the searching/querying over CSS classes defined in a 
                                                                                                page in a browser.
:ref:`dojox/data/CssRuleStore <dojox/data/CssRuleStore>`                           Deprecated   Allows the searching/querying over CSS rules loaded in a 
                                                                                                page in a browser.
:ref:`dojox/data/CsvStore <dojox/data/CsvStore>`                                   Deprecated   Comma-Separated text datastore implementation.
:ref:`dojox/data/FileStore <dojox/data/FileStore>`                                 Deprecated   A specific implementation providing a lazy-loading store of 
                                                                                                file system type objects.
:ref:`dojox/data/FlickrRestStore <dojox/data/FlickrRestStore>`                     Deprecated
:ref:`dojox/data/FlickrStore <dojox/data/FlickrStore>`                             Deprecated   Data store driven by Flickr.com public API.
:ref:`dojox/data/GoogleFeedStore <dojox/data/GoogleFeedStore>`                     Deprecated
:ref:`dojox/data/GoogleSearchStore <dojox/data/GoogleSearchStore>`                 Deprecated   Datastore that interfaces to Google's AJAX search services
:ref:`dojox/data/HtmlStore <dojox/data/HtmlStore>`                                 Deprecated   Reads arbitrary HTML to be used as a datastore, including 
                                                                                                tables, ordered and un-ordered lists and lists of ``<div>`` 
                                                                                                elements.
:ref:`dojox/data/HtmlTableStore <dojox/data/HtmlTableStore>`                       Deprecated   Datastore specifically designed for reading HTML tables.
`dojox/data/ItemExplorer`                                                          Abandoned
`dojox/data/JsonQueryRestStore`                                                    Deprecated
:ref:`dojox/data/JsonRestStore <dojox/data/JsonRestStore>`                         Deprecated   A store that interfaces with JSON RESTful services.  This 
                                                                                                been superseded by 
                                                                                                :ref:`data/store/JsonRest <dojo/store/JsonRest>`
:ref:`dojox/data/KeyValueStore <dojox/data/KeyValueStore>`                         Deprecated   A datastore that mimics a key/value property file format.
:ref:`dojox/data/OpenSearchStore <dojox/data/OpenSearchStore>`                     Deprecated   A datastore that implements OpenSearch provider search 
                                                                                                capability.
:ref:`dojox/data/OpmlStore <dojox/data/OpmlStore>`                                 Deprecated   Datastore for reading OMPL formatted data.
:ref:`dojox/data/PersevereStore <dojox/data/PersevereStore>`                       Deprecated   Builds on JsonRestStore to provide connectivity to Persevere
:ref:`dojox/data/PicasaStore <dojox/data/PicasaStore>`                             Deprecated   A datastore interface to one of the basic services of the 
                                                                                                Picasa service, the public photo feed.
:ref:`dojox/data/QueryReadStore <dojox/data/QueryReadStore>`                       Deprecated
:ref:`dojox/data/RailsStore <dojox/data/RailsStore>`                               Deprecated   A datastore for interacting with RESTful Rails controllers
:ref:`dojox/data/S3Store <dojox/data/S3Store>`                                     Deprecated   Builds on JsonRestStore to provide connectivity to Amazon S3
:ref:`dojox/data/ServiceStore <dojox/data/ServiceStore>`                           Deprecated   A read only datastore that provides an interface to an RPC 
                                                                                                service.
`dojox/data/StoreExplorer`                                                         Abandoned
:ref:`dojox/data/WikipediaStore <dojox/data/WikipediaStore>`                       Deprecated   A datastore interface to Wikipedia, using the Wikipedia SMD 
                                                                                                spec from ``dojox/rpc``.
:ref:`dojox/data/XmlStore <dojox/data/XmlStore>`                                   Deprecated   Datastore for handling XML based services or documents.
`dojox/data/util/JsonQuery`                                                        Deprecated   Mixin that converts object attribute queries to JSONQuery/
                                                                                                JSONPath syntax to be sent to the server.
================================================================================== ============ ==============================================================

Communication
=============

================================================================================== ============ ==============================================================
Package/Module                                                                     Status       Description
================================================================================== ============ ==============================================================
:ref:`dojox/atom <dojox/atom>`                                                     Experimental An implementation of the ATOM document format in a JavaScript
                                                                                                model and a full Atom Publishing Protocol (APP) IO library for
                                                                                                working with ATOM feeds.
:ref:`dojox/io/httpParse <dojox/io/httpParse>`                                     Maintained   Parses an HTTP stream for a message.
:ref:`dojox/io/OAuth <dojox/io/OAuth>`                                             Maintained   Helper singleton for signing any kind of Ajax request using 
                                                                                                the OAuth 1.0 protocol.
:ref:`dojox/io/scriptFrame <dojox/io/scriptFrame>`                                 Deprecated   Replaced with ``dojo/request``
:ref:`dojox/io/windowName <dojox/io/windowName>`                                   Deprecated   Replaced with ``dojo/request``
:ref:`dojox/io/xhrMultiPart <dojox/io/xhrMultiPart>`                               Deprecated   Replaced with ``dojo/request``
:ref:`dojox/io/xhrPlugins <dojox/io/xhrPlugins>`                                   Deprecated   Functionality now covered in ``dojo/request/registry``
`dojox/io/proxy/xip`                                                               Maintained   XHR IFrame Proxy
:ref:`dojox/rpc <dojox/rpc>`                                                       Maintained   Extra utilities for ``dojo/rpc``
`dojox/socket/Reconnect`                                                           Abandoned    Provides a WebSocket with fallback to HTTP long-polling
:ref:`dojox/xmpp <dojox/xmpp>`                                                     Abandoned    An XMPP (Jabber/GTalk) implementation.
================================================================================== ============ ==============================================================

Widgets and Forms
=================

================================================================================== ============ ==============================================================
Package/Module                                                                     Status       Description
================================================================================== ============ ==============================================================
`dojox/calc`                                                                       Maintained   Graphing calculator project.
:ref:`dojox/calendar <dojox/calendar>`                                             Mature       A complex calendaring widget the provides the ability to 
                                                                                                create and manage events.
:ref:`dojox/editor/plugins <dojox/editor/plugins>`                                 Various      Several Plugins for the ``dojox/editor/Editor``
:ref:`dojox/form/BusyButton <dojox/form/BusyButton>`                               Maintained   A button the provides visual feedback when it is activated.
:ref:`dojox/form/CheckedMultiSelect <dojox/form/CheckedMultiSelect>`               Maintained   Allows options in a MultiSelect to be selected by a checkbox.
:ref:`dojox/form/DateTextBox <dojox/form/DateTextBox>`                             Experimental A validating, serializable, range-bound date text box with a 
                                                                                                popup calendar.
:ref:`dojox/widget/DayTextBox <dojox/widget/Calendar>`                             Experimental A validating, serializable, range-bound date text box with a
                                                                                                popup calendar that contains just months.
:ref:`dojox/form/DropDownSelect <dojox/form/DropDownSelect>`                       Deprecated   Use ``dijit/form/Select`` instead.
:ref:`dojox/form/DropDownStack <dojox/form/DropDownStack>`                         Maintained   Used for "selectable" multiforms.
:ref:`dojox/form/FileInput <dojox/form/FileInput>`                                 Experimental An ``<input type="file">`` form widget, with a button for 
                                                                                                uploading to be styled via CSS, a cancel button to clear 
                                                                                                selection.
`dojox/form/FileInputAuto`                                                         Experimental An extension on FileInput providing background upload
                                                                                                progress
`dojox/form/FileInputBlind`                                                        Deprecated   Use ``dojox/form/FileInputAuto`` instead.
:ref:`dojox/form/FilePickerTextBox <dojox/form/FilePickerTextBox>`                 Maintained   A validating text box tied to a file picker popup
:ref:`dojox/form/FileUploader <dojox/form/FileUploader>`                           Deprecated   Use ``dojox/form/Uploader`` instead.
:ref:`dojox/form/ListInput <dojox/form/ListInput>`                                 Experimental An automatic list maker.
:ref:`dojox/form/Manager <dojox/form/Manager>`                                     Maintained   The widget to orchestrate dynamic forms.
:ref:`dojox/widget/MonthTextBox <dojox/widget/Calendar>`                           Experimental A validating, serializable, range-bound date text box with a
                                                                                                popup calendar that contains only months.
:ref:`dojox/form/MultiComboBox <dojox/form/MultiComboBox>`                         Experimental A ComboBox that accepts multiple inputs on a single line.
:ref:`dojox/form/PasswordValidator <dojox/form/PasswordValidator>`                 Maintained   A password validation widget that simplifies the 
                                                                                                "old/new/verify" style of requesting passwords.
`dojox/form/RadioStack`                                                            Maintained   A radio-based select stack.
:ref:`dojox/form/RangeSlider <dojox/form/RangeSlider>`                             Maintained   A form widget that allows one to select a range with two 
                                                                                                draggable images.
:ref:`dojox/form/Rating <dojox/form/Rating>`                                       Maintained   A widget for rating using stars.
:ref:`dojox/form/TimeSpinner <dojox/form/TimeSpinner>`                             Maintained   This widget is the same as a normal NumberSpinner, but for
                                                                                                the time component of a date object instead.
`dojox/form/TriStateCheckBox`                                                      Maintained   Checkbox with three states.
:ref:`dojox/form/Uploader <dojox/form/Uploader>`                                   Experimental A widget that creates a stylable file-input button, with 
                                                                                                optional multi-file selection, using only HTML elements.
:ref:`dojox/widget/YearTextBox <dojox/widget/Calendar>`                            Experimental A validating, serializable, range-bound date text box with a
                                                                                                popup calendar that contains only years.
:ref:`dojox/grid <dojox/grid/index>`                                               Deprecated   A grid widget package.  Replaced by ``dgrid`` or ``gridx``.
`dojox/layout/BorderContainer`                                                     Deprecated   Covered by ``dijit/layout/BorderContainer``
:ref:`dojox/layout/ContentPane <dojox/layout/ContentPane>`                         Maintained   An extended version of ``dijit/layout/ContentPane`` that 
                                                                                                supports running infile JavaScript.
`dojox/layout/Dock`                                                                Experimental A widget that attaches to a node and keeps track of
                                                                                                incoming / outgoing FloatingPanes and handles layout
`dojox/layout/dnd`                                                                 Abandoned    Enhancements to ``dojo/dnd``.
:ref:`dojox/layout/DragPane <dojox/layout/DragPane>`                               Maintained   Makes a pane's content draggable by/within it's surface
:ref:`dojox/layout/ExpandoPane <dojox/layout/ExpandoPane>`                         Experimental An experimental collapsing-pane for 
                                                                                                ``dijit/layout/BorderContainer``
`dojox/layout/ext-dijit/layout`                                                    Abandoned    This core functionality is now available in Dijit.
:ref:`dojox/layout/FloatingPane <dojox/layout/FloatingPane>`                       Maintained   A non-modal Floating window.
:ref:`dojox/layout/GridContainer <dojox/layout/GridContainer>`                     Maintained   A grid containing any kind of object and acting like a web 
                                                                                                portals.
`dojox/layout/GridContainerLite`                                                   Maintained   The GridContainerLite is a container of child elements that
                                                                                                are placed in a kind of grid.
:ref:`dojox/layout/RadioGroup <dojox/layout/RadioGroup>`                           Experimental An enhancement to the ``dijit/layout/StackContainer``
:ref:`dojox/layout/ResizeHandle <dojox/layout/ResizeHandle>`                       Experimental A draggable handle used to resize an attached node.
:ref:`dojox/layout/RotatorContainer <dojox/layout/RotatorContainer>`               Maintained   An enhanced StackContainer that automatically transitions
                                                                                                between its ContentPanes.
:ref:`dojox/layout/ScrollPane <dojox/layout/ScrollPane>`                           Experimental A pane that "scrolls" its content based on the mouse 
                                                                                                position inside.
:ref:`dojox/layout/TableContainer <dojox/layout/TableContainer>`                   Experimental A container that lays out its child widgets in a table 
                                                                                                layout.
:ref:`dojox/layout/ToggleSplitter <dojox/layout/ToggleSplitter>`                   Experimental A draggable and clickable spacer between two items in a 
                                                                                                ``dijit.layout.BorderContainer``.
:ref:`dojox/widget <dojox/widget>`                                                 Maintained   [desc]
:ref:`dojox/widget/AnalogGauge <dojox/widget/AnalogGauge>`                         Abandoned    Replaced with ``dojox/dgauges``
:ref:`dojox/widget/AutoRotator <dojox/widget/AutoRotator>`                         Maintained   A rotator that automatically transitions between child nodes.
:ref:`dojox/widget/BarGauge <dojox/widget/BarGauge>`                               Abandoned    Replaced with ``dojox/dgauges``
:ref:`dojox/widget/Calendar <dojox/widget/Calendar>`                               Maintained   The standard Calendar. It includes day and month/year views.
:ref:`dojox/widget/Calendar2Pane <dojox/widget/Calendar>`                          Maintained   A Calendar with two panes, the second one containing both
                                                                                                month and year.
:ref:`dojox/widget/Calendar3Pane <dojox/widget/Calendar>`                          Maintained   A Calendar with three panes, includes day, month, and year
                                                                                                views.
`dojox/widget/CalendarFisheye`                                                     Maintained   The standard Calendar. It includes day, month and year views.
                                                                                                FisheyeLite effects are included.
:ref:`dojox/widget/CalendarFx <dojox/widget/CalendarFx>`                           Maintained   The visual effects extensions for ``dojox/widget/Calendar``.
:ref:`dojox/widget/ColorPicker <dojox/widget/ColorPicker>`                         Experimental A HSV color picker
:ref:`dojox/widget/DailyCalendar <dojox/widget/Calendar>`                          Maintained   A calendar with only a daily view.
:ref:`dojox/widget/DataPresentation <dojox/widget/DataPresentation>`               Abandoned    A widget that connects to a data store in a simple manner and
                                                                                                visualizes data.
:ref:`dojox/widget/Dialog <dojox/widget/Dialog>`                                   Maintained   An enhanced version of ``dijit/Dialog``.
:ref:`dojox/widget/DialogSimple <dojox/widget/DialogSimple>`                       Maintained   An simple enhancements of ``dijit/Dialog``.
:ref:`dojox/widget/DocTester <dojox/widget/DocTester>`                             Abandoned    A widget to run DocTests inside an HTML page.
:ref:`dojox/widget/DynamicTooltip <dojox/widget/DynamicTooltip>`                   Abandoned    Extension of ``dijit/Tooltip`` providing content set via XHR 
                                                                                                request via ``href`` param.
`dojox/widget/FeedPortlet`                                                         Abandoned    A Portlet that loads a XML feed.
:ref:`dojox/widget/FilePicker <dojox/widget/FilePicker>`                           Abandoned    A pane to display the information for the currently-selected 
                                                                                                file
:ref:`dojox/widget/FisheyeList <dojox/widget/FisheyeList>`                         Maintained   Menu similar to the fish eye menu on the Mac OS.
:ref:`dojox/widget/FisheyeListItem <dojox/widget/FisheyeList>`                     Maintained   Menu item inside of a FisheyeList.
:ref:`dojox/widget/FisheyeLite <dojox/widget/FisheyeLite>`                         Experimental A Light-weight Fisheye Component, or an enhanced version of
                                                                                                ``dojo/fx/Toggler``.
:ref:`dojox/widget/Iterator <dojox/widget/Iterator>`                               Abandoned    A widget that iterates the contents of a datastore.
:ref:`dojox/widget/Loader <dojox/widget/Loader>`                                   Abandoned    A configurable global XHR-listener to display a loading 
                                                                                                message during running XHRs or to simply provide base-level 
                                                                                                topic to subscribe to for custom loading messages.
:ref:`dojox/widget/MonthAndYearlyCalendar <dojox/widget/Calendar>`                 Maintained   A calendar with only a daily view.
:ref:`dojox/widget/MonthlyCalendar <dojox/widget/Calendar>`                        Maintained   A calendar with only a month view.
`dojox/widget/MultiSelectCalendar`                                                 Experimental A simple GUI for choosing several dates in the context of a
                                                                                                monthly calendar.
:ref:`dojox/widget/Pager <dojox/widget/Pager>`                                     Experimental A Pager, displaying a list of sized nodes
:ref:`dojox/widget/PlaceholderMenuItem <dojox/widget/PlaceholderMenuItem>`         Experimental A menu item that can be used as a placeholder.
:ref:`dojox/widget/Portlet <dojox/widget/Portlet>`                                 Maintained   A container widget that is designed to be contained in a 
                                                                                                ``dojox/layout/GridContainer``.
:ref:`dojox/widget/PortletDialogSettings <dojox/widget/Portlet>`                   Maintained   A settings widget to be used with a ``dojox/widget/Portlet``.
:ref:`dojox/widget/PortletSettings <dojox/widget/Portlet>`                         Maintained   A settings widget to be used with a ``dojox/widget/Portlet``.
:ref:`dojox/widget/Roller <dojox/widget/Roller>`                                   Maintained   A simple widget to take an unordered-list of Text and roll 
                                                                                                through them.
:ref:`dojox/widget/RollingList <dojox/widget/RollingList>`                         Abandoned    A rolling list that can be tied to a data store with children.
:ref:`dojox/widget/Rotator <dojox/widget/Rotator>`                                 Abandoned    A widget for rotating through child nodes using transitions.
`dojox/widget/Selection`                                                           Maintained   Base class for widgets that manage a list of selected data
                                                                                                items.
:ref:`dojox/widget/SortList <dojox/widget/SortList>`                               Abandoned    A sortable unordered-list with a fixed header.
:ref:`dojox/widget/Standby <dojox/widget/Standby>`                                 Experimental A widget designed to act as a Standby/Busy/Disable/Blocking 
                                                                                                widget to indicate a particular DOM node is processing and 
                                                                                                cannot be clicked on at this time.
:ref:`dojox/widget/TitleGroup <dojox/widget/TitleGroup>`                           Maintained   A container which controls a series of ``dijit/TitlePane``, 
                                                                                                allowing one to be visible and hiding siblings.
:ref:`dojox/widget/Toaster <dojox/widget/Toaster>`                                 Maintained   Message that slides in from the corner of the screen, used 
                                                                                                for notifications like "new email".
:ref:`dojox/widget/UpgradeBar <dojox/widget/UpgradeBar>`                           Experimental Shows a bar at the top of the screen when the user is to be 
                                                                                                notified that they should upgrade their browser or a plugin.
:ref:`dojox/widget/Wizard <dojox/widget/Wizard>`                                   Maintained   A set of panels that display sequentially, typically notating
                                                                                                a step-by-step procedure like an install.
:ref:`dojox/widget/YearlyCalendar <dojox/widget/Calendar>`                         Maintained   A calendar with only a year view.
================================================================================== ============ ==============================================================

Utility Modules
===============

================================================================================== ============ ==============================================================
Package/Module                                                                     Status       Description
================================================================================== ============ ==============================================================
:ref:`dojox/color <dojox/color>`                                                   Maintained   Enhancements to ``dojo/color``.
`dojox/css3`                                                                       Experimental Wrappers for common CSS3 animations.
:ref:`dojox/date/buddhist <dojox/date/buddhist>`                                   Mature       Provides support for Buddhist dates.
:ref:`dojox/date/hebrew <dojox/date/hebrew>`                                       Mature       Provides support for Hebrew dates.
:ref:`dojox/date/islamic <dojox/date/islamic>`                                     Mature       Provides support for Islamic dates.
:ref:`dojox/date/umalqura <dojox/date/umalqura>`                                   Mature       Provides support for Um AlQura dates.
`dojox/date/php`                                                                   Experimental Utilities for handling PHP styled dates.
`dojox/date/posix`                                                                 Experimental Utilities for handling POSIX strftime formatted dates.
:ref:`dojox/date/relative <dojox/date/relative>`                                   Experimental Utilities for handling relative dates.
`dojox/date/timezone`                                                              Experimental Dojo port of fleegix date plugin.
:ref:`dojox/embed <dojox/embed>`                                                   Experimental Wrappers for handling ``<OBJECT>`` and ``<EMBED>`` tags
:ref:`dojox/encoding <dojox/encoding>`                                             Experimental Modules routines for common encoding algorithms.
:ref:`dojox/help <dojox/help>`                                                     Abandoned    Console extensions to allow access to available help resources
:ref:`dojox/highlight <dojox/highlight>`                                           Maintained   Syntax highlighting library.
:ref:`dojox/html <dojox/html>`                                                     Maintained   Less frequently used HTML functions and features.
`dojox/jq`                                                                         Abandoned    A JQuery API compatibility layer.
:ref:`dojox/json/query <dojox/json/query>`                                         Maintained   A comprehensive object data query tool.
:ref:`dojox/json/ref <dojox/json/ref>`                                             Maintained   JSON Referencing capable serializer and deserializer.
:ref:`dojox/json/schema <dojox/json/schema>`                                       Maintained   An object validation tool based on JSON Schema.
`dojox/jsonPath`                                                                   Abandoned    A query system similar in idea to xpath, for for JavaScript
                                                                                                objects.
:ref:`dojox/math <dojox/math>`                                                     Maintained   Various math handling routines
:ref:`dojox/NodeList/delegate <dojox/NodeList/delegate>`                           Maintained   Extends the NodeList with a ``delegate()`` feature.
`dojox/robot/recorder <dojox/robot>`                                               Experimental Semi-automates the creation of DOH robot test scripts.
:ref:`dojox/secure <dojox/secure>`                                                 Abandoned    A collection of utilities for working with untrusted data 
                                                                                                and code.
:ref:`dojox/sql <dojox/sql>`                                                       Abandoned    Code to interface with the Google Gears-specific SQL engine.
:ref:`dojox/string <dojox/string>`                                                 Maintained   Various modules/routines for enhanced string handling.
`dojox/testing/DocTest`                                                            Maintained   A port of Python's DocTests module.
:ref:`dojox/timing <dojox/timing>`                                                 Experimental A framework to deal with advanced timing constructs.
:ref:`dojox/uuid <dojox/uuid>`                                                     Maintained   A library capable of generating UUIDs.
:ref:`dojox/validate <dojox/validate>`                                             Maintained   Various validation functions that can be used for form 
                                                                                                validation.
:ref:`dojox/xml <dojox/xml>`                                                       Maintained   Various XML utilities.
================================================================================== ============ ==============================================================

See Also
========

* :ref:`dojo <dojo/index>` - The core package of Dojo Toolkit.

* :ref:`dijit <dijit/index>` - The main widget package of Dojo Toolkit.