#format dojo_rst

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
 - Table Contextmenu

Any or all of the plugins may be used, although they tend to work together so it would usually be all of them with the exception of the Table Contextmenu which adds right-click functionality to a table and could be used alone with Insert Table.

=======
Example
=======

Although the code for the Editor is complex, it is quite simple to implement:

.. cv-compound::

  The CSS

  .. cv:: css
  
    <style type="text/css">
        @import "/moin_static163/js/dojo/trunk/dojox/editor/plugins/resources/editorPlugins.css";
    </style>

  It's just a matter of using the proper *requires* in the JavaScript:

  .. cv:: javascript
  
    <script type="text/javascript">
    dojo.require("dijit.Editor");
    dojo.require("dojox.editor.plugins.TablePlugins");
    </script>

  Slightly more difficult is the HTML. The plugins are assigned within an array. Be sure to get commas correct or you will get a parse error:

  .. cv:: html
  
    <div class="tundra">
    <div dojoType="dijit.Editor" style="height:100px" plugins="[
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
        {name: 'dojox.editor.plugins.TablePlugins', command: 'tableContextMenu'}
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
