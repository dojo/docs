#format rst

Welcome to the official documentation pages of the DojoToolkit
==============================================================

:Status: Draft

.. contents::
    :depth: 3

.. image:: http://media.dojocampus.org/images/docs/logodojocdocssmall.png
   :alt: Dojo Documentation
   :class: logowelcome;

This is an open effort for anyone interested to join. If you want to contribute documentation please read the Documentation guidelines. 
Use the search box, it is very helpful and usually brings you to the page you need. If you are for example looking for "dojo.connect" simply enter "dojo connect".

The documentation is aiming to cover all dojo modules delivered within a release. If you are missing things or have ideas, don't hesitate to contact the documentation team.

----

  To successfully migrate the current book, use your dojotoolkit.org account to log in. Also take a look at the `book outline <bookmigration>`_ and put your name behind the section you can help to migrate.
  This message will be updated regularly to reflect the current progress.

  Please read the `documentation howto <howto>`_. before starting writing docs

----

============
Installation
============

If you've never used Dojo before, it is recommended you read the following sections to ensure you are 'up and running' before proceeding further into the Guides. These sections provide fundamental Dojo practices, and are invaluable in ensuring a quick start to Dojo:

* `How to Install the Dojo Toolkit <quickstart/install>`_
* `Functions used *everywhere* <quickstart/dojo-basics>`_

===============
Getting started
===============

Dojo is a very extensive library of code, most of which is optional. Here are some "Getting Started" guides that show common uses of technologies provided by the Toolkit. You can learn more about individual components in each sub-project (dojo, dijit, and dojox) in later sections, as these only skim the surface of HOWTO do things:

* `UI Development <quickstart/interfacedesign>`_
* `Back buttons <quickstart/back>`_
* `AJAX <quickstart/ajax>`_
* `Charting <quickstart/charting>`_
*  Widgets

  *  General info: see `dijit <dijit>`_ page
  *  `Writing Widgets <quickstart/writingWidgets>`_

* `Data stores (dojo.data) <quickstart/data>`_

  * `Using Datastores <quickstart/data/usingdatastores>`_

    * `Terminology <quickstart/data/usingdatastores/terminology>`_
    * `A Simple Data Source <quickstart/data/usingdatastores/simple>`_
    * `Fetching Single Items and Values <quickstart/data/usingdatastores/fetchsingle>`_
    * `Fetching Multiple Items and Values <quickstart/data/usingdatastores/fetchmultiple>`_
    * `Selecting (Filtering) Items <quickstart/data/usingdatastores/filteringitems>`_
    * `Nested Items and Lazy Loading <quickstart/data/usingdatastores/lazyloading>`_
    * `Paging data <quickstart/data/usingdatastores/pagination>`_
    * `Sorting Items <quickstart/data/usingdatastores/sorting>`_
    * `FAQ (frequent questions about using dojo.data) <quickstart/data/usingdatastores/faq>`_

* `The event system <quickstart/events>`_
* `Parsing, Formatting and Validating Numbers and Dates <quickstart/numbersDates>`_
* `Arrays, Node lists <quickstart/arrays>`_
* `Browser Sniffing <quickstart/browser-sniffing>`_

----

==============
Dojo reference                                                 
==============

* `dojo <dojo>`_

  Dojo is divided into two parts: Dojo Base, and Dojo Core. Dojo Base is the functionality provided for by just including ``dojo.js``, and Dojo Core is comprised of stable additional (optional) components. Typically, if a function or Class exists within the dojo namespace directly (eg: dojo.require(), dojo.addOnLoad()) it is part of Base Dojo. If the function or Class exists beneath the dojo namespace (eg: dojo.dnd.Mover), you will need to require the appropriate module (eg: dojo.require("dojo.dnd.Mover");) 

  These pages cover both cases, and indicate how they are provided. 

Dojo Base
---------

Dojo Base is the functionality you get by just including dojo.js or dojo.xd.js in your page.

* `dojo._base <dojo/base>`_

  * `dojo.array <dojo/array>`_

    Array utilities.
    Details on dojo.every, dojo.filter, dojo.forEach, dojo.indexOf, dojo.lastIndexOf, dojo.map, and dojo.some.

  * `dojo.browser <dojo/browser>`_
  * `dojo.Color <dojo/Color>`_
  * `dojo.connect <dojo/connect>`_
  * `dojo.declare <dojo/declare>`_
  * `dojo.Deferred <dojo/Deferred>`_
  * `dojo.event <dojo/event>`_
  * `dojo.fx <dojo/fx>`_ Dojo effects
  * `dojo.html <dojo/html>`_
  * `dojo.json <dojo/json>`_
  * `dojo.lang <dojo/lang>`_
  * `dojo.NodeList <dojo/NodeList>`_
  * `dojo.query <dojo/query>`_
  * `dojo.window <dojo/window>`_
  * `dojo.xhr <dojo/xhr>`_

