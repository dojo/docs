.. _dijit/_base/popup:

=================
dijit/_base/popup
=================

:Project owner: Bill Keese
:since: V?

.. contents ::
   :depth: 2

Introduction
============

dijit/popup is the main mechanism within dijit that enables the creation of pop-ups like dropdowns and tooltips.
It is used by every widget that creates a pop-up around another element.

Parent widgets
==============

When creating a pop-up, there are usually two widgets involved:

* The parent widget, which controls opening and closing of the pop-up
* The pop-up widget itself

Opening a pop-up from a parent widget involves calling ``popup.open`` with a kwArgs object
that provides information about the pop-up and its related parent widget.
The available properties for this object are:

parent (Widget)
  The widget that is displaying the pop-up.
popup (Widget, required)
  The widget to display as a pop-up. This can be any dijit widget; some widgets that are commonly used as popups include :ref:`dijit.ColorPalette <dijit/ColorPalette>`, :ref:`dijit.Menu <dijit/Menu>`, and :ref:`dijit.Calendar <dijit/Calendar>`.
around (DomNode)
  A DOM node that should be used as a reference point for placing the pop-up. For pop-ups that are not meant to be placed around an element, use ``x`` and ``y`` instead
x (number)
  The absolute horizontal position in pixels at which to place the pop-up.
y (number)
  The absolute vertical position in pixels at which to place the pop-up.
orient (string[])
  When placing a pop-up around a DOM node, it is possible to specify where the pop-up should appear around it by providing an array of position strings. Dijit will try each position in order until the pop-up appears fully within the viewport. Possible values are:

  * before: places drop down to the left of the anchor node/widget, or to the right in the case of RTL scripts like Hebrew and Arabic
  * after: places drop down to the right of the anchor node/widget, or to the left in the case of RTL scripts like Hebrew and Arabic
  * above: drop down goes above anchor node
  * above-alt: same as above except right sides aligned instead of left
  * below: drop down goes below anchor node
  * below-alt: same as below except right sides aligned instead of left

  If left undefined, the default value is ``[ "below", "below-alt", "above", "above-alt" ]``.

onCancel (function())
  A callback that is executed when the user has tried to cancel the pop-up by either hitting ESC or by using the pop-up’s cancel mechanism.
onClose (function())
  A callback that is executed when the pop-up is actually closed by ``popup.close``.
onExecute (function())
  A callback that is executed when a user has “executed” a function in the pop-up, like selecting a menu option.
padding (``{x: Number, y: Number}``)
  An object that specifies extra padding that should be given to the area around the pop-up when determining its placement.

While only the ``popup`` property is required, most pop-ups will normally need to also provide ``onCancel`` and ``onExecute`` callbacks (as explained below) as well as either an ``around`` or ``x`` and ``y`` properties.

Here’s an example that roughly illustrates how :ref:`dijit/_HasDropDown` opens and closes pop-ups:

.. js ::
 
    var self = this;

    // wrap the pop-up widget and position it offscreen so
    // that it can be measured by the widget’s startup method
    popup.moveOffScreen(dropDown);

    // if the pop-up has not been started yet, start it now
    if(dropDown.startup && !dropDown._started){
        dropDown.startup();
    }

    // make the pop-up appear around aroundNode
    popup.open({
        parent: this,
        popup: dropDown,
        around: aroundNode,
        orient: this.dropDownPosition,
        onExecute: function(){
            popup.close(dropDown);
        },
        onCancel: function(){
            popup.close(dropDown);
        },
        onClose: function(){
            domAttr.set(self._popupStateNode, "popupActive", false);
            domClass.remove(self._popupStateNode, "dijitHasDropDownOpen");
        }
    });

    domAttr.set(this._popupStateNode, "popupActive", "true");
    domClass.add(this._popupStateNode, "dijitHasDropDownOpen");

As you can see, there are three essential calls here, ``popup.moveOffScreen``, ``popup.open``, and ``popup.close``.
``popup.moveOffScreen`` wraps the widget in a container, appends it to the ``<body>``,
then moves it off-screen so that any measurement ``dropDown.startup`` needs to do is possible.
Once that’s done, it opens the pop-up by calling ``popup.open``.
Finally, the ``onExecute`` and ``onCancel`` callbacks both call ``popup.close``, passing in the correct pop-up widget to close.

It’s important to note here that the parent widget is responsible for both opening *and closing* the pop-up.
This architecture was used so that the parent widget is always aware of whether or not its child pop-up is open, and so that it can easily perform any necessary clean-up or other relevant activity once its pop-up has closed.

