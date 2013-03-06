.. _dijit/layout/BorderContainer:

============================
dijit/layout/BorderContainer
============================

:Authors: Becky Gibson, Bill Keese, Nikolai Onken, Marcus Reimann
:Developers: Bill Keese
:since: V1.2

.. contents ::
    :depth: 2

BorderContainer is a :ref:`dijit/layout/LayoutContainer <dijit/layout/LayoutContainer>` with the added ability
for the user to drag splitters between panes, thus resizing them.


Examples
========

Programmatic example
--------------------

.. code-example::

  .. js ::

      require([
          "dijit/layout/BorderContainer", "dijit/layout/ContentPane",
          "dojo/domReady!"
      ], function(BorderContainer, ContentPane){
          // create a BorderContainer as the top widget in the hierarchy
          var bc = new BorderContainer({
              style: "height: 300px; width: 500px;"
          });

          // create a ContentPane as the left pane in the BorderContainer
          var cp1 = new ContentPane({
              region: "left",
              style: "width: 100px",
              content: "hello world"
          });
          bc.addChild(cp1);

          // create a ContentPane as the center pane in the BorderContainer
          var cp2 = new ContentPane({
              region: "center",
              content: "how are you?"
          });
          bc.addChild(cp2);

          // put the top level widget into the document, and then call startup()
          bc.placeAt(document.body);
          bc.startup();
      });


Declarative example
-------------------

.. code-example::
  :type: inline
  :height: 400
  :width: 660

  Let's specify a simple BorderContainer with a left and center region

  .. css ::

   html, body {
       width: 100%;
       height: 100%;
       margin: 0;
       overflow:hidden;
   }

   #borderContainer {
       width: 100%;
       height: 100%;
   }

  .. js ::

    require(["dojo/parser", "dijit/layout/ContentPane", "dijit/layout/BorderContainer"]);

  .. html ::
    
    <div data-dojo-type="dijit/layout/BorderContainer" data-dojo-props="design:'sidebar', gutters:true, liveSplitters:true" id="borderContainer">
        <div data-dojo-type="dijit/layout/ContentPane" data-dojo-props="splitter:true, region:'leading'" style="width: 100px;">Hi, I'm leading pane</div>
        <div data-dojo-type="dijit/layout/ContentPane" data-dojo-props="splitter:true, region:'center'">Hi, I'm center pane</div>
    </div>


Nested Layout Widgets
---------------------

Let's take a look at a more advanced example of using BorderContainer and other layout widgets:

.. code-example::
  :djConfig: parseOnLoad: true
  :type: inline
  :height: 400
  :width: 660

  This example uses two BorderContainers to allow to, left and right content areas. 

  .. js ::

    require(["dojo/parser", "dijit/layout/ContentPane", "dijit/layout/BorderContainer", "dijit/layout/TabContainer", "dijit/layout/AccordionContainer", "dijit/layout/AccordionPane"]);

  The markup has to look as follows: Note the tabStrip attribute on the TabContainer.
   
  .. html ::
    
    <div data-dojo-type="dijit/layout/BorderContainer" data-dojo-props="gutters:true, liveSplitters:false" id="borderContainerTwo">
        <div data-dojo-type="dijit/layout/ContentPane" data-dojo-props="region:'top', splitter:false">
            Hi, usually here you would have important information, maybe your company logo, or functions you need to access all the time..
        </div>
        <div data-dojo-type="dijit/layout/AccordionContainer" data-dojo-props="minSize:20, region:'leading', splitter:true" style="width: 300px;" id="leftAccordion">
            <div data-dojo-type="dijit/layout/AccordionPane" title="One fancy Pane">
            </div>
            <div data-dojo-type="dijit/layout/AccordionPane" title="Another one">
            </div>
            <div data-dojo-type="dijit/layout/AccordionPane" title="Even more fancy" selected="true">
            </div>
            <div data-dojo-type="dijit/layout/AccordionPane" title="Last, but not least">
            </div>
        </div><!-- end AccordionContainer -->
        <div data-dojo-type="dijit/layout/TabContainer" data-dojo-props="region:'center', tabStrip:true">
            <div data-dojo-type="dijit/layout/ContentPane" title="My first tab" selected="true">
            Lorem ipsum and all around...
            </div>
            <div data-dojo-type="dijit/layout/ContentPane" title="My second tab">
            Lorem ipsum and all around - second...
            </div>
            <div data-dojo-type="dijit/layout/ContentPane" data-dojo-props="closable:true" title="My last tab">
            Lorem ipsum and all around - last...
            </div>
        </div><!-- end TabContainer -->
    </div><!-- end BorderContainer -->

  A few simple CSS rules

  .. css ::

    html, body {
        width: 100%;
        height: 100%;
        margin: 0;
        overflow:hidden;
    }

    #borderContainerTwo {
        width: 100%;
        height: 100%;
    }


