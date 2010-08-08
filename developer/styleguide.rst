#format dojo_rst

Dojo Style Guide
================

.. contents::
    :depth: 2

This document follows the basic outline of the `Java Programming Conventions Guide <http://geosoft.no/javastyle.html>`_.
 
Widget authors are expected to adhere to this style guide and also to the `Dojo Accessibility Design Requirements <developer/a11y-requirements>`_ guidelines.

General
-------

Any violation to this guide is allowed if it enhances readability.

Guidelines in this document are informed by discussions carried out among the Dojo core developers. The most weight has been given to considerations that impact external developer interaction with Dojo code and APIs. Rules such as whitespace placement are of a much lower order importance for Dojo developers, but should be followed in the main in order to improve developer coordination.

Quick Reference
---------------

Table of core API naming constructs:

+---------------------+------------------------------+-----------------------------------+
| Construct           | Convention                   | Comment                           |
+---------------------+------------------------------+-----------------------------------+
| module              | lowercase                    | never multiple words              |
+---------------------+------------------------------+-----------------------------------+
| class               | CamelCase                    |                                   |
+---------------------+------------------------------+-----------------------------------+
| public method       | mixedCase                    | whether class or instance         | 
|                     |                              | method. lower_case() is           |
|                     |                              | acceptable only if the particular |
|                     |                              | function is mimicking another     |
|                     |                              | API.                              |
+---------------------+------------------------------+-----------------------------------+
| public var          | mixesCase                    |                                   |
+---------------------+------------------------------+-----------------------------------+
| constant            | CamelCase or UPPER_CASE      |                                   |
+---------------------+------------------------------+-----------------------------------+
 
Table of constructs that are not visible in the API, and therefore carry less weight of enforcement.

+-----------------------+---------------------------+ 
| Construct             | Convention                |
+-----------------------+---------------------------+
| private method        | _mixedCase                |
+-----------------------+---------------------------+
| private var           | _mixedCase                |
+-----------------------+---------------------------+
| method args           | _mixedCase, mixedCase     |
+-----------------------+---------------------------+
| local vars            | _mixedCase, mixedCase     |
+-----------------------+---------------------------+

Naming Conventions
------------------
 
    #. When constructing string IDs or ID prefixes in the code, do not use "dojo", "dijit"  or "dojox" in the names. Because we now allow multiple versions of dojo in a page, it is important you use _scopeName instead (dojo._scopeName, dijit._scopeName, dojox._scopeName).

    #. Names representing modules SHOULD be in all lower case.

    #. Names representing types (classes) MUST be nouns and written using CamelCase capitalization: ``Account, EventHandler``

    #. Constants SHOULD be placed within a single object created as a holder for constants,  emulating an Enum; the enum SHOULD be named appropriately, and members SHOULD be  named using either CamelCase or UPPER_CASE capitalization:

        .. javascript::

            var NodeTypes = { 
                Element: 1,
                DOCUMENT: 2
            };
    
    #. Abbreviations and acronyms SHOULD NOT be UPPERCASE when used as a name: 
        
        ``getInnerHTML()``, ``getXML()``, ``XmlDocument``
    
    #. Names representing methods SHOULD be verbs or verb phrases: ``obj.getSomeValue()``

    #. Public class variables MUST be written using mixedCase capitalization.

    #. CSS variable names SHOULD follow the same conventions as public class variables.

    #. Private class variables MAY be written using _mixedCase (with preceding underscore):
        
        .. javascript::
        
            var MyClass = function(){
                var _buffer;
                this.doSomething = function(){}
            }
            
    #. Variables that are intended to be private, but are not closure bound, SHOULD be prepended with a ``_`` (underscore) char:
    
        .. javascript::
        
            this._somePrivateVariable = statement;
       
       `note:` the above variables also follows the convention for a private variable

    #. Generic variables SHOULD have the same name as their type: ``setTopic(topic) // where topic is of type Topic``

    #. All names SHOULD be written in English.

    #. Variables with a large scope SHOULD have globally unambiguous names; ambiguity MAY be  distinguished by module membership. Variables with small or private scope MAY have terse names.

    #. The name of the return object is implicit, and SHOULD be avoided in a method name: 
    
        .. javascript:
        
            getHandler(); // NOT getEventHandler()``

    #. Public names SHOULD be as clear as necessary and SHOULD avoid unclear shortenings and contractions: 
    
        .. javascript::
        
            MouseEventHandler // not MseEvtHdlr

    #. Note that, again, any context that can be determined by module membership SHOULD be used when determining if a variable name is clear. For example, a class that represents a mouse event handler:
        
        .. javascript::
            
            dojo.event.mouse.Handler; // NOT dojo.events.mouse.MouseEventhandler
        
    #. Classes/constructors MAY be named based on their inheritance pattern, with the base class to the right of the name:
        
        .. javascript::
        
            UiEventHandler
            MouseEventHandler
        
    #. The base class CAN be dropped from a name if it is obviously implicit in the name:

        .. javascript::
        
            MouseEventHandler; // as opposed to MouseUIEventHandler
        
    #. Functions that act as both getters and setters depending on the number of arguments  are named after nouns.  The 'get' and 'set' are implied.   For example:

        .. javascript::
            
            dojo.attr(node, "tabIndex"); // getter
            dojo.attr(node, "tabIndex", -1); // setter
    

