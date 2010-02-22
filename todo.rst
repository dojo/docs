#format dojo_rst

Docu Wiki ToDo
==============

.. contents::
   :depth: 2

Starting with V1.3 each new feature needs a proper documentation at docs.dojocampus.org - otherwise it will not be included in DojoToolkit. But besides that, there is still a lot of old stuff without proper documentation. 

The following pages need more love:


=====================
Top priority: dojo.js
=====================

* `dojo.Animation <dojo/Animation>`_ ``peller, slightlyoff, dante``

  needed: full page

* `dojo.anim <dojo/anim>`_

  needed: full page

* `dojo.eval <dojo/eval>`_

  needed: review

* `dojo.provide <dojo/provide>`_

  needed: review necessary

* `dojo.moduleUrl <dojo/moduleUrl>`_

  needed: review necessary


=====================
Priority 2: Dojo Core
=====================

* `dojo.AdapterRegistry <dojo/AdapterRegistry>`_

  needed: full page

* `dojo.colors <dojo/colors>`_

  needed: full page

* `dojo.cookie <dojo/cookie>`_

  needed: review

* `dojo.currency <dojo/currency>`_

  needed: setting locale in Dojo, binary floating point issues

* `dojo.rpc.JsonpService <dojo/rpc/JsonpService>`_

  needed: full page

* `dojo.rpc.JsonService <dojo/rpc/JsonService>`_

  needed: full page

* `dojo.rpc.RpcService <dojo/rpc/RpcService>`_

  needed: full page


=================
Priority 3: Dijit
=================

* `dijit._HasDropDown <dijit/_HasDropDown>`_

  needed: full page

* `dijit.form._FormSelectWidget <dijit/form/_FormSelectWidget>`_

  needed: full page

* `dijit.layout.LinkPane <dijit/layout/LinkPane>`_

  needed: full page


=================
Priority 4: DojoX
=================

* `dojox.analytics <dojox/analytics>`_ ``dmachi, phiggins``

  needed: examples or subpages?

* `dojox.atom.widget.FeedViewer <dojox/atom/widget/FeedViewer>`_

  needed: Document the widgets. The IO layer is already documented.

* `dojox.atom.widget.FeedEntryViewer <dojox/atom/widget/FeedEntryViewer>`_

  needed: Document the widgets. The IO layer is already documented.

* `dojox.atom.widget.FeedEntryEditor <dojox/atom/widget/FeedEntryEditor>`_

  needed: Document the widgets. The IO layer is already documented.

* `dojox.av.FLAudio <dojox/av/FLAudio>`_

  needed: errors in the example, no audio directory within tests available on the server

* `dojox.charting <dojox/charting>`_ ``ttrenka``

  needed: explanation about periodic updating, split apart into multiple pages for each major concept, add inline chart demos, add chart and legend widget properties/events table, using dojo data sources with charts/chart widgets

* `dojox.collections <dojox/collections>`_

  needed: full page

* `dojox.DataGrid <dojox/DataGrid>`_ ``bforbes, toonetown``

  needed: Introduction, Grid 1.2 Changes, Usage, Parameter "selection mode", Example "sorting data at the server", Example "Large datasets", Tips

* `dojox/data/QueryReadStore/example <dojox/data/QueryReadStore/example>`_

  This example is unfinished, should we delete it?

* `dojox.form.DateTextBox <dojox/form/DateTextBox>`_

  needed: full page

* `dojox.form.DropDownStack <dojox/form/DropDownStack>`_

  needed: full page

* `dojox.form.MultiComboBox <dojox/form/MultiComboBox>`_

  needed: full page

* `dojox.form.RangeSlider <dojox/form/RangeSlider>`_

  needed: full page

* `dojox.form.TimeSpinner <dojox/form/TimeSpinner>`_

  needed: full page

* `dojox.gfx <dojox/gfx>`_ 

  needed: split apart into multiple pages for each major concept, add inline gfx demos

* `dojox.html.metrics <dojox/html/metrics>`_

  needed: full page

* `dojox.html.styles <dojox/html/styles>`_

  needed: full page


* `dojox.image.Badge <dojox/image/Badge>`_

  needed: full page

* `dojox.image.MagnifierLite <dojox/image/MagnifierLite>`__

  needed: available parameters and their description

* `dojox.io.httpParse <dojox/io/httpParse>`_

  needed: full page

* `dojox.io.OAuth <dojox/io/OAuth>`_

  needed: usage, examples

* `dojox.io.scriptFrame <dojox/io/scriptFrame>`_

  needed: full page

* `dojox.io.windowName <dojox/io/windowName>`_

  needed: full page

* `dojox.io.xhrMultiPart <dojox/io/xhrMultiPart>`_

  needed: full page

* `dojox.io.xhrPlugins <dojox/io/xhrPlugins>`_

  needed: usage, examples

* `dojox.io.xhrWindowNamePlugin <dojox/io/xhrWindowNamePlugin>`_

  needed: full page

* `dojox.layout.ContentPane <dojox/layout/ContentPane>`_

  needed: full page

* `dojox.layout.DragPane <dojox/layout/DragPane>`_

  needed: full page

* `dojox.layout.ExpandoPane <dojox/layout/ExpandoPane>`_

  needed: full page

* `dojox.layout.GridContainer <dojox/layout/GridContainer>`_

  needed: params, examples, adding/removing regions, columns

* `dojox.layout.RadioGroup <dojox/layout/RadioGroup>`_

  needed: full page

* `dojox.layout.ScrollPane <dojox/layout/ScrollPane>`_

  needed: full page

* `dojox.layout.ToggleSplitter <dojox/layout/ToggleSplitter>`_

  needed: full page

* `dojox.widget.FisheyeList <dojox/widget/FisheyeList>`_ 

  needed: full page

* `dojox.widget.DataPresentation <dojox/widget/DataPresentation>`_

  add changes from http://trac.dojotoolkit.org/changeset/20698 (allow the line stroke style to be customized)


==================================
Integration with Dojo
==================================

We're working on documentation for how to use Dojo with various servers and other environments.  To claim one of the following, just add your name in the () at the beginning of the line and talk with Dylan Schiemann if you have any questions:

* ( ) ItemFileReadStore of Dojo Committers: (firstname, lastname, city)  (needed for all other demos)
* ( ) Basic Dojo-based UI for displaying information about committers... tundra theme, DTL-based table view of committers, etc.
* ( ) Java: JSP
* ( ) Java: Servlet
* ( ) Java: Persevere
* ( ) Java: DWR
* ( ) Java: Spring
* ( ) Java: AppEngine
* ( ) Java: WebSphere
* ( ) Java: Jetty
* ( ) PHP: plain
* ( ) PHP: Zend Framework
* ( ) PHP: WordPress
* ( ) Python: plain
* (Tobias) Python: Django/Dojango
* ( ) Python: Orbited
* ( ) Python: Tornado
* ( ) Python: Django
* ( ) Python: TurboGears
* ( ) Python: AppEngine
* ( ) Perl: plain
* ( ) Ruby: Rails
* ( ) Erlang: ErlyWeb/ErlyComet
* ( ) Compuware Uniface
* ( ) ProjectZero
* ( ) WaveMaker
* ( ) iPhone
* ( ) Android
* ( ) Palm Pre
* ( ) Vodafone widgets
* ( ) Facebook apps
