#format dojo_rst

Internationalization (i18n)
===========================

:Status: Draft
:Version: 1.0
:Project owner: ?--
:Available: since V0.9?

.. contents::
   :depth: 2

============
Introduction
============

Internationalization, or i18n, is the process of making an application flexible to work in different languages and respect different conventions and customs. An identifier called a locale represents a language code with an optional list of variants, which may include geographic or other information. Based on the locale, different data and logic may be applied when rendering text or dealing with numbers or dates. This section will cover the basic concepts of internationalization and show how these features are implemented in Dojo.

Dojo aims to make internationalization a basic feature of the toolkit, such that the presentation to the user never assumes one particular language or culture. Developer-facing resources, such as console output and API documentation do not yet have an internationalization framework.

Localization in the form of translated resources, mostly in the Dijit project, are generally available starting with the 1.0 release in over a dozen languages, with more to come.

* `Globalization Guidelines <quickstart/internationalization/globalization-guidelines/index>`_
* Encoding considerations
* Specifying a Locale
* Translatable Resource bundles
* Cultural conventions: Date, Number and Currency
* Bi-Directional Text
* Globalization Tutorial
