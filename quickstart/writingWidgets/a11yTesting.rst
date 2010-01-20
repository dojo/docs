#format dojo_rst

Testing Widgets for Accessibility
=================================

:Author: Becky Gibson


.. contents::
  :depth: 3

Currently the Windows operating system provides the most resources and functionality for testing for accessibility in more than one browser. Also, the majority of assistive technologies run under the Windows operating system. Test with both Firefox and Internet Explorer on at least the Windows operating system to assure at least a minimal level of accessibility.

Test for Full Keyboard Support
------------------------------

All widgets must be tested for use with the keyboard only. The most stringent way to test for keyboard support is to remove the mouse from the system and interact with the widget. This assures that only the keyboard can be used for navigation and interaction. Test that all functionality of the widget can be accomplished using the keyboard only. The functionality does not necessarily have to be performed in exactly the same manner as with the mouse. For example, it is preferred that a slider can be adjusted by dragging with the mouse or focusing the slider and adjusting the value using the arrow keys or plus and minus characters on the keyboard. But if the value and position of a slider can be adjusted by entering a new value in an associated text field, the slider is keyboard accessible. Drag and drop operations are another example of behavior which may need to be supported via an alternative mechanism such as a menu bar or context menu.

After determining that the widget is accessible using only the keyboard, test using both the keyboard and the mouse. There is no guarantee that a user will interact only using the keyboard or only using the mouse. Make certain that both types of interaction can be used within the widget and that the focus and styles are updated appropriately.

Since not all browsers support adding the tabindex to elements to make them focusable and thus keyboard accessible, it may not be possible to provide full keyboard support in all instances. 

Resources for Navigating via the keyboard
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- `Mozilla Keyboard Planning FAQ and Cross Reference <http://www.mozilla.org/access/keyboard/>`_
- `Common keyboard shortcuts in Firefox, and the equivalents in Internet Explorer and Opera <http://support.mozilla.com/en-US/kb/Keyboard+shortcuts>`_
- `Windows Keyboard Interface Summary <http://msdn.microsoft.com/en-us/library/ms997427.aspx>`_
- `Keyboard Shortcuts for Internet Explorer 6 <http://www.microsoft.com/enable/products/KeyboardSearch_IE6.aspx>`_
- `The Keyboard Lover’s Guide to IE7 <http://blogs.msdn.com/ie/archive/2006/02/08/527702.aspx>`_
- `Use Opera without a Mouse <http://www.opera.com/support/tutorials/nomouse/>`_

Test ARIA Support
-----------------

It is important that when an element is clicked on with the mouse or navigated to via the keyboard that the element receives actual focus. Focus must not be simulated via styles since assistive technology relies on the focus event to inform the user about the element and the role and state. Focus can be visually tested since browsers will indicate focus, however the focus border may be difficult to see or have been modified with a different style.

Testing using Microsoft Inspect Objects
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Microsoft Inspect Objects application from the Microsoft Active Accessibility SDK can be used on Windows to test for focus and also to verify the correct ARIA role and state has been set on the element. Test using Firefox version 3 since Firefox currently has the most comprehensive support for the ARIA role and state information.

Download Inspect32 from `Active Accessibility 2.0 SDK Tools <http://www.microsoft.com/downloads/details.aspx?FamilyID=3755582a-a707-460a-bf21-1373316e13f0&DisplayLang=en>`_. Basic information on using the tool is provided at `Using Inspect Objects <http://msdn.microsoft.com/en-us/library/ms696079.aspx>`_.

Run Inspect Objects and test the widget for focus and role and state information. Turn on Highlight Focus tracking via the Inspect Objects Options menu. This mode will display a yellow rectangle around the currently focused element. Use this rectangle to verify that the expected element is actually receiving focus. The Show Information Tooltip option may also be helpful. As you set focus to an item, Inspect Objects will display information about the role and state of the object. You can verify that the object receives focus and that the role and state information is as expected.