Dojo Core
---------

* `dojo.AdapterRegistry <dojo/AdapterRegistry>`_
* `dojo.addOnLoad <dojo/addOnLoad>`_
* `dojo.back <dojo/back>`_

  Browser history management resources

* `dojo.behavior <dojo/behavior>`_
* `dojo.cldr <dojo/cldr>`_

  transformation of relevant pieces of the Unicode.org Common Locale Data Repository to JSON

* `dojo.colors <dojo/colors>`_

  Color utilities

* `dojo.cookie <dojo/cookie>`_
* `dojo.currency <dojo/currency>`_

  localized formatting and parsing routines for currencies

* `dojo.data <dojo/data>`_

  Dojo data

  * `dojo.data.api <dojo/data/api>`_ 
  * `dojo.data.api.Read <dojo/data/api/Read>`_
  * `dojo.data.api.Write <dojo/data/api/Write>`_
  * `dojo.data.api.Identity <dojo/data/api/Identity>`_
  * `dojo.data.api.Notification <dojo/data/api/Notification>`_
  * `dojo.data.ItemFileReadStore <dojo/data/ItemFileReadStore>`_
  * `dojo.data.ItemFileWriteStore <dojo/data/ItemFileWriteStore>`_

* `dojo.date <dojo/date>`_

  * `dojo.date.locale.format <dojo/date/locale/format>`_

* `dojo.DeferredList <dojo/DeferredList>`_
* `dojo.dnd <dojo/dnd>`_

  Drag and Drop

  * `dojo.dnd.Moveable <dojo/dnd/Moveable>`_

* `dojo.html <dojo/html>`_
* `dojo.json <dojo/json>`_
* `dojo.keys <dojo/keys>`_ 
* `dojo.lang <dojo/lang>`_
* `dojo.map <dojo/map>`_

TODO:

* `dojo.byId <dojo/byId>`_
* `dojo.forEach <dojo/forEach>`_
* `dojo.require <dojo/require>`_
* `dojo.animateProperty <dojo/animateProperty>`_



===============
Dijit reference
===============

Dijit is Dojo's UI Library, and lives as a separate namespace ``dijit``. Dijit requires Dojo Core. Each of the widgets and functionality provided by Dijit is describe in the following sections, though the aforementioned `quickstart <quickstart/>`_ guides cover some basics.  

* `dijit <dijit>`_

  * `a11y Strategy <dijit-a11y-strategy>`_

    * `a11y Resources <dijit-a11y-resources>`_
    * `Creating Accessible Widgets <quickstart/writingWidgets/a11y>`_
    * `Testing for Accessibility <quickstart/writingWidgets/a11yTesting>`_

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
    * `dijit.form.DateTextBox <dijit/form/DateTextBox>`_
    * `dijit.form.NumberSpinner <dijit/form/NumberSpinner>`_
    * `dijit.form.NumberTextBox <dijit/form/NumberTextBox>`_
    * `dijit.form.TextBox <dijit/form/TextBox>`_
    * `dijit.form.TimeTextBox <dijit/form/TimeTextBox>`_
    * `dijit.form.ValidationTextBox <dijit/form/ValidationTextBox>`_
 
  * select type widgets

    * `dijit.form.ComboBox <dijit/form/ComboBox>`_
    * `dijit.form.FilteringSelect <dijit/form/FilteringSelect>`_

  * buttons

    * `dijit.form.Button <dijit/form/Button>`_
    * `dijit.form.ComboButton <dijit/form/ComboButton>`_
    * `dijit.form.DropDownButton <dijit/form/DropDownButton>`_

  * other controls

    * `dijit.form.CheckBox <dijit/form/CheckBox>`_
    * `dijit.form.Form <dijit/form/Form>`_ (widget corresponding to the form itself)
    * `dijit.form.RadioButton <dijit/form/RadioButton>`_
    * `dijit.form.Slider <dijit/form/Slider>`_

Layout
------

* `dijit.layout <dijit/layout>`_

  * `dijit.layout.AccordionContainer <dijit/layout/AccordionContainer>`_
  * `dijit.layout.BorderContainer <dijit/layout/BorderContainer>`_
  * `dijit.layout.ContentPane <dijit/layout/ContentPane>`_
  * `dijit.layout.StackContainer <dijit/layout/StackContainer>`_
  * `dijit.layout.TabContainer <dijit/layout/TabContainer>`_


