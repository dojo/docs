## page was renamed from dijit-a11y-statement
#format dojo_rst

Dijit Accessibility Statement
=============================

:Author: Becky Gibson

.. contents::
   :depth: 2


===================
Dijit Accessibility
===================

Dojo has made a serious commitment to creating a toolkit that allows the development of accessible Web applications for all users, regardless of physical abilities. The core widget set of Dojo, dijit, is fully accessible since the 1.0 release, making Dojo the only fully accessible open source toolkit for Web 2.0 development. This means that users who require keyboard only navigation, need accomodations for low vision or who use an assistive technology, can interact with the dijit widgets. If you are new to accessibility, please refer to the `Web Accessibility Issues <dijit-a11y>`_ page for more general information about accessibility. Developers wanting further information about the implementation of accessibility within dijit and/or how to create and test accessible widgets should refer to the following accessibility information:

* `Dijit Accessibility Strategy <dijit/a11y/strategy>`_
* `Dojo Accessibility Resources <dijit/a11y/resources>`_
* `Creating Accessible Widgets <quickstart/writingWidgets/a11y>`_
* `Testing Widgets For Accessibility <quickstart/writingWidgets/a11yTesting>`_
* `Basic A11y Requirements <dijit/a11y/req>`_

In addition, the documentation for each dijit widget contains a section explaining any parameters specific to accessibility, the keyboard navigation of the component, and any open accessibility issues.


=============================
Dojo Accessibility Compliance
=============================

People familiar with accessibility and accessibility guidelines such as the W3C's `Web Content Accessibility Guidelines <http://www.w3.org/WAI/GL/>`_, and the `US Section 508 <http://section508.gov/>`_ requirements, are often interested in a compliance statement for Dojo. While Dojo does not make an explicit claim of compliance to W3C WCAG 2.0 Level A or to US Section 508, every attempt has been made to meet those guidelines and to make the 1.0 and future versions of the core widget set, dijit, accessible to keyboard, low vision and assistive technology users.

- Keyboard support has been added to all of the dijit widgets and is supported in Firefox 2 & 3 on Mac and Windows as well as IE 6 & 7 on Windows (Safari and Opera do not yet support full keyboard navigation of scripted content). Note that for keyboard support in Firefox on the Mac a System Properties keyboard setting must be changed from the default. Open System Properties and select Keyboard & Mouse, then select the Keyboard Shortcuts tab. At the bottom of the panel under Full Keyboard Access: make certain that All Controls is checked.

- All of the dijit widgets support font resizing and work in Windows High Contrast mode to support low vision users.

- Dijit utilizes the under development `W3C Accessible Rich Internet Applications <http://www.w3.org/TR/wai-aria/>`_ (ARIA) specification so that all dijit widgets are accessible using the latest versions of the `JAWS <http://www.freedomscientific.com/products/fs/jaws-product-page.asp>`_ or `Window-Eyes <http://www.gwmicro.com/Window-Eyes/>`_ screen readers with Firefox 3. 

Additional WCAG 2.0 and US Section 508 compliance details are provided below.


========================
Accessibility Fine Print
========================

In many respects, dijit is ahead of the curve in supporting Accessibility. The ARIA specification which dijit has implemented is still in the development stage within the W3C but is nearing Last Call status. Not all browsers allow any object to receive focus - a requirement to providing full keyboard support. Currently only Firefox has implemented ARIA within the browser in order to provide support for assitive technologies such as screen readers. Opera, Safari and IE8 browser developers are currently working to include ARIA support. While the current versions of the JAWS and Window-Eyes screen readers support the basics of ARIA, there is additional work for them to support the advanced features of the specification. That work is currently in progress. One of the toolkits had to be first and dijit's usage of ARIA has helped to provide valuable feedback to the specification developers and test cases for the screen reader vendors. As support for ARIA continues dijit will incorporate accessibility for regions of the page updated via Ajax as well as for drag and drop.

Even though the dijit widgets are all fully accessible, the developer is responsible for using them properly and following general accessibility guidelines to create an accessible Web application. Developers should make use of any optional widget parameters listed in the accessibility section in the documentation page for each widget. Basic accessibility guidelines such as associating text labels to all form controls via the <label> element and providing alternative text for all images must be followed to maintain accessibility of the widgets and an application.

Widget sizing can also be an issue. When creating elements which require size, consider that some users may need to increase the font size. If you set the height of a dijit toolbar to 25px and a user has set the font size to largest, any text in the toolbar may be clipped. Instead of using px, set the height using ems and the toolbar size will be relative to the font size: 
<div dojoType="dijit.Toolbar" region="top" style="height:1.25em">

Also be aware of source code ordering, the BorderContainer will properly align the ContentPane regions when it renders them, no matter if the bottom region is specified before the top region in source code order. But, for best support by assistive technology, add the ContentPane regions in correct source code order, with top regions appearing first and bottom regions last. The best way to be confident of an accessible application is to test, test, test! Any developer can test basic accessibility by getting rid of your mouse and make certain you can navigate and use your application with only a keyboard. There are many resources on the Web for creating Accessible content, use them!


=========================
Accessibility Involvement
=========================

Becky Gibson of IBM's Emerging Technology team is the accessibility lead for Dojo responsible for implementing and promoting accessibility within the Dojo community. She has been fortunate to get support for Accessibility from Dojo's leadership team as well as the `BDFL <http://en.wikipedia.org/wiki/BDFL>`_ of Dijit, Bill Keese, and other dijit developers. Grants from `IBM <http://www.ibm.com/us/>`_ and `Mozilla <http://www.mozilla.org/foundation/>`_ enabled members of the `Adaptive Technology Research Centre <http://atrc.utoronto.ca/>`_ (ATRC) at the University of Toronto to actively participate in the development of the ARIA specification and its implementation within Dojo. The dijit team is always looking to recruit new members to help with accessibility or to help developers enable accessibility in new contributions to dojo, dijit, and dojox.


=============================
Additional Compliance Details
=============================

US Section 508
--------------

There is currently one US Section 508 technical standard that is of concern to dijit, found in the `1194.22 Web-based intranet and internet information and applications section <http://section508.gov/index.cfm?FuseAction=Content&ID=12#Web>`_: (d) Documents shall be organized so they are readable without requiring an associated style sheet.

Since dijit relies heavily on CSS positioning to create the widgets, they will not render in a logical order when CSS is turned off. However, dijit has provided "equivalent facilitation" so that the widgets are usable by low vision and assisitive technology users with CSS turned on. Dijit accomplishes this by providing text equivalents which are visible in Windows high contrast mode for all images used. It also does not rely on specific font sizing so adjustments in font size are honored by the widgets. In addition, dijit implements the ARIA specification which identifies the role and properties of each widget to a screen reader user, making them usable by assistive technology with CSS turned on.
