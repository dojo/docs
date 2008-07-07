#format dojo_rst

.. codeviewer::

   <script type="text/javascript">dojo.require("dijit.form.Button");</script>
   <div class="nihilo">
      <div dojoType="dijit.form.Button">whatever</div>
   </div>


.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.declare("foohoo", [dijit._Widget,dijit._Templated], {
       templateString: '<div dojoAttachEvent="onclick: _foo">Example: <span dojoAttachPoint="containerNode"></span></div>',
       _foo: function(){
          alert("foo");
       }
    });
    var widget = new foohoo({id: "test_foohoo"}, dojo.byId("fohoo"));
    </script>

    hihi
    ====

  .. cv:: html

    :label: Das ist mein HTML Code



    <div id="fohoo">Click Me</div>
    <div dojoType="foohoo">Or Me</div>

Here is my rest syntax
======================

This code example shows you how to create a widget programatically, awesome isn't it?

.. codeviewer::

   <script type="text/css">
   dojo.declare("foohoo", [dijit._Widget,dijit._Templated], {
      templateString: '<div dojoAttachEvent="onclick: _foo">Example: <span dojoAttachPoint="containerNode"></span></div>',
      _foo: function(){
         alert("foo");
      }
   });
   var widget = new foohoo({id: "test_foohoo"}, dojo.byId("fohoo"));
   </script>
   <div id="fohoo">Click Me</div>
   <div dojoType="foohoo">Or Me</div>

Here is my rest syntax
======================

.. highlight:: python
   :linenothreshold: 5

.. note::
    
    was auch immer

.. warning::

    holla di guga

.. code-block :: javascript
   :linenos:

    def whatever():
        print "whatever" 
    def move():
        print "whatever" 
    def print():
        print "whatever" 
    def whatever():
        print "whatever" 

.. code-block :: php
    :linenos:

    <?php
        echo("goehgoehgoeg");
    ?>

.. code-block :: html

   <html>
      <head><title>holla</title></head>
      <body><p>holla</p></body>
   </html>


Another codeblock

.. code-block :: javascript
    :linenos:

    window.document.alert("gegeg");

    dojo.provide("dojango");

    /* An example on how to use an xd build and also loading local files can be found here:
     * http://jburke.dojotoolkit.org/demos/xdlocal/LocalAndXd.html
     */

    if (dojo.baseUrl == '/') {
        // if we use an xd build located on another host, we have to use the absolute url of the called host
        dojo.registerModulePath("dojango", "media/dojango/dojango");
    }
    else {
        // relative to the dojo/dojo.js-file
        dojo.registerModulePath("dojango", "../../../dojango");
    }

    dojo.provide("rs.Media");

    // we have to load our widget-class!
    //dojo.require("rs.widget.MediaManager");
    dojo.require("rs.form");
    dojo.require("dijit.form.CheckBox");

    dojo.declare("rs.Media", null, {

        // TODO: enable our redsquare-form soon! needs better form-layout
        //rs.chunk.Media.mediaForm = new rs.form("mediaForm");
        constructor:function(urls) {
            this.saveUrl = urls.liveMediaSave;
            this.deleteUrl = urls.liveMediaDelete;
            this.mediaId = null;
            this.mediaManager = null;
            this.removeMediaMsgTitle = gettext("Delete media");
            this.removeMediaMsg = gettext("Do you really want to delete this media file?");
            this.mediaManager = dijit.byId("mediaManager");

another headline
================
