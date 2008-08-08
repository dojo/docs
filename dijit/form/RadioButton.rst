#format dojo_rst

dijit.form.RadioButton
======================

:Status: Draft
:Version: 1.2

dijit.form.RadioButton captures binary user-choices. Unlike command buttons, which do some action on being pressed, radio buttons are more for form data. 

Note: to use dijit.form.RadioButton you currently have to include dijit.form.CheckBox

Examples
--------

We'll enhance native radio buttons programatically

.. cv-compound::

  .. cv:: javascript

  .. cv:: html

    <input type="radio" name="group" id="radioOne" /> Tea <br />
    <input type="radio" name="group" id="radioTwo" /> Coffee <br />
