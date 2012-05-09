.. _dojox/layout/DragPane:

=====================
dojox.layout.DragPane
=====================

:Project owner: ?--
:since: V?

.. contents ::
   :depth: 2

dojox.layout.DragPane provides drag-based scrolling for divs with overflow.


Introduction
============

A small widget which takes a node with overflow and 
allows dragging to position the content. Useful with text, images,		
or for just adding "something" to a overflow-able div.
	

Usage
=====
The content is draggable upon selecting and moving the mouse.
You need to make sure to set the css overflow property (auto or hidden). You can also set the css white-space property to nowrap to eliminate wrapping the images or text.

.. html ::

   <div data-dojo-type="dojox.layout.DragPane"> some content </div>




Examples
========

Programmatic example
--------------------

TODO: example

Declarative example
-------------------

.. code-example::
  :djConfig: parseOnLoad: true
  :type: inline

  .. js ::

          require(["dojox/layout/DragPane"]);

  .. html ::
          
    <h2>Drag the text in the box below:</h2>
	
	<div class="dragBox" data-dojo-type="dojox.layout.DragPane">
		<div class="largeFont">Dojo saves you time and scales with your development process, using web   standards as its platform. It’s the toolkit experienced developers turn to for building high quality desktop and mobile web applications.
		From simple websites to large packaged enterprise applications whether desktop or mobile, Dojo will meet your needs.</div>
	</div>
	
	<h2>Inverted:</h2>
	
	<div class="dragBox" data-dojo-props="invert:false" data-dojo-type="dojox.layout.DragPane">
		<div class="largeFont">Dojo saves you time and scales with your development process, using web standards as its platform. It’s the toolkit experienced developers turn to for building high quality desktop and mobile web applications.
		From simple websites to large packaged enterprise applications whether desktop or mobile, Dojo will meet your needs.</div>
	</div>

  .. css ::
    	
    .largeFont {
	font-size:x-large;
    }

    .dragBox {
        overflow:hidden;
	white-space: nowrap;
	width:675px;
	height:200px;
	border:2px solid black;
    }

See also
========

* TODO: links to other related articles