===============
DojoX reference
===============

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

  * `dojox.data.AndOrReadStore <dojox/data/AndOrReadStore>`_
  * `dojox.data.AndOrWriteStore <dojox/data/AndOrWriteStore>`_
  * `dojox.data.AtomReadStore <dojox/data/AtomReadStore>`_
  * `dojox.data.CouchDBRestStore <dojox/data/CouchDBRestStore>`_
  * `dojox.data.CssClassStore <dojox/data/CssClassStore>`_
  * `dojox.data.CssRuleStore <dojox/data/CssRuleStore>`_
  * `dojox.data.CsvStore <dojox/data/CsvStore>`_
  * `dojox.data.FileStore <dojox/data/FileStore>`_
  * `dojox.data.FlickrRestStore <dojox/data/FlickrRestStore>`_
  * `dojox.data.FlickrStore <dojox/data/FlickrStore>`_
  * `dojox.data.GoogleFeedStore <dojox/data/GoogleFeedStore>`_
  * `dojox.data.GoogleSearchStore <dojox/data/GoogleSearchStore>`_
  * `dojox.data.HtmlStore <dojox/data/HtmlStore>`_
  * `dojox.data.HtmlTableStore <dojox/data/HtmlTableStore>`_
  * `dojox.data.jsonPathStore <dojox/data/jsonPathStore>`_
  * `dojox.data.JsonRestStore <dojox/data/JsonRestStore>`_
  * `dojox.data.KeyValueStore <dojox/data/KeyValueStore>`_
  * `dojox.data.OpmlStore <dojox/data/OpmlStore>`_
  * `dojox.data.PersevereStore <dojox/data/PersevereStore>`_
  * `dojox.data.PicasaStore <dojox/data/PicasaStore>`_
  * `dojox.data.QueryReadStore <dojox/data/QueryReadStore>`_
  * `dojox.data.S3Store <dojox/data/S3Store>`_
  * `dojox.data.ServiceStore <dojox/data/ServiceStore>`_
  * `dojox.data.SnapLogicStore <dojox/data/SnapLogicStore>`_
  * `dojox.data.WikipediaStore <dojox/data/WikipediaStore>`_
  * `dojox.data.XmlStore <dojox/data/XmlStore>`_

* `dojox.date <dojox/date>`_
* `dojox.dtl <dojox/dtl>`_
* `dojox.editor <dojox/editor>`_
* `dojox.embed <dojox/embed>`_
* `dojox.encoding <dojox/encoding>`_
* `dojox.flash <dojox/flash>`_
* `dojox.form <dojox/form>`_

  * `dojox.form.BusyButton <dojox/form/BusyButton>`_
  * `dojox.form.Rating <dojox/form/Rating>`_

* `dojox.fx <dojox/fx>`_

  * `dojox.fx.wipeTo <dojox/fx/wipeTo>`_

* `dojox.gfx <dojox/gfx>`_
* `dojox.gfx3d <dojox/gfx3d>`_
* `dojox.grid <dojox/grid>`_
* `dojox.help <dojox/help>`_
* `dojox.highlight <dojox/highlight>`_
* `dojox.html <dojox/html>`_
* `dojox.image <dojox/image>`_

  * `dojox.image.Lightbox <dojox/image/Lightbox>`_

* `dojox.io <dojox/io>`_
* `dojox.json <dojox/json>`_
* `dojox.jsonPath <dojox/jsonPath>`_
* `dojox.lang <dojox/lang>`_
* `dojox.layout <dojox/layout>`_
* `dojox.math <dojox/math>`_
* `dojox.off <dojox/off>`_
* `dojox.presentation <dojox/presentation>`_
* `dojox.resources <dojox/resources>`_
* `dojox.robot <dojox/robot>`_
* `dojox.rpc <dojox/rpc>`_

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

  * `dojox.widget.Toaster <dojox/widget/Toaster>`_
  * `dojox.widget.Roller <dojox/widget/Roller>`_

* `dojox.wire <dojox/wire>`_
* `dojox.xml <dojox/xml>`_
* `dojox.xmpp <dojox/xmpp>`_



----

=====
DojoC
=====

DojoC is an svn repository used by DojoCampus for a variety of widgets, tutorials, sandbox, and other demos. You are welcome to explore and contribute, though absolutely nothing is guaranteed to work. DojoC is meant as a community workshop, and code comes and goes frequently, often times 'promoted' to `DojoX projects <dojox>`_. 

* `More about DojoC <dojoc>`_

----

========================
Documentation guidelines
========================

* `How to become a dojo doc ninja <howto>`_
* `Behind the scenes <internals>`_
* `A big "thank you"! <thank-you>`_
