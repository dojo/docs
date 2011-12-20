.. _dijit/a11y/index:

==========================
Dijit Accessibility (a11y)
==========================

:Author: Becky Gibson

.. contents ::
   :depth: 2

It is important that all users can access applications built using Dojo.
People with disabilities access the Web in many manners.
Some people rely on the keyboard only to navigate and make selections.
Others use custom font and color settings, custom style sheets, screen magnification or screen readers to interact with the computer.
With the addition of multimedia to the Web, captioning is important for folks with hearing loss.
Those with cognitive disabilities may use a variety of assistive technology to adapt the content to a particular learning style.

In addition, many countries require that Web content is accessible to all.
Section 508 of the Disabilities Act requires the US Government to purchase accessible technology.
Australia, Japan, Great Britain and the European Union all have accessibility regulations.
Thus, it is important for the Dojo Toolkit to provide a way to build accessible applications.


Web Accessibility Issues
========================

The main accessibility concern for the Dojo Toolkit is the widget set.
The widgets need to be usable by all users to create accessible applications using Dojo.
The main issues are with color, device independent interactions and providing semantic information about these user interface (UI) components.
The core widgets in Dojo 0.9, those found in the dijit subsystem, will be fully accessible for the 1.0 release.

**Color/CSS:** There are several issues with color. Some people have vision problems, which prevent them from seeing certain colors or may need a high contrast between foreground and background colors. These people may adjust the operating system colors to meet their needs or use the high contrast settings provided by the operating system. In some cases, when a person can not distinguish the colors in an image, they may turn off images in the browser and rely on the description of the image provided through a text alternative. In HTML, the text alternative is provided by using the alt attribute of the img element.

In order to create high performance, easily styled and visually appealing widgets, dijit makes use of CSS background images to create a desktop-like look and feel.
Without additional work, these widgets would not work in high contrast mode.
Selecting high contrast mode in the Windows operating system forces all color and image related CSS information to be turned off in the browser.
All positioning information is retained but the colors and background images are turned off.
Dojo widgets that create the visual effects using CSS background-images without providing text alternatives are not visible in high contrast mode.
To accommodate high contrast mode, the dijit widgets rely on CSS background images to convey information contain a hidden text alternative element, which is made visible when high contrast mode is detected.
This text alternative also accommodates users who may turn images off in the browser.

**Device Independent Interactions:** Not all users are able to interact with the computer using a mouse, thus, device independent interaction is important. This means that, at a minimum, keyboard interactions must be supported. The dijit widgets must not work solely via the mouse. For HTML links and form controls, the keyboard is automatically supported. But, since dijit is creating custom widgets via DHTML and scripting of elements other than links and form controls, keyboard event handling must be added. Dojo widgets created using technologies other than HTML such as SVG, must also support the keyboard or provide an alternative interface that works with the keyboard.

**Detailed information about role and state:** Accessibility application programming interfaces (APIs) for desktop graphical user interface (GUI) frameworks define a standard contract between an application component and an assistive technology (AT). The information about the type of component and its current state is provided to the AT via the accessibility programming interface.

Examples of accessibility APIs are:

* `Java Accessibility API <http://java.sun.com/products/jfc/accessibility/index.jsp>`_
* `Microsoft Active Accessibility (MSAA) <http://msdn.microsoft.com/library/default.asp?url=/library/en-us/msaa/msaaccrf_8y2b.asp>`_
* `Apple Accessibility for COCOA <http://developer.apple.com/documentation/Cocoa/Conceptual/Accessibility/index.html>`_
* `Gnome Accessibility Toolkit (ATK) <http://library.gnome.org/devel/atk/unstable/>`_

In the browser environment, certain HTML elements have well defined roles and states.
Examples include lists, links and form elements.
The browser communicates the information about these elements and the current state such as checked, unchecked, readonly, disabled, visited, etc.
to assistive technology via the accessibility APIs.
Now that user interface components are being created via scripted HTML elements such as ``<div>`` and ``<span>``, the assistive technology needs additional information about the created component and its behaviors.

The W3C Web Accessibility Initiative `Accessible Rich Internet Applications (WAI-ARIA) Roadmap <http://www.w3.org/TR/aria-roadmap/>`_ provides specifications that describe how to provide this additional information to the assistive technology.
These specifications define a set of roles and states that can be added to the created DHTML user interface components.
With the addition of this information and support by the browser and assistive technology, a user of AT can obtain detailed information about the user interface components created for the Web.
For example, a tree component is identified as a tree and each tree item, its level in the tree, expanded and collapsed state and number of children is now available to a screen reader user.
The current ARIA specifications are supported in Firefox 1.5 and later versions as well as the by the Window-Eyes screen reader beginning in version 5.5 and partial support by JAWS  beginning in version 7.1.
Support from other Windows browsers and assistive technology vendors are expected in the future.
To provide the most comprehensive accessibility solution for Dojo, the ARIA techniques are being applied to the dijit widgets.