Pop-up widgets
==============

Any normal widget can be used as a pop-up.
For example, :ref:`dijit/Calendar` is a normal widget that can be displayed inline in the page, but is used as a pop-up by the :ref:`DateTextBox <dijit/form/DateTextBox>` widget.
In other words, there’s no need for a :ref:``PopupWidget`` base class for pop-up widgets.
However, there are two important methods that the pop-up widget can use to hint to the parent widget that it's ready to be closed:

.. js ::

    onExecute: function(){
        // summary: attach point for notification about when a menu item has been executed
    },

    onCancel: function(/*Boolean*/ closeAll){
        // summary: attach point for notification about when the user cancels the current menu
    }

dijit/popup will monitor calls to these two methods and inform the parent widget when either of them is executed.

Here’s an example from a pop-up widget that triggers onExecute when it’s been clicked:

.. js ::

    onItemClick: function(/*Widget*/ item, /*Event*/ evt){
        ...
        // before calling user defined handler, close hierarchy of menus
        // and restore focus to place it was when menu was opened
        this.onExecute();

        // user defined handler for click
        item.onClick(evt);
        ...
    }

Lifecycle
=========

The lifecycle of a pop-up widget looks like this:

1. Parent widget calls ``popup.open`` to display the pop-up, passing ``onExecute`` and ``onCancel`` callbacks for when it needs to close
2. User interacts with the pop-up, causing ``this.onExecute()`` or ``this.onCancel()`` to be called on the pop-up widget
3. dijit/popup code notices the ``onExecute``/``onCancel`` method has been called and informs the parent widget by calling the ``onExecute`` function defined in the ``popup.open`` call
4. Parent widget calls ``popup.close``, which closes the pop-up
5. ``popup.close`` calls the ``onClose`` callback defined in the original ``popup.open`` call

If the user clicks a blank section of the screen in order to close the pop-up instead of interacting with the widget, then the ending steps of the lifecycle are slightly different:

1. dijit/popup code notices the click on the blank area of the screen
2. dijit/popup code doesn’t close the pop-up widget directly, but rather calls the ``onCancel`` callback from the original ``popup.open`` call
3. Parent widget calls ``popup.close``, which closes the pop-up

Stacks
======

Pop-ups can open other pop-ups.
This ability is leveraged heavily by :ref:`dijit/Menu`.
To facilitate this, dijit/popup keeps track of the entire stack of open pop-ups.
In the case when a hierarchy of pop-ups all need to be closed at once, calling ``popup.close`` on the top-most pop-up will close all child pop-ups.
This means that parent widgets do not need to maintain their own stack of pop-ups in order to ensure that they can clean up properly after themselves.

Keyboard handling
=================

dijit/popup automatically listens for key presses on the ESC key as a way to cancel the highest pop-up
and return to the parent node (which may itself be a pop-up).
When the ESC key is pressed, the ``onCancel`` callback passed in the call to ``popup.open`` is called.
dijit/popup also listens for the TAB key, and if it sees it, the entire stack of pop-ups is cancelled
(in the case of menus, where one pop-up has opened another and so forth).

Note that in neither of these cases does the dijit/popup code directly close any pop-ups.
It just calls the ``onCancel`` callback defined in the call to ``popup.open``.
That callback then is responsible for calling ``popup.close(popupWidget)``.

Popup DOM node positioning
==========================

``popup.moveOffScreen`` should be called on any nodes that will be used as pop-ups. Its main function, besides hiding the node, is to attach it as a direct child of ``<body>``. The reason this is done is to ensure the node doesn’t get cut off if it is inside a ``<div>`` with a short height. (For example, given a button inside a :ref:`dijit/layout/TabContainer`, the pop-up might want to overflow past the bottom of the TabContainer.)

Note that this design decision makes TAB key handling particularly difficult, and it’s not handled perfectly: if a user hits the TAB key while on a sub-menu of a :ref:`dijit/MenuBar`, or any drop down from a :ref:`dijit/form/DropDownButton`, they probably expect the focus to go to the next element after the MenuBar/DropDownButton.
However, since the drop-down has actually been repositioned as the last element in ``<body>``, just letting the browser handle the TAB key won't do what the user expects.

As a compromise, the TAB key (while focus is on a pop-up) will re-focus on the DropDownButton/MenuBarItem that spawned the top pop-up.
This is handled by the code that calls ``popup.open``, in the return handler for ``onCancel``.
See :ref:`dijit/form/DropDownButton` for an example.
