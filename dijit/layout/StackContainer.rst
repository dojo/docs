#format dojo_rst

dijit.layout.StackContainer
===========================

:Status: Draft
:Version: 1.2

A container that has multiple children, but shows only one child at a time (like looking at the pages in a book one by one). This container is good for wizards, slide shows, and long lists or text blocks.

StackContainer's current pane can be set via the selectChild() method, or it can be controlled from a StackController.  StackController
is a controller not in the MVC send of the word, but like a TV remote control... it's sets which page the StackController is tuned to.

Examples
--------

Here's an example of a progamatically created StackContainer, and associated StackController:

.. cv-compound::
 
  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.layout.StackContainer");
    dojo.require("dijit.layout.ContentPane");
    dojo.addOnLoad(function(){
        var sc = new dijit.layout.StackContainer({
            style: "height: 300px; width: 400px;",
            id: "myProgStackContainer"
        },"scontainer-prog");
  
        var cp1 = new dijit.layout.ContentPane({
             title: "tab 1",
             content: "tab 1 content"
        });
        sc.addChild(cp1);
  
        var cp2 = new dijit.layout.ContentPane({
             title: "tab 2",
             content: "tab 2 content"
        });
        sc.addChild(cp2);
  
        sc.startup();

        var controller = new dijit.layout.StackController({containerId: "myProgStackContainer"}, "scontroller-prog");
        controller.startup();
    });
    </script>

  The html is very simple

  .. cv:: html

    <div id="scontainer-prog"></div>
    <div id="scontroller-prog"></div>



Here you will see a declaratively created StackContainer

.. cv-compound::
  
  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.layout.StackContainer");
    dojo.require("dijit.layout.ContentPane");
    dojo.require("dijit.form.Button");
    </script>

  .. cv:: html

    <button id="previous" onClick="dijit.byId('stackContainer').back()" dojoType="dijit.form.Button"><</button>
    <span dojoType="dijit.layout.StackController" containerId="stackContainer"></span>
    <button id="next" onClick="dijit.byId('stackContainer').forward()" dojoType="dijit.form.Button">></button>
  
    <div dojoType="dijit.layout.StackContainer" id="stackContainer">
      <div dojoType="dijit.layout.ContentPane" title="Questions">
      Please answer following questions
      </div>
      <div dojoType="dijit.layout.ContentPane" title="Answers">
      Here is what you should have answered :P
      </div>
    </div>

  .. cv:: css

    <style type="text/css">
      #stackContainer {
          border: 1px solid #ccc;
          margin-top: 10px;
      }
      
      #stackContainer div {
          padding: 5px;
      }
    </style>
