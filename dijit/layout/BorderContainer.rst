#format dojo_rst

.. cv-compound::

  Lets specify a simple BorderContainer with a left and center region

  .. cv:: javascript

    <script type="text/javascript">
      dojo.require("dijit.layout.ContentPane");
      dojo.require("dijit.layout.BorderContainer");
    </script>

  The markup has to look as follows
  
  .. cv:: html
    :label: A dijit button
    
    <div style="position: relative; width: 100%; height: 400px; border: 1px #ccc solid;">
      <div dojoType="dijit.layout.BorderContainer" design="sidebar" gutters="true" liveSplitters="true" id="borderContainer">
        <div dojoType="dijit.layout.ContentPane" splitter="true" region="leading" style="width: 100px;">Hi</div>
        <div dojoType="dijit.layout.ContentPane" splitter="true" region="center">Hi, I'm center</div>
      </div>
    </div>

  .. cv:: css
    :label: A simple set of css rules

    <style type="text/css">
      #borderContainer {
        width: 100%;
        height: 100%;
      }
    </style>
