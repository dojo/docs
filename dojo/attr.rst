#format dojo_rst

dojo.modulename
===============

:Status: Draft
:Version: 1.0
:Available: since 1.2

.. contents::
   :depth: 2

TODO: short summary of the component/class/method


============
Introduction
============

TODO: introduce the component/class/method

========
Examples
========

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.addOnLoad(function(){
        dojo.connect(dijit.byId("buttonOne"), "onClick", function(){
          var node = dojo.byId("testNode");
          
          onOver = function(evt){alert('OVER');}
 
          dojo.attr(node, "onmouseover", onOver);
          dojo.attr(node, "tabindex", 1);
          dojo.attr(node, "style", {"background": "#ff0000"});
          dojo.attr(node, "name", "nameAtt");
          dojo.attr(node, "innerHTML", "New Content");
        });
      });
    </script>

  .. cv:: html

    <button dojoType="dijit.form.Button" id="buttonOne">Create node</button>
    <div id="testNode"></div>
