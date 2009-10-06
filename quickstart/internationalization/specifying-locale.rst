#format dojo_rst

Specifying a Locale
===================

:Status: Draft
:Version: 1.0
:Authors: Adam Peller
:Available: since V?

.. contents::
   :depth: 2

=================
What is a Locale?
=================

Localization is driven by a locale, a short string often supplied by the host environment, which conforms to RFC 3066 used in the HTML specification. It consists of short identifiers, typically two characters long which are case-insensitive. Note that Dojo uses dash separators like the RFC, not underscores like Java (e.g. "en-us", not "en_US"). Typically country codes are used in the optional second identifier, and additional variants may be specified. For example, Japanese is "ja"; Japanese in Japan is "ja-jp". Notice that the lower case is intentional -- while Dojo will often convert all locales to lowercase to normalize them, it is the lowercase that must be used when defining your resources.


==============================
How does Dojo find the locale?
==============================

By default, Dojo derives the user locale setting from the navigator browser object, the only locale information available from Javascript. The browser locale is determined during browser installation and is not easily configurable. Note that this is not the same as the locale in the preferences dialog which can be used to accompany HTTP requests; there is unfortunately no way to access that locale from the client without a server round-trip. The user's locale may easily be overridden on a page prior to the Dojo bootstrap by setting the djConfig.locale property. Of course, setting this property in a static way defeats internationalization for other users. This setting may be established by a server to achieve personalization of web applications, where a user may be able to select their locale or this information may be available through some other means. Once Dojo is loaded, it is not possible to change the locale for the page.


=====================================
What about deprecated locale support?
=====================================

Several locales used since the early days of the Internet have been deprecated in favor of new codes. These include 'iw' for Hebrew in favor of 'he'. Also, 'in' in favor of 'id' for Indonesian, 'no' in favor of 'nb' Norwegian Bokmål (to differentiate from Nynorsk), and 'ji' became 'yi' for Yiddish. Dojo tries to adhere to the latest specifications. Unfortunately, some applications still use the deprecated codes, most notably the JDK. The best practice when dealing with these technologies is to run a transformation on the string before assigning to djConfig.locale to assure that the new locale codes are used.


===================================
Using many locales at the same time
===================================

In the unusual case where multiple locales are used on a single page, the djConfig.extraLocale property must be set, prior to bootstrap, listing the additional locales as elements in an array, otherwise they will not work at runtime. Optionally, one of these extra locales may be passed into routines like dojo.date.format or Dijit widgets using the 'lang' attribute, but such use cases are rare. Typically, the one locale is sufficient to localize the entire page and the locale should not be applied to any one specific widget or API.
