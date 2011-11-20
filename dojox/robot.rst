.. _dojox/robot:

dojox.robot.recorder
====================

:Status: Contributed
:Version: 1.2
:Author: haysmark

.. contents::
  :depth: 3

dojox.robot.recorder is a recording module for use with the doh.robot Web UI testing framework. It has no APIs and is not a widget.

Unlike the dojo.robotx and dijit.robotx, the recorder does not persist over page changes. You must add the recorder module to each page you wish to record your interaction with. Furthermore, you must stop the recorder before you change the page (form submit, click a link). Otherwise, your recording data for that page will be lost.

To use the recorder:

1. In a working copy of the app you want to write a test for, add this JavaScript:

   .. code-block:: javascript

     dojo.require("dojox.robot.recorder");

   You must add this line for each page of your app you want to test.

2. Load your app.
3. Click inside the page and press Ctrl-Alt-Enter. You will get an alert dialog confirming that the recorder started.
4. Interact with the page. The recorder will silently record your actions.
5. When you are finished with the current page, before you go on to the next page, click inside the page again and press Ctrl-Alt-Enter.
6. A box will appear on top of your page containing the auto-generated code. Highlight the code and copy it to the clipboard.

From here, you have a fully functional DOH test in your clipboard that you can put into your app for testing or in a separate file for use with the dojo.robotx.
