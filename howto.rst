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

You can add a real example to the documentation by using the ".. cv-compound::" and ".. cv::" directives. The code you show can include JavaScript, CSS and HTML. Lets look at an example it action:

.. code-example::

  Some very simple CSS to make things look fancy

  .. css::
    :label: The CSS

    <style type="text/css">
      body { margin: 0; padding: 0; height: auto; }
      .fancy { 
        font-family: Arial; padding: 10px; color: orange; 
        font-size: 12px; font-weight: bold; 
      }
    </style>

  Two nodes is all we need

  .. html::
    :label: Very basic HTML

    <p class="fancy">Hi reader, click me</p>

  Very simple JavaScript using Dojos query selector

  .. javascript::
    :label: dojo.query in action

    <script type="text/javascript">
    dojo.addOnLoad(function(){
      var i=0;
      dojo.query(".fancy").onclick(function(e){
        dojo.attr(e.target, "innerHTML", "You clicked me "+(++i)+" times.");
      });
    });
    </script>

All you need to do is, to define the codeblocks for the JS/HTML and CSS parts you would like to use. 
You can leave things out, so having a simple JavaScript example could just include the .. cv:: javascript directive. 
Following code is the representation of the demo you saw above:

.. code-block :: html
  :linenos:

  .. code-example::

    Some very simple CSS to make things look fancy

    .. css::
      :label: The CSS

      <style type="text/css">
        body { margin: 0; padding: 0; height: auto; }
        .fancy { 
          font-family: Arial; padding: 10px; color: orange; 
          font-size: 12px; font-weight: bold; 
        }
      </style>

    Two nodes is all we need

    .. html::
      :label: Very basic HTML

      <p class="fancy">Hi reader, click me</p>

    Very simple JavaScript using Dojos query selector

    .. javascript::
      :label: dojo.query in action

      <script type="text/javascript">
      dojo.addOnLoad(function(){
        var i=0;
        dojo.query(".fancy").onclick(function(e){
          dojo.attr(e.target, "innerHTML", "You clicked me "+(++i)+" times.");
        });
      });
      </script>

Nice, isn't it?

Inline/Dialog view
------------------

The same CodeGlass can be instantiated inline and in a modal dialog. Just add :type: inline/dialog to determine what type you would like to use

.. code-block :: html
  :linenos:

  .. code-example::
    :type: inline

Other parameters
----------------

Besides that you can pass following parameters to the cv-compound directive

+---------------------------------------+------------------------------------+-----------------------------------------------+
|   Parameter                           | Example                            | Description                                   |
+=======================================+====================================+===============================================+
| `:djConfig:` key: value, key: value   | `:djConfig:` parseOnLoad: true     | You can pass extra djConfig parameters here   |
+---------------------------------------+------------------------------------+-----------------------------------------------+
| `:width:` num                         | `:width:` 750                      | The width of the opened CodeGlass             |
+---------------------------------------+------------------------------------+-----------------------------------------------+
| `:height:` num                        | `:height:` 500                     | The height of the opened CodeGlass            |
+---------------------------------------+------------------------------------+-----------------------------------------------+
| `:version:` start-?end                | `:version:` 1.3                    | The version supported by the example          |
|                                       | `:version:` 1.3-2.0                |                                               |
+---------------------------------------+------------------------------------+-----------------------------------------------+
| `:toolbar:` value, value              | `:toolbar:` versions, themes       | The toolbars to show. If not provided, all    |
|                                       | `:toolbar:` none                   | are shown. Possible values are: themes,       |
|                                       | `:toolbar:` a11y, i18n, dir        | versions, dir, a11y, i18n and none            |
+---------------------------------------+------------------------------------+-----------------------------------------------+

Lets look at an example using the inline style and extra parameters in use:

