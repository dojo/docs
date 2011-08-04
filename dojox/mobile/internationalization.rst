#format dojo_rst

Internationalization (i18n)
===========================

:Authors: Yoshiroh Kamiyama

.. contents::
    :depth: 2

dojox.mobile itself does not require dojo.i18n because:

  * Use of it increases the code size
  * Not good for client-side runtime performance

Recommended approach is to substitute localized strings on a server due to the following reasons:

  * Server-side markup generation is the typical usage of dojox.mobile
  * Should be able to use server-side i18n facility (e.g. Java resource bundle)
  * No http requests to retrieve i18n resources are necessary
  * Client-side does not need to look up the i18n resource table

With that said, it is still possible to take client-side approach with dojo.i18n, although you'll have to pay a price in performance for doing so.

=================
dojox.mobile.i18n
=================

dojox.mobile.i18n is an optional feature that simplifies localization using dojo.i18n. You can use the dojox.mobile.i18n.load() method to load a resource bundle. The method signature is the same as that of dojo.requireLocalization(). The return value is an array of localized string resources, which is returned from dojo.i18n.getLocalization().

.. code-block :: javascript

  dojo.require("dojox.mobile.i18n");
  var bundle = dojox.mobile.i18n.load("dojox.mobile.tests", "sample");

It is not mandatory, but one simple approach is to use English text as resource keys. For example, as shown below, you can write as if you are writing an ordinary English application.

.. code-block :: html

  <h1 dojoType="dojox.mobile.Heading" back="Sunday">Day of the Week</h1>

In fact, however, what you wrote are not English resource values, but resource keys, "Sunday" and "Day of the Week". That is, if you provide an Italian resource as follows,

.. code-block :: javascript

  define({
      "Day of the Week": "giorno della settimana",
      "Sunday": "Domenica"
  });

and set your browser's locale to Italian, then you will get the following result.

.. image:: Heading-italian.png

Here, you don't need to programmatically handle the returned resource bundle array. dojox.mobile widgets automatically replace the resource keys to their corresponding resource values.

In this example, if you prepared a resource bundle for English, it would look like this:

.. code-block :: javascript

  define({
      "Day of the Week": "Day of the Week",
      "Sunday": "Sunday"
  });

But you don't have to have English resource, because when a look-up fails, key is used as its value. That's the benefit of use of English text as resource keys. If you take this approach, you should not have English resource, since it simply increases the download size and no gain.

If your resource value contains variables that have to be substituted with some given values, you need to access the resource bundle array, perform substitution, and apply the value to the widget.

.. code-block :: javascript

  define({
      "MINUTES": "%1 Minuto"
  });

.. code-block :: javascript

  dijit.byId("item1").set("label", bundle["MINUTES"].replace("%1", "30"));
