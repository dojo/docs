#format dojo_rst

dojo.marginBox
===============

:Status: Draft
:Version: 1.0
:Project owner: ?--
:Available: since 1.0

.. contents::
   :depth: 2

Getter/setter for the margin-box of node.


============
Introduction
============

Returns an object in the expected format of box (regardless if box is passed). The object might look like:

{ l: 50, t: 200, w: 300: h: 150 }

for a node offset from its parent 50px to the left, 200px from the top with a margin width of 300px and a margin-height of 150px.


=====
Usage
=====

TODO: how to use the component/class/method

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   var marginBox = dojo.marginBox(domNode);
 </script>



========
Examples
========

Geting margin box I.
--------------------

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.addOnLoad(function(){
        var marginBox = dojo.marginBox(dojo.byId("marginNodeOne"));

        dojo.byId("resultOne").innerHTML = "Top: "marginBox.t+"<br />Left: "marginBox.l+"<br />Width: "marginBox.w+"<br />Height: "marginBox.h+"<br />";
      });
    </script>

  .. cv:: html

    <div id="marginNodeOne">Hi, I am a marginNode, really!</div>
    <div id="resultOne"></div>
    
  .. cv:: css

    <style type="text/css">
      #marginNodeOne {
        width: 200px;
        height: 200px;
        padding: 10px;
        margin: 10px;
        border: 1px solid #ccc;
      }

      #resultOne {
        
      }
    </style>

TODO: example

Declarative example
-------------------

TODO: example


========
See also
========

* TODO: links to other related articles
