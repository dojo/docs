#format dojo_rst

dojox.analytics
===============

:Status: Draft
:Version: 1.0
:Project owner: Dustin Machi
:Available: since 1.1

.. contents::
   :depth: 2

Analytics is an analytic and client monitoring system. Including the base analytics system and any number of plugins enables logging of different system data back to the server.


============
Introduction
============

Plugins included at this time: 

* dojo - reports dojo startup  collected information
* window - reports available window information to the server
* mouseOver - allows periodic sampling of mouseOver 
* mouseClick - reports any mouse clicks to the server
* idle - reports idle/activity 
* consoleMessages - reports console.* messages to the server	

Additionally, a `Google Ananlytics <dojox/analytics/Urchin>`_ (Urchin tracker) helper is included in this project, though is unrelated to the Core dojox.analytics project code. 


=====
Usage
=====

  Usage of the core analytics system is simple.  At its base it is simply a logger for pushing data off to the server without interfering with the normal operation of the page.  There are a number of djConfig options that will affect the overall behavior of the core system, and others that apply only to specific analytics plugins.  After a normal dojo.js include with the appropriate djCOnfig settings, all that needs to be done is to require the analytics module and any of the plugins you wish to use.  In practice, it is better to create a custom base build of dojo that includes the analytics component and any modules you want to use for your pages.  This will minimally increase the size of your dojo.js (Only a few K depending on which/how many modules you enable), but will be available immediately and can easily be added/removed from your overall code base by simply using dojo.js or AnalyticsDojo.js at your leisure.

.. code-block :: javascript
  :linenos:

   <script type="text/javascript" src="dojotoolkit/dojo/dojo.js"
	  djConfig="djConfig: true, sendInterval: 5000, analyticsUrl: 'http://server/path/to/dataLogger'"></script>

   <script language="JavaScript" type="text/javascript">
          // include the analytics system
          dojo.require("dojox.analytics");

          // this plugin returns the informatin dojo collects when it launches 
	  dojo.require("dojox.analytics.plugins.dojo");

	  // this plugin return the information the window has when it launches
	  // and it also ties to a few events such as window.option
	  dojo.require("dojox.analytics.plugins.window");

	  // this plugin tracks console. message, It logs console.error, warn, and 
	  // info messages to the tracker.  It also defines console.rlog() which 
	  // can be used to log only to the server.  Note that if isDebug() is disabled
	  // you will still see the console messages on the sever, but not in the actual
	  // browser console.
	  dojo.require("dojox.analytics.plugins.consoleMessages");

	  // tracks where a mouse is on a page an what it is over, periodically sampling
	  // and storing this data
	  dojo.require("dojox.analytics.plugins.mouseOver");

	  //tracks mouse clicks on the page
	  dojo.require("dojox.analytics.plugins.mouseClick");

	  //tracks when the user has gone idle
	  dojo.require("dojox.analytics.plugins.idle");
		
    </script>

==========================
Available djConfig Options
==========================

Base
==== 
 * sendInterval - The time between posts of new data to the server. Data will be queued and then sent off when the interval has passed. Defaults to 5000 ms
 * inTransitRetry - If the interval has passed and the client already has an in progress transmission, the client will back off this amount of time. Defaults to 200ms
 * dataUrl - The url you wish to send the data logs to
 * sendMode - The method by which data is sent to the server. "xhrPost"(default) or "script" for x-domain delivery.
 * maxRequestSize - Limit the size of messages to this length.  Defaults to 2000 for IE and 4000 otherwise.  This is need to limit the size of urls in the script use case

consoleMessages
===============
 * consoleLogFuncs - array of console functions you want to be logged to the server.  Defaults to ["error", "warn", "info", "rlog"].  Note that you can place arbitrary names in this list, and if that function doesn't exist it will become available to your console object.  For exmaple, console.rlog("foo") will be sent to the server in this case.

idle
=====
 * idleTime - Time after which the user will be considered idle. Defaults to 60000 ms.

mouseOver
=========
 * sampleDelay - Time between mouseover samples, defaults to 2500ms
 * targetProps - The even properties we want to save from a 'sample'. Defaults to id, className, localName, href, spellcheck, lang, textContent, value

window
======
 * windowConnects - Defines global functions that the analytics system will connect to and log use of. Defaults to "open" and "onerror"

=============================
Declaring an Analytics Plugin
=============================

An analytics plugin is simply a function that takes advantage of the base analytics logger.  There is only one method of substance, and that is the "addData" method of dojox.analytics (base).  A module will typically create its own addData method which is hitched to the base addData, like this:

.. code-block :: javascript
  :linenos:

   myPlugin = new (function(){
    this.addData = dojo.hitch(dojox.analytics, "addData", "myPlugin")
   })();

Subsequently, the function can connect to an event or do some other function that will trigger its addData to be called.  Each "entry" in the logs will then contain ["myPlugin", passedData].


See also
========

* http://www.sitepen.com/blog/2008/03/13/analyze-your-code-errors-interface-and-marketing-effectiveness-with-dojoxanalytics/
