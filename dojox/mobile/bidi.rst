.. _dojox/mobile/bidi:

===================================================
Dojo Mobile Bi-directional Languages Support (Bidi)
===================================================

.. contents ::
    :depth: 2

What Are Bi-Directional Languages?
==================================

Bi-Directional, or Bidi for short, languages refers to languages that are essentially written and read from right-to-left.
These languages include Arabic, Persian (Farsi), Azerbaijani, Urdu, Punjabi (in Pakistan), Pushto, Dari, Uigur, Hebrew, and Yiddish.
While these languages follow the right-to-left direction, they may include numbers or text written in Western languages that follows the left-to-right direction.
This demographic of users has a preference of right-to-left directionality.
Hence, everything has to be from right-to-left to follow the natural direction of their languages.
This includes also the interface of applications.

User Interfaces for Bidi Users
==============================

The flow of components on the screen is directly affected by the natural direction of languages being used.
Thus, for Left-to-Right languages, LTR, the components are generally aligned to the left.
On the other hand, for Right-to-Left languages, RTL, the components are  right aligned.
This change in the layout of components according to the language direction is called "mirroring".

The other aspect of bidi languages support in user interfaces is how text is displayed. Some parts of the text must be displayed
right-to-left, and other parts must be displayed left-to-right.

The following figures show how an application containing an EdgeToEdgeList will look like for both bidi and non-bidi users.

Left-to-right EdgeToEdgeList:

.. image :: bidi_EdgeToEdgeList_LTR.png

Right-to-left EdgeToEdgeList:

.. image :: bidi_EdgeToEdgeList_RTL.png

Bidi Support in Dojo Mobile
===========================

Dojo (and in particular Dojo Mobile since version 1.9) provides support for bidi languages.
Since code footprint is a concern for web applications, bidi support is optional, and applications that need bidi support
must specify it explicitly by setting the ``dojo-bidi`` feature flag to true.

The code snippet below shows how to enable the bidi support.

.. html ::

  <script type="text/javascript" src="../../../../dojo/dojo.js" 
    data-dojo-config="async: true,
    parseOnLoad: true,
    has: { 'dojo-bidi': true }">
  </script>

Once bidi support is enabled, mirroring can be controlled using the ``dir`` attribute of Dojo widgets, as explained in the next section.

Bidi applications can also control how bi-directional text is displayed using the ``textDir`` attribute,
as explained in the "Bi-directional Text Support" section.

Mirroring Support
=================

The ``dir`` attribute
---------------------

In order to set the direction of the components in a web page, simply add the ``dir`` attribute in the tag and set it to either ``rtl`` or ``ltr``.
This usually solves the alignment of the component. 

.. html ::

  <body style="visibility:hidden;" dir="rtl">
    <div id="settings" dojoType="dojox.mobile.View" selected="true">
      <h1 dojoType="dojox.mobile.Heading">Settings</h1>
      <ul dojoType="dojox.mobile.EdgeToEdgeList">
        <li dojoType="dojox.mobile.ListItem" icon="images/a-icon-2-41x41.png" rightText="mac" moveTo="hello">
        Wi-Fi
        </li>
        <li dojoType="dojox.mobile.ListItem" icon="images/a-icon-2-41x41.png" rightText="AcmePhone" moveTo="hello">
        Carrier
        </li>
      </ul>
    </div>
  </body>

When it comes to mobile applications, the same approach is followed beside enabling the bidi support.
Dojox.mobile widgets support mirroring, widgets that need special handling for mirroring have a separate style sheet with the name ``<widgetName>_rtl.css``.
This style sheet contains all the required styles to enable widget mirroring. 
The code snippets below show how to load the required rtl style sheet manually or automatically.

Loading the RTL style sheets manually (using link tags):

.. html ::

  <link href="../../themes/android/base.css" rel="stylesheet">
  <link href="../../themes/android/Switch.css" rel="stylesheet">
  <link href="../../themes/android/base_rtl.css" rel="stylesheet">
  <link href="../../themes/android/Switch_rtl.css" rel="stylesheet">

Loading the RTL style sheets automatically using the ``deviceTheme`` module:

.. html ::

  <script type="text/javascript" src="../../deviceTheme.js" 
    data-dojo-config="'dojo-bidi': true, mblThemeFiles: ['base','Switch']">
  </script>

The ``deviceTheme`` module will automatically load the ``_rtl.css`` files for each widget.

And finally set the ``dir`` attribute of the widget  to rtl:

.. html ::

  <body style="visibility:hidden;">
    <div id="settings" dojoType="dojox.mobile.View" selected="true">
    <h1 dojoType="dojox.mobile.Heading">الاعدادات</h1>
      <ul dojoType="dojox.mobile.EdgeToEdgeList">
        <li dojoType="dojox.mobile.ListItem" dir="rtl" icon="images/a-icon-2-41x41.png" rightText="مصر" moveTo="hello">
        الشبكة اللاسلكية
        </li>
        <li dojoType="dojox.mobile.ListItem" dir=”rtl” icon="images/a-icon-2-41x41.png" rightText="مصرية" moveTo="hello">
        شبكة المحمول
        </li>
       </ul>
     </div>
   </body>


.. image :: bidi_mirrored.png

Setting the ``dir`` Attribute at Different Levels
-------------------------------------------------

The default direction for the widget is LTR. However the direction of the widget can be specified explicitly on several levels:

* Widget Level
* Body Level
* Inheritance

Widget Level
------------

By adding the ``dir`` attribute in the widget tag itself, we specify the direction of the widget directly. This has the highest precedence in mirroring. The following code snippet sets the direction of the first list item to rtl. The figure shows the output of the RTL list item.

.. html ::

  <ul dojoType="dojox.mobile.EdgeToEdgeList">
    <li dojoType="dojox.mobile.ListItem" dir="rtl" icon="images/a-icon-2-41x41.png" rightText="مصر" moveTo="hello">
    الشبكة اللاسلكية
    </li>
    <li dojoType="dojox.mobile.ListItem" icon="images/a-icon-2-41x41.png" rightText="acmePhone" moveTo="hello">
    Carrier
    </li>
  </ul>


.. image :: bidi_widget_level.png

Body Level
----------

This level of directionality is achieved by adding the ``dir`` attribute to the Body tag. Everything included in the body tag will have the same direction as the body unless another ``dir`` is specified to a certain widget.

Inheritance
-----------

If the direction is not specified on the widget level, then widgets inherit the direction from their ancestors in the tree.

* **Note** To enable inheritance of the ``dir`` attribute, the ``dojo/parser`` module must be used instead of ``dojox/mobile/parser`` as in the code snippet below. 

.. js ::

  require([
    "dojo/parser",
    "dojox/mobile",
    "dojox/mobile/compat"
  ]);

.. html ::

  <div dir="ltr">
    <div dir="rtl">
      <ul dojoType="dojox.mobile.EdgeToEdgeList">
        <li dojoType="dojox.mobile.ListItem" icon="images/a-icon-2-41x41.png" rightText="مصر" moveTo="hello">
        الشبكة اللاسلكية
        </li>
        <li dojoType="dojox.mobile.ListItem" icon="images/a-icon-2-41x41.png" rightText="مصرية" moveTo="hello">
        شبكة المحمول
        </li>
      </ul>
    </div>
  </div>


.. image :: bidi_inheritance.png

Bi-directional Text Support
===========================

TBD

