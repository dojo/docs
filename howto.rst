#format dojo_rst

How to become a dojo doc ninja
==============================


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

  `Your text<wiki:path/to/wiki/page`_

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
      
Craig's Questions
-----------------

- Should all form control examples also include a dijit.form.Form tag?
- What is the convention for attributes, methods, etc.?  These should be spelled out in the How-To or be given 
  their own tags
- Should we remove the remaining refs to 0.9 (like dijit.form.I nlineEdit?)
- NumberSpinner page has an example of code examples getting mushed together.  Solution?
- Is there a way to display REAL help underneath the editor box?  The help that sometimes appears doesn't
  actually work.
- There doesn't seem to be a way to link outside of the directory and its children.  /path/to/file doesn't work, and
  though you can use ../.. the rules for how many to include don't seem to apply
- As a general rule, do we want to factor out common concepts (like Containers, which are explained on the new
  TabContainer page) and refer back to them?  Or explain them on each widget page?  Does it depend on the widget
  and what concepts are most central to the widget?
