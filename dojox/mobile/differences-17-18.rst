.. _dojox/mobile/differences-17-18:

===============================
Differences between 1.7 and 1.8
===============================

:Authors: Yoshiroh Kamiyama

.. contents ::
    :depth: 2

Differences from 1.7
====================

Carousel
--------
- Carousel has no backward compatibility, since it was experimental in 1.7. The new Carousel does not support data stores. There are two subclasses that support data stores. Use :ref:`DataCarousel <dojox/mobile/DataCarousel>` if you want to use carousel with dojo.data. Use :ref:`StoreCarousel <dojox/mobile/StoreCarousel>` if you want to use carousel with dojo.store.

FixedSplitter
-------------
- FixedSplitter.css is no longer in the themes/common folder. It is in the device theme folder. (e.g. themes/iphone/FixedSplitter.css)

FlippableView
-------------
- FlippableView was deprecated in 1.7, and removed in 1.8. Use SwapView instead.

ListItem
--------
- The sync property is no longer supported. It always behaves asynchronously.
- The btnClass property is no longer supported. Use rightIcon instead.
- The btnClass2 property is no longer supported. Use rightIcon2 instead.

SpinWheel
---------
- SpinWheel.css is no longer in the themes/common folder. It is in the device theme folder. (e.g. themes/iphone/SpinWheel.css)
- getValue() is no longer supported. Use get("values") instead.
- setValue() is no longer supported. Use set("values", newValue) instead.

SpinWheelSlot
-------------
- getValue() is no longer supported. Use get("value") instead.
- getKey() is no longer supported. Use get("key") instead.
- setValue() is no longer supported. Use set("value", newValue) instead.

Switch
------
- When you place it in a ListItem, class="mblItemSwitch" is no longer necessary.

TabBar
------
In 1.7 or older, barType="segmentedControl" produced different UIs
according to the current theme. In the iphone theme, it was a
segmented control, but in other themes, it was tabs with or without
icons. In 1.8, however, barType="segmentedControl" always produces a
segmented control UI regardless of the current theme.

If you still need the old behavior,

.. html ::

      barType:{"iphone_theme":"segmentedControl","*":"tallTab"}

should produce a segmented control for the iphone theme, and a tall
tab bar for the other themes. You need to use deviceTheme.js to
specify barType that way.  Also, if you want to hide the tab icons of the
segmented control in the iphone theme, you could apply a css like this:

.. html ::

  <style>
  .iphone_theme .mblTabBarSegmentedControl .mblTabBarButtonIconArea {
      display: none;
  }
  </style>

See test_ScrollableView-demo.html for an example usage.

TabBarButton
-------------
- Specifying a DOM Button with the class attribute like class="mblDomButtonWhitePlus" is no longer supported. Use icon="mblDomButtonWhitePlus" instead.
- select() and deselect() are no longer supported. Use set("selected", boolean) instead.

ToolBarButton
-------------
- Specifying the button color style with the class attribute like class="mblColorBlue" is no longer supported. Use defaultColor="mblColorBlue" instead.
- Specifying a DOM Button with the class attribute like class="mblDomButtonWhitePlus" is no longer supported. Use icon="mblDomButtonWhitePlus" instead.
- select() and deselect() are no longer supported. Use set("selected", boolean) instead.

dojox.mobile.parser
-------------------
- dojox.mobile.parser no longer accepts array-type attribute like

.. html ::

     labels="['A','B','C','D','E']"

Instead, you should specify like

.. html ::

 labels="A,B,C,D,E"

, which is the format dojo.parser accepts.

bookmarkable
------------
- To enable the bookmarkable feature, require dojox.mobile.bookmarkable instead of dojo.hash. See `View Navigation History Management <bookmarkable>`_ for details.


New Features in 1.8
===================

ProgressIndicator
-----------------

ProgressIndicator was a singleton non-widget module. In 1.8, it is an ordinary widget which inherits from _WidgetBase. A new enhanced ProgressIndicator has the ability to customize size, color, and display position. See :ref:`ProgressIndicator <dojox/mobile/ProgressIndicator>` for details.

dojox.mobile.parser
-------------------

- stopParser

To support dojox.mvc, the stopParser feature was added to dojox.mobile.parser. If a widget has the stopParser flag, the parser stops parsing its child widgets. dojo.parser has this capability, but dojox.mobile.parser didn't until 1.8 to keep the code size small.
 
- New data-dojo-type syntax

dojox.mobile.parser accepts the new data-dojo-type syntax like data-dojo-type="dijit/form/Button".

- Function type property

dojox.mobile.parser handles function-type properties correctly. In the following example, the onClick() method of the ListItem widget is overridden by the myClick function.

.. html ::

  <li data-dojo-type="dojox.mobile.ListItem"
      data-dojo-props='moveTo:"bar", onClick:myClick'>
      Slide
  </li>

New Widgets
-----------

* :ref:`TreeView <dojox/mobile/TreeView>`
* :ref:`RoundRectStoreList <dojox/mobile/RoundRectStoreList>`
* :ref:`EdgeToEdgeStoreList <dojox/mobile/EdgeToEdgeStoreList>`
* :ref:`Container <dojox/mobile/Container>`
* :ref:`Pane <dojox/mobile/Pane>`
* :ref:`ScrollablePane <dojox/mobile/ScrollablePane>`
* :ref:`SearchBox <dojox/mobile/SearchBox>`
* :ref:`Accordion <dojox/mobile/Accordion>`
* :ref:`GridLayout <dojox/mobile/GridLayout>`
* :ref:`IconMenu <dojox/mobile/IconMenu>`
* :ref:`IconMenuItem <dojox/mobile/IconMenuItem>`
* :ref:`ScreenSizeAware <dojox/mobile/ScreenSizeAware>`
* :ref:`SimpleDialog <dojox/mobile/SimpleDialog>`
* :ref:`ProgressBar <dojox/mobile/ProgressBar>`
* :ref:`Rating <dojox/mobile/Rating>`
* :ref:`CarouselItem <dojox/mobile/CarouselItem>`
* :ref:`DataCarousel <dojox/mobile/DataCarousel>`
* :ref:`StoreCarousel <dojox/mobile/StoreCarousel>`
* :ref:`ValuePicker <dojox/mobile/ValuePicker>`
* :ref:`ValuePickerSlot <dojox/mobile/ValuePickerSlot>`
* :ref:`ValuePickerDatePicker <dojox/mobile/ValuePickerDatePicker>`
* :ref:`ValuePickerTimePicker <dojox/mobile/ValuePickerTimePicker>`
* :ref:`DatePicker <dojox/mobile/DatePicker>`
* :ref:`TimePicker <dojox/mobile/TimePicker>`
* :ref:`Audio <dojox/mobile/Audio>`
* :ref:`Video <dojox/mobile/Video>`
* :ref:`Badge <dojox/mobile/Badge>`
* :ref:`Icon <dojox/mobile/Icon>`
