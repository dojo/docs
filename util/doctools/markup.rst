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


====================
Method-Specific Tags
====================

* **callback**: This method represents a location that a user can connect to (i.e. using dojo.connect) to receive notification that some event happened, such as a user clicking a button or an animation completing. For example:


	.. code-block :: javascript
		:linenos:
	
		onClick: function(){
		        // summary:
		        //            Called when the user clicks the widget
		        // tags:
		        //            callback
		        ...
		}
		
* **extension**: Unlike a normal protected method, we mark a function as an extension if the default functionality isn't how we want the method to ultimately behave. This is for things like lifecycle methods (e.g. postCreate) or methods where a subclass is expected to change some basic default functionality (e.g. buildRendering). A callback is just a notification that some event happened, an extension is where the widget code is expecting a method to return a value or perform some action. For example, on a calendar: 

.. code-block :: javascript
	:linenos:
	
	isDisabledDate: function(date){
	        // summary:
	        //            Return true if the specified date should be disabled (i.e. grayed
	        //            out and unclickable)
	        // description:
	        //            Override this method to define special days to gray out, such as
	        //            weekends or (for an airline) black-out days when discount fares
	        //            aren't available.
	        // tags:
	        //            extension
	        ...
	}

============================
General Function Information
============================

.. code-block :: javascript
	:linenos:

	Foo = function(){
	  // summary:
	  //        Soon we will have enough treasure to rule all of New Jersey.
	  // description:
	  //        Or we could just get a new roommate. Look, you go find him. He
	  //        don't yell at you.  All I ever try to do is make him smile and sing
	  //        around him and dance around him and he just lays into me. He told
	  //        me to get in the freezer 'cause there was a carnival in there.
	  // returns:
	  //        Look, a Bananarama tape!
	}


==================
Object Information
==================

Has no description of what it returns

.. code-block :: javascript
	:linenos:

	var mcChris = {
	  // summary:
	  //        Dingle, engage the rainbow machine!
	  // description:
	  //        Tell you what, I wish I was--oh my g--that beam,
	  //        coming up like that, the speed, you might wanna adjust that.
	  //        It really did a number on my back, there. I mean, and I don't
	  //        wanna say whiplash, just yet, cause that's a little too far,
	  //        but, you're insured, right?
	}
	
========================================
Function Assembler Information (declare)
========================================

If the declaration passes a constructor, the summary and description must be filled in there. If you do not pass a constructor, the comment block can be created in the passed mixins object.
For example:

.. code-block :: javascript
	:linenos:

	dojo.declare(
	  "Steve",
	  null,
	  {
	    // summary:
	    //    Phew, this sure is relaxing, Frylock.
	    // description:
	    //    Thousands of years ago, before the dawn of
	    //    man as we knew him, there was Sir Santa of Claus: an
	    //    ape-like creature making crude and pointless toys out
	    //    of dino-bones, hurling them at chimp-like creatures with
	    //    crinkled hands regardless of how they behaved the
	    //    previous year.
	    // returns:
	    //    Unless Carl pays tribute to the Elfin Elders in space.
	  }
	);

==========
Parameters
==========

Simple Types
------------

Types should (but don't have to) appear in the main parameter definition block. For example:

.. code-block :: javascript
	:linenos:

	function(/*String*/ foo, /*int*/  bar)...
	
Type Modifiers
--------------

There are some modifiers you can add after the type:

* ? means optional
* ... means the last parameter repeats indefinitely
* [] means an array

.. code-block :: javascript
	:linenos:
	
	function(/*String?*/ foo, /*int...*/  bar, /*String[]?*/ baz){ }

Full Parameter Summaries
------------------------

If you want to also add a summary, you can do so in the initial comment block. If you've declared a type in the parameter definition, you do not need to redeclare it here. 

.. code-block :: javascript
	:linenos:

	function(foo, bar){
	  // foo: String
	  //        used for being the first parameter
	  // bar: int
	  //        used for being the second parameter
	}


=========
Variables
=========

Instance variables, prototype variables and external variables can all be defined in the same way. There are many ways that a variable might get assigned to this function, and locating them all inside of the actual function they reference is the best way to not lose track of them, or accidentally comment them multiple times.

.. code-block :: javascript
	:linenos:

	function Foo(){
	  // myString: String
	  // times: int
	  //        How many times to print myString
	  // separator: String
	  //        What to print out in between myString*
	  this.myString = "placeholder text";
	  this.times = 5;
	}
	Foo.prototype.setString = function(myString){
	  this.myString = myString;
	}
	Foo.prototype.toString = function(){
	  for(int i = 0; i < this.times; i++){
	    console.log(this.myString, foo.separator);
	  }
	}
	Foo.separator = "=====";



=================
Tagging Variables
=================

Variables can be tagged by placing them in a whitespace-separated format before the type value between [ and ] characters. The tags available for variables are the same as outlined in the main tags, plus a few variable-specific additions:

* **deprecated**: In methods, the doc system can search for dojo.deprecated calls. But variables will need specific declarations that they are deprecated.

	.. code-block :: javascript

	  // label: [deprecated readonly] String
	  //            A label thingie
	  label: ""

* **const**: A widget attribute that can be used for configuration, but can only have its value assigned during initialization. This means that changing this value on a widget instance (even with the attr method) will be a no-op.

	.. code-block :: javascript

		// id: [const] String
		//            A unique, opaque ID string that can be assigned by users...
		id: ""

* **readonly**: This property is intended to be read and cannot be specified during initialization, or changed after initialization.

	.. code-block :: javascript

		// domNode: [readonly] DomNode
		//            This is our visible representation of the widget...
		domNode: null