BorderContainer Inside A Dijit Template
---------------------------------------

You can use a BorderContainer inside your own dijit template with a bit of care to call startup() on your dijit
after it has been added to the DOM, so that its contained BorderContainer can lay itself out.

.. code-example::
  :djConfig: async: true, parseOnLoad: false
  :height: 400
  :width: 660

  A few simple css rules

  .. css ::

    html, body {
        width: 100%;
        height: 100%;
        margin: 0;
    }

    #borderContainerThree {
        width: 100%;
        height: 100%;
        overflow:hidden;
        border: none;
    }

  .. js ::

    require([
        "dojo/parser",
        "dojo/_base/declare",
        "dijit/_WidgetBase",
        "dijit/_TemplatedMixin",
        "dijit/_WidgetsInTemplateMixin",
        "dijit/form/Button",
        "dijit/layout/ContentPane",
        "dijit/layout/BorderContainer",
        "dijit/layout/TabContainer",
        "dijit/layout/AccordionContainer",
        "dijit/layout/AccordionPane"
    ], function(parser, declare, _WidgetBase, _TemplatedMixin, _WidgetsInTemplateMixin){
        declare("MyDijit",
            [_WidgetBase, _TemplatedMixin, _WidgetsInTemplateMixin], {
                // Note: string would come from dojo/text! plugin in a 'proper' dijit
                templateString: '<div style="width: 100%; height: 100%;">' +
                    '<div data-dojo-type="dijit/layout/BorderContainer" design="headline" ' +
                    '  style="width: 100%; height: 100%;" data-dojo-attach-point="outerBC">' +
                    '<div data-dojo-type="dijit/layout/ContentPane" region="center">MyDijit - Center content goes here.</div>' +
                    '<div data-dojo-type="dijit/layout/ContentPane" region="bottom">MyDijit - Bottom : ' +
                    ' <div data-dojo-type="dijit/form/Button">A Button</div>' +
                    '</div>' +
                    '</div></div>'
        });

        parser.parse();
    });

  The markup has to look as follows:
  
  .. html ::

    <div data-dojo-type="dijit/layout/BorderContainer" data-dojo-props="gutters:true" id="borderContainerThree">
        <div data-dojo-type="dijit/layout/ContentPane" data-dojo-props="region:'top'">
            <div data-dojo-type="dijit/form/Button" id="createButton">Create Inner Dijit
                <script type="dojo/on" data-dojo-event="click">
                    require(["dojo/dom", "dojo/dom-construct"], function(dom, domConstruct){
                        // Create a new instance
                        var newdijit = new MyDijit({}, domConstruct.create('div'));
                        newdijit.placeAt(dom.byId('mydijitDestination'));
                        newdijit.startup();
                    });
                </script>
            </div>
        </div>
        <div data-dojo-type="dijit/layout/ContentPane" data-dojo-props="region:'left', splitter:false">
            OUTER LEFT<br />
            This is my content.<br />
            There is much like it,<br />
            but this is mine.<br />
            My content is my best friend.<br />
            It is my life.<br />
            I must master it,<br />
            as I must master my life.
        </div>
        <div data-dojo-type="dijit/layout/ContentPane" data-dojo-props="region:'center', splitter:false">
            <div id="mydijitDestination" style="width: 100%; height: 100%"></div>
        </div>
    </div>

Accessibility
=============

Keyboard
--------

===========================================    =================================================
Action                                         Key
===========================================    =================================================
Navigate to splitters for resizable regions    tab - all resizable splitters are in the tab order
Change the size of a vertical region           left / right arrows to decrease and increase
Change the size of a horizontal region         down / up arrows to decrease and increase
===========================================    =================================================

Note: The children of BorderContainer must be created in the source code in their natural tab order.
Header regions should be first and footer regions last.
In Left to right locales, left regions should be before center and right ones.

See also
========

* :ref:`dijit/layout/LayoutContainer <dijit/layout/LayoutContainer>` - base class of BorderContainer
