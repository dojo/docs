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

`Visit the official reST Quick reference <http://docutils.sourceforge.net/docs/user/rst/quickref.html#hyperlink-targets>`_.

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
  :Author: Optional mdule author

Code examples
-------------

Non executed code
~~~~~~~~~~~~~~~~~

If you need to give a simple source code example without it being executed use the ".. code-block ::" directive and put the code right into the next line inlined by two spaces. If you want to display line numbers, use the "linnos" attribute.

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
