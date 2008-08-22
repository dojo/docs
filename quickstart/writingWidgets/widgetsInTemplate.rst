#format dojo_rst


Widgets inside the Template
===========================
So what if we want the widget to have a widget inside of it, as in ...:

.. code-block :: html

  <div class="combinedDateTime">
     <div dojoType="dijit.form.DateTextBox"></div>
     <div dojoType="dijit.form.TimeTextBox"></div>
  </div>

When using this template in a directly extended widget class, you will need to set the property widgetsInTemplate: true. Why? Because a widget inside a template requires some recursive parsing, which may be slow if you're drawing thousands of widgets ... especially if there is nothing extra to parse. Therefore, it is false by default.

dijit.Declaration-based widget classes automatically set widgetsInTemplate to true.

dojoAttachPoint
---------------
In this case, the dojoAttachPoint becomes a pointer to the sub-widget, not to a DOM node.  For example, with this template:

.. code-block :: html

  <div class="combinedDateTime">
     <div dojoType="dijit.form.DateTextBox" dojoAttachPoint="start"></div>
     <div dojoType="dijit.form.TimeTextBox" dojoAttachPoint="end"></div>
  </div>

You can do this in your widget code:

.. code-block :: javascript

  this.start.attr('value', new Date());



dojoAttachEvent
---------------
dojoAttachEvent also functions to attach a widget event (not a DOM event) on the sub widget to the main widget.  For example, consider InlineEditBox which embeds dijit buttons into it's own template:

.. code-block :: html

  <fieldset dojoAttachPoint="editNode" waiRole="presentation" style="position: absolute; visibility:hidden" class="dijitReset dijitInline"
	dojoAttachEvent="onkeypress: _onKeyPress" 
	><div dojoAttachPoint="editorPlaceholder"></div
	><span dojoAttachPoint="buttonContainer"
		><button class='saveButton' dojoAttachPoint="saveButton" dojoType="dijit.form.Button" dojoAttachEvent="onClick:save" disabled="true">${buttonSave}</button
		><button class='cancelButton' dojoAttachPoint="cancelButton" dojoType="dijit.form.Button" dojoAttachEvent="onClick:cancel">${buttonCancel}</button
	></span
  ></fieldset>

The onClick event on the dijit.form.Button will call InlineEditBox.save().
