#format sphinx_rst

:mod:`parrot` -- Dead parrot access
===================================

.. module:: parrot
   :platform: Unix, Windows
   :synopsis: Analyze and reanimate dead parrots.


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
