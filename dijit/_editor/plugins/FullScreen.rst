#format dojo_rst

dijit._editor.plugins.FullScreen
================================

:Status: Draft
:Version: 1.0
:Authors: Jared Jurkiewicz
:Developers: Jared Jurkiewiczs
:Available: since V1.4

.. contents::
    :depth: 2

Have you ever been on a website where you were able to edit some document to post, for example a blog site, and found that all they give you for an editing 'window' in some nearly postage stamp sized box to edit content in?   Doesn't that make it nearly impossible to edit the document effectively?  It's time to put an end to such behaviors and this plugin's goal is to do exactly that for the dijit.Editor.  No more postage stamp sized editors!

========
Features
========

Once required in and enabled, this plugin provides the following features to dijit.Editor.

* Button with icon in toolbar for toggling a dijit.Editor to take over the entire view port of its current 'window' (normally the entire browser window.)
* HotKey enabled for CTRL-SHIFT-F11.  When this combination is pressed in the view port, the editor will toggle between full screen and normal modes.

===========
Limitations
===========

* The FullScreen plugin can only expand the editor to the size of its current 'window' object.  so if you have dojo embedded in an iframe in your page, the maximum it can make the editor is the size of the iframe containing it.
* The FullScreen plugin works best when the editor is a direct child of <body>.  Nesting it in layout containers will generally work, but you may experience some issues.  Please report those issues to us via the `tracker system <http://bugs.dojotoolkit.org>`_ and we will try to address them if possible.  Please see the section on `Full Screen mode and LayoutContainers <dijit/_editor/plugins/FullScreen#fullscreenmodeandlayoutcontainers>`_ for more details.
* When using FullScreen plugin on an editor contained within a layout container, such as BorderContainer or Tabcontainer, make sure that the Editor is wrapped within a content pane.  This is to avoid issues with the border container directly altering style information on the editor when the browser is resized.  The ContentPane acts as a buffer between the BorderContainer resize control and Editor.  
* FullScreen mode requires that you define your Dojo theme on the <body> element of your page.  Example: 

.. code-block :: html

  <body class="tundra"> 
    Your content here.
  <body>

=====
Usage
=====

Basic Usage
-----------
Usage of this plugin is quite simple and painless.  The first thing you need to do is require into the page you're using the editor.  This is done in the same spot all your dojo.require calls are made, usually a head script tag.  For example:

.. code-block :: javascript
 
    dojo.require("dijit.Editor");
    dojo.require("dijit._editor.plugins.FullScreen");


