#format dojo_rst

A11y Requirements
=================

:Status: Draft
:Version: 1.2
:Author: Becky Gibson

.. contents::
  :depth: 3

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

.. image:: 

If color is removed, the difference between the active and non-active tabs can still be distinguished as demonstrated in the image below. 

.. image::

The following two images show another example using the dojo menu in the tundra theme. A blue background is applied to to the menu item with focus. 

.. image::

This background is still apparent when color (but not contrast) is removed.

.. image::

How to Test
~~~~~~~~~~~

If you are developing on the Mac the simplest way to test for this is to open Universal Access from System Properties, pick the Seeing panel and click on "Use grayscale". If you can still detect the contrast difference in modes, you have met the a11y requirement. Even better if you can increase the contrast on the "Enhance Contrast" slider and still see the difference. Try to be reasonable about the contrast level - if it isn't obvious or you have to ask for a second opinion the contrast probably isn't sufficent. If you have an image editing program you can capture an image of the component, load it into your editing program, reduce the saturation and make sure you can still perceive a contrast difference. Hey, anyone should be able to test for this!

If you want examples of contrast ratios for different background and foreground colors see Gez Lemon's Example Luminosity Contrast Ratios or pick your own colors and use his Luminosity Contrast Ratio Analyser.

More Details
~~~~~~~~~~~~
This requirement comes from the W3C Web Content Accessibility Guidelines (WCAG) 2.0; Use of Color: Color is not used as the only visual means of conveying information, indicating an action, prompting a response, or distinguishing a visual element. The more contrast that the color difference provides, the better.

WCAG 2.0 has techniques demonstrating the proper use of color:

C15: Using CSS to change the presentation of a user interface component when it receives focus.
C16: Changing the background color or border of the element with hover and focus
WCAG 2.0 has some specific requirements about the contrast ratio of text and images of text to the background but that doesn't generally apply to Dijit UI where text within the widgets is kept to a minimum. There are formulas for determining the color contrast as well as testing tools - see the How to Test section.

Perceivable without color or images
-----------------------------------


Visible at various font sizes
-----------------------------

==========
Functional
==========

Usable via the mouse and keyboard
---------------------------------

Enabled for assistive technology
--------------------------------
