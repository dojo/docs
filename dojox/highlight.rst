.. _dojox/highlight:

===============
dojox/highlight
===============


.. contents ::
  :depth: 3

This project provides client-side syntax highlighting for a number of languages, and is more or less a direct port of Ivan Sagalaev's Highlight.js engine, contributed under CLA.

To use the Highlight engine, require it into your page, along with any appropriate language packs:

.. js ::

  require(["dojox/highlight", "dojox/hightlight/languages/javascript"]);


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

The name in parenthesis indicate that which you should require to load the definitions. eg:

.. js ::

  require(["dojox/highlight/languages/pygments/css"]); // add CSS rules to the engine

Highlight Styles
----------------

Highlight is entirely CSS based, so you will need the appropriate CSS file. The default system css is available in the resources/ folder by the name of highlight.css:

.. html ::

    <link rel="stylesheet" href="/js/dojox/highlight/resources/highlight.css" />

Additionally, the Pygments CSS files are located in resources/pygments/ and are described by a theme name. Simply load in the appropriate theme you choose:

.. html ::

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

After loading in the highlight engine, and putting the CSS on the page, the only remaining step it to highlight the nodes. Highlight acts on ``<code>`` blocks. It can be instantiated just as any other widget in Dojo by using the data-dojo-type:

.. html ::

      <code data-dojo-type="dojox/highlight/widget/Code">var foo = dojo.map([1,2,3,4,5], function(n){ return n % 2 });</code>

Or by calling ``dojox/highlight::init(someNode)``.

.. js ::

  require(["dojox/highlight", "dojo/query"], function(highlight, query){
    // attempt to highlight all <code> blocks on a page:
    query("code").forEach(highlight.init);
  });
  
Highlight can also be used via the dojox/highlight/processString function

.. code-example ::

  .. css ::

      @import "{{baseUrl}}dojox/highlight/resources/highlight.css"

  .. js ::

      require(["dojo/dom-attr", "dijit/registry", "dojox/highlight", "dojox/highlight/languages/sql", "dijit/form/Button"],
      function(domAttr, registry, highlight, sql){
        function highlight(){
          // highlighting the code
          var code = highlight.processString("Select a from b where a = 2;").result;
          // putting the highlighted code in a html element so you can see
          domAttr.set('demoCode1', {innerHTML: code});
        }
        registry.byId("buttonOne").on("click", lang.hitch(this, "highlight"));
      });

  .. html ::

    <div id="demoCode1">Select a from b where a = 2;</div>
    <button data-dojo-type="dijit/form/Button" id="buttonOne">Highlight Code</button>
