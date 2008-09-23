#format dojo_rst

Testing Widgets for Accessibility
=================================

:Status: Draft
:Version: 1.2
:Author: Becky Gibson


.. contents::
  :depth: 3

Currently the Windows operating system provides the most resources and functionality for testing for accessibility in more than one browser. Also, the majority of assistive technologies run under the Windows operating system. Test with both Firefox and Internet Explorer on at least the Windows operating system to assure at least a minimal level of accessibility.

Test for full keyboard support
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
