.. _dojox/mobile/bidi:

===================================================
Dojo Mobile Bi-directional Languages Support (Bidi)
===================================================

:Authors: Ramy Said, Tomer Mahlin
:Developers: Alex Shensis, Alia Naguib, Ahmed Mustafa, Helena Halperin, Semion Chichelnitsky
:since: V1.9

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
    <div id="settings" data-dojo-type="dojox/mobile/View" selected="true">
      <h1 data-dojo-type="dojox/mobile/Heading">Settings</h1>
      <ul data-dojo-type="dojox/mobile/EdgeToEdgeList">
        <li data-dojo-type="dojox/mobile/ListItem" icon="images/a-icon-2-41x41.png" rightText="mac" moveTo="hello">
        Wi-Fi
        </li>
        <li data-dojo-type="dojox/mobile/ListItem" icon="images/a-icon-2-41x41.png" rightText="AcmePhone" moveTo="hello">
        Carrier
        </li>
      </ul>
    </div>
  </body>

When it comes to mobile applications, the same approach is followed beside enabling the bidi support.
Dojo Mobile widgets support mirroring, widgets that need special handling for mirroring have a separate style sheet with the name ``<widgetName>_rtl.css``.
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
    <div id="settings" data-dojo-type="dojox/mobile/View" selected="true">
    <h1 data-dojo-type="dojox/mobile/Heading">الاعدادات</h1>
      <ul data-dojo-type="dojox/mobile/EdgeToEdgeList">
        <li data-dojo-type="dojox/mobile/ListItem" dir="rtl" icon="images/a-icon-2-41x41.png" rightText="مصر" moveTo="hello">
        الشبكة اللاسلكية
        </li>
        <li data-dojo-type="dojox/mobile/ListItem" dir=”rtl” icon="images/a-icon-2-41x41.png" rightText="مصرية" moveTo="hello">
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

  <ul data-dojo-type="dojox/mobile/EdgeToEdgeList">
    <li data-dojo-type="dojox/mobile/ListItem" dir="rtl" icon="images/a-icon-2-41x41.png" rightText="مصر" moveTo="hello">
    الشبكة اللاسلكية
    </li>
    <li data-dojo-type="dojox/mobile/ListItem" icon="images/a-icon-2-41x41.png" rightText="acmePhone" moveTo="hello">
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
      <ul data-dojo-type="dojox/mobile/EdgeToEdgeList">
        <li data-dojo-type="dojox/mobile/ListItem" icon="images/a-icon-2-41x41.png" rightText="مصر" moveTo="hello">
        الشبكة اللاسلكية
        </li>
        <li data-dojo-type="dojox/mobile/ListItem" icon="images/a-icon-2-41x41.png" rightText="مصرية" moveTo="hello">
        شبكة المحمول
        </li>
      </ul>
    </div>
  </div>


.. image :: bidi_inheritance.png

Bi-directional Text Support
===========================


Background
-----------

Base text direction is a very important aspect associated with the display of Bidi text. It greatly affects the readability of Bidi text. When text is displayed with not natural to it base text direction it becomes unreadable to a very considerable extent. 


The Unicode Bidirectional Algorithm, which is commonly used for preparation of Bidi text for display, is not capable to reliably identify the natural base text direction for a given text. Only a human reader can unfailingly recognize the natural base text direction for a given text.


Support for enforcing the base text direction is provided out of the box by most platforms / technologies, but very often the default settings do not guarantee proper display of English and Arabic (or English and Hebrew) text in the same application.


Dojo provides necessary means (textDir attribute) to enforce the base text direction. Those should be explicitly leveraged by the application in order to ensure proper display of English and Arabic (or English and Hebrew) text on the same screen.

The ``textDdir`` attribute
----------------------------
Control over text direction for text which appears on the screen as part of the widget is provided via textDir attribute.For example:

.. html ::

   <body>
       <input data-dojo-type="dojox/mobile/TextBox" data-dojo-props='value:"Hello World !", textDir:"rtl"'>
   </body>


textDir controls only direction of text displayed inside widget. It does not affect the graphics of the widget. 
For widgets which don't display any text it has no effect.
Control over text direction (via textDir) is provided independently from control over GUI direction (via dir). For example you can set dir and textDir to different values as shown on the example below:

.. html ::

   <body>
       <input data-dojo-type="dojox/mobile/ComboBox" data-dojo-props='value:"Hello עולם!", list:"values", textDir:"rtl",dir:"ltr"'>
   </body>



Possible values
---------------

textDir can receive the same range of values defined for dir attribute in HTML5. Namely:

* ltr
* rtl
* auto

