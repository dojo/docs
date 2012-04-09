.. _dijit/Tooltip:

=============
dijit.Tooltip
=============

:Authors: Doug Hays, Bill Keese, Marcus Reimann
:Project owner: Bill Keese
:since: V1.0

.. contents ::
    :depth: 2

Introduction
============

Tooltip is similar to the title="" attribute in regular HTML, but is much more flexible.
You can control the display timing, and specify arbitrary (rich-text) HTML for the tooltip contents.

Note that if you want your tooltip to contain a form or something that the user clicks on / focuses on, you should use the :ref:`dijit.TooltipDialog <dijit/TooltipDialog>` instead.


Usage
=====

.. code-example ::
  :djConfig: async: true

  .. js ::
 
    require(["dojo/ready", "dijit/Tooltip"], function(ready, Tooltip){
        ready(function(){
            new Tooltip({
                connectId: ["exampleNode"],
                label: "the text for the tooltip"
            });
        });
    });

  .. html ::

    <span id="exampleNode">Lorem ipsum dolor sit amet.</span>

=========  =========================  =============================================================================
Parameter  Type                       Description
=========  =========================  =============================================================================
connectId  Strings|DomNodes           Id of DomNode to attach the tooltip to. When user hovers over the specified dom nodes, the tooltip will appear.
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

Examples
========

Programmatic example
--------------------

Here's a tooltip created programmatically:

.. code-example ::
  :djConfig: async: true

  .. css ::

    .bar1 { background-color: #ffa0a0; width: 17px; height: 74px; position: absolute; top: 100px; left: 10px; }
    .bar2 { background-color: #ffd4a0; width: 17px; height: 45px; position: absolute; top: 129px; left: 40px; }
    .bar3 { background-color: #fff79e; width: 17px; height: 30px; position: absolute; top: 144px; left: 70px; }
    .bar4 { background-color: #ffa0a0; width: 17px; height: 74px; position: absolute; top: 100px; left: 100px; }

  .. js ::

    require(["dojo/ready", "dijit/Tooltip"], function(ready, Tooltip){
        // create a new Tooltip and connect it to bar1 and bar4
        new Tooltip({
            connectId: ["bar1", "bar4"],
            label: "value <b>74</b>"
        });
        // create a new Tooltip and connect it to bar2
        new Tooltip({
            connectId: ["bar2"],
            label: "value <b>45</b>"
        });
        // create a new Tooltip and connect it to bar3
        new Tooltip({
            connectId: ["bar3"],
            label: "value <b>30</b>"
        });
    });

  .. html ::

    <span id="bar1" class="bar1">&nbsp;</span>
    <span id="bar2" class="bar2">&nbsp;</span>
    <span id="bar3" class="bar3">&nbsp;</span>
    <span id="bar4" class="bar4">&nbsp;</span>
    <div>Move your mouse over a colored bar</div>


Declarative markup
------------------

And here's a tooltip created from markup connected to a :ref:`dijit.form.Button <dijit/form/Button>` widget:

.. code-example ::
  :djConfig: async: true, parseOnLoad: true

  .. css ::

    .box { color: white; background-color: #ba2929; width: 200px; height: 50px; padding: 10px; }

  .. js ::

    require(["dojo/parser", "dijit/Tooltip", "dijit/form/Button"]);

  .. html ::

    <div class="box">Example content above button</div>
    <button id="buttonId" data-dojo-type="dijit/form/Button">Longanimity</button>
    <button id="button2" data-dojo-type="dijit/form/Button">Tooltip below</button>
    <div class="box">Example content below button</div>
    <div data-dojo-type="dijit/Tooltip" data-dojo-props="connectId:'buttonId',position:['above']">
        a <i>disposition</i> to bear injuries patiently : <b>forbearance</b>
    </div>
    <div data-dojo-type="dijit/Tooltip" data-dojo-props="connectId:'button2',position:['below']">
        a <i>disposition</i> to bear injuries patiently : <b>forbearance</b>
    </div>


Tooltip Positioning
===================

By default, dijit tries to find a place to display the tooltip to the left or the right of the target element.
You can control the search path for positions via a global setting like:

dijit.Tooltip.defaultPosition = ["above", "below"];

Attaching to Multiple Nodes
===========================
The Tooltip widget has two optional parameters:
  - selector
  - getContent()

These parameters allow a single Tooltip widget to display unique tooltips for (for example) each row in a table:

.. code-example ::

  .. js ::

      require(["dojo/ready", "dijit/Tooltip", "dojo/query!css2"], function(ready, Tooltip){
          ready(function(){
              new Tooltip({
                  connectId: "myTable",
                  selector: "tr",
                  getContent: function(matchedNode){
                      return matchedNode.getAttribute("tooltipText");
                  }
              });
          });
      });

  .. html ::

      <table id="myTable">
           <tr tooltipText="tooltip for row 1"><td>row 1</td></tr>
           <tr tooltipText="tooltip for row 2"><td>row 2</td></tr>
           <tr tooltipText="tooltip for row 3"><td>row 3</td></tr>
      </table>

Further, the table contents can be changed freely after the Tooltip is created.
Rows can be created, removed, or modified, and no calls to the Tooltip widget are necessary.
The node specified by the connectId, however, should exist at the time the Tooltip is created.

Selector is a CSS selector that specifies that the Tooltip should be attached, via event delegation,
to matching subnodes of the connectId node, rather than the connectId node itself.
So, specifying selector=".dijitTreeRow" will track mouseenter and mouseleave events on
each row of a Tree, rather than merely monitoring mouseenter/mouseleave on the Tree itself.

Note that, like :ref:`dojo/on::selector() <dojo/on#selector-function>`,
you need to require() an appropriate level of dojo/query to handle your selector.

getContent() lets the app customize the tooltip text that's displayed based on the node that triggered
the tooltip.


Accessibility
=============

Tooltips are displayed when the associated item receives focus or a mouseover event.
Be careful when assigning tooltips to arbitrary elements such as spans of text which may not receive keyboard focus because users of assistive technology or keyboard only users will not benefit from the tooltip.
If the tooltip information is important, make certain that the item which triggers display of the tooltip can receive focus via the keyboard.
This can be accomplished by adding a tabindex="0" attribute onto the trigger element to put it into the tab order of the page.

Known Issues
------------

Tooltips are not spoken in IE 8 with JAWS 10.
This is because Dijit Tooltips are implemented using the ARIA alert role and IE 8 does not support that role.
A ticket (`#3957 <http://bugs.dojotoolkit.org/ticket/3957>`_) has been filed to modify Dijit Tooltips
to use the ARIA tooltip role since that role is now supported in Firefox 3 and IE 8.

See also
========

* :ref:`dijit.TooltipDialog <dijit/TooltipDialog>` - displays a tooltip that contains form elements (like a dialog)
* :ref:`dojox.widget.DynamicTooltip <dojox/widget/DynamicTooltip>` - addition to dijit.Tooltip functionality allowing remotely loaded content to appear
