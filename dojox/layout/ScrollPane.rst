.. _dojox/layout/ScrollPane:

=======================
dojox.layout.ScrollPane
=======================

:Project owner: ?--
:since: V?

.. contents ::
   :depth: 2

dojox.layout.ScrollPane is an interesting UI, scrolling an overflowed div based on mouse position, either vertical or horizontal.


Introduction
============

A pane that "scrolls" its content based on the mouse poisition inside

Usage
=====

A sizable container that takes it's content's natural size and creates a scroll effect based on the relative mouse position. It is an interesting way to display lists of data, or blocks of content, within a confined space.

Horizontal scrolling is supported. Combination scrolling is not.

Vertical orientation is set by default, you can set orientation to horizontal.

All example are > 1.7.

Programmatic Creation:

.. js ::

   require(["dojox/layout/ScrollPane"], function( ScrollPane){
		var scrollPane = new dojox.layout.ScrollPane({
			orientation: "vertical",
			style:"width:125px; height:200px; border:1px solid; overflow:hidden;"
		},"someNodeId");
	});

Declarative (HTML) Creation:

.. html ::

    <div data-dojo-type=="dojox.layout.ScrollPane" style="width:150px height:300px;">
      <!-- Any Height Content -->
    </div>

Examples
========

Programmatic example
--------------------

.. code-example::
  :djConfig: parseOnLoad: true
  :type: inline

  .. js ::

	require(["dojox/layout/ScrollPane"], function( ScrollPane){
	    var scrollPane = new dojox.layout.ScrollPane({
		orientation: "vertical",
		style:"width:125px; height:200px; border:1px solid; overflow:hidden;"
	    },"someNodeId0");
	});

  .. html ::

	<h2>Programatic Vertical:<h2>
	
	<div id="someNodeId0">
	    <ol>
		<li>text</li>
		<li>text</li>
		<li>text</li>
		<li>text</li>
		<li>text</li>
		<li>text</li>
		<li>text</li>
		<li>text</li>
		<li>text</li>
		<li>text</li>
		<li>text</li>
		<li>text</li>
		<li>text</li>
		<li>text</li>
		<li>text</li>
		<li>text</li>
		<li>text</li>
		<li>text</li>
		<li>text</li>
		<li>text</li>
	    </ol>
	</div>

Declarative example
-------------------

.. code-example::
  :djConfig: parseOnLoad: true
  :type: inline

  .. css ::

	td
	{
	  border: 1px solid black;
 	  padding: 6px;
	}

  .. js ::

	require(["dojox/layout/ScrollPane"]);

  .. html ::

	<h2>Declarative (HTML) Vertical:</h2>
	<div>

		<div data-dojo-type="dojox.layout.ScrollPane" style="width:100px; height:150px; border:1px solid; overflow:hidden;">
			<ol>
				<li>text</li>
				<li>text</li>
				<li>text</li>
				<li>text</li>
				<li>text</li>
				<li>text</li>
				<li>text</li>
				<li>text</li>
				<li>text</li>
				<li>text</li>
				<li>text</li>
				<li>text</li>
				<li>text</li>
				<li>text</li>
				<li>text</li>
				<li>text</li>
				<li>text</li>
				<li>text</li>
				<li>text</li>
				<li>text</li>
			</ol>
		</div>
		
	</div>


	<br style="clear:both;">	

	<h2>Declaritive (HTML) Horizontal</h2>
	<div data-dojo-type="dojox.layout.ScrollPane" data-dojo-props='orientation:"horizontal"' style="width:500px; height:50px; border:1px solid; overflow:hidden;">
	<table>
		<tr>
			<td>Text</td>
			<td>Text</td>

			<td>Text</td>
			<td>Text</td>
			<td>Text</td>
			<td>Text</td>
			<td>Text</td>
			<td>Text</td>

			<td>Text</td>
			<td>Text</td>
			<td>Text</td>
			<td>Text</td>
			<td>Text</td>
			<td>Text</td>

			<td>Text</td>
			<td>Text</td>
			<td>Text</td>
			<td>Text</td>
			<td>Text</td>
		</tr>

	</table>
	</div>

