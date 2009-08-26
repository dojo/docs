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

.. code-block :: html
  :linenos:

  .. cv-compound::

    Some very simple CSS to make things look fancy

    .. cv:: css
      :label: The CSS

      <style type="text/css">
        .fancy { 
          font-family: Arial; padding: 10px; color: orange; 
          font-size: 12px; font-weight: bold; 
        }
      </style>

    Two nodes is all we need

    .. cv:: html
      :label: Very basic HTML

      <p class="fancy">Hi reader, click me</p>

    Very simple JavaScript using Dojos query selector

    .. cv:: javascript
      :label: dojo.query in action

      <script type="text/javascript">
      dojo.addOnLoad(function(){
        var i=0;
        dojo.query(".fancy").onclick(function(e){
          dojo.attr(e.target, "innerHTML", "You clicked me "+(++i)+" times.");
        });
      });
      </script>

This will result in the following 

.. cv-compound::

  Some very simple CSS to make things look fancy

  .. cv:: css
    :label: The CSS

    <style type="text/css">
      .fancy { 
        font-family: Arial; padding: 10px; color: orange; 
        font-size: 12px; font-weight: bold; 
      }
    </style>

  Two nodes is all we need

  .. cv:: html
    :label: Very basic HTML

    <p class="fancy">Hi reader, click me</p>

  Very simple JavaScript using Dojos query selector

  .. cv:: javascript
    :label: dojo.query in action

    <script type="text/javascript">
    dojo.addOnLoad(function(){
      var i=0;
      dojo.query(".fancy").onclick(function(e){
        dojo.attr(e.target, "innerHTML", "You clicked me "+(++i)+" times.");
      });
    });
    </script>

A few important notes:

Right indenting
---------------

You need to make sure you always use correct indenting. As you see in the example above, after the .. cv-compund ::, everything is indented by exactly 2 extra spaces. If you don't follow that standard you will see scary error messages, and who wants that, really ;)

Codeblock header and descriptions
---------------------------------

Each of the codeblocks (JS/HTML/CSS) can have its own dedicated header and description.
You can add a header to a block by adding the :label: block to your code as follows:

.. code-block :: html
  :linenos:

  .. cv:: javascript
    :label: And the JavaScript code

This will result in a header in the JavaScript codeblock.
To add a descriptive text to a codeblock you can simply add reST markup before the block definition with the same amount of spaces indented as the block directive:

.. code-block :: html
  :linenos:

  This will be the descriptive text for the JavaScript block.
  * You can even use reST syntax here
  * Its pretty cool

  .. cv:: javascript
    :label: And the JavaScript code

Keep the header and description simple though, they should only explain shortly what is happening in the codeblock.

Custom parameters within the code
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Since CodeGlass (this is the name of the Dojo widget creating the demos) is very flexible and is allowing you to change the Dojo version and the themes on the fly you might want to be able to use dynamic variables in your code example as well.
Imagine you are including a few CSS files from a dojox widget and you need to be sure that the example also works with other versions of Dojo from other locations. Simply doing an absolute reference to the document won't work.
To fix this, at this moment you can use following parameters within the template and they change accordingly:

+---------------+
|   Parameter   |
+---------------+
| {{ baseUrl }} |
+---------------+

An example if this in action (simply change the version and you will see what it does)

.. cv-compound::

  This is a demo of the dynamic variables you can use in CodeGlass
    
  .. cv:: html
    :label: This is the HTML of the example

    <p>Current Dojo baseUrl: <strong>{{ baseUrl }}</strong></p>


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
