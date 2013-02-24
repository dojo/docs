.. _dijit/_KeyNavMixin:

==================
dijit/_KeyNavMixin
==================

:Authors: Bill Keese
:since: V1.9

.. contents ::
    :depth: 2

Introduction
============

Add this mixin to widgets to enable keyboard navigation between the widget's descendants.
Navigation can be performed via arrow keys and HOME/END keys, and also a letter key search.
:ref:`dijit/Tree <dijit/Tree>` is an example of a widget that extends _KeyNavMixin.

If your widget contains a simple linear list of children (i.e. if it extends :ref:`dijit/_Container <dijit/_Container>`),
then you should mixin :ref:`dijit/_KeyNavContainer <dijit/_KeyNavContainer>` instead.

To use this mixin, the subclass must implement a number of abstract methods:

    - _getFirst() and _getLast() to return the HOME and END keys.
    - _onLeftArrow(), _onRightArrow() _onDownArrow(), and _onUpArrow() methods to handle the
      LEFT/RIGHT/UP/DOWN arrow keys.  These methods are meant to navigate relative to the current node,
      so they should operate based on this.focusedChild.
    - _getNext(child) to find the next child relative to a specified child.
      "Next" in this context refers to a linear ordering of the children or descendants used
      for letter key search.

In addition, the subclass must:

    - Set all descendants' initial tabIndex to "-1"; both initial descendants and any
      descendants added later, by for example addChild().
    - Define childSelector to a function or string that identifies focusable child widgets.
    - Define this.containerNode.

Also, child widgets must implement a focus() method.



Example
========

Here's an example of a behavioral widget, to be attached to a table.

The UP/DOWN/LEFT/RIGHT arrows and HOME/END keys can be used to navigate between cells,
and the user can also type letter keys to navigate directly to those cells, such as typing the "p" key to navigate
to the cell labeled "pear".

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

    .. js ::

        require([
            "dojo/_base/declare", "dojo/_base/array", "dojo/_base/lang", "dojo/on", "dojo/parser", "dojo/query",
            "dijit/registry", "dijit/_WidgetBase", "dijit/_KeyNavMixin", "dojo/domReady!"
        ], function(declare, array, lang, on, parser, query, registry, _WidgetBase, _KeyNavMixin){
            MyGrid = declare([_WidgetBase, _KeyNavMixin], {
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

                // Specifies which DOMNode children can be focused
                childSelector: "td",

                _focusedChildIndex: function(children){
                    // summary:
                    //      Helper method to return the index of the currently focused child in the array
                    return array.indexOf(children, this.focusedChild);
                },


                // Home/End key support
                _getFirst: function(){
                    return this.getChildren()[0];
                },
                _getLast: function(){
                    var children = this.getChildren();
                    return children[children.length - 1];
                },

                // Simple arrow key support.   Up/down logic assumes that evey row has the same number of cells.
                _onLeftArrow: function(){
                    var children = this.getChildren();
                    this.focusChild(children[(this._focusedChildIndex(children) - 1 + children.length) % children.length]);
                },
                _onRightArrow: function(){
                    var children = this.getChildren();
                    this.focusChild(children[(this._focusedChildIndex(children) + 1) % children.length]);
                },
                _numCols: function(){
                    // summary:
                    //      Helper method to return the number of columns in the table
                    return query("tr:first-child > td", this.domNode).length;
                },
                _onDownArrow: function(){
                    var children = this.getChildren();
                    this.focusChild(children[(this._focusedChildIndex(children) + this._numCols()) % children.length]);
                },
                _onUpArrow: function(){
                    var children = this.getChildren();
                    this.focusChild(children[(this._focusedChildIndex(children) - this._numCols() + children.length) % children.length]);
                },

                // Letter key navigation support
                _getNext: function(child){
                    var children = this.getChildren();
                    return children[(array.indexOf(children, child) + 1) % children.length];
                }
            });

            MyCell = declare(_WidgetBase, {
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

        <table data-dojo-type="MyGrid">
            <tr>
                <td data-dojo-type="MyCell">apple</td>
                <td data-dojo-type="MyCell">banana</td>
                <td data-dojo-type="MyCell">orange</td>
            </tr>
                <td data-dojo-type="MyCell">pear</td>
                <td data-dojo-type="MyCell">grapes</td>
                <td data-dojo-type="MyCell">strawberry</td>
            </tr>
        </table>

See also
========
* :ref:`dijit/_KeyNavContainer <dijit/_KeyNavContainer>`
