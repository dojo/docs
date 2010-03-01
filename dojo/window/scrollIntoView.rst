#format dojo_rst

dojo.window.scrollIntoView
==========================

:Status: Draft
:Version: 1.0
:Available: since V1.5

.. contents::
   :depth: 2

Scrolls a node into view, similar to node.scrollIntoView() but working around browser quirks.

========
Examples
========

Two buttons
-----------

.. cv-compound ::

  .. cv :: javascript

    <script>
       dojo.require("dojo.window");
    </script>

  .. cv :: html 

    <button type=button id=button1 onclick="dojo.window.scrollIntoView('button2');">scroll to button 2</button>
    <div style="height: 500px; border: 1px solid black>
        div to separate buttons
    </div>
    <button type=button id=button2 onclick="dojo.window.scrollIntoView('button1');">scroll to button 1</button>