Dynamic change
---------------

Similarly to dir attribute, textDir supports dynamic change. Display of text changes accordingly when value of textDir is set programmatically.

Inheritance
-------------

As opposed to dir attribute textDir is neither inherited nor propagated.  This is because textDir is supposed to be used for controlling base text direction of end user text. This type of text usually appears in very well defined contexts. The same composite widget  (i.e. dialog) can show both end user text and translated text. Widget by itself can't distinguish between those types of text and thus can't decide to which portions of text apply textDir. This is why it is in responsibility of programmer to explicitly provide a value to textDir attribute for only those widgets which show end user text. 

Examples
---------

First example illustrates usage of textDir attribute to enforce different base text direction values to different instances of EdgeToEdgeList widget.

Notice that the upper list with caption "RTL RoundRectCategory!" has textDir set to "rtl" while bottom list with caption  "LTRL RoundRectCategory!"  has textDir set to "ltr".

.. html ::

   <body>
      <h2 data-dojo-type="dojox/mobile/RoundRectCategory" data-dojo-props='textDir:"rtl"'>RTL RoundRectCategory!</h2>
      <ul data-dojo-type="dojox/mobile/EdgeToEdgeList" data-dojo-props='textDir:"rtl"'>
         <li id="first" data-dojo-type="dojox/mobile/ListItem" data-dojo-props='icon:"../../images/i-icon-1.png"'>
	    <font style="font-style:italic; font-size: 16pt">Rtl </font>direction!!
	    <div data-dojo-type="dojox/mobile/Switch"></div>
	 </li>
	 <li id="second" data-dojo-type="dojox/mobile/ListItem" data-dojo-props='icon:"../../images/i-icon-2.png",rightText:"mac.", moveTo:"hello."'>
				 Wi-Fi!  Internet!  Rtl direction! 			
	 </li>
	 <li id="third" data-dojo-type="dojox/mobile/ListItem" data-dojo-props='icon:"../../images/i-icon-3.png", rightText:"AcmePhone.", moveTo:"hello."'>
			שלום World!
	 </li>
      </ul>
      <h2 data-dojo-type="dojox/mobile/RoundRectCategory" data-dojo-props='textDir:"ltr"'>LTR RoundRectCategory!</h2>
      <ul data-dojo-type="dojox/mobile/EdgeToEdgeList" data-dojo-props='textDir:"ltr"'>
	 <li id="first_ltr" data-dojo-type="dojox/mobile/ListItem" data-dojo-props='icon:"../../images/i-icon-1.png"'>
           <font style="font-style:italic; font-size: 16pt">Ltr </font>direction!!
	   <div data-dojo-type="dojox/mobile/Switch"></div>
	 </li>
	 <li id="second_ltr" data-dojo-type="dojox/mobile/ListItem" data-dojo-props='icon:"../../images/i-icon-2.png",rightText:"mac.", moveTo:"hello."'>
				Wi-Fi!  Internet!  Ltr direction!
	 </li>
	 <li id="third_ltr" data-dojo-type="dojox/mobile/ListItem" data-dojo-props='icon:"../../images/i-icon-3.png",textDir:"ltr", rightText:"AcmePhone.", moveTo:"hello."'>
				שלום World!
	 </li>
       </ul>
   </body>

Image below illustrates how this example looks like on Google Nexus 7 tablet:


.. image :: textDirAndroid.png


Second example illustrates selective assignment of textDir attribute for different widgets which are part of a composite widget - dialog. 

Please note that textDir for first input field is set to "ltr" while for other widgets it is set to "rtl".



.. html ::

  <body>
    <button onclick="show2()">Show Dialog</button>
    <div id="dlg2" data-dojo-type="dojox/mobile/SimpleDialog" data-dojo-props='closeButton:true'>
      <div class="dlgTitle" >Dialog for Text dir test
         <button data-dojo-type="dojox/mobile/Button" class="mblBlueButton" data-dojo-props='textDir:"rtl"'>שלום עולם !</button>
      </div>
      <table>
         <tr>
           <td style="width:250px"><img alt="" src="../images/pic1.jpg" width="230" height="230"></td>
           <td style="vertical-align:top">
              <input data-dojo-type="dojox/mobile/TextBox" data-dojo-props='value:"Hello World !", textDir:"ltr"'><br>
              <input data-dojo-type="dojox/mobile/ComboBox" data-dojo-props='value:"Hello שלום!", list:"values", textDir:"rtl"'>
           </td>
         </tr>
      </table>
    </div>
   </body>


Image below illustrates the result on iPad 2 

.. image :: bidi_textDiriOS.png
