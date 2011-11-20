.. _dijit/typematic:

dijit.typematic
===============

:Version: 1.7
:Project owner: Doug Hays
:Available: since V1.7

.. contents::
   :depth: 2

============
Introduction
============

dijit/typematic is used for two purposes:

   * normalize the speed which browsers implement key-repeat (when the user holds down a key on the keyboard, such as the arrow keys)
   * implement a repeating action when the user holds down a mouse button (typically pressing an arrow icon)

========
Examples
========

Here's an example of implementing a repeating action when the user presses the arrow key while focused in a textbox,
or clicks the plus icon next to the textbox

.. code-example::
  :type: inline
  :height: 400
  :width: 660


  .. javascript::

     <script>
     require(["dojo/dom", "dijit/typematic"], function(dom, typematic){
         var textbox = dom.byId("textbox"), icon = dom.byId("icon");
         typematic.addKeyListener(textbox, {charOrCode: keys.DOWN_ARROW}, null, function(){
              textbox.value = textbox.value + 1;
         }, 500, 100, 10);
         typematic.addMouseListener(icon, null, function(){
              textbox.value = textbox.value + 1;
         }, 500, 100, 10);
     });
     </script>

  .. html::

	<input id="textbox" value="1"><span id="icon">+</span>
