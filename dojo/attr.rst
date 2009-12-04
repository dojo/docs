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

dojo.attr() gives you a unified API to deal with DOM Node attribute modifications. Attributes such as "style" and "onclick" or other event attributes are not real attributes but shortcuts to their respective objects or event handlers.
On top of that several browsers deal with attribute setting and getting in different ways

.. code-block :: javascript
 :linenos:

  node.setAttribute("style", "border:1px solid #ff0033;");

for instance won't work in IE.

In Dojo you can do the same thing working in all browsers using following method


.. code-block :: javascript
 :linenos:

  dojo.attr(node, "style", {border:"1px solid #ff0033"});

========
Examples
========

Setting different node attributes
---------------------------------

The following example will set several attributes such as the "tabindex" and "name"

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      function setAttributes(){
          dojo.attr('testNode', {
                    tabIndex: 1,
                    name: "nameAtt",
                    innerHTML: "New Content"
          });
      }

      function displayAttributes(){
          dojo.attr("console", "innerHTML",
             "tabindex: "+dojo.attr("testNode", "tabindex")+"\n" +
             "name: "+dojo.attr("testNode", "name")+"\n" +
             "innerHTML: "+dojo.attr("testNode", "innerHTML")+"\n"
          );
      }
    </script>

  .. cv:: html

    <button dojoType="dijit.form.Button" id="buttonOne" onClick="setAttributes();">Set attributes</button>
    <button dojoType="dijit.form.Button" id="buttonTwo" onClick="displayAttributes();">Get attributes</button>
    <div id="testNode">Hi friends :)</div>
    <div id="console"></div>

Setting events
--------------

This example will demonstrate how you can set events using dojo.attr().  You should still consider using `dojo.connect <dojo/connect>`_ when you are dealing with events since you are getting lots more possibilities and granularity with using `dojo.connect <dojo/connect>`_.  In particular you get a handle to later disconnect the event.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      function setupHandlers(){
          dojo.attr("testNodeTwo", "onmouseover", function(evt){
            dojo.attr("consoleOne", "innerHTML", "The mouse is over");
          });

          dojo.attr("testNodeTwo", "onclick", function(evt){
            dojo.attr("consoleOne", "innerHTML", "The mouse was clicked");
          });
      }
    </script>

  .. cv:: html

    <button dojoType="dijit.form.Button" id="buttonThree" onClick="setupHandlers();">Setup handlers</button>
    <div id="testNodeTwo">Hi, try the events! Click me or hover me.</div>
    <div id="consoleOne"></div>

Setting styles
--------------

The following example will set the "style" attribute of the given dom node. When you set "style" with `dojo.attr()` it delegates the work to `dojo.style() <dojo/style`_.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      function changeStyle(){
          dojo.attr("testNodeThree", "style", {padding: "5px", border: "1px solid #ccc", background: "#eee"});
      }
    </script>

  .. cv:: html

    <button dojoType="dijit.form.Button" id="buttonFour" onClick="changeStyle();">Change style</button>
    <div id="testNodeThree">Hi, change my style</div>

========
See also
========

* `dojo.hasAttr <dojo/hasAttr>`_
* `dojo.removeAttr <dojo/removeAttr>`_
* `dojo.getNodeProp <dojo/getNodeProp>`_
* `NodeList.attr <NodeList/attr>`_
* `dojo.style <dojo/style>`_
* `DOM Attributes and The Dojo Toolkit 1.2 <http://www.sitepen.com/blog/2008/10/23/dom-attributes-and-the-dojo-toolkit-12/>`_
