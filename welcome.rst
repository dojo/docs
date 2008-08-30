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

  To successfully migrate the current book, please create an account at this wiki, so we can track changes until LDPA is setup.
  Once you have created an account, please go to the `book outline <bookmigration>`_ and put your name behind the
  section you can help migrating.
  This message will be updated regularly to reflect the current progress.

  Please read the `documentation howto <howto>`_. before starting writing docs

----

Installation
------------

If you've never used Dojo before, it is recommended you read the following sections to ensure you are 'up and running' before proceeding further into the Guides. These sections provide fundamental Dojo practices, and are invaluable in ensuring a quick start to Dojo:

* `How to Install the Dojo Toolkit <quickstart/install>`_
* `Functions used *everywhere* <quickstart/dojo-basics>`_

Getting started
---------------

Dojo is a very extensive library of code, most of which is optional. Here are some "Getting Started" guides that show common uses of technologies provided by the Toolkit. You can learn more about individual components in each sub-project (dojo, dijit, and dojox) in later sections, as these only skim the surface of HOWTO do things:

* `UI Development <quickstart/interfacedesign>`_
* `Back buttons <quickstart/back>`_
* `AJAX <quickstart/ajax>`_
* `Charting <quickstart/charting>`_
* `Data stores (dojo.data) <quickstart/data>`_

  * `Using Datastores <quickstart/data/usingdatastores>`_

    * `A Simple Data Source <quickstart/data/usingdatastores/simple>`_
    * `Fetching Single Items and Values <quickstart/data/usingdatastores/fetchsingle>`_
    * `Fetching Multiple Items and Values <quickstart/data/usingdatastores/fetchmultiple>`_
    * `Selecting (Filtering) Items <quickstart/data/usingdatastores/filteringitems>`_
    * `Nested Items and Lazy Loading <quickstart/data/usingdatastores/lazyloading>`_
    * `Paging data <quickstart/data/usingdatastores/pagination>`_
    * `Sorting Items <quickstart/data/usingdatastores/sorting>`_

* `The event system <quickstart/events>`_
* `Parsing, Formatting and Validating Numbers and Dates <quickstart/numbersDates>`_
* `Arrays, Node lists <quickstart/arrays>`_
* `Browser Sniffing <quickstart/browser-sniffing>`_

----

Dojo reference                                                 
--------------

Dojo is divided into two parts: Dojo Base, and Dojo Core. Dojo Base is the functionality provided for by just including ``dojo.js``, and Dojo Core is comprised of stable additional (optional) components. Typically, if a function or Class exists within the dojo namespace directly (eg: dojo.require(), dojo.addOnLoad()) it is part of Base Dojo. If the function or Class exists beneath the dojo namespace (eg: dojo.dnd.Mover), you will need to require the appropriate module (eg: dojo.require("dojo.dnd.Mover");) 

These pages cover both cases, and indicate how they are provided. 

* `dojo <dojo>`_
* `dojo._base <dojo/base>`_
* `dojo.addOnLoad <dojo/addOnLoad>`_
* `dojo.array <dojo/array>`_
* `dojo.browser <dojo/browser>`_
* `dojo.connect <dojo/connect>`_
* `dojo.Color <dojo/Color>`_
* `dojo.declare <dojo/declare>`_
* `dojo.data <dojo/data>`_

  * `dojo.data.api <dojo/data/api>`_
  * `dojo.data.api.Read <dojo/data/api/Read>`_
  * `dojo.data.api.Write <dojo/data/api/Write>`_
  * `dojo.data.api.Identity <dojo/data/api/Identity>`_
  * `dojo.data.api.Notification <dojo/data/api/Notification>`_
  * `dojo.data.ItemFileReadStore <dojo/data/ItemFileReadStore>`_
  * `dojo.data.ItemFileWriteStore <dojo/data/ItemFileWriteStore>`_

* `dojo.date <dojo/date>`_

  * `dojo.date.locale.format <dojo/date/locale/format>`_

* `dojo.Deferred <dojo/Deferred>`_
* `dojo.DeferredList <dojo/DeferredList>`_
* `dojo.fx <dojo/fx>`_
* `dojo.html <dojo/html>`_
* `dojo.json <dojo/json>`_
* `dojo.keys <dojo/keys>`_ 
* `dojo.lang <dojo/lang>`_
* `dojo.map <dojo/map>`_
* `dojo.NodeList <dojo/NodeList>`_
* `dojo.window <dojo/window>`_
* `dojo.xhr <dojo/xhr>`_
* `dojo.byId <dojo/byId>`_
* `dojo.connect <dojo/connect>`_
* `dojo.forEach <dojo/forEach>`_
* `dojo.query <dojo/query>`_
* `dojo.require <dojo/require>`_

Dijit reference
---------------

