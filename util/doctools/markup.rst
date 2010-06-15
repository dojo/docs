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
		
		postCreate: function(){
		        // summary:
		        //            Called after a widget's dom has been setup
		        // tags:
		        //            protected
		},

* **private**: The method or property is not intended for use by anything other than the class itself. For example:

	.. code-block :: javascript
	
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
	
		parse: function(/*Node*/ node){
		        // summary:
		        //            Parse things.
		        // tags:
		        //            protected extension
		        ...
		}

A Note
------

The current API tools (for displaying the documentation) not only assumes that any variable beginning with a _prefix is considered private, but also assumes that any method beginning with the phrase "on" is an event handler (i.e. onFoo, onClick, onmouseover).


====================
Method-Specific Tags
====================

* **callback**: This method represents a location that a user can connect to (i.e. using dojo.connect) to receive notification that some event happened, such as a user clicking a button or an animation completing. For example:


	.. code-block :: javascript
		
		onClick: function(){
		        // summary:
		        //            Called when the user clicks the widget
		        // tags:
		        //            callback
		        ...
		}
		
* **extension**: Unlike a normal protected method, we mark a function as an extension if the default functionality isn't how we want the method to ultimately behave. This is for things like lifecycle methods (e.g. postCreate) or methods where a subclass is expected to change some basic default functionality (e.g. buildRendering). A callback is just a notification that some event happened, an extension is where the widget code is expecting a method to return a value or perform some action. For example, on a calendar: 

.. code-block :: javascript
	
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

	function(/*String*/ foo, /*int*/  bar)...
	
Type Modifiers
--------------

There are some modifiers you can add after the type:

* ? means optional
* ... means the last parameter repeats indefinitely
* [] means an array

.. code-block :: javascript
	
	function(/*String?*/ foo, /*int...*/  bar, /*String[]?*/ baz){ }

Full Parameter Summaries
------------------------

If you want to also add a summary, you can do so in the initial comment block. If you've declared a type in the parameter definition, you do not need to redeclare it here. 

.. code-block :: javascript

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



==============================
Variable Comments in an Object
==============================

The parser takes the comments in between object values and applies the same rules as if they were in the initial comment block:

.. code-block :: javascript

	{
	  // key: String
	  //        A simple value
	  key: "value",
	  // key2: String
	  //        Another simple value
	}

============
Return Value
============

Because a function can return multiple types, the types should be declared on the same line as the return statement, and the comment must be the last thing on the line. If all the return types are the same, the parser uses that return type. If they're different, the function is considered to return "mixed". For example:

.. code-block :: javascript

	function(){
	  if(arguments.length){
	    return "You passed argument(s)"; // String
	  }else{
	    return false; // Boolean
	  }
	}

Note: The return type should be on the same line as the return statement. The first example is invalid, the second is valid:

.. code-block :: javascript

	function(){
	  return {
	    foo: "bar" // return Object
	  }
	}
	function(){
	  return { // return Object
	    foo: "bar"
	  }
	}


============================
Documentation-Specific Code
============================

Sometimes objects are constructed in a way that is hard to see from just looking through source. Or we might pass a generic object and want to let the user know what fields they can put in this object. In order to do this, there are two solutions:

Inline Commented-Out Code
-------------------------

There are some instances where you might want an object or function to appear in documentation, but not in Dojo, nor in your build. To do this, start a comment block with ``/*=====``. The number of ``=`` can be 5 or more.

The parser simply replaces the ``/*=====`` and ``=====*/`` with whitespace at the very start, so you must be very careful about your syntax.

.. code-block :: javascript

	dojo.mixin(wwwizard, {
	/*=====
	  // url: String
	  //        The location of the file
	  url: "",
	  // mimeType: String
	  //        text/html, text/xml, etc
	  mimeType: "",
	=====*/
	  // somethingElse: Boolean
	  //        Put something else here
	  somethingElse: "eskimo"
	});

Code in a Separate File
-----------------------

Doing this allows us to see syntax highlighting in our text editor, and we can worry less about breaking the syntax of the file that's actually in the code-base during parsing. It's nothing more complicated that writing a normal JS file, with a ``dojo.provide`` call.

The trade-off is that it's harder to maintain documentation-only files. It's a good idea to only have one of these per the namespace depth you're at. eg in the same directory that the file you're documenting is. We'll see an example of its use in the next section.

===================
Documenting a kwArg
===================

A lot of Dojo uses keyword-style arguments (kwArg). It's difficult to describe how to use them sometimes. One option is to provide a pseudo-object describing its behavior. So we'll create ``module/_arg.js`` and do the following:

.. code-block :: javascript

	dojo.provide("module._arg");
	module._arg.myFuncArgs = function(/*Object*/ kwArgs){
	  // url: String
	  //        Location of the thing to use
	  // mimeType: String
	  //        Mimetype to return data as
	        this.url = kwArgs.url;
	        this.mimeType = kwArgs.mimeType;
	}

This describes a real object that mimics the functionality of the generic object you would normally pass, but also provides documentation of what fields it has and what they do.

To associate this object with the originating function, do this:

.. code-block :: javascript

	var myFunc = function(/*module._arg.myFuncArgs*/  kwArgs){
	  console.log(kwArgs.url);
	  console.log(kwArgs.mimeType);
	}

Since we didn't do a ``dojo.require`` on module._arg, it won't get included, but the documentation parser will still provide a link to it, allowing the user to see its functionality. This pseudo object may also be included in-line using the ``/*===== =====*/`` syntax. For an example of how to do this inline, see "dojo.__FadeArgs" pseudo code in dojo/_base/fx.js, used to document ``dojo.fadeIn()`` and ``dojo.fadeOut()``

==========================================
Which Documentation-Specific Syntax To Use
==========================================

Documenting in another file reduces the chance that your code will break code parsing. It's a good idea from this perspective to use the separate file style as much as possible.

There are many situations where you can't do this, in which case you should use the inline-comment syntax. There is also a fear that people will forget to keep documentation in sync as they add new invisible mixed in fields. If this is a serious concern, you can also use the inline comment syntax.

===========================
Validating your docs markup
===========================

If you are a developer who has marked their code up using this syntax and want to test to make sure it is correct, you can run the doctool yourself locally. `See Generating API Documentation <util/doctools/generate>`_. There is also a tool to quickly view simple parsing found in util/docscripts/_browse.php
