#format dojo_rst

dojo.attr
===============

:Status: Draft
:Version: 1.0
:Available: since 1.2

.. contents::
   :depth: 2

A getter and setter for DOM attributes, events and CSS styles


============
Introduction
============

dojo.atr() gives you a unified api to deal with attribute modifications. Attributes such as "style" and "onclick" or other event attributes are not real attributes but shortcuts to their respective objects or event handlers.
On top of that several browsers deal with attribute setting and getting in different ways

node.setAttribute("style", "border:1px solid #ff0033;");

for instance won't work in IE. 

========
Examples
========

Setting different node attributes
---------------------------------

The following example will set several attributes such as the "tabindex" and "name"

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.addOnLoad(function(){
        dojo.connect(dijit.byId("buttonOne"), "onClick", function(){
          dojo.attr(node, "tabindex", 1);
          dojo.attr(node, "name", "nameAtt");
          dojo.attr(node, "innerHTML", "New Content");
        });

        dojo.connect(dijit.byId("buttonTwo"), "onClick", function(){
          var node = dojo.byId("testNode");
          var str = "";

          str += "tabindex: "+dojo.attr(node, "tabindex")+"\n";
          str += "tabindex: "+dojo.attr(node, "name")+"\n";
          str += "tabindex: "+dojo.attr(node, "innerHTML")+"\n";

          alert(str);
        });
      });
    </script>

  .. cv:: html

    <button dojoType="dijit.form.Button" id="buttonOne">Set attributes</button>
    <button dojoType="dijit.form.Button" id="buttonTwo">Get attributes</button>
    <div id="testNode">Hi friends :)</div>

Setting events
--------------

This example will demonstrate how you can set events using dojo.attr(), still concider using dojo.connect when you are dealin gwith events since you are getting lots more possibilities and granularitiy with using dojo.connect

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.addOnLoad(function(){
        dojo.connect(dijit.byId("buttonThree"), "onClick", function(){
          var node = dojo.byId("testNodeTwo");
          
          onOver = function(evt){alert('OVER');}
          onClick = function(evt){alert('CLICK');}
 
          dojo.attr(node, "onmouseover", onOver);
          dojo.attr(node, "onmouseclick", onClick);
          
        });
      });
    </script>

  .. cv:: html

    <button dojoType="dijit.form.Button" id="buttonThree">Set events</button>
    <div id="testNodeTwo">Hi, try the events</div>

Setting styles
--------------

The following example will set the "style" attribute of the given dom node. It is recommended to use dojo.style if you want to do more complex style modifications.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.addOnLoad(function(){
        dojo.connect(dijit.byId("buttonFour"), "onClick", function(){
          var node = dojo.byId("testNodeThree");
          
          dojo.attr(node, "style", "padding: 5px; border: 1px solid #ccc; background: #eee;");
          
        });
      });
    </script>

  .. cv:: html

    <button dojoType="dijit.form.Button" id="buttonThree">Change style</button>
    <div id="testNodeThree">Hi, try the events</div>
