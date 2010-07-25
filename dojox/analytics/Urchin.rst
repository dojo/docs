#format dojo_rst

dojox.analytics.Urchin
======================

:Status: Draft
:Version: 1.0
:Project owner: Peter Higgins
:Available: since V1.2

.. contents::
   :depth: 2

This class is used to delay loading of the popular `Google Analytics <http://google.com/analytics>`_ Tracker, formerly known as Urchin. The synchronous nature of ``<script>`` tags causes page rendering to stall until loading of remote files has completed, and this module alleviates that. 

To use, require the Urchin module into your page, and create a new instance:

.. code-block :: javascript
  :linenos:

  dojo.require("dojox.analytics.Urchin");
  dojo.addOnLoad(function(){
      new dojox.analytics.Urchin({ acct:"UA-12345-67" });
  });

The most important attribute (parameter) would be the `acct` value, which should be the ID Google prodivded during signup.

You can define your account number as a djConfig parameter ``urchin``. Simply include the key and a value however you set djConfig, either before ``dojo.js`` is loaded:

.. code-block :: javascript
  :linenos: 

  <script type="text/javascript">
     var djConfig = { urchin: "UA-12345-67" };
  </script>
  <script src="http://o.aolcdn.com/dojo/1.5/dojo/dojo.xd.js"></script>

or directly on the djConfig attribute of your ``dojo.js`` script tag:

.. code-block :: javascript
  :linenos:

   <script src="js/dojo/dojo.js" djConfig="urchin: UA-12345-67"></script>

Being a Class constructor, you can also use Urchin with a ``dojoType``. Assuming you have ``dojo.require``'d the Urchin module, and have parseOnLoad:true (or manually run the `parser <dojo/parser>`_), you simply need to add a tag somewhere in your page:

.. code-block :: html
  :linenos:

     <div dojoType="dojox.analytics.Urchin" acct="UA-12345-67"></div>

Ajax-API
--------

The urchin tracker allows you to add additional tracking to Ajax/long-lived pages with dynamic content. When you wish to send a new tracker request, call ``trackPageView`` with some identifier, and Google will track it as a separate hit:

.. code-block :: javascript
  :linenos:

   var tracker = new dojox.ananlytics.Urchin({ acct:"UA-12345-67" });
   // later:
   tracker.trackPageView("/some-newURL");

You can do this as often as you like during the lifetime of a single page view. 

**NOTE**: The initial page view is tracked as part of the ``GAonLoad`` event fired, so there is no need to do it manually. You will not, however, be able to call trackPageView() until after GAonLoad has fired.

.. code-block :: javascript
  :linenos:

   var tracker = new dojox.ananlytics.Urchin({ acct:"UA-12345-67" });
   dojo.connect(tracker, "GAonLoad", function(){
       tracker.trackPageView("/some-otherURL");
   });

This is provided only as a convenience, and to have a reliable way of being alerted when Google Ananlytics is ready. 

You can also do this as a shorthand, too. If you want to prevent the automatic tracking, and only track a custom-ajax page onload:

.. code-block :: javascript
  :linenos:

  new dojox.analytics.Urchin({ acct:"UA-12345-67", 
     GAonLoad: function(){
         this.trackPageView("/special/pageload")
     }
  });
  

Optional Parameters
-------------------

In Dojo 1.3 and before, these parameters existed. In Dojo 1.4, they have been removed for a more robust solution. Disregard this following information if you are using Dojo 1.4 or higher. 

There is only one optional parameter: ``loadInterval``. This defines the time in ms to repoll for the availability of the Google tracker. Set to a higher number for less processing, and a lower number for more frequent checks. Default is 420 in Dojo 1.2, and 42 in Dojo versions 1.3 and higher.

The reduction in default interval time is the result of implementing a decaying timer, to ensure the analyitics tracker was loaded as quickly as possible, without continually running in the event the tracker is never resolved. These options are defined by the ``decay``, ``timeout``, and ``loadInterval`` parameters. ``timeout`` defines the time in ms the ``loadInterval`` can become before quitting, and the ``decay`` defines a float to increment the ``loadInterval`` by. The default ``decay`` is 0.5, incrementing the interval by 50% on each iteration. eg:

100, 150, 225, 345 ...

When the ``timeout`` is reached, the tracker fails. ``GAonLoad`` will not fire, so ensure you do not call a reference to the tracker until after GAonLoad fires.
