#format dojo_rst

A11y Requirements
=================

:Status: Draft
:Version: 1.2
:Author: Becky Gibson

.. contents::
  :depth: 2

===================
5 A11y Requirements
===================

Below are the 5 basic Dojo Accessibility requirements which must be met when creating and styling user interface components. Each Dojo developer and designer are required to implement accessibility for dijit components. The folks with a11y experience will help but it is each developer's responsibility to understand and follow these guidelines. If you need help with a11y, create a trac ticket with the category a11y-review but remember that it is not the a11y team's job to implement accessibility for you!

**Visual**

  + `Identification and interaction with visual elements does not rely on color alone <#interaction-does-NOT-rely-on-color-alone>`_
  + `All functionality is perceivable without color or Images <#perceivable-without-color-or-images>`_
  + `All functionality is visible and usable at various font sizes <#visible-at-various-font-sizes>`_

**Functional**

  + `All functionality is usable via the mouse and keyboard <#usable-via-the-mouse-and-keyboard>`_
  + `All functionality is enabled for assistive technology <#enabled-for-assistive-technology>`_

Note that this is not a comprehensive list of Web Accessibility requirements, just the list of items most likely to be encountered by a Dojo Designer or Developer. For complete Accessibility Guidelines see:

  + `W3C Web Content Accessibility Guidelines 2.0 <http://www.w3.org/WAI/GL/>`_
  + `US Section 508 of the Rehabilitation Act <http://www.section508.gov/>`_
  + `W3C provided list of accessibility policies around the world <http://www.w3.org/WAI/Policy/>`_

======
Visual
======

Interaction does NOT rely on color alone
----------------------------------------

This is perhaps the most confusing requirement and most difficult to describe. It tries to address color blindness issues where a person may not be able to perceive certain colors. It does not mean you can not use color! However, when you use color to distinguish behavior such as active, selected, or focused elements, there must be enough contrast between the colors used for the difference to be apparent if the color itself can not be seen. A few examples are in order.

Here is a dojo tab container displayed using the blue soria theme. The first tab is active and has a darker blue background color. The non-active tabs are displayed in the lighter blue. Since there is a difference in contrast, the use of the background color is acceptable. 

.. image:: soriatabcontainer.png

If color is removed, the difference between the active and non-active tabs can still be distinguished as demonstrated in the image below. 

.. image:: soriatabcontainergrey.png

The following two images show another example using the dojo menu in the tundra theme. A blue background is applied to to the menu item with focus. 

.. image:: tundramenu.png

This background is still apparent when color (but not contrast) is removed.

.. image:: tundramenugrey.png

How to Test
~~~~~~~~~~~

If you are developing on the Mac the simplest way to test for this is to open Universal Access from System Properties, pick the Seeing panel and click on "Use grayscale". If you can still detect the contrast difference in modes, you have met the a11y requirement. Even better if you can increase the contrast on the "Enhance Contrast" slider and still see the difference. Try to be reasonable about the contrast level - if it isn't obvious or you have to ask for a second opinion the contrast probably isn't sufficent. If you have an image editing program you can capture an image of the component, load it into your editing program, reduce the saturation and make sure you can still perceive a contrast difference. Hey, anyone should be able to test for this!

If you want examples of contrast ratios for different background and foreground colors see Gez Lemon's `Example Luminosity Contrast Ratios <http://juicystudio.com/services/coloursaferatio.php>`_ or pick your own colors and use his `Luminosity Contrast Ratio Analyser <http://juicystudio.com/services/luminositycontrastratio.php>`_.

More Details
~~~~~~~~~~~~
This requirement comes from the W3C Web Content Accessibility Guidelines (WCAG) 2.0; Use of Color: `Color is not used as the only visual means of conveying information, indicating an action, prompting a response, or distinguishing a visual element <http://www.w3.org/TR/WCAG20/#visual-audio-contrast-without-color>`_. The more contrast that the color difference provides, the better.

WCAG 2.0 has techniques demonstrating the proper use of color:

  + `C15: Using CSS to change the presentation of a user interface component when it receives focus <http://www.w3.org/TR/2008/WD-WCAG20-TECHS-20080430/C15.html>`_.
  + `C16: Changing the background color or border of the element with hover and focus <http://www.w3.org/TR/2008/WD-WCAG20-TECHS-20080430/C16.html>`_

WCAG 2.0 has some specific requirements about the contrast ratio of text and images of text to the background but that doesn't generally apply to Dijit UI where text within the widgets is kept to a minimum. There are formulas for determining the color contrast as well as testing tools - see the How to Test section.

Perceivable without color or images
-----------------------------------

This requirement is intended to target low vision users who may have special display settings to help with a specific visual impairment. It can often get confused with the requirement that "Identification and interaction with visual elements does not rely on color alone" which must be met for the default display mode seen by the majority of users. Low Vision users often use a display setting referred to as High Contrast Mode. In Windows, this setting removes all colors and background images from Web pages. See `Widgets and High Contast Mode <http://www.dojotoolkit.org/2007/03/30/widgets-and-high-contrast-mode>`_ for a more complete description.

In Windows High Contrast mode any action or function that is differentiated by color or via a CSS background image is no longer visible. Using a background color to distinguish the active tab within a tab container which meets the first requirement does not meet this requirement since there is no longer any color differentiation for the user to comprehend. An additional means of identifying the active tab, such as a different outline around the tab or underlining the tab title must be provided for this mode. Icons and visual elements created via CSS background images are no longer visible and a real <img> element or text equivalent must be provided.

This requirement will take additional styles in order to meet. Dijit has code to detect high contrast mode and add a dijit-a11y class to the body element of the page. This will trigger additional styles to enable text equivalents, underlining, borders or other visual clues to make the components usable in high contrast mode. See High Contrast/Images Off in the 'Dijit Accessibility Strategy <dijit/a11y-strategy>`_ section for more implementation details. Some of the mechanisms to visually identify elements in high contrast mode are to add a different border or outline, increase the border width, or add an underline or overline to text. Background-images can be replaced by text or <img> elements (but the <img> elements must also have text alternatives). Examples in the Dojo widgets include:

**a dotted border on the tab title of the active tab container**

.. image:: tab.png

standard display

.. image:: tabHC.png

high contrast (yellow on black)

**a wide border to represent the progress within a progress bar**

.. image:: progress.png

standard display

.. image:: progressHC.png

high contrast (white on black)

**an overline on the selected date in the calendar**

.. image:: calendar.png

standard display

.. image:: calendarHC.png

high contrast (yellow on black)

**text alternatives for the editor toolbar buttons**

.. image:: toolbar.png

standard display

.. image:: toolbarHC.png

high contrast (black on white)


Visible at various font sizes
-----------------------------

==========
Functional
==========

Usable via the mouse and keyboard
---------------------------------

Enabled for assistive technology
--------------------------------
