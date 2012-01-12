.. _dojox/editor/plugins/TablePlugins:

=================================
dojox.editor.plugins.TablePlugins
=================================

:Author: Mike Wilcox

A series of plugins that give the Editor the ability to create and edit HTML tables. The list of Table Plugins are:
 - Insert Table
 - Modify Table
 - Insert Table Row Before
 - Insert Table Row After
 - Insert Table Column Before
 - Insert Table Column After
 - Delete Table Row
 - Delete Table Column
 - Color Table Cell
 - Resize Table Column
 - Table Contextmenu

Any or all of the plugins may be used, although they tend to work together so it would usually be all of them with the exception of the Table Contextmenu which adds right-click functionality to a table and could be used alone with Insert Table.

Notes on individual plugins
===========================
ResizeTableColumn
-----------------
ResizeTableColumn plugin is a plugin for dijit.Editor, which provides the users with the ability to resize the width of the table columns. The width of column can be changed by dragging and dropping the edge of the column. The result of the drag&drop is as follows:

* The width of the table column can be changed by dragging the edge of the column.
* The delta width is either taken from or added to the adjacent column on the trailing edge (for G11N)
* Sizing the rightmost or leftmost columns affects only those columns.
* The leading and trailing columns can only be sized to the extent of the containing div.


Example
=======

Although the code for the Editor is complex, it is quite simple to implement:

.. code-example ::

  The CSS

  .. css ::

        @import "{{baseUrl}}dojox/editor/plugins/resources/editorPlugins.css";

  It's just a matter of using the proper *requires* in the JavaScript:

  .. js ::

    dojo.require("dijit.Editor");
    dojo.require("dojox.editor.plugins.TablePlugins");
    dojo.require("dojox.editor.plugins.ResizeTableColumn");

  Slightly more difficult is the HTML. The plugins are assigned within an array. Be sure to get commas correct or you will get a parse error:

  .. html ::
  
    <div class="tundra">
    <div data-dojo-type="dijit/Editor" style="height:100px" data-dojo-props="plugins:[
        'bold','italic',
        {name: 'dojox.editor.plugins.TablePlugins', command: 'insertTable'},
        {name: 'dojox.editor.plugins.TablePlugins', command: 'modifyTable'},
        {name: 'dojox.editor.plugins.TablePlugins', command: 'InsertTableRowBefore'},
        {name: 'dojox.editor.plugins.TablePlugins', command: 'InsertTableRowAfter'},
        {name: 'dojox.editor.plugins.TablePlugins', command: 'insertTableColumnBefore'},
        {name: 'dojox.editor.plugins.TablePlugins', command: 'insertTableColumnAfter'},
        {name: 'dojox.editor.plugins.TablePlugins', command: 'deleteTableRow'},
        {name: 'dojox.editor.plugins.TablePlugins', command: 'deleteTableColumn'},
        {name: 'dojox.editor.plugins.TablePlugins', command: 'colorTableCell'},
        {name: 'dojox.editor.plugins.TablePlugins', command: 'tableContextMenu'},
        {name: 'dojox.editor.plugins.TablePlugins', command: 'ResizeTableColumn'}
      ]">
      Dojo Rocks with a fox in socks. Red socks.
      <table width="200" border="2" align="center"
        cellpadding="2" cellspacing="2" bordercolor="#00FFFF" bgcolor="#FF0000" id="myTable">
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td bgcolor="#00FFFF">&nbsp;</td>
        </tr>
      </table>
    </div>
    </div>
