#format dojo_rst

dojox.highlight
===============

:Status: Draft
:Version: 1.2

.. contents::
  :depth: 3

This project provides client-side syntax highlighting for a number of languages, and is more or less a direct port of Ivan Sagalaev's Highlight.js engine, contributed under CLA.

To use the Highlight engine, require it into your page, along with any appropriate language packs:

.. code-block :: javascript

  dojo.require("dojox.highlight");
  dojo.require("dojox.highlight.languages.javascript");


Provided Languages
------------------

There are several pre-defined language packs. Shipped with Dojo include:

* C++ (cpp)
* CSS (css)
* Delphi (delphi)
* Django (django)
* HTML (html)
* JavaScript (javascript)
* Python (python)
* SQL (sql)
* XML (xml)

The rollups _all (all languages), _dynamic, _static, and _www provide layers of common groups of languages. 

There are additional definitions for Pygments-based highlighting:

* CSS (pygments.css)
* HTML (pygments.html)
* JavaScript (pygments.javascript)
* XML (pygments.xml)

The rollups _www and _html are provided as layers, for related code inclusion.

The name in parenthesis indicate that which you should dojo.require() to load the definitions. eg: 

.. code-block :: javascript

  dojo.require("dojox.highlight.languages.pygments.css"); // add CSS rules to the engine

Highlight Styles
----------------

Highlight is entirely CSS based, so you will need the appropriate CSS file. The default system css is available in the resources/ folder by the name of highlight.css:

.. code-block :: html

    <link rel="stylesheet" href="/js/dojox/highlight/resources/highlight.css" />

Additionally, the Pygments CSS files are located in resources/pygments/ and are described by a theme name. Simply load in the appropriate theme you choose: 

.. code-block :: html

    <link rel="stylesheet" href="/js/dojox/highlight/resources/pygments/colorful.css" />

There are several themes available:

* autumn
* borland
* colorful
* default
* emacs
* friendly
* fruity
* manni
* murphey
* native
* pastie
* perldoc
* trac

Using Highlight
---------------

After loading in the highlight engine, and putting the CSS on the page, the only remaining step it to highlight the nodes. Highlight acts on ``<code>`` blocks. It can be instantiated just as any other widget in Dojo by using the dojoType:

.. code-block :: html

      <code dojoType="dojox.highlight.Code">var foo = dojo.map([1,2,3,4,5], function(n){ return n % 2 });</code>

Or by calling ``dojox.highlight.init(someNode)``. 

.. code-block :: javascript

  // attempt to highlight all <code> blocks on a page:
  dojo.query("code").forEach(dojox.highlight.init);

Highlight can also be used via the dojox.highlight.processString function

.. cv-compound::

  .. cv:: css

    <style type="text/css">
      @import "/moin_static163/js/dojox/highlight/resources/highlight.css"
    </style>

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dojox.highlight");
      dojo.require("dojox.highlight.languages.sql");
    </script>

  .. cv:: html

    <div id="sqlDisplay">if you can see this please fix the demo</div>
    <script type="text/javascript">
        var sql = dojox.highlight.processString("Select a from b where a = 2;");
        dojo.query("#sqlDisplay").innerHtml = sql;
    </script>
