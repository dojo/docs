#format dojo_rst

dijit.form.Button
=================

:Status: Draft
:Version: 1.2

The dijit.form.Button widget is a representation of a normal <button> or <input type="submit/reset" />

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

As usual you can create the button widget using th dojoType attribute

.. cv-compound::

  .. cv:: javascript
    <script type="text/javascript">
    dojo.require("dijit.form.Button");
    </script>

  .. cv:: html

    <button dojoType="dijit.form.Button">Click me too!</button>