Below is a picture of the diijt Tree with Inspect Objects running and the Show Information Tooltip and Turn On Highlight Focus options set. With focus on an expanded tree item the MS Inspect focus rectangle and role and state information is displayed within the tooltip. The role is “outline item” and the state is “focused, expanded, focusable”. This verifies that the role of treeitem (interpreted as outline item by MS Inspect) has been properly set in the dijit tree item code. The state information verifies that the element is focused and the expanded state is set. With focus on an collapsed tree item node the state would display, “focused, collapsed, focusable”, since the expanded property is set to false. Note that when the state of an element changes, focus must be removed from the element and then returned in order for Inspect Objects to update the information. Or, rather than change focus use the Inspect Objects Action Refresh command to update the information about the currently focused object.

.. image:: treeInspect.jpg

Testing with Accessibility Probe (AccProbe)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

`Accessibility Probe <http://www.eclipse.org/actf/downloads/tools/accprobe/index.php>`_ is an under development Eclipse RCP-based stand-alone Java aplication that combines inspection, event-monitoring, and hierarchical viewing of accessible objects and their properties. It is currently only available for the Windows platform but does support both Microsoft Active Accessibility (MSAA) and IAccessible2-enabled applications. IAccessible2 is an extension to MSAA to support some of the more complex ARIA roles and is used in Firefox 3. The AccProbe is also more accessible than MS Inspect and is another option for ARIA and focus testing. It works in a similar manner to Inspect in that it provided focus tracking and inspection of ARIA role and state values. 

Testing using a screen reader
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For best results, testing with a screen reader is recommended. This section provides a brief introduction to using screen readers. Currently `Window-Eyes <http://www.gwmicro.com/Window-Eyes/>`_ 6.1 and `JAWS <http://www.freedomscientific.com/jaws-hq.asp>`_ 9 or later versions of both running with Firefox 3 will recognize ARIA role and state information. Unfortunately it takes some time and experience to become proficient using a screen reader and these programs are expensive. There are demo versions available which will run for a limited amount of time (usually 30 minutes) before a reboot of the system is required). But, note that often the demo versions are not to be used for commercial purposes.

When testing with a screen reader be careful not to use the mouse when navigating through the widget. Often a tester will miss problems with keyboard navigation or focus by using the mouse to initiate or force interaction within a widget. Not all screen reader users are blind – some may have low vision or use the screen reader to assist with cognitive disabilities, but, in order to catch all problems it is important to interact with the widget in the same manner as someone with no vision.

Screen readers work by storing the contents of the entire page into a virtual buffer. The user can move through this buffer and have the contents spoken by the screen reader. There are many mechanisms to move through the virtual buffer, by character, word, line, or from object to object. Both JAWS and Window-Eyes have different terminology for this buffer. Window-Eyes refers to it as “browse mode” and JAWS as “virtual PC cursor mode”. When interacting with a Web page, the screen reader can no longer rely on the virtual buffer. In Window-Eyes the user must turn browse mode off to interact with form elements and interactive widgets. In JAWS the user must enter forms mode on or turn virtual PC cursor mode off to interact with form controls and interactive widgets.

When testing fully keyboard accessible Dojo widgets the screen readers must be in the “interactive mode” to announce the role and state of an element as the element receives focus. In Window-Eyes this is “browse mode off” which is toggled using the ctrl-shift-a keys. In JAWS this is “forms mode on” which is turned on by pressing enter on a focusable element and is turned off by pressing the numpad plus key. JAWS also has a toggle to turn virtual PC cursor mode on and off, insert-z, that can be used instead of forms mode.

If the role and state information have been applied correctly the screen reader will hear information about the role and stated of widget elements as well as information about child objects. The image below is a simple tree control with three main nodes with titles Node1 , Node 2, and Node 3. Node 1 has no children. Node 2 is expanded and has two child nodes titled Node 2.1 and Node 2.2. Node 3 has children but is not expanded. Here is a brief example of what is spoken by Window-Eyes with focus on the Node 2 tree item within the tree control displayed in the image below, “Node 2 expanded two items, 2 of 3.”

