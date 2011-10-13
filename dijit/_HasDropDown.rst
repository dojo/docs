#format dojo_rst

dijit/_HasDropDown
==================

:Author: Colin Snover
:Project owner: Bill Keese
:Available: since 1.4
:Version: 1.7

.. contents::
   :depth: 2

============
Introduction
============

dijit/_HasDropDown is a dijit Widget mixin that provides drop-down menu functionality. Widgets like `dijit/form/Select`_, `dijit/form/ComboBoxMixin`_, `dijit/form/DropDownButton`_, and `dijit/form/_DateTimeTextBox`_ all use dijit/_HasDropDown to implement their drop-down functionality.

=====
Usage
=====

First, mixin dijit/_HasDropDown when you create your widget:

.. code-block :: javascript
 :linenos:

  define([ "dojo/_base/declare", "dijit/_HasDropDown" ],
      function(declare, _HasDropDown){
      return declare(_HasDropDown, {
          ...
      });
  });

Then, either set the value of ``_HasDropDown.dropDown`` to an existing widget:

.. code-block :: javascript
 :linenos:

  require([ "dijit/registry", "my/CustomDropDown", "dojo/domReady!" ], function(registry, CustomDropDown){
      var customDropDown = new CustomDropDown({
          dropDown: registry.byId("dropDownMenuWidget")
      }, "myDropDownWidget");
  });

Or, override the ``_HasDropDown.loadDropDown`` and ``_HasDropDown.isLoaded`` functions to allow for lazy instantiation of the drop-down (see `Dynamic \& lazy-loading drop-downs`_, below).

========================
Optional node properties
========================

.. note::
   All of these properties can only be set *before* ``_Widget.buildRendering`` is called.

_buttonNode
-----------

By default, dijit/_HasDropDown will use either ``focusNode`` or ``domNode`` as the element to click to display the drop-down. If you want to use a specific element to click to display the drop-down instead, attach that element to ``_buttonNode``.

_arrowWrapperNode
-----------------

When a dijit/_HasDropDown is instantiated, a CSS class ``dijit(Up|Down|Right|Left)ArrowButton`` is added to specify which direction the pop-up appears by default relative to the widget. By default, these classes are set on ``_buttonNode``. Attaching an element to ``_arrowWrapperNode`` will cause these classes to be applied to that element instead.

_popupStateNode
---------------

When a drop-down is opened, a CSS class ``dijitHasDropDownOpen`` and a ``popupActive`` attribute are added to indicate that the drop-down is open. By default, these changes apply to ``focusNode``, or ``_buttonNode`` if there is no ``focusNode``. Attaching an element to ``_popupStateNode`` will cause these changes to occur on that element instead.

_aroundNode
-----------

When the drop-down is opened, it is positioned based on the location of ``domNode``. Attaching an element to ``_aroundNode`` will cause the drop-down to be positioned relative to that element instead.

=================================
Dynamic & lazy-loading drop-downs
=================================

By default, _HasDropDown assumes that a dijit widget has been created and assigned to ``_HasDropDown.dropDown`` before the widget starts up. This works well for drop-downs that always contain the same content and are available immediately, but it may reduce startup performance and it makes it impossible to create dynamically populated/asynchronous drop-downs. In order to work around these limitations, more advanced drop-down widgets can implement ``_HasDropDown.loadDropDown`` and ``_HasDropDown.isLoaded`` instead:

.. code-block :: javascript
 :linenos:

  define([ "dojo/_base/declare", "dijit/form/Button", "dijit/_HasDropDown" ],
      function(declare, Button, _HasDropDown){
      return declare([Button, _HasDropDown], {
          isLoaded: function(){
              // Returns whether or not we are loaded - if our dropdown has an href,
              // then we want to check that.
              var dropDown = this.dropDown;
              return (!!dropDown && (!dropDown.href || dropDown.isLoaded));
          },
      
          loadDropDown: function(){
              // Loads our dropdown
              var dropDown = this.dropDown;
              if(!dropDown){ return; }
              if(!this.isLoaded()){
                  var handler = dropDown.on("load", this, function(){
                      handler.remove();
                      this.openDropDown();
                  });
                  dropDown.refresh();
              }else{
                  this.openDropDown();
              }
          }
      });
  });

========
See also
========

* `Writing Widgets <quickstart/writingWidgets>`_
* `dijit._Widget <dijit/_Widget>`_
* `dijit/form/Select`_
* `dijit/form/DropDownButton`_
* `dijit/popup`_
