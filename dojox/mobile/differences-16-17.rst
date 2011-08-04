#format dojo_rst

Differences between 1.6 and 1.7
===============================

:Authors: Yoshiroh Kamiyama

.. contents::
    :depth: 2

====================
Differences from 1.6
====================

dojox.mobile.parser
-------------------

* Added support for jsId.
* Added dojo.parser = dojox.mobile.parser; so that other modules or user applications can directly call dojo.parser even when dojox.mobile.parser is used.
* Updated signature of parse() and instantiate() to align with dojo.parser's ones.
* The 2nd argument of instantiate(), 'defaultParams', will no longer be mixed-in to widget parameters. It could break the widget, and the behavior is different from dojo.parser.
* Respect the noStart flag. If it is specified, startup() of the instantiated widget will not be called.
* Added support for the html5-style attributes, data-dojo-\*.

dojox.mobile.Button
-------------------

* Separated from _base.js and created dojox/mobile/Button.js. This means your application needs to add dojo.require("dojox.mobile.Button") if you use the button.
* btnClass has been changed to class. You need to specify a button class using the class attribute as follows.
* <button dojoType="dojox.mobile.Button" class="mblBlueButton">OK</button>
* The default button class no longer exists. You always need to explicitly specify a button class such as "mblBlueButton".

dojox.mobile.FlippableView
--------------------------

* FlippableView has been renamed to "dojox.mobile.SwapView".

dojox.mobile.ToolBarButton
--------------------------

* You no longer need to add "mblDomButton" to the ToolBarButton class. It will be automatically added programmatically.

dojox.mobile.View
-----------------

selected="true" is no longer necessary if you just want to show the first view at startup. If you want to show a view other than the first one, adding selected="true" is still effective.

===================
New Features in 1.7
===================

dojox.mobile.deviceTheme
------------------------

This module detects mobile devices from User-Agent string, and automatically loads an appropriate theme. The default is the iPhone theme.
You can also explicitly specify which device theme to load via query string in the URL. Below is examples.

  * theme=Android
  * theme=BlackBerry
  * theme=iPad
  * theme=iPhone (default)

Ex. test_transition-animations.html?theme=Android

New Widgets
-----------

* `dojox.mobile.SpinWheel <dojox/mobile/SpinWheel>`_
* `dojox.mobile.SpinWheelSlot <dojox/mobile/SpinWheelSlot>`_
* `dojox.mobile.SpinWheelDatePicker <dojox/mobile/SpinWheelDatePicker>`_
* `dojox.mobile.SpinWheelTimePicker <dojox/mobile/SpinWheelTimePicker>`_
* `dojox.mobile.RoundRectDataList <dojox/mobile/RoundRectDataList>`_
* `dojox.mobile.EdgeToEdgeDataList <dojox/mobile/EdgeToEdgeDataList>`_
* `dojox.mobile.ContentPane <dojox/mobile/ContentPane>`_
* `dojox.mobile.Carousel <dojox/mobile/Carousel>`_
* `dojox.mobile.PageIndicator <dojox/mobile/PageIndicator>`_
* `dojox.mobile.Opener <dojox/mobile/Opener>`_
* `dojox.mobile.Overlay <dojox/mobile/Overlay>`_
* `dojox.mobile.Tooltip <dojox/mobile/Tooltip>`_
* `dojox.mobile.CheckBox <dojox/mobile/CheckBox>`_
* `dojox.mobile.ComboBox <dojox/mobile/ComboBox>`_
* `dojox.mobile.ExpandingTextArea <dojox/mobile/ExpandingTextArea>`_
* `dojox.mobile.RadioButton <dojox/mobile/RadioButton>`_
* `dojox.mobile.Slider <dojox/mobile/Slider>`_
* `dojox.mobile.Switch <dojox/mobile/Switch>`_
* `dojox.mobile.TextArea <dojox/mobile/TextArea>`_
* `dojox.mobile.TextBox <dojox/mobile/TextBox>`_
* `dojox.mobile.ToggleButton <dojox/mobile/ToggleButton>`_
* `dojox.mobile. <dojox/mobile/>`_
