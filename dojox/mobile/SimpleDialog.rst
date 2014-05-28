.. _dojox/mobile/SimpleDialog:

=========================
dojox/mobile/SimpleDialog
=========================

:Authors: Yoshiroh Kamiyama
:Developers: Yoshiroh Kamiyama
:since: V1.8

.. contents ::
    :depth: 2

Introduction
============

The dojox/mobile/SimpleDialog widget is a dialog box for mobile. Compared with dijit/Dialog, 
 its code size is much smaller and its functionality is more limited. 

When a SimpleDialog is created, it is initially hidden (display="none"). To show it, you must 
get a reference to the widget and call its show() method.

The contents can be arbitrary HTML, text, or widgets. Note, however, that the widget is i
nitially hidden. You need to be careful when you place in a SimpleDialog elements that 
cannot be initialized in hidden state.

After a SimpleDialog is created, its DOM node is moved right under the <body> element 
so that it is positioned correctly at the center of the screen and can be placed over 
the translucent cover that blocks the entire screen.

.. image :: SimpleDialog.png

Constructor Parameters
======================

+----------------+----------+----------------------------------+----------------------------------------------------------------------------------+
|Parameter       |Type      |Default                           |Description                                                                       |
+----------------+----------+----------------------------------+----------------------------------------------------------------------------------+
|top             |String    |"auto"                            |The top edge position of the widget. If "auto", the widget is placed at the       |
|                |          |                                  |middle of the screen. Otherwise, the value (ex. "20px") is used as the top style  |
|                |          |                                  |of widget's domNode.                                                              |
+----------------+----------+----------------------------------+----------------------------------------------------------------------------------+
|left            |String    |"auto"                            |The left edge position of the widget. If "auto", the widget is placed at the      |
|                |          |                                  |center of the screen. Otherwise, the value (ex. "20px") is used as the left style |
|                |          |                                  |of widget's domNode.                                                              |
+----------------+----------+----------------------------------+----------------------------------------------------------------------------------+
|modal           |Boolean   |true                              |If true, a translucent cover is added over the entire page to prevent the user    |
|                |          |                                  |from interacting with elements on the page.                                       |
+----------------+----------+----------------------------------+----------------------------------------------------------------------------------+
|closeButton     |Boolean   |false                             |If true, a button to close the dialog box is displayed at the top-right corner.   |
+----------------+----------+----------------------------------+----------------------------------------------------------------------------------+
|closeButtonClass|String    |"mblDomButtonSilverCircleRedCross"|A class name of a DOM button to be used as a close button.                        |
+----------------+----------+----------------------------------+----------------------------------------------------------------------------------+

Examples
========

Declarative example
-------------------

.. js ::

  // Java Script
  require([
    "dijit/registry",
    "dojox/mobile",
    "dojox/mobile/parser",
    "dojox/mobile/SimpleDialog",
    "dojox/mobile/Button"
  ], function(registry){
    show = function(dlg){
      registry.byId(dlg).show();
    };
    hide = function(dlg){
      registry.byId(dlg).hide();
    };
  });

.. css ::

  /* Style */
  .mblSimpleDialogButton {
    margin: 7px 0 0;
    width: 262px;
    font-size: 17px;
    font-weight: bold;
    opacity: 0.95;
  }
  .mblSimpleDialogButton2l {
    float: left;
    width: 127px;
    margin: 7px 0 0;
    font-size: 17px;
    font-weight: bold;
    opacity: 0.95;
  }
  .mblSimpleDialogButton2r {
    float: right;
    width: 127px;
    margin: 7px 0 0;
    font-size: 17px;
    font-weight: bold;
    opacity: 0.95;
  }
  .mblSimpleDialog .mblProgressIndicator {
    position: relative;
    margin: 14px 0 7px;
    top: 0;
  }

.. html ::

  <div id="dlg_message" data-dojo-type="dojox/mobile/SimpleDialog">
    <div class="mblSimpleDialogTitle">Information</div>
    <div class="mblSimpleDialogText">This is a sample dialog.</div>
    <button data-dojo-type="dojox/mobile/Button" class="mblSimpleDialogButton"
            style="width:100px;" onclick="hide('dlg_message')">OK</button>
  </div>

  <button onclick="show('dlg_message')">Show Dialog</button>

.. image :: SimpleDialog-example1.png

Programmatic example
--------------------