Specific Naming Conventions
---------------------------

    #. The terms get/set SHOULD NOT used where a field is accessed, unless the variable being accessed is lexically private.

    #. The ``is`` prefix SHOULD be used for boolean variables and methods. Alternatives include ``has`` ``can`` and ``should``

    #. The term ``compute`` CAN be used in methods where something is computed.

    #. The term ``find`` CAN be used in methods where something is looked up.

    #. The terms ``initialize`` or ``init`` CAN be used where an object or a concept is established.

    #. UI Control variables SHOULD be suffixed by the control type. Examples: 
        
        ``leftComboBox, topScrollPane``
    
    #. Plural form MUST be used to name collections.

    #. A ``num`` prefix or ``count`` postfix SHOULD be used for variables representing a number of objects.
        
    #. Iterator variables SHOULD be called ``i``, ``j``, ``k``, etc.
    
    #. Complement names MUST be used for complement entities. Examples: get/set, add/remove, create/destroy, start/stop, insert/delete, begin/end, etc.
    
    #. Abbreviations in names SHOULD be avoided.
    
    #. Negated boolean variable names MUST be avoided: ``isNotError`` and ``isNotFound`` are unacceptable.

    # Methods returning an object MAY be named after what they return, and methods returning void after what they do.

Files
-----
 
    #. Class or object-per-file guidelines are not yet determined
    
    #. Tabs (set to 4 spaces) SHOULD be used for indentation.
    
    #. If your editor supports "file tags", please append the appropriate tag at the end of the file to enable others to effortlessly obey the correct indentation guidelines for that file:
        
        ``// vim:ts=4:noet:tw=0:``

    #. The incompleteness of a split line MUST be made obvious
    
        .. javascript::
        
            var someExpression = Expression1
                + Expression2
                + Expression3
            ;
            
            var o = someObject.get(
                Expression1,
                Expression2, 
                Expression3
            );
            
        Note the indentation for expression continuation is indented relative to the variable name, while indentation for parameters is relative to the method being called.
            
        Note also the position of the parenthesis in the method call; positioning SHOULD be similar to the use of block notation.


Variables
---------

    #. Variables SHOULD be initialized where they are declared and they SHOULD be declared in the smallest scope possible. A null initialization is acceptable.
    
    #. Variables MUST never have a dual meaning.
    
    #. Related variables of the same type CAN be declared in a common statement; unrelated variables SHOULD NOT be declared in the same statement.
    
    #. Variables SHOULD be kept alive for as short a time as possible.
    
    #. Loops / iterative declarations
        
        #. Only loop control statements MUST be included in the ``for`` loop construction.
        
        #. Loop variables SHOULD be initialized immediately before the loop; loop variables in a ``for`` statement MAY be initialized in the ``for`` loop construction.
        
        #. The use of ``do...while`` loops is acceptable (unlike in Java).
        
        # The use of ``break`` and ``continue`` is not discouraged (unlike in Java).

    #. Conditionals
        
        #. Complex conditional expressions SHOULD be avoided; use temporary boolean variables instead.
        
        #. The nominal case SHOULD be put in the ``if`` part and the exception in the ``else`` part of an ``if`` statement.
        
        #. Executable statements in conditionals MUST be avoided.

    #. Miscellaneous
    
        #. The use of magic numbers in the code SHOULD be avoided; they SHOULD be declared using named ``constants`` instead.
        
        #. Floating point constants SHOULD ALWAYS be written with decimal point and at least one decimal.
        
        #. Floating point constants SHOULD ALWAYS be written with a digit before the decimal point.
        