Once it has been required in, all you have to do is include it in the list of extraPlugins (or the plugins property if you're reorganizing the toolbar) for you want to load into the editor.  For example:

.. code-block :: html

  <div dojoType="dijit.Editor" id="editor" extraPlugins="['fullscreen']"></div>



And that's it.  The editor instance you can reference by 'dijit.byId("editor")' is now enabled with the FullScreen plugin!  You can use the button or hotkey command to toggle the editor mode.

Configurable Attributes
-----------------------

The Full Screen plugin has a few configurable attributes on it that let you affect its current behavior a bit.  The options are listed below:

+---------------------------+---------------------------------------------------------------------------------------------------------+
| **Option**                | **Description**                                                                                         |
+---------------------------+---------------------------------------------------------------------------------------------------------+
| zIndex                    |The zIndex at which to set the editor when it overlays the page.  The default is 500, so that things     |
|                           |like dijit.Menus and other drop downs will still work properly with it.  If you already have items       |
|                           |positioned in your page at a higher zIndex than 500, you will need to increase this value for the        |
|                           |FullScreen plugin when you enable it.                                                                    |
+---------------------------+---------------------------------------------------------------------------------------------------------+

Example:

.. code-block :: html

  <div dojoType="dijit.Editor" id="editor" extraPlugins="[name: 'fullscreen', zIndex: 900}]"></div>


=====================================
Full Screen mode and LayoutContainers
=====================================
Layout containers put restrictions on their children content in order to force specific layout.  Such restrictions are often in the CSS definitions, and do things such as applying 'position: absolute' as a CSS property.  These styles can cause issues with the Editor and FullScreen mode.  The editor full screen plugin works around them by removing classes for amm parent dom nodes up to the body tag.  The classes are re-applied back to their nodes when full screen is toggled off.  This provides usable full screen modes in most layout containers. 

**FullScreen mode and BorderContainer:** 
For FullScreen mode on an editor in BorderContainer to work properly, the Editor **must** be contained within a content pane.  The Editor cannot be a direct child of BorderContainer.  This is because BorderContainer directly alters DOM styles such as top and left of its direct children and if it were to apply those style changes to Editor, it would undue the settings that enable the Editor to take up the entire viewport.  The editor and its plugins cannot prevent this.  So when using an instance of the Editor will FullScreen support be sure to nest it inside a ContentPaqne to avoid problems.  

**Extra information on Layout Containers and FullScreen:**
The ideal solution to scaling out issues with LayoutContainer nested Editors is to reparent the Editor temporarily to the <body> element of your page.  This, however, will not work in some browsers, such as FireFox.  This is because FireFox forcibly reloads an IFRAME element if the iframe (or any of its parent dom nodes), moves its DOM position in the page.  At this time there are no known workarounds to that FireFox behavior, and due to such, the editor takes the the alternate approach of class manipulation explained above.  If a workaround is discovered, then the plugin and these docs will be updated to reflect the improved behavior.  


===================
A11Y Considerations
===================

* When using the hotkey CTRL-SHIFT-F11, the focus is kept in the editor window.
* When using the button (via mouse click or keyboard), focus does not move into the edit area.  This is so that users who accidentally enable the mode do not have to chift-tab out to undo the mode.  They can just press the button again.


========
Examples
========

Basic Usage
-----------

**Note:** The Demo Viewer runs in an iframe, so it can only maximize to the size of the demo viewer.

.. code-example::
  :djConfig: parseOnLoad: true
  :version: 1.4

  .. javascript::

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dijit.Editor");
      dojo.require("dijit._editor.plugins.FullScreen");
    </script>

    
  .. html::

    <b>Press the FullScreen button or use the hotkey CTRL-SHIFT-F11 while in the editing pane and the editor will go into full screen mode</b>
    <br>
    <div dojoType="dijit.Editor" height="250px"id="input" extraPlugins="['fullscreen']">
    <div>
    <br>
    blah blah & blah!
    <br>
    </div>
    <br>
    <table>
    <tbody>
    <tr>
    <td style="border-style:solid; border-width: 2px; border-color: gray;">One cell</td>
    <td style="border-style:solid; border-width: 2px; border-color: gray;">
    Two cell
    </td>
    </tr>
    </tbody>
    </table>
    <ul> 
    <li>item one</li>
    <li>
    item two
    </li>
    </ul>
    </div>


Setting the zIndex
------------------

**Note:** The Demo Viewer runs in an iframe, so it can only maximize to the size of the demo viewer.

.. code-example::
  :djConfig: parseOnLoad: true
  :version: 1.4

  .. javascript::

    <script>
      dojo.require("dijit.form.Button");
      dojo.require("dijit.Editor");
      dojo.require("dijit._editor.plugins.FullScreen");
    </script>

    
  .. html::

    <b style="position: absolute; top: 0px; left: 0px; z-index: 700;">Press the FullScreen button or use the hotkey CTRL-SHIFT-F11 while in the editing pane and the editor will go into full screen mode.  Without the zIndex setting, this div would overlay the editor.</b>
    <br>
    <br>
    <br>
    <div dojoType="dijit.Editor" height="250px"id="input" extraPlugins="[{name:'fullscreen', zIndex: 900}]">
    <div>
    <br>
    blah blah & blah!
    <br>
    </div>
    <br>
    <table>
    <tbody>
    <tr>
    <td style="border-style:solid; border-width: 2px; border-color: gray;">One cell</td>
    <td style="border-style:solid; border-width: 2px; border-color: gray;">
    Two cell
    </td>
    </tr>
    </tbody>
    </table>
    <ul> 
    <li>item one</li>
    <li>
    item two
    </li>
    </ul>
    </div>

Nesting an Editor With FullScreen in BorderContainer
----------------------------------------------------

**Note:** The Demo Viewer runs in an iframe, so it can only maximize to the size of the demo viewer.

.. code-example::
  :djConfig: parseOnLoad: true
  :version: 1.4

  .. javascript::

    <script>
      dojo.require("dijit.Editor");
      dojo.require("dijit._editor.plugins.FullScreen");
      dojo.require("dijit.layout.BorderContainer");
      dojo.require("dijit.layout.ContentPane");
      dojo.require("dojo.parser");	// scan page for widgets and instantiate them
    </script>

  .. cv:: css

    <style type="text/css">
      html, body {
        width: 100%;
        height: 100%;
        margin: 0;
      }
    </style>

  .. html::

    <div dojoType="dijit.layout.BorderContainer" gutters="true" liveSplitters="true" style="width: 100%; height: 100%;">
      <div dojoType="dijit.layout.ContentPane" splitter="true" region="top" style="height: 100px;"><b>This example demonstrates how to embed an editor in a BorderContainer and still use the FullScreen plugin</b></div>
      <div dojoType="dijit.layout.ContentPane" splitter="true" region="center">
        <br>
        <div dojoType="dijit.Editor" height="250px"id="input" extraPlugins="['fullscreen']">
          <div>
          <br>
          blah blah & blah!
          <br>
          </div>
          <br>
          <table>
          <tbody>
          <tr>
          <td style="border-style:solid; border-width: 2px; border-color: gray;">One cell</td>
          <td style="border-style:solid; border-width: 2px; border-color: gray;">
          Two cell
          </td>
          </tr>
          </tbody>
          </table>
          <ul> 
          <li>item one</li>
          <li>
          item two
          </li>
          </ul>
        </div>
      </div>
    </div>

========
See Also
========

* `dijit.Editor <dijit/Editor>`_
* `dijit._editor.plugins <dijit/_editor/plugins>`_
* `dojox.editor.plugins <dojox/editor/plugins>`_
