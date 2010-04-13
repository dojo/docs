#format dojo_rst

Dojo Inline Documentation 
=========================

:Status: Draft
:Version: 1.0
:Project owner: Neil Roberts
:Available: since V1.3

.. contents::
   :depth: 2

Syntax, keywords and guidelines for Dojo's inline API documentation format

============
Introduction
============

API documentation takes the form of comment blocks, typically with one or more keywords. Function parameters may also be hinted inline and return values also indicated inline.

===========
Using a Key
===========

When parsing a comment block, we give the parser a list of "keys" to look for. These include summary, description, and returns, but many comment blocks will also have all of the variables and parameters in the object or function added to this list of keys as well.
Formatting: Each keyword should be on a line by itself, with a space before and a colon after. For variable names there's a type after the colon. The content associated with the keyword is indented by two tabs. For example:

.. code-block :: javascript
	:linenos:

	// summary:
	//            This is the summary for the method.
	//            It's indented by two tabs.
	// foo: Integer
	//            First argument to this function
	// bar: String
	//            Second argument to this function
	// returns:
	//            A calculated value.

The parser will keep reading content as part of the specified key until it sees a completely blank line, or another keyword.
Although our formatting convention requires that keywords exist on a separate line, if any of these keywords occur at the beginning of a line, the parser will start reading the text following it and save it as part of that key's content. This means that you should be careful about what word you use to start a line. For example, "summary" shouldn't start a line unless the content that follows is the summary.

==========================================
Using Markdown
==========================================

You can use `Markdown <http://daringfireball.net/projects/markdown/syntax>`_  in descriptions and examples. 

To indicate a code block, indent the code block using a single tab. The parser considers the | (pipe) character to indicate the start of a line. You must use | followed by a tab in order to indicate a code block. In Markdown, to indicate an inline piece of code, surround the code with backticks. eg `<div>`.

===================
General Information
===================

These keys provide descriptions for the function or object:

* **summary**: A short statement of the purpose of the function or object. Will be read in plain text (html entity escaped, Markdown only for code escaping)

* **description**: A complete description of the function or object. Will appear in place of summary. (uses Markdown)

* **tags**: A list of whitespace-separated tags used to indicate how the methods are to be used (see explanations below)

* **this**: We assume that this points to a class instance. To clarify, use this key to either set a specific location or the string  "namespace" to indicate you're referring to a sibling variable

* **returns**: A description of what the function returns (does not include a type, which should appear within the function)

* **example**: A writeup of an example. Uses Markdown syntax, so use Markdown syntax to indicate code blocks from any normal text. This key  can occur multiple times.

=====
Tags
=====

Tags are used to help the documentation tool group things by purpose and to provide other modifiers that the language doesn't necesarily provide (public, private, protected, etc.). Most tags are ad-hoc, which is to say you can invent your own, but several are pre-defined and used throughout Dojo code. Most UIs that show documentation understand at least public, private, protected, callback, and extension.
Methods are assumed to be public, but are considered protected by default if they start with a _prefix. This means that the only time you'd use protected is if you don't want someone to use a function without a _prefix, and the only time you'd use private is if you don't want someone to touch your method at all.


* **protected**: The method can be called or overriden by subclasses but should not be accessed (directly) by a user. For example: 

	.. code-block :: javascript
		:linenos:
	
		postCreate: function(){
		        // summary:
		        //            Called after a widget's dom has been setup
		        // tags:
		        //            protected
		},

* **private**: The method or property is not intended for use by anything other than the class itself. For example:

	.. code-block :: javascript
		:linenos:

		_attrToDom: function(/*String*/ attr, /*String*/  value){
		        // summary:
		        //            Reflect a widget attribute (title, tabIndex, duration etc.) to
		        //            the widget DOM, as specified in attributeMap.
		        // tags:
		        //            private
		        ...
		}

* **multiple tags**: Multiple tags can separated by spaces: 

	.. code-block :: javascript
		:linenos:

		parse: function(/*Node*/ node){
		        // summary:
		        //            Parse things.
		        // tags:
		        //            protected extension
		        ...
		}
