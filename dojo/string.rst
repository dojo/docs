.. _dojo/string:

===========
dojo/string
===========


.. contents ::
   :depth: 2

**dojo/string** is a module that provides some simple string manipulation utilities.

Usage
=====

.. js ::

  require(["dojo/string"], function(string){
    var a = string.pad("pad me", 10);
    var b = string.rep("dup", 10);
    var c = string.substitute("${replace} - ${me}", { replace: "foo", me: "bar" });
    var d = string.trim("  trim me  ");
  });

pad()
-----

Pad a string to guarantee that it is at least ``size`` length by filling with the character ``ch`` at either the start
or end of the string. Pads at the start, by default.

rep()
-----

Repeats a string a certain number of times.

substitute()
------------

``substitute()`` is a workhorse and the basis for Dijit's templating.  It performs parameterized substitution in the
form of ``${name}`` with a variety of advanced options.  An object is provided as the hashtable to lookup when doing
these substitutions. The expression in the curly braces may be a simple property, like ``name`` or a dotted expression
like ``data.employee.name``.  Alternatively, an array may be provided and indices referenced like ``${0}``.  The
expression may be further qualified by a colon and the name of a format function, to
run the output each lookup through a property, such as ``mylib.formatName``.   A ``this`` reference may be provided
for the format function, otherwise it will be scoped to the global namespace.  Lastly, an optional transform function
can be run on all properties just prior to substitution, such as one to escape HTML entities.

.. _dojo/string#trim:

trim()
------

``trim()`` trims whitespace off both ends of a string.

This will default to the ES5 String.prototype.trim if available, otherwise it will utilise a more performant, but not
very compact version of the ``trim()``, which is different than the ``trim()`` which is included in
:ref:`dojo/_base/lang`.

Examples
========

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  An example of ``pad()``.

  .. js ::

    require(["dojo/string", "dojo/dom", "dojo/domReady!"],
    function(string, dom){
      dom.byId("output").innerHTML = string.pad(dom.byId("input").innerHTML, 6);
    });

  .. html ::

    <div id="input">123</div>
    <div id="output"></div>

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  An example of ``rep()``.

  .. js ::

    require(["dojo/string", "dojo/dom", "dojo/domReady!"],
    function(string, dom){
      dom.byId("output").innerHTML = string.rep("Pete and Repeat went out in a boat, Pete fell in. ", 5);
    });

  .. html ::

    <div id="output"></div>

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  An example of ``substitute()`` using an object map.

  .. js ::

    require(["dojo/string", "dojo/dom", "dojo/domReady!"],
    function(string, dom){
      dom.byId("output").innerHTML = string.substitute(dom.byId("input").innerHTML, { replace: "foo", me: "bar" });
    });

  .. html ::

    <div id="input">${replace} has the hots for ${me}</div>
    <div id="output"></div>

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  An example of ``substitute()`` using an array map.

  .. js ::

    require(["dojo/string", "dojo/dom", "dojo/domReady!"],
    function(string, dom){
      dom.byId("output").innerHTML = string.substitute(dom.byId("input").innerHTML, ["foo", "bar"]);
    });

  .. html ::

    <div id="input">${0} has the hots for ${1}</div>
    <div id="output"></div>

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  An example of ``trim()``.

  .. js ::

    require(["dojo/string", "dojo/dom", "dojo/domReady!"],
    function(string, dom){
      dom.byId("output").innerHTML = string.trim(dom.byId("input").innerHTML);
    });

  .. html ::

    <pre id="input">   I got space!   </pre><br /><br />
    <pre id="output"></pre>

  .. css ::

    pre { border: 2px solid black; display: inline; padding: 3px; }

See Also
========

* :ref:`dojo/_base/lang::trim() <dojo/_base/lang#trim>` - Base Dojo ``trim()``
