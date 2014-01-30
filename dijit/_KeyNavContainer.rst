.. _dijit/_KeyNavContainer:

=====================
dojo/_KeyNavContainer
=====================

:Authors: Bill Keese
:since: V1.0

.. contents ::
    :depth: 2

Introduction
============

_KeyNavContainer extends :ref:`dijit/_Container <dijit/_Container>` to
provide keyboard navigation support.  Specifically:

    - The user can navigate using the arrow keys, either LEFT/RIGHT or UP/DOWN depending on the
      orientation of the widget, and HOME/END keys.
    - The user can jump to any given widget by typing one or more letters of the label of that widget.

To use this mixin, call connectKeyNavHandlers() in postCreate(), listing the keys for navigating to the previous
and next widgets.

Also, child widgets must implement a focus() method.

Examples
========

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

    .. js ::

        require([
            "dojo/_base/declare", "dojo/_base/array", "dojo/keys", "dojo/parser", "dojo/query",
            "dijit/_WidgetBase", "dijit/_KeyNavContainer", "dojo/domReady!"
        ], function(declare, array, keys, parser, query,  _WidgetBase, _KeyNavContainer){
            MyMenu = declare([_WidgetBase, _KeyNavContainer], {
                buildRendering: function(){
                    // This is a behavioral widget so we'll just use the existing DOM.
                    // Alternately we could have a template.
                    this.inherited(arguments);

                    // Set containerNode.   Usually this is set in the template.
                    this.containerNode = this.domNode;
                },

                postCreate: function(){
                    // Don't forget the this.inherited() call
                    this.inherited(arguments);

                    // Set tabIndex on the container <table> node, since by default it's not tab navigable
                    this.domNode.setAttribute("tabIndex", "0");
                },

                _focusedChildIndex: function(children){
                    // summary:
                    //      Helper method to return the index of the currently focused child in the array
                    return array.indexOf(children, this.focusedChild);
                },

                _onDownArrow: function(){
                    var children = this.getChildren();
                    this.focusChild(children[(this._focusedChildIndex(children)+1) % children.length]);
                },

                _onUpArrow: function(){
                    var children = this.getChildren();
                    this.focusChild(children[(this._focusedChildIndex(children)-1 + children.length) % children.length]);
                }
            });

            MyMenuItem = declare(_WidgetBase, {
                postCreate: function(){
                    this.domNode.setAttribute("tabIndex", "-1");
                },
                focus: function(){
                    this.domNode.focus();
                }
            });

            parser.parse();
        });

    .. css ::

        table, td {
            border: 1px solid gray;
        }
        td:focus {
            background-color: yellow;
        }

    .. html ::

        <table data-dojo-type="MyMenu">
                <tr><td data-dojo-type="MyMenuItem">apple</td></tr>
                <tr><td data-dojo-type="MyMenuItem">banana</td></tr>
                <tr><td data-dojo-type="MyMenuItem">orange</td></tr>
                <tr><td data-dojo-type="MyMenuItem">pear</td></tr>
                <tr><td data-dojo-type="MyMenuItem">grapes</td></tr>
                <tr><td data-dojo-type="MyMenuItem">strawberry</td></tr>
        </table>

See also
========
* :ref:`dijit/_KeyNavMixin <dijit/_KeyNavMixin>`
* :ref:`dijit/_Container <dijit/_Container>`