Layout
------        

    #. Block statements.
    
        #. Block layout SHOULD BE as illustrated below:
        
            .. javascript::
            
                while(!isDone){
                    doSomething();
                    isDone = moreToDo();
                }
                
        #. ``if`` statements SHOULD have the following form:
        
            .. javascript::
            
                if(someCondition){
                    statements;
                }else if(someOtherContion){
                    statements;
                }else{
                    statements;
                }

        #. ``for`` statements SHOULD have the following form:
        
            .. javascript::
            
                for(init; condition; update){
                    statements;
                }
                
        #. ``while`` statements SHOULD have the following form:
        
            .. javascript::
            
                while(!isDone){
                    doSomething();
                    isDone = moreToDo();
                }
                
        #. ``do...while`` statements SHOULD have the following form:
        
            .. javascript::
            
                do{
                    statements;
                }while(condition);
         
         #. ``switch`` statements SHOULD have the following form:
         
            .. javascript::
            
                switch(condition){
                    case "ABC":
                        statement;
                        // fallthrough
                    case "DEF":
                        statements;
                        break;
                    defaults:
                        statements;
                        // no break keyword on the last case - it's redundant.
                }
                
        #. ``try...catch...finally`` statements SHOULD have the following form:
        
            .. javascript::
            
                try{
                    statements;
                }catch(e){
                    statements;
                }finally{
                    statements;
                }
                
        #. A single statement if-else, while or for MUST NOT be written without brackets, but CAN be written on the same line:
        
            .. javascript::
            
                if(condition){ statement; }
                else{ statement; }
                
                while(condition){ statement; }
                
                for(init; condition; update){ statement; }
                
    #. Whitespace
    
        #. Conventional operators MAY be surrounded by a space (including ternary operators).
    
        #. The following reserved words SHOULD NOT be followed by a space:

            * break
            * catch 
            * continue
            * do
            * else
            * finally
            * for
            * function if anonymous. eg: ``var foo = function(){};``
            * if
            * return 
            * switch
            * this
            * try
            * void
            * while
            * with
            
        #. The following reserved words SHOULD be followed by a space:
            
            * case
            * default
            * delete
            * function if named. eg: ``function foo(){})``
            * in
            * instanceof
            * new
            * throw
            * typeof
            * var
            
        #. Commas SHOULD be followed by a space.

        #. Colons MAY be surrounded by a space.

        #. Semi-colons in for statements SHOULD be followed by a space.

        #. Semi-colons SHOULD NOT be preceded by a space.

        #. Function calls and method calls SHOULD NOT be followed by a space. 
        
            .. javascript::
            
                doSomething(someParameter); // not doSomething (someParameter); 
        
        #. Logical units within a block SHOULD be separated by one blank line.

        #. Statements MAY be aligned wherever this enhances readability.

    #. Line length
    
        There's no line length limit in dojo although 120 characters (treating tabs as 4 spaces) is a 
        guideline. In particular code examples embedded into the API documentation may benefit from 
        longer lines, since they start out already indented by 4 or 5 tabs.
        
    #. Comments
    
        #. Tricky code SHOULD not be commented, but rewritten.
        #. All comments SHOULD be written in English.
        #. Comments SHOULD be indented relative to their position in the code, preceding or to the right of the code in question.
            
        #. The declaration of collection variables SHOULD be followed by a comment stating the common type of the elements in the collection.
            
        #. Comments SHOULD be included to explain BLOCKS of code, to explain the point of the following block.
        
        #. Comments SHOULD NOT be included for every single line of code.
 
Documentation
-------------
 
Markup Guidelines
~~~~~~~~~~~~~~~~~

Dojo's API documentation is written inline in the code, similar to JavaDoc.  See the `Dojo Inline Documentation <util/doctools/markup>`_ for information on dojo's proprietary format.

CSS
~~~

The CSS styling basically inherits all the rules from JavaScript, that means "key: value" looks like in JS, etc. Therefore a CSS file might look like this:

.. code-block :: html

   .className1 {
        color: red;
   }
   
   .className1, 
   #someId {
        color: blue; 
   }

Mainly the rules are:

  * each selector is on a new line
  * the opening curly brace is preceded by a space
  * the key value pairs have a space after the colon
  * every block is followed by an empty new line 