Dijit is Dojo's UI Library, and lives as a separate namespace ``dijit``. Dijit requires Dojo Core. Each of the widgets and functionality provided by Dijit is describe in the following sections, though the aforementioned `quickstart <quickstart/>`_ guides cover some basics.  

* `dijit <dijit>`_

  * `dijit a11y <dijit-a11y-strategy>`_
  * `dijit a11y resources <dijit-a11y-resources>`_

* `dijit.Dialog <dijit/Dialog>`_
* `dijit.Editor <dijit/Editor>`_
* `dijit.Tree <dijit/Tree>`_

  * `dijit.tree.Model <dijit/tree/Model>`_
  * `dijit.tree.TreeStoreModel <dijit/tree/ForestStoreModel>`_
  * `dijit.tree.ForestStoreModel <dijit/tree/ForestStoreModel>`_

* `dijit.form <dijit/form>`_

  * `dijit.form.Form <dijit/form/Form>`_
  * `dijit.form.NumberSpinner <dijit/form/NumberSpinner>`_
  * `dijit.form.RadioButton <dijit/form/RadioButton>`_
  * `dijit.form.Button <dijit/form/Button>`_
  * `dijit.form.ComboButton <dijit/form/ComboButton>`_
  * `dijit.form.DropDownButton <dijit/form/DropDownButton>`_
  * `dijit.form.CheckBox <dijit/form/CheckBox>`_
  * `dijit.form.Slider <dijit/form/Slider>`_
  * `dijit.form.ComboBox <dijit/form/ComboBox>`_
  * `dijit.form.FilteringSelect <dijit/form/FilteringSelect>`_
  * `dijit.form.TextBox <dijit/form/TextBox>`_
  * `dijit.form.NumberTextBox <dijit/form/NumberTextBox>`_
  * `dijit.form.CurrencyTextBox <dijit/form/CurrencyTextBox>`_
  * `dijit.form.DateTextBox <dijit/form/DateTextBox>`_
  * `dijit.form.TimeTextBox <dijit/form/TimeTextBox>`_
  * `dijit.form.ValidationTextBox <dijit/form/ValidationTextBox>`_

* `dijit.layout <dijit/layout>`_

  * `dijit.layout.ContentPane <dijit/layout/ContentPane>`_
  * `dijit.layout.BorderContainer <dijit/layout/BorderContainer>`_
  * `dijit.layout.StackContainer <dijit/layout/StackContainer>`_
  * `dijit.layout.AccordionContainer <dijit/layout/AccordionContainer>`_
  * `dijit.layout.TabContainer <dijit/layout/TabContainer>`_

* `dijit.ProgressBar <dijit/ProgressBar>`_

Dojox reference
---------------

DojoX serves many purposes, and by design is difficult to document. Here, we have an ongoing effort to document the most used, stable, reliable and powerful aspects of DojoX. DojoX contains code in alpha and experimental states, so your assistance in testing and documenting are especially helpful. 

These sections cover the available projects shipped with the Dojo Toolkit

* `dojox <dojox>`_
* `dojox.analytics <dojox/analytics>`_

  * `dojox.analytics.Urchin <dojox/analytics/Urchin>`_

* `dojox.data <dojox/data>`_

  * `dojox.data.FileStore <dojox/data/FileStore>`_
  * `dojox.data.JsonRestStore <dojox/data/JsonRestStore>`_
  * `dojox.data.ServiceStore <dojox/data/ServiceStore>`_

* `dojox.grid <dojox/grid>`_
* `dojox.cometd <dojox/cometd>`_
* `dojox.rpc <dojox/rpc>`_
  
  * `dojox.rpc.SMDLibrary <dojox/rpc/SMDLibrary>`_
  * `dojox.rpc.Service <dojox/rpc/Service>`_

* `dojox.widget <dojox/widget>`_

  * `dojox.widget.Toaster <dojox/widget/Toaster>`_
  * `dojox.widget.Roller <dojox/widget/Roller>`_

* `dojox.form <dojox/form>`_

  * `dojox.form.BusyButton <dojox/form/BusyButton>`_
  * `dojox.form.Rating <dojox/form/Rating>`_

* `dojox.image <dojox/image>`_

  * `dojox.image.Lightbox <dojox/image/Lightbox>`_

* `dojox.highlight <dojox/highlight>`_

* `dojox.fx <dojox/fx>`_

  * `dojox.fx.wipeTo <dojox/fx/wipeTo>`_

----

DojoC
-----

DojoC is an svn repository used by DojoCampus for a variety of widgets, tutorials, sandbox, and other demos. You are welcome to explore and contribute, though absolutely nothing is guaranteed to work. DojoC is meant as a community workshop, and code comes and goes frequently, often times 'promoted' to `DojoX projects <dojox>`_. 

* `More about DojoC <dojoc>`_

----

Documentation guidelines
------------------------

* `How to become a dojo doc ninja <howto>`_
* `Behind the scenes <internals>`_
* `A big "thank you"! <thank-you>`_
