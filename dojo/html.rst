.. _dojo/html:

=========
dojo/html
=========

:Authors: Sam Foster, Nikolai Onken, Marcus Reimann
:Developers: Sam Foster, Alex Russell, Dylan Schiemann
:Since: V1.2

.. contents ::
    :depth: 2

**dojo/html** provides useful utilities for managing HTML.

Introduction
============

``dojo/html`` is a module that provides a single public function ``set()``.  It is used to safely and
conveniently replace an element's content, while providing some hooks and options for how the replacement
should be handled.  This is generally only applicable to "complex" replacement, (e.g. where the options parameters
are needed, or you are inserting a NodeList).  If you are just placing strings of HTML in a DOM node,
it is preferable to use :ref:`dojo/dom-construct::place() <dojo/dom-construct#place>`.

Also, while designed as a private class, the ``_ContentSetter()`` object is used in the toolkit for complex setting operations as well.  In the early days of Dojo, the ContentPane contained all this functionality directly, but it was moved as a separate module to make it easier to use by the rest of the toolkit.

Usage
=====

You can think of ``set()`` like the :ref:`dijit/layout/ContentPane <dijit/layout/ContentPane>`, but standalone.

.. js ::

  require(["dojo/html"], function(html){
    html.set(node, cont, params);
  });

``set()`` takes up to three arguments:

======== ======================= =======================================================================================
Argument Type                    Description
======== ======================= =======================================================================================
node     DomNode                 The node where the content should be set
cont     String|DomNode|NodeList The content that should be set, which can be a string a DOM node, a NodeList or any 
                                 other enumerable list of nodes.
params   Object?                 *Optional* a hash of options/flags that affect the behavior of the ``.set()``
======== ======================= =======================================================================================

The options that can be set in ``params`` are:

============== ======== ================================================================================================
Option         Type     Description
============== ======== ================================================================================================
cleanContent   Boolean  Should the content be treated be stripped of ``<!DOCTYPE>`` and other content that might be an 
                        issue. Defaults to ``false``.
extractContent Boolean  Should the content be treated as a full HTML document and the real content be stripped out of 
                        the ``<html>`` and ``<body>`` tags before injection.  Defaults to ``false``.
parseContent   Boolean  Should the content be passed to the ``dojo/parser`` before being set in order to instantiate 
                        any marked up Objects.  Defaults to ``false``.
parserScope    String   Passed to the parser to identify the "scope" of which to identify the marked up content.  Only 
                        useful when ``parseContent`` is ``true``.  Defaults to ``dojo/_base/kernel::_scopeName``.
startup        Boolean  Start the child widgets after parsing content.  Only effective when ``parseContent`` is 
                        ``true``.  Defaults to ``true``.
onBegin        Function Called right before the content is replaced.  *Note* there is a default implementation of 
                        ``onBegin`` and you should call ``this.inherited(arguments)`` in your custom function to ensure 
                        the default behaviors occur.
onEnd          Function Called right after the content is replaced.  *Note* there is a default implementation of 
                        ``onBegin`` and you should ``this.inherited(arguments)`` in your custom function to ensure the 
                        default behaviors occur.  If you need access to the parsed results of the content, they are 
                        available in ``this.parseResults``.
onContentError Function Called whenever there is an error replacing the content.
============== ======== ================================================================================================

Examples
========

.. code-example ::
  :djConfig: async:true

  This example does nothing more than what you could accomplish with ``dojo/dom-construct::place()`` or setting the 
  ``innerHTML`` of the node directly.

  .. js ::

    require(["dojo/html", "dojo/dom", "dojo/on", "dojo/domReady!"],
    function(html, dom, on){
      on(dom.byId("setContent"), "click", function(){
        html.set(dom.byId("content"), "I was set!");
      });
    });

  .. html ::

    <button type="button" id="setContent">Set Content</button>
    <div id="content">I haven't been replaced.</div>

.. code-example ::
  :djConfig: async: true

  This example does something slightly more complex, in that it uses the ``dojo/parser`` to parse the content.

  .. js ::

    require(["dojo/html", "dojo/dom", "dojo/on", "dijit/form/NumberTextBox", "dojo/domReady!"],
    function(html, dom, on){
      on(dom.byId("setContent"), "click", function(){
        html.set(dom.byId("content"), '<tbody>'
          + '<tr>'
            + '<td><label for="amt">How Much?</label></td>'
            + '<td><input type="text" id="amt" name="amt" data-dojo-type="dijit/form/NumberTextBox" value="0"'
              + ' data-dojo-props="constraints: { min: 0, max: 20, places: 0 },'
              + ' promptMessage: \'Enter a value between 0 and +20\','
              + ' required: true,'
              + ' invalidMessage: \'Wrong!\'" />'
            + '</td>'
          + '</tr></tbody>',
          {
            parseContent: true
          });
      });
    });

  .. html ::

    <button type="button" id="setContent">Set Content</button>
    <table id="content">
      <tbody>
        <tr>
          <td>Not Set Yet</td>
        </tr>
      </tbody>
    </table>

In the above example we are accomplishing a few things.  First some browsers object to setting the ``innerHTML`` on tables, ``dojo/html`` accommodates for that.  We are also parsing the marked-up content with the ``dojo/parser`` by setting ``parseContent`` to ``true``.

See also
========

* :ref:`dojo/dom-construct <dojo/dom-construct>` - A module used for creating and placing DOM nodes
