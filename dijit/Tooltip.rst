#format dojo_rst


dijit.Tooltip
=============
Tooltip is similar to the title="" attribute in regular HTML, but is much more flexible. You can control the display timing, and specify arbitrary (rich-text) HTML for the tooltip contents.

Note that if you want your tooltip to contain a form or something that the user clicks on / focuses on, you should use the `dijit.TooltipDialog <dijit/TooltipDialog>_` instead.

Here's a tooltip created programatically:

.. cv:: compound

  ..cv:: javascript
        <script>
           dojo.require("dijit.Tooltip");
           dojo.addOnLoad(function(){
              new dijit.Tooltip({
                  connectId: "wordOfTheDay2",
                  label: "a <i>disposition</i> to bear injuries patiently : <b>forbearance</b>"
              });
           });
        </script>

  ..cv:: html
         <div id="wordOfTheDay2">Longanimity</div>

And here's the same tooltip created from markup:

.. cv:: compound

  ..cv:: javascript
        <script>
           dojo.require("dijit.Tooltip");
        </script>

  ..cv:: html
        <div dojoType="dijit.Tooltip" connectId="wordOfTheDay">
            a <i>disposition</i> to bear injuries patiently : <b>forbearance</b>
         </div>
         <div id="wordOfTheDay">Longanimity</div>


Accessibility
-------------

Tooltips are displayed when the associated item receives focus or a mouseover event. Be careful when assigning tooltips to arbitrary elements such as spans of text which may not receive keyboard focus because users of assistive technology or keyboard only users will not benefit from the tooltip. If the tooltip information is important, make certain that the item which triggers display of the tooltip can receive focus via the keyboard. This can be accomplished by adding a tabindex="0" attribute onto the trigger element to put it into the tab order of the page.
