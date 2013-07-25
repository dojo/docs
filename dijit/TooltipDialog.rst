.. _dijit/TooltipDialog:

===================
dijit/TooltipDialog
===================

:Authors: Bill Keese, Nikolai Onken, Marcus Reimann
:since: V0.9

.. contents ::
    :depth: 2

A variant on Dialog Box is dijit.TooltipDialog.


Introduction
============

The dijit/TooltipDialog displays a tooltip that contains form elements (like a dialog).

Although both Dialog and TooltipDialog are modal,
TooltipDialog can be closed by clicking anywhere on the screen,
whereas for Dialog you must click on the [x] mark of the Dialog.

A TooltipDialog is meant to be opened as a drop down from another widget, usually
:ref:`dijit/form/DropDownButton <dijit/form/DropDownButton>`.


Examples
========

Programmatic example
--------------------

The first example shows how to create a TooltipDialog and DropDownButton programmatically.

.. code-example ::

  .. js ::

    require([
        "dijit/TooltipDialog",
        "dijit/form/TextBox",
        "dijit/form/Button",
        "dijit/form/DropDownButton",
        "dojo/dom",
        "dojo/domReady!"
    ], function(TooltipDialog, TextBox, Button, DropDownButton, dom){
        var myDialog = new TooltipDialog({
            content:
                '<label for="name">Name:</label> <input data-dojo-type="dijit/form/TextBox" id="name" name="name"><br>' +
                '<label for="hobby">Hobby:</label> <input data-dojo-type="dijit/form/TextBox" id="hobby" name="hobby"><br>' +
                '<button data-dojo-type="dijit/form/Button" type="submit">Save</button>'
        });

        var myButton = new DropDownButton({
            label: "show tooltip dialog",
            dropDown: myDialog
        });
        dom.byId("dropDownButtonContainer").appendChild(myButton.domNode);
    });

  .. html ::

    <div id="dropDownButtonContainer"></div>


Declarative markup
------------------

As usual you can create the TooltipDialog and DropDown button widget declaratively using the data-dojo-type attribute.
When created declaratively the DropDownButton node has two children, one for the label of the button,
and the other for the drop-down widget that's displayed when you press the button.

Here's one displaying a TooltipDialog:

.. code-example ::

  .. js ::

    require(["dojo/parser", "dijit/TooltipDialog", "dijit/form/DropDownButton", "dijit/form/TextBox", "dijit/form/Button"]);

  .. html ::

    <div data-dojo-type="dijit/form/DropDownButton">
        <span>Register</span>
        <div data-dojo-type="dijit/TooltipDialog">
            <label for="name2">Name:</label> <input data-dojo-type="dijit/form/TextBox" id="name2" name="name2" /><br />
            <label for="hobby2">Hobby:</label> <input data-dojo-type="dijit/form/TextBox" id="hobby2" name="hobby2" /><br />
            <button data-dojo-type="dijit/form/Button" type="submit">Save</button>
        </div>
    </div>

Low Level Programmatic example
------------------------------

When possible, your anchor widget should extend :ref:`dijit/_HasDropDown <dijit/_HasDropDown>`.
However, a TooltipDialog may be popped up from any node, by calling the low level
:ref:`dijit/popup <dijit/popup>`.open() API directly.


In this case you should:

1. Make sure the TooltipDialog gets focus when it's opened
2. Setup an onCancel callback to close the popup when the user presses the ESC key.
3. Setup an _onBlur handler to close the popup when the user clicks another part of the screen.


For example:

.. code-example ::

  .. js ::

    require([
        "dijit/TooltipDialog",
        "dijit/popup",
        "dojo/on",
        "dojo/dom",
        "dojo/domReady!"
    ], function(TooltipDialog, popup, on, dom){
        var myTooltipDialog = new TooltipDialog({
            id: 'myTooltipDialog',
            style: "width: 300px;",
            content:
                "<p>Focus goes here: <input></p>" +
                "<p>Press ESC or click a blank area of the screen to close.</p>",

            onShow: function(){
                // Focus the first element in the TooltipDialog
                this.focus();
            },

            _onBlur: function(){
                // User must have clicked a blank area of the screen, so close the TooltipDialog
                popup.close(myTooltipDialog);
            }
        });

        on(dom.byId('thenode'), 'click', function(){
            popup.open({
                popup: myTooltipDialog,
                around: dom.byId('thenode'),

                onCancel: function(){
                    // User pressed escape, so close myself
                    popup.close(myTooltipDialog);
                }
            });
        });
    });

  .. html ::

    <div id="thenode">Click to pop up the dialog.</div>


Mouse over example
------------------
Here's a modified example where the TooltipDialog is controlled by mouse enter / mouse leave
instead of by clicking or keyboard:

.. code-example ::

  .. js ::

    require([
        "dijit/TooltipDialog",
        "dijit/popup",
        "dojo/on",
        "dojo/dom",
        "dojo/domReady!"
    ], function(TooltipDialog, popup, on, dom){
        var myTooltipDialog = new TooltipDialog({
            id: 'myTooltipDialog',
            style: "width: 300px;",
            content: "<p>I have a mouse leave event handler that will close the dialog.",
            onMouseLeave: function(){
                popup.close(myTooltipDialog);
            }
        });

        var node = dom.byId('mouseovernode');
        console.log(on, node);
        on(node, 'mouseover', function(evt){
            popup.open({
                popup: myTooltipDialog,
                around: node
            });
        });
    });

  .. html ::

    <div id="mouseovernode">Move the mouse over me to pop up the dialog.</div>



Accessibility
=============

Keyboard
--------

============================================================    =================================================
Action                                                          Key
============================================================    =================================================
Navigate to next focusable element in the tooltip dialog        tab
Navigate to previous focusable element in the tooltip dialog    shift-tab
Close the tooltip dialog                                        escape
============================================================    =================================================

See the detailed Keyboard Navigation Notes and Known Issues in :ref:`dijit/Dialog <dijit/Dialog>`