.. image:: treenode.jpg

Test for Low Vision Support
---------------------------

Test in Windows High Contrast Mode
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The code in dijit._base.wai.js to check for high contrast mode currently only works with Firefox and Internet Explorer on the Windows Operating system. Windows comes configured with default high contrast mode settings. Turn on high contrast mode in Windows XP via the Accessibility Options dialog available from the Control Panel. From the Diplay panel check the high contrast checkbox. Press the settings button to modify the display colors and font sizes. Checking the Use shortcut checkbox from the settings dialog allows toggling high contrast mode on and off using the shift-alt-printscreen key combination. Press OK to confirm the settings and then OK again to close the dialog and turn on high contrast mode. Note, putting your system in high contrast mode will likely rearrange the desktop icons on the system due to the changes in font size.

After turning on high contrast mode, test the widget in Firefox and Internet Explorer. If the widget test page was already loaded in the browser, you may need to refresh the page for the high contrast mode to take affect. When the widget is reloaded high contrast mode will be detected and the accessible version of the widget will be loaded. This version should provide visible text alternatives for CSS background images to create the look and feel of the widget user interface. Verify that all components within the widget are visible. Any components or visual effects which are created via background images or color will no longer be visible in high contrast mode. Verify that the user is able to determine where current focus is within the widget. If focus is not visually evident the widget developer may have used a background color change to indicate focus (or the browser provided focus rectangle may be hard to distinguish). Fix this by using a different styled border or other mechanism to indicate focus if the browser differentiation is not sufficient. When testing in high contrast mode it is fairly evident where the problems occur since any visual effects which rely on color or images will no longer be visible.

Test for Usable Operation with Images Off
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In addition to testing for support of high contrast mode, the widgets should also work with images are turned off in the browser. Currently this mode is only detected by the dijit.wai.onload function in Firefox on Windows. Test in Firefox by turning images off via the Tools Options dialog. Test in Internet Explorer by turning on high contrast mode (so the accessible version of the Dojo widgets will be loaded) and then also turning off images in the Advanced tab of the Tools Internet Options dialog.

With images turned off the widgets should still be usable. Since no images are loaded, the alt attribute of any real image elements and the text alternatives for any CSS background images should be displayed. Verify that the text alternatives provide sufficient information for the user to interact with the widget.

Test for Font Size Changes
~~~~~~~~~~~~~~~~~~~~~~~~~~

The widgets should still be usable if the font size of the page is changed. Increase and decrease the font size and make certain that the widget still renders correctly. Some problems can occur when the height or width of a widget is set using pixels. When the font size increases it may no longer fit within the height or width specified. One example is creating a toolbar and setting its height: 25px. When the system is in high contrast mode, the toolbar images are replaced by text. If that text size is increased it may not fit within the 25px toolbar height and be clipped. Instead of setting the height using pixels use ems or % instead.

Each browser has a different mechanism for changing font size:

- Firefox 2 - select View Text Size Increase or press ctrl + or View Text Size Decrease or press ctrl -
- Firefox 3 - select View Zoom Text Only. Firefox 3 also will zoom the entire page, including imeages, using View Zoom In or press ctrl + to increase and View Zoom Out or press ctrl - to decrease
- IE 6 - select View Text Size and pick from Largest, Larger, Medium, Smaller, or Smallest
- IE 7 - select View Text Size and pick from Largest, Larger, Medium, Smaller, or Smallest. IE 7 will also zoom the entire page using Page Zoom Zoom In or press ctrl + and Page Zoom Zoom Out or press ctrl -.
- Safari - select View Make Text Bigger or press ctrl + or View Make Text Smaller or press ctrl -

(on the Mac use the apple key in place of the ctrl key)

The page zooming features of Firefox 3 and IE 7 diminish the need to support changing text size but it is still important to support IE 6 and Firefox 2.
