#format dojo_rst

How to become a dojo doc ninja
==============================

:Status: Draft
:Version: 1.2

.. contents::
  :depth: 3

.. image:: dojodocninja.png
   :alt: Dojo Doc ninja
   :class: imageFloatRight;

Joining the Dojo doc team is easy, all you need to do is write and get familiar with a few basics you will master fast.

======================
Dojo Doc Syntax (reST)
======================

Dojo doc uses the reST syntax to describe all docs, we have implemented a few features of the great reST Sphinx extension and implemented dojo-specific ones to provide cool stuff like inline code demos (Yah, you won't believe it, but your code will just work).

`Visit the official reST Quick reference <http://docutils.sourceforge.net/docs/user/rst/quickref.html>`_.

Please note the following topics

Header
------

Every doc document has to start with following first line::

  #format dojo_rst

Then should follow the document header (<h1>) for instance::

  dojo.module
  ===========

As a last standard item you should insert version info::

  :Status: Draft|Contributed
  :Version: targeted Dojo version
  :Author: Optional module author

And we should also include a TOC if our page is getting long::

  .. contents::
    :depth: 3

Sections
--------

Each new section (<h2>) should marked with::

  ===========
  Sectionname
  ===========

Subsections (<h3>) should marked with::

  Subsection
  ----------

The syntax for Subsubsections (<h4>) is::

  Subsubsection
  ~~~~~~~~~~~~~


=====
Links
=====

If you want to link to wiki internal pages use following syntax::

  `Your text <path/to/wiki/page>`_

Will create following link: `Your text <path/to/wiki/page>`_

When you want to use the same link location twice you would do it like this::

  My `link`_ is very cool and is my `link`_

  .. _link: my/link

The result will be:

My `link`_ is very cool and is my `link`_

.. _link: my/link

The good thing about this way of defining links is that you won't have to look in the content of your text and find all occurrences of a link you might want to change. This way all your links are stored in one convenient location and if you need to change them you know where to look.

Note from a contributor:  The character used is the grave accent (on the key with the ~ on the left of the keyboard).  Others may find that obvious but I was very confused trying to figure out why my links wouldn't work and it was because I was using the apostrophe character (on the key with the ").

=============
Code examples
=============

Non executed code
-----------------

If you need to give a simple source code example without it being executed use the ".. code-block ::" directive and put the code right into the next line indented by two spaces. If you want to display line numbers, use the "linenos" attribute.

  .. code-block :: javascript
    :linenos:

    .. code-block :: javascript
      :linenos:

      <script type="text/javascript">alert("Your code");</script>

Executed code
-------------

You can add a real example to the documentation by using the ".. cv-compound::" and ".. cv::" directives. The code you show can include JavaScript, CSS and HTML

.. code-block :: javascript
  :linenos:

  .. cv-compound:

    First we declare the CSS

    .. cv:: css
      :label: The CSS

      <style type="text/css">
      body {
        font-family: Arial;
        margin: 10px;
      }
      .fohooo { 
        color: #15d32a; 
        font-size: 16px; 
      }
      </style>

    The HTML snippet simply defines the markup of your code. Dojo will then parse the DOM nodes and create the widgets programatically. 
    
      * Programmatic code generation
      * Dom manipulation

    .. cv:: html
      :label: This is the HTML of the example

      <div id="fohooo" class="fohooo">I'm just a node</div>
      <div id="fohooooooo" class="fohooo">Don't click Me</div>
      <div dojoType="foohooo" class="fohooo">Or Me</div>

    This is the JavaScript code of your example. Simply paste both HMTL and JavaScript into the browser.

    .. cv:: javascript
      :label: And the JavaScript code

      <script type="text/javascript">
      dojo.require("dijit._Templated");
      dojo.require("dijit._Widget");

      dojo.addOnLoad(function(){
        dojo.declare("foohooo", [dijit._Widget,dijit._Templated], {
           templateString: '<div dojoAttachEvent="onclick: _foo">Example: <span dojoAttachPoint="containerNode"></span></div>',
           _foo: function(){
              alert("foo");
           } 
        });
        var widget = new foohooo({id: "test_foohooo"}, dojo.byId("fohooo"));
      });
      </script>

This will result in the following 

.. cv-compound:

  First we declare the CSS

  .. cv:: css
    :label: The CSS

    <style type="text/css">
    body {
      font-family: Arial;
      margin: 10px;
    }
    .fohooo { 
      color: #15d32a; 
      font-size: 16px; 
    }
    </style>

  The HTML snippet simply defines the markup of your code. Dojo will then parse the DOM nodes and create the widgets programatically. 
    
    * Programmatic code generation
    * Dom manipulation

  .. cv:: html
    :label: This is the HTML of the example

    <div id="fohooo" class="fohooo">I'm just a node</div>
    <div id="fohooooooo" class="fohooo">Don't click Me</div>
    <div dojoType="foohooo" class="fohooo">Or Me</div>

  This is the JavaScript code of your example. Simply paste both HMTL and JavaScript into the browser.

  .. cv:: javascript
    :label: And the JavaScript code

    <script type="text/javascript">
    dojo.require("dijit._Templated");
    dojo.require("dijit._Widget");

    dojo.addOnLoad(function(){
      dojo.declare("foohooo", [dijit._Widget,dijit._Templated], {
         templateString: '<div dojoAttachEvent="onclick: _foo">Example: <span dojoAttachPoint="containerNode"></span></div>',
         _foo: function(){
            alert("foo");
         } 
      });
      var widget = new foohooo({id: "test_foohooo"}, dojo.byId("fohooo"));
    });
    </script>


The valid reST syntax has to look like following markup:


.. code-block :: html
  :linenos:

  .. cv-compound::

    First we declare the CSS

    .. cv:: css
      :label: The CSS
      
       <style type="text/css">
       </style>

    The HTML snippet simply defines the markup of your code. Dojo will then parse the DOM nodes and create the widgets programatically. 
    
      * Programmatic code generation
      * Dom manipulation

    .. cv:: html
      :label: This is the HTML of the example

      <div id="fohooo" class="fohooo">Click Me</div>
      <div id="fohooooooo" class="fohooo">Don't click Me</div>
      <div dojoType="foohooo" class="fohooo">Or Me</div>

    This is the JavaScript code of your example. Simply paste both HMTL and JavaScript into the browser.

    .. cv:: javascript
      :label: And the JavaScript code

      <script type="text/javascript">
      dojo.declare("foohooo", [dijit._Widget,dijit._Templated], {
         templateString: '<div dojoAttachEvent="onclick: _foo">Example: <span dojoAttachPoint="containerNode"></span></div>',
         _foo: function(){
            alert("foo");
         }
      });
      dojo.addOnLoad(function(){
        var widget = new foohooo({id: "test_foohooo"}, dojo.byId("fohooo"));
      });
      </script>

======
Images
======

To attach images, use the AttachFile option you have at the bottom of each page. Once your image is uploaded you can include it on you page using following syntax::

  .. image:: yourimage.gif


===============================
Tips and Tricks, the edge cases
===============================

Many times you will encounter some question on a forum or the #dojo channel and you just want to keep a note about it with the respective answer. Those cases should be put into subpages suffixed with ``-tricks``. 
So, if someone posts something interesting to know about the dijit.Dialog, and you just want to note this for other people, post it in the dijit/Dialog-tricks page. If such a page doesn't exist, feel free to create one.


===============
Url conventions
===============

when you find an undocumented dojo module, use the dojo namespace as the guide::

  dojo.declare

should become::

  dojo/declare

Or::

  dijit.Tree

should become::

  dijit/Tree

So be aware of case-sensitivity. 

Url conventions outside the namespace
-------------------------------------

For any other part of the documentation we use lowerCamelCase::

  quickstart/dataPaging
