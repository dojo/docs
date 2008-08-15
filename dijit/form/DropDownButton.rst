#format dojo_rst

dijit.form.DropDownButton
=========================

:Status: Draft
:Version: 1.2

The dijit.form.DropDownButton widget is for a button that displays some kind of drop down, often a menu, when you press it.

Examples
--------

The first example shows how to create a button programmatically.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.form.Button");

    dojo.addOnLoad(function(){
      var button = new dijit.form.Button({
                    label: "Click me!"
      }, "buttonNode");
    });
    </script>

  .. cv:: html

    <button id="buttonNode" />

As usual you can create the DropDown button widget declaratively using the dojoType attribute.
When created declaratively the DropDownButton node has two children, one for the label of the button,
and the other for the drop-down widget that's displayed when you press the button.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.form.Button");
      dojo.require("dijit.Menu");
    </script>

  .. cv:: html

    <div dojoType="dijit.form.DropDownButton">
      <span>Edit<b>!</b></span>
      <div dojoType="dijit.Menu">
        <div dojoType="dijit.MenuItem" onClick="console.log('hi!')">Cut</div>
        <div dojoType="dijit.MenuItem" onClick="console.log('hi!')">Copy</div>
      </div>
    </div>

The end.