.. js ::

  require([
    "dojo/_base/window",
    "dojo/dom-construct",
    "dojox/mobile/SimpleDialog",
    "dojox/mobile/ProgressIndicator",
    "dojox/mobile/Button"
  ], function(win, domConstruct, SimpleDialog, ProgressIndicator, Button){
    showProgIndDlg = function(){
      var piIns = ProgressIndicator.getInstance();
      var hideProgIndDlg = function(simpleDlg){
        piIns.stop();
        simpleDlg.hide();
      }

      var dlg = new SimpleDialog();
      win.body().appendChild(dlg.domNode);
      var msgBox = domConstruct.create("div",
                                       {class: "mblSimpleDialogText",
                                        innerHTML: "Processing..."},
                                        dlg.domNode);
      var piBox = domConstruct.create("div",
                                      {class: "mblSimpleDialogText"},
                                       dlg.domNode);
      piBox.appendChild(piIns.domNode);
      var cancelBtn = new Button({class: "mblSimpleDialogButton mblRedButton",
                                  innerHTML: "Cancel"});
      cancelBtn.connect(cancelBtn.domNode, "click",
                        function(e){hideProgIndDlg(dlg)});
      cancelBtn.placeAt(dlg.domNode);
      dlg.show();
      piIns.start();

      setTimeout(function(){
        /*
         * Write your lengthy task here. Once finished, hide the dialog:
         */
        hideProgIndDlg(dlg);
      }, 3000);
    }
  });

.. html ::

  <button onclick="showProgIndDlg();">Show Dialog</button>

.. image :: SimpleDialog-example2.png

Mixin example
-------------

This is an example of creating a SimpleDialog from HTML fragment by mixing in dojox/mobile/_ContentPaneMixin using the 'data-dojo-mixins' attribute.

.. html ::

	<div id="dlg_volume"
	     data-dojo-type="dojox/mobile/SimpleDialog"
	     data-dojo-mixins="dojox/mobile/_ContentPaneMixin"
	     data-dojo-props='href:"dialog.html"'></div>

.. html ::

  <!-- dialog.html (HTML fragment file) -->
  <div class="mblSimpleDialogTitle">Volume</div>
  <div class="mblSimpleDialogText">Ringtone</div>
  <input data-dojo-type="dojox/mobile/Slider"
         data-dojo-props='value:"0", min:"0", max:"20", step:"0.1", type:"range"'
         style="width:90%;">
  <div class="mblSimpleDialogText">Media</div>
  <input data-dojo-type="dojox/mobile/Slider"
         data-dojo-props='value:"0", min:"0", max:"20", step:"0.1", type:"range"'
         style="width:90%;">
  <div class="mblSimpleDialogText">Alarm</div>
  <input data-dojo-type="dojox/mobile/Slider"
         data-dojo-props='value:"0", min:"0", max:"20", step:"0.1", type:"range"'
         style="width:90%;">
  <button data-dojo-type="dojox/mobile/Button"
          class="mblSimpleDialogButton2l" onclick="hide('dlg_volume')">OK</button>
  <button data-dojo-type="dojox/mobile/Button"
          class="mblSimpleDialogButton2r" onclick="hide('dlg_volume')">Cancel</button>

.. image :: SimpleDialog-example3.png

Large dialog example for Tablet
-------------------------------

.. css ::

  /* Style */
  #dlg1 {
    top: 25%;
    left: 25%;
    width: 550px;
  }
  #dlg1 INPUT, #dlg1 TEXTAREA {
    background-color: #000000;
    color: #ffffff;
    width: 95%;
    font-size: 17px;
    margin: 4px;
  }
  #dlg1 TEXTAREA {
    height: 160px;
  }
  .dlgTitle {
    font-family: Helvetica;
    font-size: 17px;
    margin: 14px;
  }

.. html ::

  <div id="dlg1" data-dojo-type="dojox/mobile/SimpleDialog" data-dojo-props='closeButton:true'>
    <div class="dlgTitle">Account Information
      <button id="btn1" data-dojo-type="dojox/mobile/Button"
              class="mblBlueButton" style="margin-top:-5px;width:60px;float:right;">Edit</button>
    </div>
    <hr/>
    <table style="width:100%">
      <tr>
        <td style="width:250px"><img alt="" src="images/pic1.jpg" width="230" height="230"></td>
        <td style="vertical-align:top">
          <input data-dojo-type="dojox/mobile/TextBox" value="Kirena Kobe" readOnly="readOnly"><br>
          <input data-dojo-type="dojox/mobile/TextBox" value="123-456-7891"><br>
          <input data-dojo-type="dojox/mobile/TextBox" value="kkobe@acme.com">
        </td>
      </tr>
      <tr>
        <td colspan="2">
          <textarea>Lorem ipsum dolor sit amet, consectetuer adipiscing elit.</textarea></td>
      </tr>
    </table>
  </div>


.. image :: SimpleDialog-example4.png
