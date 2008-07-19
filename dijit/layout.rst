#format dojo_rst

HTML and Layouts

Typically HTML has bottom-up sizing, where a container is as big as it's contents, so that given

.. code-block :: html
  :linenos:

  <div id="outer">
    <div id="inner1">
      Part 1
    </div>
    <div id="inner2">
      Part 2
    </div>
  </div>

inner1 is big enough to hold the text "Part 1", inner2 is big enough to hold the text "Part 2", and outer is big enough to hold the divs. And if outer is bigger than the browser's viewport, the browser window displays a scrollbar. The web page you're reading now uses that layout, and unless your monitor is 3 feet tall (in which case, we envy you!) you see the scrollbar on the right.

But for some web pages, you want them to work with the opposite pattern, where you start with a given size, typically the browser viewport, and then partition it into smaller sections. This is the way desktop application look, for example a mail program that has a tree on the left, a list of messages in the upper right, and the message preview on the lower right.

Note that in this scenario, there's no scrollbar on the browser window itself, but if any pane is too small to display all the text it contains then it gets a scrollbar.
maildemo.png

Layout like the picture above can be done using tables or fancy CSS (see recent A List Apart article about CSS sizing), but that technique has it's limits... it doesn't allow things like tabs or accordions or split containers where the user can adjust the size of each pane.
Dijit Layout

Dijit has a number of layout widgets which can be combined in a hierarchy to achieve that. Every layout widget contains a list of other layout widgets, except for the "leaf" nodes in the hierarchy, which are typically ContentPanes.

How does this work in practice? You need to think about the application above in a top-down (or outside-in) way:

   1. the screen is split into two parts. The top is a toolbar and
   2. the bottom is split into a left section and right section
   3. the left section has three panes one of which is shown at a time
   4. the right section is split into two parts, a list of messages and a preview pane.

Conceptually it's a set of containers like this:
layoutblock.png

There are three types of elements in that picture:

   1. containers that display all their children side by side
   2. containers that display one child at a time
   3. leaf nodes containing content

#1 is either LayoutContainer or SplitContainer. A LayoutContainer is used when all but one of the elements is a constant size. (In this case, the toolbar is a constant size and the the bottom section takes the rest of the screen, so we will use a LayoutContainer for that, and SplitContainers for the other parts.

#2 is AccordionContainer, TabContainer, or StackContainer. They all do basically the same thing, but look different.

#3 is typically ContentPane but could be any widget. An important consideration is whether or not the widget's size is adjustable (like a ContentPane) or not (like a Toolbar). See #1 above.

So keeping those rules in mind and picking which widgets to use it will look like:

* LayoutContainer
    
  * Toolbar
  * Horizontal Split Container

    * Accordion Container

      * ContentPane #1
      * ContentPane #2
      * ContentPane #3

    * Vertical Split Container

       * Content Pane #4
       * Content Pane #5
