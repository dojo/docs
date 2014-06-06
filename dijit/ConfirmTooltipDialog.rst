.. _dijit/ConfirmTooltipDialog:

==========================
dijit/ConfirmTooltipDialog
==========================

:Authors: Bill Keese
:since: V1.10
:jsDoc: http://dojotoolkit.org/api/dijit/ConfirmTooltipDialog


.. contents ::
    :depth: 2


Introduction
============

The dijit/ConfirmTooltipDialog is a :ref:`dijit/TooltipDialog <dijit/TooltipDialog>`
that has built in OK and Cancel buttons.


Examples
========

Programmatic example
--------------------

The first example shows how to create a ConfirmTooltipDialog and DropDownButton programmatically.

.. code-example ::

  .. js ::

    require([
        "dijit/ConfirmTooltipDialog",
        "dijit/form/TextBox",
        "dijit/form/DropDownButton",
        "dojo/dom",
        "dojo/domReady!"
    ], function(ConfirmTooltipDialog, TextBox, DropDownButton, dom){
        var myDialog = new ConfirmTooltipDialog({
            content:
                '<label for="name">Name:</label> <input data-dojo-type="dijit/form/TextBox" id="name" name="name"><br>' +
                '<label for="hobby">Hobby:</label> <input data-dojo-type="dijit/form/TextBox" id="hobby" name="hobby"><br>'
        });

        var myButton = new DropDownButton({
            label: "show tooltip dialog",
            dropDown: myDialog
        });
        dom.byId("dropDownButtonContainer").appendChild(myButton.domNode);
        myButton.startup();
    });

  .. html ::

    <div id="dropDownButtonContainer"></div>



Declarative markup
------------------

As usual you can create the ConfirmTooltipDialog and DropDown button widget declaratively using the data-dojo-type attribute.
When created declaratively the DropDownButton node has two children, one for the label of the button,
and the other for the drop-down widget that's displayed when you press the button.

Here's one displaying a ConfirmTooltipDialog:

.. code-example ::

  .. js ::

    require(["dojo/parser", "dijit/ConfirmTooltipDialog", "dijit/form/DropDownButton", "dijit/form/TextBox"]);

  .. html ::

    <div data-dojo-type="dijit/form/DropDownButton">
        <span>Register</span>
        <div data-dojo-type="dijit/ConfirmTooltipDialog">
            <label for="name2">Name:</label> <input data-dojo-type="dijit/form/TextBox" id="name2" name="name2" /><br />
            <label for="hobby2">Hobby:</label> <input data-dojo-type="dijit/form/TextBox" id="hobby2" name="hobby2" /><br />
        </div>
    </div>


See Also
========
* :ref:`dijit/TooltipDialog <dijit/TooltipDialog>`
* :ref:`dijit/ConfirmDialog <dijit/ConfirmDialog>`
