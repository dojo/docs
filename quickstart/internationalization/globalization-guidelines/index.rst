#format dojo_rst

Globalization Guidelines
========================

:Status: Draft
:Version: 1.0
:Authors: Adam Peller
:Available: since V0.9?

.. contents::
   :depth: 2

========
Overview
========

Dojo addressed the globalization features at the very beginning of its development. This document presents the rules and describes how to use these features to globalize your Web applications based on Dojo version 1.0. Each of the rules use one of the following directive words:

* **Must**: You must always follow the rules; otherwise your application cannot be globalized.
* **Should**: You are recommended to follow the rules in some situations. Your application can be globalized if you do not follow these rules, but more effort might be needed.
* **May**: These rules do not affect the capability of globalization. You can choose whether to follow them or not.

Use the following guidelines to implement internationalization.


=====================================================================================================
`Encoding Guidelines <quickstart/internationalization/globalization-guidelines/encoding-guidelines>`_
=====================================================================================================

* `You should always use UTF-8 for encoding settings wherever applicable. <quickstart/internationalization/globalization-guidelines/encoding-guidelines#you-should-always-use-utf-8-for-encoding-settings-wherever-applicable>`_
* `You should encode all text files in UTF-8. <quickstart/internationalization/globalization-guidelines/encoding-guidelines#you-should-encode-all-text-files-in-utf-8>`_
* `You must specify the UTF-8 encoding in every HTML file before any non-English characters. <quickstart/internationalization/globalization-guidelines/encoding-guidelines#you-must-specify-the-utf-8-encoding-in-every-html-file-before-any-non-english-characters>`_
* `You must use the BOM header for UTF-16 files. <quickstart/internationalization/globalization-guidelines/encoding-guidelines#you-must-use-the-bom-header-for-utf-16-files>`_
* `You must use UTF-8 to decode XHR request parameters. <quickstart/internationalization/globalization-guidelines/encoding-guidelines#you-must-use-utf-8-to-decode-xhr-request-parameters>`_
* `You must use UTF-8 encoding when using a non-English string in a URL. <quickstart/internationalization/globalization-guidelines/encoding-guidelines#you-must-use-utf-8-encoding-when-using-a-non-english-string-in-a-url>`_
* `You must set Content-Type in an HTTP response header if the response is not encoded in UTF-8. <quickstart/internationalization/globalization-guidelines/encoding-guidelines#you-must-set-content-type-in-an-http-response-header-if-the-response-is-not-encoded-in-utf-8>`_


=========================================================================================================================================
`Locale and Resource Bundle Guidelines <quickstart/internationalization/globalization-guidelines/locale-and-resource-bundle-guidelines>`_
=========================================================================================================================================

* You must set Content-Type in an HTTP response header if the response is not encoded in UTF-8.
* You must set djConfig.locale in all files to the same as the locale used by the server code.
* You must always use resource bundle to store the strings displayed to users.
* You should use djConfig.locale to set the default locale and extra locales, and use only dojo.requireLocalization without the locale parameter.
* You may make a build to include resource bundles in the locales that you use.


==============================
String Manipulation Guidelines
==============================

* You should use the Js2Xlf tool to convert JSON files into XLIFF files for translation.
* You should deal with free text using ICU library at the server side.
* You should use only casing functions for locale neutral situation.
* You should not use locale sensitive casing functions provided by JavaScript.
* You should always escape a string as a whole rather than character by character.
* You should not use any comparing, searching, or replacing functions for strings that might contain combining character sequences.
* You should not use inserting, removing, or splitting functions for strings that might contain special characters.
* You should not use trimming functions for strings that might contain special characters.
* You should not use counting functions for strings that might contain special characters.
* You must check the return value of String.charAt() when the string contains surrogates.


====================================
Formatting and Validation Guidelines
====================================

* You must use dojo.string.substitute() to generate text output rather than simply use "+" between strings.
* You must use Dojo format functions to convert locale sensitive data into text.
* You must use Dojo validating and parsing functions to convert text from the users' input into data.
* You should not hard-code patterns and locales when formatting data.


========================
Dijit Widgets Guidelines
========================

* You should not specify both the height and the width of a widget to be translated by numeric units.
* You must ensure that all resources used in widgets are localizable.
* You should consider BiDi support in development and customization. 
