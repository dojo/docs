#format dojo_rst

Translatable Resource bundles
=============================

:Status: Draft
:Version: 1.0
:Project owner: ?--
:Available: since V?

.. contents::
   :depth: 2

============
Introduction
============

`dojo.i18n <dojo/i18n>`_ solves a problem in Javascript: now that we've implemented a significant amount of logic on the client, there are i18n issues which cannot easily be solved by server substitution. Furthermore, server substitution scales poorly and exposes the client-side toolkit to a particular server architecture. With a client-side internationalization framework, the integration point moves to the browser where simple or complex logic can be applied without becoming a bottleneck. This architecture also encourages encapsulation and efficient caching both at edge servers and in the browser. And, while all translations are present on the server, rest assured that only those which match the user's locale are requested by the client and sent over the wire.

The methods used in Dojo to substitute localized resources are intended for Dojo-generated content. There are trade-offs to this approach, such as trading server-load for client-side response time. It is usually best to continue using the same mechanism to localize the rest of the page, which is typically a webapp server, rather than trying to force everything on the page through Dojo and Javascript. This does mean that there will usually be two different sets of resources to manage, translate, and deploy. Dojo and Dijit will soon provide translations for many major languages, and additional translations may be provided by the community. Those augmenting Dojo or writing their own widgets will need to create and translate their own set of resources, as needed.

The translation task in a Dojo application is limited to anything which appears in the DOM, that is anything which is visible on the web page. It's unacceptable to hard-code an English string and have that appear to users, no matter how unlikely it is to appear. Debug or console message however, for the time being, are not localized as a matter of policy. There are no guidelines on console messages at the present time. They are generally discouraged in production code.


==================
Localizing Strings
==================

dojo.requireLocalization() / dojo.i18n.getLocalization()
  these methods leverage `Dojo's package concept <dojo/require>`_ to load localized resources. Each translated resource is implemented as a file containing a Javascript Object (see JSON notation) where each property may be a string or any other Javascript type. Resources are located within the directory structure beneath a specially named "nls" directory (short for native language support). Each translation is made available in a subdirectory named by locale.

`dojo.requireLocalization() <dojo/requireLocalization>`_ is used to declare usage of these resources and load them in the same way that dojo.requires() pulls in Javascript packages, but using the translation appropriate to the caller. The location of the bundle is specified using two arguments: the first is the directory structure containing the nls directory; the second is the name of the file in that directory containing the localized resources. The locale used is discovered at runtime from the browser, or specified by an override in djConfig (see "Specifying a locale") If djConfig.extraLocale is set, the localizations in that list will be loaded also.

Use `dojo.i18n.getLocalization() <dojo/i18n/getLocalization>`_ to get a reference to the object representing the localized resources. The resources loaded by dojo.requireLocalization() are searched and one best matching the user's locale are used. The localized values will be available as properties on the returned object. For example:

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   //TODO: replace this example with the strings from dojo.color when translations are available
   dojo.require("dojo.i18n");
   dojo.requireLocalization("dijit.form", "validate");
   var validate = dojo.i18n.getLocalization("dijit.form", "validate");
   console.log(validate.invalidMessage);
 </script>


For an English-speaking user, the example above will display the value for invalidMessage from dijit/form/validate.js:

"* The value entered is not valid."

The root happens to have the English translation, which also acts as a fallback for any unsupported locales (English was an arbitrary choice, but the one commonly used in Dojo). Therefore, no translations were found in the en or en-us directories as they would have been redundant. Meanwhile, a Japanese user in the ja-jp locale will see the value in dijit/form/nls/ja, which is the best match for that locale:

"* 入力したデータに該当するものがありません。"

Translation subdirectories are searched and mixed in such a way that variants can specify overrides for some or all of their parent locale. Because the search requires looking for translations under both the language as well as variants, sometimes a 404 will occur; this is normal and can be optimized at build time.


========
See also
========

* `dojo.i18n <dojo/i18n>`_
* `dojo.requireLocalization <dojo/requireLocalization>`_
* `dojo.i18n.getLocalization <dojo/i18n/getLocalization>`_
