.. _dojox/mobile/internationalization:

===========================
Internationalization (i18n)
===========================

:Authors: Yoshiroh Kamiyama

.. contents ::
    :depth: 2

There are a couple of approaches for internationalization of your
dojox.mobile applications. From the performance perspective, the
server-side approach is the best choice. However, you can of course
choose a client-side approach using dojo.i18n. In some situations, you
may want to use dojox.mobile.i18n that is optional feature.

Server-side Substitution
========================

dojox.mobile itself does not require dojo.i18n, because using it:

  - Increases the code size
  - Degrades client-side runtime performance

The recommended approach is to substitute localized strings on the
server due to the following reasons:

  - Server-side markup generation is the typical usage of dojox.mobile
  - Should be able to use server-side i18n facility (e.g. Java resource bundle)
  - No http requests to retrieve i18n resources are necessary
  - Client-side does not need to look up the i18n resource table

With that said, it is still possible to take the client-side approach
using dojo.i18n, although you'll have to pay a price in performance
for doing so.

dojo.i18n
=========

If you need to do internationalization at the client-side, use of
dojo.i18n is the standard approach. Just like typical desktop dojo
applications, dojox.mobile applications can also leverage
dojo.i18n. From dojo-1.7, you can load nls resources with the
dojo.i18n plugin as shown below. Once you get a resource bundle, you
can use the localized strings to replace UI labels, to show messages,
or whatever. In the example below, a localized text is used to replace
the button label.

.. html ::

  <html>
      <head>
      <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,minimum-scale=1,user-scalable=no"/>
      <meta name="apple-mobile-web-app-capable" content="yes" />
      <link href="../themes/iphone/iphone.css" rel="stylesheet">

      <script src="../../../dojo/dojo.js" djConfig="parseOnLoad: true"></script>

      <script language="JavaScript" type="text/javascript">
          require([
              "dojo/ready",
              "dojo/i18n!dojox/mobile/tests/nls/sample"
              "dojox/mobile/parser",
              "dojox/mobile",
              "dojox/mobile/compat",
              "dojox/mobile/Button",
              ], function(ready, sampleStrings){
              ready(function(){
                  dijit.byId("btn1").set("label", sampleStrings["Sunday"]);
              });
          });
      </script>
      </head>
      <body>
      <div id="settings" data-dojo-type="dojox.mobile.View">
          <button id="btn1" class="mblBlueButton" data-dojo-type="dojox.mobile.Button">Sunday</button>
      </div>
      </body>
  </html>

dojox.mobile.i18n
=================

The above approach, however, requires javascript code for each UI
widget that has translatable strings. That could be a pain especially
when the application consists of a lot of widgets and is mainly
written using dojo markup.

dojox.mobile.i18n is an optional feature that simplifies
internationalization in such cases. It is a thin wrapper around
dojo.i18n, and has ability to replace strings, such as CDATA or
attribute values, in the dojo markup. You can use the
dojox.mobile.i18n.load() method to load a resource bundle. The method
signature is the same as that of the deprecated
dojo.requireLocalization(). The return value is an array of localized
string resources, which is returned from the dojo.i18n plugin.

.. js ::

  dojo.require("dojox.mobile.i18n");
  var bundle = dojox.mobile.i18n.load("dojox.mobile.tests", "sample");

You can embed string resource keys into your markup as shown
below. The keys are automatically replaced with translated text of the
loaded resource bundle. That is basically what dojox.mobile.i18n does.

.. html ::

  <h1 data-dojo-type="dojox.mobile.Heading" back="L_DAY_SUNDAY">L_DAY_OF_THE_WEEK</h1>

The nls resource would be something like this:

.. js ::

  define({
      L_DAY_OF_THE_WEEK: "Day of the Week",
      L_DAY_SUNDAY: "Sunday"
  });

It is of course not mandatory, but one interesting idea is to use
English text as resource keys. For example, as shown below, you can
write as if you are writing an ordinary English application.

.. html ::

  <h1 data-dojo-type="dojox.mobile.Heading" back="Sunday">Day of the Week</h1>

In fact, however, what you wrote are not English resource values, but
resource keys, "Sunday" and "Day of the Week". That is, if you provide
an Italian resource as follows,

.. js ::

  define({
      "Day of the Week": "giorno della settimana",
      "Sunday": "Domenica"
  });

and set your browser's locale to Italian, then you will get the following result.

.. image :: Heading-italian.png

Here, you don't need to programmatically handle the returned resource
bundle array. dojox.mobile widgets automatically replace the resource
keys with their corresponding resource values.

In this example, if you prepared a resource bundle for English, it would look like this:

.. js ::

  define({
      "Day of the Week": "Day of the Week",
      "Sunday": "Sunday"
  });

But you don't have to have English resource, because when a look-up
fails, the key is used as its value. That's the benefit of using
English text as resource keys. If you take this approach, you should
not have English resource, since it simply increases the download size
and achieves no gain.

If your resource value contains variables that have to be replaced
with some given values, you need to access the resource bundle array,
perform substitution, and apply the value to the widget.

.. js ::

  define({
      "MINUTES": "%1 Minuto"
  });

.. js ::

  dijit.byId("item1").set("label", bundle["MINUTES"].replace("%1", "30"));

Why dojox.mobile.i18n?
======================

If you are developing custom widgets that have pre-defined
translatable text inside the widgets, you have no choice. dojo.i18n is
your solution.

However, if you are developing dojox.mobile-based user applications
that have user-defined translatable text, that is, when translatable
text is given to dojox.mobile widgets, then dojo.i18n can still be
your solution, but dojox.mobile.i18n may be another option, because it
provides the ability to replace string resource keys in dojo markup
with translated text without JavaScript coding. Internationalization
of your application's heading titles, button labels, list item labels,
etc. are such examples.
