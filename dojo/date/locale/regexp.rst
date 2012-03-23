.. _dojo/date/locale/regexp:

==========================
dojo/date/locale::regexp()
==========================

.. contents ::
   :depth: 2

Builds the regular expression needed to parse a localized date. This is mainly designed as an internal function but is
exposed if needed. It defaults to using the current locale and the default formatting options to generate the regular
expression but can be controlled using for the :ref:`formatting options <dojo/date/locale/format#attributes>` just like
other functions in the module.

Usage
=====

.. js ::

  require(["dojo/date/locale"], function(locale){
    // Return a regular expression based on the defaults for the current locale
    var exp = locale.regexp();
    
    // Return the short date regular expression for "en-gb" locale
    var exp = locale.regexp({
      formatLength: "short",
      selector: "date",
      locale: "en-gb"
    });
  });

Attributes
==========

========= ================================== ==============================================================
Arguments Type                               Description
========= ================================== ==============================================================
options   dojo/date/locale::__FormatOptions? *Optional* Uses the format options to generate the string see: 
                                             :ref:`format() <dojo/date/locale/format#attributes>`
========= ================================== ==============================================================

The function returns a String.

.. code-example ::

  .. js ::

    require(["dojo/date/locale", "dojo/dom", "dojo/domReady!"],
    function(locale, dom){
      var output = locale.regexp({
        formatLength: "short",
        selector: "date",
        locale: "en-gb"
      });
      dom.byId("output").innerHTML = output;
    });

  .. html ::

    <strong>Output:</strong>
    <pre id="output"></pre>

See also
========

* :ref:`dojo/date/locale <dojo/date/locale>`

.. api-link :: dojo.date.locale.regexp
