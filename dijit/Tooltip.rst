#format dojo_rst

dijit.Tooltip
=============

:Authors: Doug Hays, Bill Keese, Marcus Reimann
:Project owner: Bill Keese
:Available: since V1.0

.. contents::
    :depth: 2

============
Introduction
============

Tooltip is similar to the title="" attribute in regular HTML, but is much more flexible. You can control the display timing, and specify arbitrary (rich-text) HTML for the tooltip contents.

Note that if you want your tooltip to contain a form or something that the user clicks on / focuses on, you should use the `dijit.TooltipDialog <dijit/TooltipDialog>`_ instead.


=====
Usage
=====

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   dojo.require("dijit.Tooltip");
   new dijit.Tooltip({
      connectId: ["exampleNode"],
      label: "the text for the tooltip"
   });
 </script>

=========  =========================  =============================================================================
Parameter  Type                       Description
=========  =========================  =============================================================================
connectId  Array of Strings|DomNodes  Id's of domNodes to attach the tooltip to. When user hovers over any of the specified dom nodes, the tooltip will appear. 
                                      Note: Currently connectId can only be specified on initialization, it cannot be changed via attr('connectId', ...) 
                                      Note: in 2.0 this will be renamed to connectIds for less confusion.
label      String                     Text to display in the tooltip. Specified as innerHTML when creating the widget from markup.
position   Array of Strings           This variable controls the position of tooltips, if the position is not specified to the Tooltip widget or TextBox widget itself. The property "connectId" is an array, since it can contain multiple nodes to connect to. The following values are possible:
                                      
                                      * before: places tooltip to the left of the target node/widget, or to the right in the case of RTL scripts like Hebrew and Arabic
                                      * after: places tooltip to the right of the target node/widget, or to the left in the case of RTL scripts like Hebrew and Arabic
                                      * above: tooltip goes above target node
                                      * below: tooltip goes below target node
                                      
                                      The list of positions is tried, in order, until a position is found where the tooltip fits within the viewport.
                                      Be careful setting this parameter. A value of "above" may work fine until the user scrolls the screen so that there's no room above the target node. Nodes with drop downs, like DropDownButton or FilteringSelect, are especially problematic, in that you need to be sure that the drop down and tooltip don't overlap, even when the viewport is scrolled so that there is only room below (or above) the target node, but not both.
showDelay  Integer                    Number of milliseconds to wait after hovering over/focusing on the object, before the tooltip is displayed (default = 400).
=========  =========================  =============================================================================

========
Examples
========

Programmatic example
--------------------

Here's a tooltip created programatically:

.. cv-compound::

  .. cv:: javascript

        <script>
           dojo.require("dijit.Tooltip");
           dojo.addOnLoad(function(){
              new dijit.Tooltip({
                  connectId: ["wordOfTheDay2"],
                  label: "a <i>disposition</i> to bear injuries patiently : <b>forbearance</b>"
              });
           });
        </script>

  .. cv:: html

         <span id="wordOfTheDay2">Longanimity</span>


Declarative markup
------------------

And here's a tooltip created from markup connected to a `dijit.form.Button <dijit/form/Button>`_ widget:

.. cv-compound::

  .. cv:: css

    <style type="text/css">
    .box { color: white; background-color: #ba2929; width: 200px; height: 50px; padding: 10px; }
    </style>


  .. cv:: javascript

        <script>
           dojo.require("dijit.Tooltip");
           dojo.require("dijit.form.Button");
        </script>

  .. cv:: html

        <div class="box">Example content above button</div>
        <button id="buttonId" dojoType="dijit.form.Button">Longanimity</button>
        <button id="button2" dojoType="dijit.form.Button">Tooltip below</button>
        <div class="box">Example content below button</div>
        <div dojoType="dijit.Tooltip" connectId="buttonId" position="above">
            a <i>disposition</i> to bear injuries patiently : <b>forbearance</b>
        </div>
        <div dojoType="dijit.Tooltip" connectId="button2" position="below">
            a <i>disposition</i> to bear injuries patiently : <b>forbearance</b>
        </div>


===================
Tooltip Positioning
===================

By default, dijit tries to find a place to display the tooltip to the left or the right of the target element.
You can control the search path for positions via a global setting like:

dijit.Tooltip.defaultPosition = ["above", "below"];

=============
Accessibility
=============

Tooltips are displayed when the associated item receives focus or a mouseover event. Be careful when assigning tooltips to arbitrary elements such as spans of text which may not receive keyboard focus because users of assistive technology or keyboard only users will not benefit from the tooltip. If the tooltip information is important, make certain that the item which triggers display of the tooltip can receive focus via the keyboard. This can be accomplished by adding a tabindex="0" attribute onto the trigger element to put it into the tab order of the page.

Known Issues
------------

When using Firefox 2 with JAWS 9, the tooltip text is spoken twice. This has been fixed in Firefox 3. 

Tooltips are not spoken in IE 8 with JAWS 10. This is because Dijit Tooltips are implemented using the ARIA alert role and IE 8 does not support that role.   A ticket (http://bugs.dojotoolkit.org/ticket/3957) has been filed to modify Dijit Tooltips to use the ARIA tooltip role since that role is now supported in Firefox 3 and IE 8
