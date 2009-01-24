#format dojo_rst

:Status: Draft
:Version: 1.0
:Project owner: ?--
:Available: since V?

.. contents::
   :depth: 2

dojox.analytics.Urchin
======================

This class is used to delay loading of the popular `Google Analytics <http://google.com/analytics>`_ Tracker, formerly known as Urchin. The synchronous nature of ``<script>`` tags causes page rendering to stall until loading of remote files has completed, and this module alleviates that. 

To use, require the Urchin module into your page, and create a new instance:

.. code-block :: javascript

  dojo.require("dojox.analytics.Urchin");
  dojo.addOnLoad(function(){
      new dojox.analytics.Urchin({ acct:"UA-12345-67" });
  });

The most important attribute (parameter) would be the `acct` value, which should be the ID Google prodivded during signup.

You can define your account number as a djConfig parameter ``urchin``. Simply include the key and a value however you set djConfig, either before ``dojo.js`` is loaded:

.. code-block :: javascript
 
  <script type="text/javascript">
     var djConfig = { urchin: "UA-12345-67" };
  </script>
  <script src="http://o.aolcdn.com/dojo/1.2/dojo/dojo.xd.js"></script>

or directly on the djConfig attribute of your ``dojo.js`` script tag:

.. code-block :: javascript

   <script src="js/dojo/dojo.js" djConfig="urchin: UA-12345-67"></script>

Being a Class constructor, you can also use Urchin with a ``dojoType``. Assuming you have ``dojo.require``'d the Urchin module, and have parseOnLoad:true (or manually run the `parser <dojo/parser>`_), you simply need to add a tag somewhere in your page:

.. code-block :: html

     <div dojoType="dojox.analytics.Urchin" acct="UA-12345-67"></div>

Optional Parameters
-------------------

There is only one optional parameter: ``loadInterval``. This defines the time in ms to repoll for the availability of the Google tracker. Set to a higher number for less processing, and a lower number for more frequent checks. Default is 400.

Ajax-API
--------

The urchin tracker allows you to add additional tracking to Ajax/long-lived pages with dynamic content. When you wish to send a new tracker request, call ``trackPageView`` with some identifier, and Google will track it as a separate hit:

.. code-block :: javascript

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
  
