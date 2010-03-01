#format dojo_rst

dojo.window.get
==================

:Status: Draft
:Version: 1.0
:Available: since V1.5

.. contents::
   :depth: 2

Gets the window object associated with a document

============
Introduction
============

Returns the window object associated with a document.

========
Examples
========

Here's some code to trace up from a node to the root of the main document, passing through iframes.   Based on the code in dijit/focus.js:

.. code-block :: javascript
  
			while(node){
				if(node.tagName && node.tagName.toLowerCase() == "body"){
					// is this the root of the document or just the root of an iframe?
					if(node === dojo.body()){
						// node is the root of the main document
						break;
					}
					// otherwise, find the iframe this node refers to (can't access it via parentNode,
					// need to do this trick instead). window.frameElement is supported in IE/FF/Webkit
					node=dojo.window.get(node.ownerDocument).frameElement;
				}else{
					node=node.parentNode;
				}
			}
