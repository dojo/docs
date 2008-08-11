#format dojo_rst

How to become a dojo doc ninja
==============================

:Status: Draft
:Version: 1.2

.. image:: http://media.dojocampus.org/images/docs/dojodocninja.png
   :alt: Dojo Doc ninja
   :class: imageFloatRight;

Joining the Dojo doc team is easy, all you need to do is write and get familiar with a few basics you will master fast.

Dojo Doc Syntax (reST)
----------------------

Dojo doc uses the reST syntax to describe all docs, we have implemented a few features of the great reST Sphinx extension and implemented dojo specific ones to provide cool stuff like inline code demos (Yah, you won't believe it, but your code will just work)

`Visit the official reST Quick reference <http://docutils.sourceforge.net/docs/user/rst/quickref.html>`_.

Please note the following topics

Header
~~~~~~

Every doc document has to start with following first line::

  #format dojo_rst

Then should follow the document header for instance::

  dojo.module
  ===========

As a last standard item you should insert version info::

  :Status: Draft|Contributed
  :Version: targeted Dojo version
  :Author: Optional module author

Links
-----

If you want to link to wiki internal pages use following syntax::

  `Your text <path/to/wiki/page>`_

Will create following link: `Your text <path/to/wiki/page>`_

When you want to use the same link location twice you would do it like this::

  My `link`_ is very cool and is my `link`_

  .. _link: my/link

The result will be:

My `link`_ is very cool and is my `link`_

.. _link: my/link

The good thing about this way of defining links is that you won't have to look in the content of your text and find all occurences of a link you might want to change. This way all your links are stored in one convenient location and if you need to change them you know where to look.

Code examples
-------------

Non executed code
~~~~~~~~~~~~~~~~~

If you need to give a simple source code example without it being executed use the ".. code-block ::" directive and put the code right into the next line inlined by two spaces. If you want to display line numbers, use the "linenos" attribute.

  .. code-block :: javascript
    :linenos:

    .. code-block :: javascript
      :linenos:

      <script type="text/javascript">alert("Your code");</script>

Executed code
~~~~~~~~~~~~~

You can add a real example to the documentation by using the ".. codeviewer::" directive. The code you show can include JavaScript, CSS and HTML

  .. code-block :: javascript
    :linenos:

    .. codeviewer::

    <script type="text/javascript">dojo.require("dijit.form.Button");</script>
    <div class="nihilo">
       <div dojoType="dijit.form.Button">whatever</div>
    </div>

This will result in the following 


.. codeviewer::

  <script type="text/javascript">dojo.require("dijit.form.Button");</script>
  <div class="nihilo">
     <div dojoType="dijit.form.Button">whatever</div>
  </div>

Executed code compounds
~~~~~~~~~~~~~~~~~~~~~~~

Sometimes your examples need separation between CSS, JavaScript and HTML. Use the ".. cv-compound::" directive for that. Each compound can include several ".. code-viewer::" directives

.. cv-compound:b:

  First we declare the CSS

  .. cv:: css
    :label: The CSS

    <style type="text/css">
    .fohooo { color: #15d32a; font-size: 16px; }
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

Tips and Tricks, the edge cases
-------------------------------

Many times you will encounter some question on a forum or the #dojo channell and you just want to keep a note about it with the respective answer. Those cases should be put into sub pages -tricks. 
So if someone posts something interesting to know about the dijit.Dialog and you just want to note this for other people post it in the dijit/Dialog-tricks page. If such a page doesn't exist, feel free to create one
      
Craig's Questions
-----------------

- Should all form control examples also include a dijit.form.Form tag?
  *nikolai: I think its a good habbit to dojoize forms as much as you can, to get the full benefit of using them, but I am not sure whether this is the way to go*
- What is the convention for attributes, methods, etc.?  These should be spelled out in the How-To or be given 
  their own tags
  *nikolai: how do you mean?*
- Should we remove the remaining refs to 0.9 (like dijit.form.I nlineEdit?)
  * probably for now we should only document what will be in 1.2, for old docs people would have to look up the book and other resources*
- NumberSpinner page has an example of code examples getting mushed together.  Solution?
  * I fixed that, was a little } missing :) reST is very sensitive in regards to indenting, code, etc.
- Is there a way to display REAL help underneath the editor box?  The help that sometimes appears doesn't
  actually work.
  * underneath the wiki editor? yah, will look into that :) I agree, its rather confusing*
- There doesn't seem to be a way to link outside of the directory and its children.  /path/to/file doesn't work, and
  though you can use ../.. the rules for how many to include don't seem to apply
  * its fixed now, just use absolute linking without a first / - so when you are in dijit and want to link to dojox you just do `text <dojox/foo>`_ also see the `howto <howto>`_ I sortof updated the docs
- As a general rule, do we want to factor out common concepts (like Containers, which are explained on the new
  TabContainer page) and refer back to them?  Or explain them on each widget page?  Does it depend on the widget
  and what concepts are most central to the widget?
  * I'd think we should factor them out and and explain about those concepts on delegated pages, again not sure if this is the way to go though*
