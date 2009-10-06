#format dojo_rst

Globalization Guidelines: Locale and Resource Bundle
====================================================

:Status: Draft
:Version: 1.0
:Authors: ?--
:Available: since V?

.. contents::
   :depth: 2

======================
Locale Setting in Dojo
======================

There is a slight difference in the locale naming conventions between Dojo and Java. Dojo uses "-" (hyphen) as the separator for concatenate language code, country code, and variants, whereas Java uses an "_" (underline). For example, "zh_CN" in Java is similar to "zh-cn" in Dojo.

Like the default locale in Java, Dojo has a global locale value that is stored in a global variable: dojo.locale. This default locale value affects the behavior of several locale-related functions and widgets. The value of dojo.locale is not supposed to be changed. You should use djConfig.locale to initialize this value.

You must set djConfig.locale in all files to achieve server-based personalization
---------------------------------------------------------------------------------

If djConfig.locale is undefined, Dojo will consult the browser's navigator object for the setting chosen at browser install time. Note that this is unrelated to the locale setting in the preferences dialog, which is for interaction with the server only. To provide personalization from the server to control locale settings in an application, you must set djConfig.locale in the page at the server side, prior to loading dojo.js. For example, here is a JSP page that sets the default locale for Dojo:

.. code-block :: html
 :linenos:

 ...
 <%
 String actualLocale = ResourceBundle.getBundle("my.app.test",
     request.getLocale()).getLocale().toString().replace('_', '-');
 %>
 <script type="text/javascript" src="../dojo/dojo.js" djconfig="locale: '<%=userLocale%>'">
 </script>
 ...


=====================
Resource Bundle Files
=====================

You must always use resource bundles to store the strings displayed to users.
-----------------------------------------------------------------------------

Dojo introduces resource bundle into JavaScript. If you are familiar with Java resource bundle, you can find that Dojo resource bundle is very similar to Java resource bundle. The following table shows a summary of the differences between Java and Dojo:

=================  ================================  ===================================================
Resource bundle:   Java                              Dojo
=================  ================================  ===================================================
File Format        Properties file                   JSON file
Locale Identifier  Suffix of file name               Directory name
Locale Naming      Use "_" (underline) as separator  Use "-" (hyphen) as separator
Get Bundle         ResourceBundle.getBundle          dojo.requireLocalization, dojo.i18n.getLocalization
Get Message        ResourceBundle.getString          JSON object
=================  ================================  ===================================================

For example, there are two resource bundles named "bar" and "foo" in a package named "my.app" with some of their localized versions:

In Java (6 files with different names):
::

  my/
    app/
      bar.properties
      bar_zh.properties
      bar_zh_CN.properties
      bar_zh_TW.properties
      foo.properties
      foo_zh_CN.properties

And in Dojo (4 directories and 6 files):

::

  my/
    app/
      nls/
        bar.js
        foo.js
        zh/
          bar.js
        zh-cn/
          bar.js
          foo.js
        zh-tw/
          bar.js

The fallback strategy in Dojo is the same as that in Java.


=====================
Using Resource Bundle
=====================

First, you should use the dojo.registerModulePath function to define the directory where resource bundles are as a registered module. The module name needs to be used in later callings to the dojo.requireLocalization and dojo.i18n.getLocalization functions. For the previous example, you can use the following line to define the module "my.app":

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   dojo.registerModulePath("my.app", "../../my/app");
   // Note: Here, the "../../my/app" path is relative to the directory that contains "dojo.js".
 </script>

Then you can use the dojo.requireLocalization function to load resource bundles from files. After a resource bundle is loaded, the dojo.i18n.getLocalization function returns a copy of the bundle object.

When you get the bundle object, you can use it as a normal JSON object (a hash) to get messages. If you modify values in the bundle object, the original global bundle object will not be affected.

You may use djConfig.locale to set the default locale and extra locales, and use only dojo.requireLocalization without the locale parameter.
--------------------------------------------------------------------------------------------------------------------------------------------

djConfig.locale overrides the browser's default locale as specified by the navigator Javascript object. This setting is effective for the entire page and must be declared prior to loading dojo.js. djConfig.extraLocale establishes additional locales whose resource bundles will be made available. This is used rarely to accomodate multiple languages on a single page. No other locales may be used on the page.

If you omit the locale parameter when calling the dojo.requireLocalization function, the function will load the resource bundles for locales in djConfig.locale as well as for all the locales in djConfig.extraLocale.

For example, if you define:

.. code-block :: javascript
 :linenos:

 <script type="text/javascript" src="../dojo/dojo.js" djconfig="locale: 'zh-cn', extraLocale: ['zh-tw', 'fr']">
 </script>

then the following two code blocks are equal:

Code block A:

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   dojo.requireLocalization("my.app", "bar");
   
   var bar = dojo.i18n.getLocalization("my.app", "bar");
 </script>

Code block B:

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   dojo.requireLocalization("my.app", "bar", "zh-cn"); // default locale
   dojo.requireLocalization("my.app", "bar", "zh-tw"); // extra locale
   dojo.requireLocalization("my.app", "bar", "fr");    // extra locale
   
   var bar = dojo.i18n.getLocalization("my.app", "bar", "zh-cn"); // default locale
 </script>

The first method is preferred as it is less brittle.


======
Builds
======

Before you deploy your Web application using Dojo, you should consider building the Dojo layers that are used by your application into a single JavaScript file. Using such a build brings you many advantages. The unused scripts, white spaces, comments, and overridden string values can be removed to make smaller downloads, and the need to search by locale can be skipped such that extra server requests and 404 responses are avoided. In general, the build reduces the request time from the browser to the server to avoid latency issues.

You should make a build to include resource bundles in the locales that you use
-------------------------------------------------------------------------------

Resource bundles can either be included in a build or be used without a build. If you use resource bundles without a build, the first request for each resource bundle will generate N+1 HTTP requests when it searches the server for values, where N is the number of segments in the target locale. For example, a call of dojo.requireLocalization("my.app", "bar") in the "zh-cn" locale looks for "bar.js" first in the "zh-cn", then in "zh", and finally in the root. Without optimization, some of these requests might result in harmless HTTP 404 errors (page not found) if a variant does not need to override any definitions from its parent.


===========
Translation
===========

JSON is a convenient and efficient format for resource bundles in JavaScript, but the JSON format is not well supported by many professional translation centers. `XLIFF <http://docs.oasis-open.org/xliff/v1.2/cs02/xliff-core.html#SectionIntroduction>`_ is the industry standard file format for localization and translation. Among other things, XLIFF will ease in declaration of encoding and hide details from the translator such as JavaScript character entities. Tools will be developed to support round-trip transforms between JSON and XLIFF. Support for `gettext PO files <http://www.gnu.org/software/gettext/manual/gettext.html#PO-Files>`_ in the future is also possible.

Translators must also be aware of the substitution syntax of Dojo — ${x}
