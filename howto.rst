#format dojo_rst

How to become a dojo doc ninja
==============================


.. image:: http://media.dojocampus.org/images/docs/dojodocninja.png
   :alt: Dojo Doc ninja
   :class: dojoDocNinja

Joining the Dojo doc team is easy, all you need to do is write and get familiar with a few basics you will master fast.

1. Dojo Doc Syntax (reST)

Dojo doc uses the reST syntac to describe all docs, we have implemented a few features of the great reST Sphinx extension to provide cool stuff like inline code demos (Yah, you won't believe it, but your code will just work)

2. Versioning

All you need to to is make sure you target a specific dojo version and note that at the top of the page. This project only aims to cover the latest version of Dojo

3. Fame

Writing docs is a lot of work and we all deserve a little portion of dojo fame. Make sure you create your own page in the Wiki with links to your personal blog, website, twitter or other sites

Documentation basics
--------------------

1. Every doc should start with a header, e.g. the dojo module you are documenting.
2. All docs have to have code examples, what use does a doc have if you can't see examples? ;)
3. Write

Code examples
-------------

1. Non executed code
If you need to give a simple source code example without it being executed use the ".. code-block ::" directive and put the code right into the next line inlined by two spaces. If you want to display line numbers, use the "linnos" attribute.

  .. code-block :: javascript
    :linenos:

    .. code-block :: javascript
      :linenos:

      <script type="text/javascript">alert("Your code");</script>

2. Executed code
You can add real example to the documentation by using the ".. codeviewer::" directive. The code you show can include Javascript, CSS and HTML

  .. code-block :: javascript
    :linenos:

    .. codeviewer::

    <script type="text/javascript">dojo.require("dijit.form.Button");</script>
    <div class="nihilo">
       <div dojoType="dijit.form.Button">whatever</div>
    </div>

This will result in following 


.. codeviewer::

  <script type="text/javascript">dojo.require("dijit.form.Button");</script>
  <div class="nihilo">
     <div dojoType="dijit.form.Button">whatever</div>
  </div>

3. Executed code compounds
Sometimes your examples need separation between CSS, JavaScript and HTML. Use the ".. cw-compound::" directive for that. Each compund can include several ".. code-viewer::" directives

  .. code-block :: javascript
    :linenos:

  .. cv-compound::

    First we declare the CSS

    .. cv:: css
      :label: The CSS

      <style type="text/css">
      .fohooo { color: #15d32a; font-size: 16px; }
      </style>

    The html snippet simply defines the markup of your code. Dojo will then parse the dom nodes and create the widgets programatically. Usually the lifecycle goes as follows
    
      * Programmatic code generation
      * Dom manipulation

    .. cv:: html
      :label: This is the HTML of the example

      <div id="fohooo" class="fohooo">Click Me</div>
      <div id="fohooooooo" class="fohooo">Don't click Me</div>
      <div dojoType="foohooo" class="fohooo">Or Me</div>

    This is the jscript code of your example. Simple past both HMTL and Jscript into the browser.

    .. cv:: javascript
      :label: And the jscript code

      <script type="text/javascript">
      dojo.declare("foohooo", [dijit._Widget,dijit._Templated], {
         templateString: '<div dojoAttachEvent="onclick: _foo">Example: <span dojoAttachPoint="containerNode"></span></div>',
         _foo: function(){
            alert("foo");
         }
      });
      dojo.addOnLoad(function(){
        var widget = new foohoo({id: "test_foohooo"}, dojo.byId("fohooo"));
      });
      </script>

This will result in following structure

.. cv-compound::

  First we declare the CSS

  .. cv:: css
    :label: The CSS

    <style type="text/css">
    .fohooo { color: #15d32a; font-size: 16px; }
    </style>

  The html snippet simply defines the markup of your code. Dojo will then parse the dom nodes and create the widgets programatically. Usually the lifecycle goes as follows
    
    * Programmatic code generation
    * Dom manipulation

  .. cv:: html
    :label: This is the HTML of the example

    <div id="fohooo" class="fohooo">Click Me</div>
    <div id="fohooooooo" class="fohooo">Don't click Me</div>
    <div dojoType="foohooo" class="fohooo">Or Me</div>

  This is the jscript code of your example. Simple past both HMTL and Jscript into the browser.

  .. cv:: javascript
    :label: And the jscript code

    <script type="text/javascript">
    dojo.declare("foohooo", [dijit._Widget,dijit._Templated], {
       templateString: '<div dojoAttachEvent="onclick: _foo">Example: <span dojoAttachPoint="containerNode"></span></div>',
       _foo: function(){
          alert("foo");
       }
    });
    dojo.addOnLoad(function(){
      var widget = new foohoo({id: "test_foohooo"}, dojo.byId("fohooo"));
    });
    </script>
