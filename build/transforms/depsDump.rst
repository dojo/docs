.. _build/transforms/depsDump:

========================
Build Transform depsDump
========================

:Author: Rawld Gill

.. contents ::
   :depth: 2

Summary
=======

Optionally dumps the dependency graph of all discovered modules and/or a basic GraphViz dot digraph program.

Description
===========

The transform outputs the dependency graph of all discovered modules (both AMD and legacy) in a fairly compressed JSON
resource. The format includes a map from module name to unique identifier and then uses the unique identifiers to output
the dependency graph, thereby eliminating verbose module identifiers.

The unique identifiers are continuously increasing integers, starting at zero. The map is encapsulated in a tree of
nested objects. The dotted JavaScript property name for any property indicates the module name by replacing the dots
with slashes. The "*" property of any object indicates that module's unique identifier. The forrest of module names is
rooted at the property ``idTree`` of the output JSON object. Consider the following example:

.. js ::

    idTree: {
        dojo:{
            "*":0
            _base:{
                array:{
                    "*":1
                },
                lang:{
                    "*":2
                },
                // etc.
            },
            // etc.
        },
        dijit:{
            "*":487,
            // etc.
        }
    }

The partial ``idTree`` value given above contains a forest with the ``dojo`` and ``dijit`` trees. The modules dojo,
dojo/_base/array, dojo/_base/lang, and dijit have the identifiers 0, 1, 2, and 487 respectively.

The property ``depsTree`` of the output JSON object is an array or arrays and indicated the dependencies for each
module. The dependencies for module *x* with unique identifier *y* are listed in at ``depsTree[`` *y* ``]``, which
contains an array of unique identifiers giving the modules upon which *y* depends.

The JSON object is output to the filename given by the profile property ``depsDumpFilename``; relative filenames are
computed with respect to the computed destBaseBase property (see xxx). If ``depsDumpFilename`` is missing or falsy, then
the JSON object is not output.

The transform may be also used to output a Graphvis (http://www.graphviz.org/) digraph dot program. The program is
output to the filename given by the profile property ``depsDumpDotFilename``; relative filenames are computed with
respect to the computed destBaseBase property (see xxx). If ``depsDumpDotFilename`` is missing or falsy, then the program
is not output.

The modules contained in the dot program may be limited by provided an explicit set of modules in the profile property
``dotModules``, a comma-separated list of module identifiers. When profiled, the dependency graph resulting from these
modules and their dependencies is output.

For example, the following profile will output a dot program for the dependency graph of dojo/_base/json:

.. js ::

    var profile = {
        depsDumpDotFilename:"dojo-base-json.dot",
        dotModules:"dojo/_base/json"
    }

This could then be used to generate a PNG of the graph as follows (assuming Graphvis is installed).

.. code-block :: text

   ~/dev/dtk/util/buildscripts:./build.sh --profile base --profile ../build/examples/dojo-base-json-dot --release
   ~/dev/dtk/util/buildscripts:dot -Tpng ../../release/dojo/dojo-base-json.dot -o ../../release/dojo/dojo-base-json.png

The resulting image should look something like this:

.. image :: dojo-base-json.png

Profile Knobs
=============

``depsDumpFilename`` (default = ``undefined``)

  * [*string*] filename to output dependency graph
  * [*falsy*] dependency graph is not output

``depsDumpDotFilename`` (default = ``undefined``)

  * [*string*] filename to output dot program
  * [*falsy*] dot program is not output

``dotModules`` (default = ``undefined``)

  * [*comma-separated string of module identifiers*]  set of identifiers to include in graph (these modules and their
    dependency trees will be included in the output)
  * [*falsy*] all modules are included

Source Location
===============

util/build/transforms/copy.js
