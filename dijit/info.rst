#format dojo_rst

Dijit
=====

*Dijit* is a widget system layered on top of Dojo. If you are new to the whole Dojo experience, Dijit is a good place to start. You can build amazing Web 2.0 GUI's using very little, or no, JavaScript (though having an understanding of JavaScript will take you a long way) 

Dijit Basics
------------

You can use Dijit in one of two ways: **declaratively** by using special attributes inside of regular HTML tags, and **programmatically** through JavaScript. You have the same options either way. 

.. code-block :: javascript
  :linenos:
 
  var dialog = new dijit.Dialog({ title:"Hello Dijit!" }, "someId");
  dialog.startup();

is identical to: 

.. code-block :: html
  :linenos:

  <div dojoType="dijit.Dialog" title="Hello Dijit!" id="someId"></div>

The declarative method requires you include the `dojo.parser </dojo/parser>`_ and have either ``djConfig.parseOnLoad`` set to true, or you manually call ``dojo.parser.parse()`` when you would like the widgets (dijits) to be created.

Themes
------

Dijit comes bundled with three themes: Tundra, Soria, and Nihilo. Themes are collections of images and CSS, and brings a common design and color scheme to all the widgets. You can override the theme by container or by element to add nuance and flair. Themes must be included by the inclusion of the theme's root file from the relative position in the source tree:

.. code-block :: html

  <link rel="stylesheet" href="lib/dijit/themes/tundra/tundra.css">

and by the addition of a theme class name on a parent element. By using the ``<body>`` tag, we are able to ensure all widgets in the page have the same CSS rules:

.. code-block :: html

  <html>
  <head>
      <title>Hello, Dijit</title>
      <link rel="stylesheet" href="lib/dijit/themes/tundra/tundra.css">
      <script src="lib/dojo/dojo.js"></script>
  </head>
  <body class="tundra">
      <h1>Hello, Dijit</h1>
  </body>

It is recommended you include the theme CSS file **before** ``dojo.js`` to avoid any potential latency issues.

Dijit i18n/a11y
---------------

Everything in Dijit is designed to be globally accessible -- to accommodate users with different languages and cultures as well as those with different abilities.  Language translations, bi-directional text, and cultural representation of things like numbers and dates are all encapsulated within the widgets.  Server interactions are done in a way that makes no assumptions about local conventions.  All widgets are keyboard accessible and using the standard Dijit theme, usable in high-contrast mode as well as by screen readers.  These features are baked in so that, as much as possible, all users are treated equally.
