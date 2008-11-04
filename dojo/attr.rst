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

.. code-block :: javascript
 :linenos:

  node.setAttribute("style", "border:1px solid #ff0033;");

for instance won't work in IE. 

In Dojo you can do the same thing workin gin all browsers using following method


.. code-block :: javascript
 :linenos:

  dojo.attr(node, "style", "border:1px solid #ff0033;");

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
          var node = dojo.byId("testNode");
          
          dojo.attr(node, "tabindex", 1);
          dojo.attr(node, "name", "nameAtt");
          dojo.attr(node, "innerHTML", "New Content");
        });

        dojo.connect(dijit.byId("buttonTwo"), "onClick", function(){
          var node = dojo.byId("testNode");
          var str = "";

          str += "tabindex: "+dojo.attr(node, "tabindex")+"\n";
          str += "name: "+dojo.attr(node, "name")+"\n";
          str += "innerHTML: "+dojo.attr(node, "innerHTML")+"\n";

          dojo.attr(dojo.byId("console"), "innerHTML", str);
        });
      });
    </script>

  .. cv:: html

    <button dojoType="dijit.form.Button" id="buttonOne">Set attributes</button>
    <button dojoType="dijit.form.Button" id="buttonTwo">Get attributes</button>
    <div id="testNode">Hi friends :)</div>
    <div id="console"></div>

Setting events
--------------

This example will demonstrate how you can set events using dojo.attr(), still concider using `dojo.connect <dojo/connect>`_ when you are dealing with events since you are getting lots more possibilities and granularitiy with using `dojo.connect <dojo/connect>`_

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.addOnLoad(function(){
        dojo.connect(dijit.byId("buttonThree"), "onClick", function(){
          var node = dojo.byId("testNodeTwo");
          
          onOver = function(evt){
            dojo.attr(dojo.byId("consoleOne"), "innerHTML", "The mouse is over");
          }

          onClick = function(evt){
            dojo.attr(dojo.byId("consoleOne"), "innerHTML", "The mouse is clicked");
          }
 
          dojo.attr(node, "onmouseover", onOver);
          dojo.attr(node, "onclick", onClick);
          
        });
      });
    </script>

  .. cv:: html

    <button dojoType="dijit.form.Button" id="buttonThree">Set events</button>
    <div id="testNodeTwo">Hi, try the events! Click me or hover me.</div>
    <div id="consoleOne"></div>

Setting styles
--------------

The following example will set the "style" attribute of the given dom node. It is recommended to use `dojo.style <dojo/style>`_ if you want to do more complex style modifications.

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

    <button dojoType="dijit.form.Button" id="buttonFour">Change style</button>
    <div id="testNodeThree">Hi, change my style</div>

========
See also
========

* `DOM Attributes and The Dojo Toolkit 1.2 <http://www.sitepen.com/blog/2008/10/23/dom-attributes-and-the-dojo-toolkit-12/>`_
