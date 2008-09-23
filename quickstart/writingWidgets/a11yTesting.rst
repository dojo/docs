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
