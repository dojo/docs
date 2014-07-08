.. _dijit/ConfirmDialog:

===================
dijit/ConfirmDialog
===================

:Authors: Bill Keese
:since: V1.10
:jsDoc: http://dojotoolkit.org/api/dijit/ConfirmDialog

.. contents ::
    :depth: 2

Introduction
============

The dijit/ConfirmTooltipDialog is a :ref:`dijit/Dialog <dijit/Dialog>`
that has built in OK and Cancel buttons.

Usage
=====

Programmatic instantiation
--------------------------

.. code-example ::

    .. js ::

        require(["dijit/ConfirmDialog", "dojo/domReady!"], function(ConfirmDialog){
            myDialog = new ConfirmDialog({
                title: "My ConfirmDialog",
                content: "Test content.",
                style: "width: 300px"
            });
        });


    .. html ::

        <button onclick="myDialog.show();">show</button>


ConfirmDialog via markup
------------------------

This example shows creating a ConfirmDialog declaratively.

.. code-example ::

    .. js ::

        require(["dijit/ConfirmDialog", "dijit/form/TextBox", "dijit/form/Button"]);

    .. html ::

        <div data-dojo-type="dijit/ConfirmDialog" data-dojo-id="myDialog" title="Name and Address">
            <table>
                <tr>
                    <td><label for="name">Name:</label></td>
                    <td><input data-dojo-type="dijit/form/TextBox" name="name" id="name"></td>
                </tr>
                <tr>
                    <td><label for="address">Address:</label></td>
                    <td><input data-dojo-type="dijit/form/TextBox" name="address" id="address"></td>
                </tr>
            </table>
        </div>

        <button data-dojo-type="dijit/form/Button" type="button" onClick="myDialog.show();">
            Show me!
        </button>



See Also
========

* :ref:`dijit/Dialog <dijit/Dialog>`
* :ref:`dijit/ConfirmTooltipDialog <dijit/ConfirmTooltipDialog>`
