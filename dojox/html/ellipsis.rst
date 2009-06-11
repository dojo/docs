#format dojo_rst

dojox.html.ellipsis
===================

:Status: Draft
:Version: 1.0
:Authors: Nathan Toone
:Available: since V1.4

.. contents::
    :depth: 2

**dojox.html.ellipsis** offers cross-broser support for `text-overflow: ellipsis`


=====
Usage
=====

To use, just include the ellipsis.css file (found in the dojox/html/resources directory) and dojo.require("dojox.html.ellipsis") in your code.

You can then add "dojoxEllipsis" on any node that you want to ellipsis-ize.  In order to function properly, the node with the dojoxEllipsis class set on it should be a child of a node with a defined width.  It should also be a block-level element (i.e. <div>) - it will not work on td elements.

``NOTE:`` When using the dojoxEllipsis class within tables, the table needs to have the `table-layout: fixed` style

========
Examples
========

Within a fixed-width div
------------------------

.. cv-compound ::

  .. cv :: javascript

    <script>
      dojo.require("dojox.html.ellipsis");
    </script>

  .. cv :: html

    <div style="width: 100px;">
        <div class="dojoxEllipsis">Long inner text that should be truncated after 100 pixels.</div>
    </div>

  .. cv:: css

    <style type="text/css">
      @import "/moin_static163/js/dojo/trunk/release/dojo/dojox/html/resources/ellipsis.css";
    </style>

Within a table
--------------

.. cv-compound ::

  .. cv :: javascript

    <script>
      dojo.require("dojox.html.ellipsis");
    </script>

  .. cv :: html

    <table style="width: 75%; table-layout: fixed">
        <tr>
            <td width="25%"><div class="dojoxEllipsis">Long inner text that should be truncated if it gets too big.</div></td>
            <td width="75%"><div class="dojoxEllipsis">Long inner text that should be truncated if it gets too big.</div></td>
        </tr>
    </table>

  .. cv:: css

    <style type="text/css">
      @import "/moin_static163/js/dojo/trunk/release/dojo/dojox/html/resources/ellipsis.css";
    </style>
