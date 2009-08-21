#format dojo_rst

dojox.Drawing
=============

:Status: Up to date
:Version: 1.4
:Project owner: Mike Wilcox
:Author: Mike Wilcox
:Available: since 1.4

Basic Description
-----------------

Utilizes DojoX GFX to allow for SVG and VML vector graphics drawing in the browser without Flash. The goal of Drawing is to be as close as possible to a desktop vector drawing program such as Flash or Visio.

Drawing is similar to DojoX Sketch, but is designed to be more versatile extendable and customizable.


Drawing currently only initiates from HTML, although it's technically not a Dijit to keep the file size light. But if Dijit is available, Drawing will register itself with it and can be accessed dijit.byId('myDrawing'). If Dijit is not available, Drawing creates a registry in the Dijit stub so it can still be accessed via dijit.byId. However, it's recommended to simply use jsId in the markup.

The files are laid out as such:

* Drawing
	The master class. More than one instance of a Drawing can be placed on a page at one time (although this has not yet been tested). Plugins can be added in markup.
	
* Toolbar
	Like Drawing, Toolbar is a psudeo Dijit that does not need Dijit. It is optional. It can be oriented horizontal or vertical by placing one of those params in the class (at least one is required). Plugins can be added in markup. A drawingId is required to point toolbar to the drawing.
	
* defaults
	Contains the default styles and dimensions for Stencils. An individual Stencil can be changed by calling stencil.att({color obj}); To change 	all styles, a custom defaults file should be used.
	
* Stencils
	Drawing uses a concept of 'Stencils' to avoid confusion between a Dojox Shape and a Drawing Shape. The classes in the 'stencils' package are display only, they are not used for actually drawing (see 'tools'). This package contains _Base from which stencils inherit most of their 	methods.(Path and Image are display only and not found in Tools)
	
* Tools
	The Tools package contains Stencils that are attached to mouse events and can be used for drawing. Items in this package can also be selected and modified.
	
* Tools / Custom
	Holds tools that do not directly extend Stencil base classes and often have very custom code.
	
* Library (not implemented)
	The Library package, which is not yet implemented, will be the place to hold stencils that have very specific data points that result in a picture. Flag-like-banners, fancy borders, or other complex shapes would go here.
	
* Annotations
	Annotations 'decorate' and attach to other Stencils, such as a 'Label' that can show text on a stencil, or an 'Angle' that shows while dragging or modifying a Vector, or an Arrow head that is attached to the beginning or end of a line.
	
* Manager
	Contains classes that control functionality of a Drawing.
	
* Plugins
	Contains optional classes that are 'plugged into' a Drawing. There are two types: 'drawing' plugins that modify the canvas and 'tools' which would 	show in the toolbar.
	
* Util
	A collection of common tasks.

Example
-------

After using the proper requires, the following is all that is needed to embed Drawing in your document: 

.. code-block :: html
 :linenos:

 <div dojoType="dojox.drawing.Drawing" id="drawing" style="width:800px; height:400px;"
     plugins="[{'name':'dojox.drawing.plugins.drawing.Grid', 'options':{gap:100}}]">   
 </div>
 
 <div dojoType="dojox.drawing.Toolbar" drawingId="drawing" class="drawingToolbar vertical">
     <div tool="dojox.drawing.tools.Line" selected="false">Line</div>
     <div tool="dojox.drawing.tools.Rect" selected="false">Rect</div>
     <div tool="dojox.drawing.tools.Ellipse" selected="false">Ellipse</div>
     <div tool="dojox.drawing.tools.TextBlock" selected="false">Statement</div>
     <div tool="dojox.drawing.tools.custom.Equation" selected="false">Equation</div>
     <div plugin="dojox.drawing.plugins.tools.Pan" options="{}">Pan</div>
     <div plugin="dojox.drawing.plugins.tools.Zoom" options="{zoomInc:.1,minZoom:.5,maxZoom:2}">Zoom</div>
 </div>

**NOTE** Due to the nature of VML, a DOCTYPE cannot be used with Drawing or any GFX work. This will force your page into quirks mode and may create a need for style adjustments.

Manipulating the Drawing
------------------------

* Stencil Types
	Each tool on the toolbar (and the Path Stencil) has an associated type:
	
	* ellipse
	
	* rect
	
	* line
	
	* image
	
	* path
	
	* text
	
	* textBlock
	
	* arrow
	
	* vector
	
	* axes
	
	* equation
	
	The difference between *text* and *textBlock* is *text* can not be dragged or selected, whereas *textBlock* can. *text* is used for non-editing situations such as labels or titles.
	
	*path* is currently not available as a tool, though it will shortly. It is in the code primarily for use in arrow heads. It can be used programmatically.
	
	Note that any custom tools such as *axes*, *equation* or *vector* need to be required in the document. They are not included in the basic Drawing package.

