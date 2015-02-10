.. _dijit/_HasDropDown:

==================
dijit/_HasDropDown
==================

:Author: Colin Snover
:Project owner: Bill Keese
:since: 1.4

.. contents ::
   :depth: 2

Introduction
============

dijit/_HasDropDown is a dijit widget mixin that provides drop-down menu functionality.
Widgets like :ref:`dijit/form/Select <dijit/form/Select>`, :ref:`dijit/form/ComboBox <dijit/form/ComboBox>`,
:ref:`dijit/form/DropDownButton <dijit/form/DropDownButton>`, and :ref:`dijit/form/DateTextBox <dijit/form/DateTextBox>`
all use dijit/_HasDropDown to implement their drop-down functionality.

Usage
=====

First, mixin dijit/_HasDropDown when you create your widget:

.. js ::
 
  define([ "dojo/_base/declare", "dijit/_HasDropDown" ],
      function(declare, _HasDropDown){
      return declare(_HasDropDown, {
          ...
      });
  });

Then, either set the value of :ref:`HasDropDown.dropDown` to an existing widget:

.. js ::
 
  require([ "dijit/registry", "my/CustomDropDown", "dojo/domReady!" ], function(registry, CustomDropDown){
      var customDropDown = new CustomDropDown({
          dropDown: registry.byId("dropDownMenuWidget")
      }, "myDropDownWidget");
  });

Or, override the :ref:`HasDropDown.loadDropDown` and :ref:`HasDropDown.isLoaded` functions to allow for lazy instantiation of the drop-down (see `Dynamic & lazy-loading drop-downs`_, below).

Optional node properties
========================

.. note ::
   All of these properties can only be set *before* :ref:`Widget.buildRendering` is called.

_buttonNode
-----------

By default, dijit/_HasDropDown will use either ``focusNode`` or ``domNode`` as the element to click to display the drop-down.
If you want to use a specific element to click to display the drop-down instead, attach that element to :ref:`buttonNode`.

_arrowWrapperNode
-----------------

When a dijit/_HasDropDown is instantiated, a CSS class ``dijit(Up|Down|Right|Left)ArrowButton`` is added to specify which direction the pop-up appears by default relative to the widget.
By default, these classes are set on :ref:`buttonNode`.
Attaching an element to :ref:`arrowWrapperNode` will cause these classes to be applied to that element instead.

_popupStateNode
---------------

When a drop-down is opened, a CSS class ``dijitHasDropDownOpen`` and a ``popupActive`` attribute are added to indicate that the drop-down is open.
By default, these changes apply to ``focusNode``, or :ref:`buttonNode` if there is no ``focusNode``.
Attaching an element to :ref:`popupStateNode` will cause these changes to occur on that element instead.

_aroundNode
-----------

When the drop-down is opened, it is positioned based on the location of ``domNode``.
Attaching an element to :ref:`aroundNode` will cause the drop-down to be positioned relative to that element instead.



.. _HasDropDown.lazyload:

=================================
Dynamic & lazy-loading drop-downs
=================================

By default, _HasDropDown assumes that a dijit widget has been created and assigned to :ref:`HasDropDown.dropDown`
before the widget starts up.
This works well for drop-downs that always contain the same content and are available immediately,
but it may reduce startup performance and it makes it impossible to create dynamically populated/asynchronous drop-downs.
In order to work around these limitations, more advanced drop-down widgets can implement
:ref:`HasDropDown.loadDropDown` and :ref:`HasDropDown.isLoaded` instead:

.. js ::
 
  define([ "dojo/_base/declare", "dijit/form/Button", "dijit/_HasDropDown" ],
      function(declare, Button, _HasDropDown){
      return declare([Button, _HasDropDown], {
          isLoaded: function(){
              // Returns whether or not we are loaded - if our dropdown has an href,
              // then we want to check that.
              var dropDown = this.dropDown;
              return (!!dropDown && (!dropDown.href || dropDown.isLoaded));
          },
      
          loadDropDown: function(callback){
              // Loads our dropdown
              var dropDown = this.dropDown;
              if(!dropDown){ return; }
              if(!this.isLoaded()){
                  var handler = dropDown.on("load", this, function(){
                      handler.remove();
                      callback();
                  });
                  dropDown.refresh();
              }else{
                  callback();
              }
          }
      });
  });

See also
========

* :ref:`Writing Widgets <quickstart/writingWidgets>`
* :ref:`dijit._Widget <dijit/_Widget>`
* :ref:`dijit/form/Select <dijit/form/Select>`
* :ref:`dijit/form/DropDownButton <dijit/form/DropDownButton>`
* :ref:`dijit/popup <dijit/popup>`