.. code-example::
  :djConfig: parseOnLoad: true
  :width: 680
  :height: 450
  :type: inline
  :version: 1.3-2.0
  :toolbar: none

  .. javascript::
    :label: The dojo requires

    <script type="text/javascript">
      dojo.require("dijit.layout.ContentPane");
      dojo.require("dijit.layout.BorderContainer");
      dojo.require("dijit.layout.TabContainer");
      dojo.require("dijit.layout.AccordionContainer");
    </script>

  The markup has to look as follows
  
  .. html::
    :label: The markup

    <div dojoType="dijit.layout.BorderContainer" gutters="true" id="borderContainerTwo" >
      <div dojoType="dijit.layout.ContentPane" region="top" splitter="false">
        Hi, usually here you would have important information, maybe your company logo, or functions you need to access all the time..  
      </div>	
      <div dojoType="dijit.layout.BorderContainer" liveSplitters="false" design="sidebar" region="center" id="mainSplit">
        <div dojoType="dijit.layout.AccordionContainer" minSize="20" style="width: 300px;" id="leftAccordion" region="leading" splitter="true">
          <div dojoType="dijit.layout.AccordionPane" title="One fancy Pane">
          </div>
          <div dojoType="dijit.layout.AccordionPane" title="Another one">
          </div>
          <div dojoType="dijit.layout.AccordionPane" title="Even more fancy" selected="true">
          </div>
          <div dojoType="dijit.layout.AccordionPane" title="Last, but not least">
          </div>
        </div><!-- end AccordionContainer -->
        <div dojoType="dijit.layout.TabContainer" region="center" tabStrip="true">
          <div dojoType="dijit.layout.ContentPane" title="My first tab" selected="true">
            Lorem ipsum and all around...
          </div>
          <div dojoType="dijit.layout.ContentPane" title="My second tab">
            Lorem ipsum and all around - second...
          </div>
          <div dojoType="dijit.layout.ContentPane" title="My last tab" closable="true">
            Lorem ipsum and all around - last...
          </div>
        </div>
      </div>
    </div>

  .. css::
    :label: A few simple css rules

    <style type="text/css">
      body, html {
        width: 100%;
        height: 100%;
        margin: 0;
      }

      #borderContainerTwo {
        width: 100%;
        height: 100%;
      }
    </style>

The extra parameters we defined where

.. code-block :: html
  :linenos:

  .. code-example::
    :djConfig: parseOnLoad: true
    :width: 680
    :height: 450
    :type: inline
    :version: 1.3-2.0

A few important notes:

Codeblock type definitions
--------------------------

When you add a block for JavaScript code, you need to make sure that you include the actual JavaScript tag within the example.
If you forget, the code won't execute.
The same accounts for CSS, so you either have to include the style or the link tag.
Everything within an HTML block will by just appended to the document body.

Right indenting
---------------

You need to make sure you always use correct indenting. As you see in the example above, after the .. cv-compund ::, everything is indented by exactly 2 extra spaces. If you don't follow that standard you will see scary error messages, and who wants that, really ;)

Codeblock header and descriptions
---------------------------------

Each of the codeblocks (JS/HTML/CSS) can have its own dedicated header and description.
You can add a header to a block by adding the :label: block to your code as follows:

.. code-block :: html
  :linenos:

  .. javascript::
    :label: And the JavaScript code

This will result in a header in the JavaScript codeblock.
To add a descriptive text to a codeblock you can simply add reST markup before the block definition with the same amount of spaces indented as the block directive:

.. code-block :: html
  :linenos:

  This will be the descriptive text for the JavaScript block.
  * You can even use reST syntax here
  * Its pretty cool

  .. javascript::
    :label: And the JavaScript code

Keep the header and description simple though, they should only explain shortly what is happening in the codeblock.

Custom parameters within the code
---------------------------------

Since CodeGlass (this is the name of the Dojo widget creating the demos) is very flexible and is allowing you to change the Dojo version and the themes on the fly you might want to be able to use dynamic variables in your code example as well.
Imagine you are including a few CSS files from a dojox widget and you need to be sure that the example also works with other versions of Dojo from other locations. Simply doing an absolute reference to the document won't work.
To fix this, at this moment you can use following parameters within the template and they change accordingly:

+---------------+
|   Parameter   |
+===============+
| {{ baseUrl }} |
+---------------+
| {{ theme }}   |
+---------------+

An example if this in action (simply change the version and you will see what it does)

.. code-example::

  This is a demo of the dynamic variables you can use in CodeGlass
    
  .. html::
    :label: This is the HTML of the example

    <p>Current Dojo baseUrl: <strong>{{ baseUrl }}</strong></p>
    <p>Current Dojo theme: <strong>{{ theme }}</strong></p>

CodeGlass style
---------------

Make sure you always give a width and height which makes the examples look nice. Adjusting the width and height can result in wonders :)

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
