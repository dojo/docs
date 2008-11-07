#format dojo_rst

dojo.marginBox
===============

:Status: Draft
:Version: 1.0
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

.. code-block :: javascript
 :linenos:

 <script type="text/javascript">
   var marginBox = dojo.marginBox(domNode);
 </script>



========
Examples
========

Getting margin box I.
---------------------

This example displays the return values of dojo.marginBox on a node. 

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.addOnLoad(function(){
        var marginBox = dojo.marginBox(dojo.byId("marginNodeOne"));

        dojo.byId("resultOne").innerHTML = "Top: "+marginBox.t+"<br />Left: "+marginBox.l+"<br />Width: "+marginBox.w+"<br />Height: "+marginBox.h+"<br />";
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
    </style>

Getting margin box I.
---------------------

This example displays the return values of dojo.marginBox on a nested node. 

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.addOnLoad(function(){
        var marginBox = dojo.marginBox(dojo.byId("marginNodeTwo"));

        dojo.byId("resultTwo").innerHTML = "Top: "+marginBox.t+"<br />Left: "+marginBox.l+"<br />Width: "+marginBox.w+"<br />Height: "+marginBox.h+"<br />";
      });
    </script>

  .. cv:: html

    <div>
      Hi I am nested
      <div id="marginNodeTwo">Hi, I am a marginNode, really!</div>
    </div>
    <div id="resultTwo"></div>
    
  .. cv:: css

    <style type="text/css">
      #marginNodeTwo {
        width: 300px;
        height: 200px;
        padding: 10px;
        margin: 10px;
        border: 1px solid #ccc;
      }
    </style>

Setting margin box I.
---------------------

This example is showcasing the usage of dojo.marginBox as a setter, take a look at the JavaScript code to see what the code does.

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
      dojo.addOnLoad(function(){
        var marginBox = dojo.marginBox(dojo.byId("marginNodeThree"), {t: 20, l: 30, h: 300, w: 300});
      });
    </script>

  .. cv:: html

    <div>
      Hi I am nested
      <div id="marginNodeThree">Hi, I am a marginNode, really!</div>
    </div>

  .. cv:: css

    <style type="text/css">
      #marginNodeThree {
        padding: 10px;
        margin: 10px;
        border: 1px solid #ccc;
      }

      #resultOne {
        
      }
    </style>
