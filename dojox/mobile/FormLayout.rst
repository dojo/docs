.. _dojox/mobile/FormLayout:

=======================
dojox.mobile.FormLayout
=======================

:since: v1.9

.. contents ::
    :depth: 2

Introduction
============

FormLayout is a widget which layouts form controls. Each control is associated with a label. Two layouts are supported using the columns property: single and two columns. A third option is to set the columns property to "auto". In this case the layout is determined by the width of the screen: A single column if the screen width is lower than 500px, two columns otherwise.

Each element of a form is made of a <label> and a <fieldset> that contains one or more form widgets.
Form controls are: "dojox/mobile/Button", "dojox/mobile/CheckBox", "dojox/mobile/ComboBox", "dojox/mobile/RadioButton", "dojox/mobile/Slider", "dojox/mobile/TextBox", "dojox/mobile/SearchBox", "dojox/mobile/ExpandingTextArea", "dojox/mobile/ToggleButton".

Examples
========

Example 1
---------
A single column form.

.. image :: FormLayout1.png

.. html ::

		<div data-dojo-type="dojox.mobile.FormLayout" data-dojo-props="columns:'single'">
			<div>
				<label>Buttons</label>
				<fieldset>
					<button data-dojo-type="dojox.mobile.Button">Help</button>
					<input type="submit" class="mblBlueButton" data-dojo-type="dojox.mobile.Button" value="Submit">
					<button class="mblRedButton" data-dojo-type="dojox.mobile.Button">Cancel</button>
				</fieldset>
			</div>
			<div>
				<label>Checkbox</label>
				<fieldset><input type="checkbox" data-dojo-type="dojox.mobile.CheckBox"><label>Click me</label>
				</fieldset>
			</div>
			<div>
				<label>Toggle Button</label>
				<fieldset>
					<button data-dojo-type="dojox.mobile.ToggleButton">Toggle me</button>
				</fieldset>
			</div>
			<div>
				<label>Switch</label>
				<fieldset><input type="checkbox" data-dojo-type="dojox.mobile.Switch" value="on"></fieldset>
			</div>
			<div>
				<label>Radio Button</label>
				<fieldset>
					<input type="radio" id="rb1" data-dojo-type="dojox.mobile.RadioButton" name="mobileRadio"
						   value="Large" checked><label for="rb1">1</label>
					<input type="radio" id="rb2" data-dojo-type="dojox.mobile.RadioButton" name="mobileRadio"
						   value="Medium"><label for="rb2">2</label>
					<input type="radio" id="rb3" data-dojo-type="dojox.mobile.RadioButton" name="mobileRadio"
						   value="Small"><label for="rb3">3</label>
				</fieldset>
			</div>
			<div>
				<label>Slider</label>
				<fieldset><input id="sh" name="shb" data-dojo-type="dojox.mobile.Slider" value="0" min="0" max="20"
								 step="0.1" type="range" style="width:150px;"></fieldset>
			</div>
			<div>
				<label>ComboBox</label>
				<fieldset><input type="text" data-dojo-type="dojox.mobile.ComboBox"
								 data-dojo-props='value:"", list:"states"'></fieldset>
			</div>
			<div>
				<label>TextArea</span></label>
				<fieldset>
					<textarea data-dojo-type="dojox.mobile.TextArea" rows="3" cols="20">TextArea</textarea><br>
					<textarea data-dojo-type="dojox.mobile.ExpandingTextArea" rows="3"
							  cols="20">ExpandingTextArea</textarea>
				</fieldset>
			</div>
			<div>
				<label>TextBox</label>
				<fieldset><input data-dojo-type="dojox.mobile.TextBox" intermediateChanges="true" maxLength="9"
								 selectOnClick="true" placeHolder="max 9 chars"
								 onChange="console.log('onChange fired with ' + arguments[0])"></fieldset>
			</div>
			<div>
				<label>SearchBox</span></label>
				<fieldset><input data-dojo-type="dojox.mobile.SearchBox" type="search" selectOnClick="true"
								 placeHolder="Search" data-dojo-props='list:"states", pageSize:5, onSearch:myOnSearch'>
				</fieldset>
			</div>
		</div>
	</div>



Example 2
---------
The same form using two columns layout.

.. image :: FormLayout2.png

.. html ::

		<div data-dojo-type="dojox.mobile.FormLayout" data-dojo-props="columns:'two'">
    ...
		</div>                


Example 3
---------
The same form using two columns layout and right align mode.

.. image :: FormLayout3.png

.. html ::

		<div data-dojo-type="dojox.mobile.FormLayout" data-dojo-props="rightAlign: true, columns:'two'">
    ...
		</div>                