* Data Structures

 Each Stencil has its own data and point structure. Either *data* or *points*, but not both, can be used when programatically inserting Stencils or importing data as shown below. Data structures are loosely modeled on those from DojoX GFX. *data* shows the object properties, and *points* shows which array slot corresponds to which point on the stencil. Unless noted, all arguments are numbers **without** units (such as *px*). A point is an object with two properties, *x* and *y*, each a number. The structures are as follows:
	 
	* ellipse
		data:
			cx: Center point x
			
			cy: Center point y
			
			rx: Horizontal radius
			
			ry: Vertical radius
			
		points:
			0: Top left point
			
			1: Top right point
			
			2: Bottom right point
			
			3: Bottom left point
			
	* rect
		data:
			x: Left point x
			
			y: Top point y
			
			width: width of rectangle
			
			height: height of rectangle
		
		points:
			
			0: Top left point
			
			1: Top right point
			
			2: Bottom right point
			
			3: Bottom left point
		
	* line
		data:
			x1: First point x
			y1: First point y
			x2: Second point x
			y2: Second point y
			
		 ALTERNATIVE
			
			x: First point x
			y: First point y
			angle: angle of line
			radius: length of line
		points:
			0: First point
	 		1: Second point
	
	* image
		data:
			x: Left point x
			
			y: Top point y
			
			width: Optional width of Image. If not provided, it is obtained
			
			height: Optional height of Image. If not provided, it is obtained
			
			src: [String] The location of the source image
		
		points:
			0: Top left point
			
			1: Top right point
			
			2: Bottom right point
			
			3: Bottom left point
	
	* path
		data:
			Not supported
		points:
			0: First point
			
			[1, 2, 3...] more points
	
	* text
		data:
			x: Left point x
			
			y: Top point y
			
			width: Optional width of Text. Not required but reccommended. For auto-sizing, use TextBlock
			
			height: Optional height of Text. If not provided, _lineHeight is used.
			
			text: [String] The string content. If not provided, may auto-delete depending on defaults.
		points:
			*Using points obviously does not allow for the text string or other properties*
			
			0: Top left point
			
			1: Top right point
			
			2: Bottom right point
			
			3: Bottom left point
	
	* textBlock
		data:
			x: Left point x
			
			y: Top point y
			
			width: Optional width of Text. Not required but reccommended. For auto-sizing, use *auto*
			
			height: Optional height of Text. If not provided, _lineHeight is used.
			
			text: [String] The string content. If not provided, may auto-delete depending on defaults.
		points:
			*Using points obviously does not allow for the text string or other properties*
			
			0: Top left point
			
			1: Top right point
			
			2: Bottom right point
			
			3: Bottom left point
	
	* arrow
		Same as *line*. Additional properties *arrowStart* and *arrowEnd* can be used (they are not part of the data object).
	
	* vector
		Same as *line*. A vector can have a length of zero.
	
	* axes
		data:
			TODO
		points:
			TODO
	
	* equation
		Same as *textBlock*.
	 
DojoX Drawing contains several methods to manipulate the drawing. Most of these methods can be found in the main JavaScript file, drawing.js:

**onSurfaceReady**
	Any actions taken on the drawing should happen within this function or after it's called. This event is similar to dojo.addOnLoad; it fires when the canvas is ready.
		
**addStencil**
	To programatically add a Stencil to the drawing, use the *addStencil* method with two arguments, the basic Stencil type, and a object properties, which should include either the Stencil data or Stencil points.
 
.. code-block :: javascript
 :linenos:
  
 var textBlock = myDrawing.addStencil("textBlock", {data:{x:20, y:30, width:200, text:"This is editable text"}}); 
 var ellipse = myDrawing.addStencil("ellipse", {data:{cx:200, cy:200, rx:100, ry:50}});
 var arrow = myDrawing.addStencil("arrow", {data:{x1:400, y1:200, x2:500, y2:300}, arrowStart:true});
 var rect = myDrawing.addStencil("rect", {data:{x:50, y:275, width:100, height:100}}); 
 var text = myDrawing.addStencil("text", {data:{x:300, y:260, width:200, text:"This is just text"}});
 

**removeStencil**
	 Removes a stencil from the drawing using the stencil itself as the argument:
 
.. code-block :: javascript
 :linenos:
    
 myDrawing.removeStencil(myRect);
 

**removeAll**
	Removes all stencils from the drawing.
	
**selectAll**
	Selects all stencils in the drawing.
	
**importer**
	Imports an array of stencil data objects to the drawing. The objects should be in the format of the stencil structures shown above.
	
**exporter**
	Collects all Stencil data and returns an array of objects. Drawing does not export SVG, nor does it do any serialization.
	
**toSelected**
	Applies a function to the selected stencils. Could be used with the stencil.attr() method to style selected objects.
	
**resize**
	Resizes the drawing based on the passed argument object. This occurs automatically if inside a Dijit layout widget.
	
**changeDefaults**
	Changes the current style that is applied to newly drawn stencils. Pass in an object that represents one of the objects in drawing.style that will be mixed in. Not all properties are necessary. Only one object may be changed at a time. Non-objects like angleSnap cannot be changed in this manner. The following example changes the default fill to blue, the border color to yellow, and the border width to 5:  

.. code-block :: javascript
 :linenos:
  		
 myDrawing.changeDefaults({
     norm:{
          fill:"#0000ff",
          width:5,
          color:"#ffff00"
     }
 });
 

 
