.. _dojox/embed/Flash:

=================
dojox.embed.Flash
=================

:Project owner: ?--
:since: V1.2

.. contents ::
   :depth: 2

Base functionality to insert a flash movie into a document on the fly.


Introduction
============

Embedding flash media in HTML can be done in different ways. Usually the following method is used:

.. html ::
 
 <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="100%" height="700" id="flash1" name="flash1">
   <param name="movie" value="flash.swf">
   <param name="allowfullscreen" value="true">
   <param name="allowscriptaccess" value="always">
   <param name="flashvars" value="var_1=value_1&var_2=value_2">
   <embed id="flash1"
          name="flash1"
          src="flash.swf"
          width="100%"
          height="700"
          allowscriptaccess="always"
          allowfullscreen="true"
          flashvars="var_1=value_1&var_2=value_2"
   />
 </object>

Here object tag is used for IE and old Netscape's embed tag is used for other browsers. What if user's browser does not have Adobe flash player installed? Object tag can use codebase attribute and embed attribute can use pluginspage attribute. They define locations where and which flash player version browser should download in case of missing plugin:

.. html ::
 
 <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="100%" height="700" id="flash1" name="flash1" codebase="http://fpdownload.adobe.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0">
   <param name="movie" value="flash.swf">
   <param name="allowfullscreen" value="true">
   <param name="allowscriptaccess" value="always">
   <param name="flashvars" value="var_1=value_1&var_2=value_2">
   <embed id="flash1"
          name="flash1"
          src="flash.swf"
          width="100%"
          height="700"
          allowscriptaccess="always"
          allowfullscreen="true"
          flashvars="var_1=value_1&var_2=value_2"
          pluginspage="http://www.adobe.com/go/getflashplayer"
   />
 </object>

However this is an old and not very user friendly method. By using codebase and pluginspage attributes you impose flash plugin to user. In this case browser notifies user for missing plugins. Besides this code is not markup compliant because it uses embed tag if used with non html5 doctypes. Very popular and bullet proof method of flash embedding in today's browsers is:

.. html ::
  
 <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="100%" height="700">
   <param name="movie" value="flash.swf" />
   <!--[if !IE]>-->
     <object type="application/x-shockwave-flash" data="flash.swf" width="100%" height="700">
   <!--<![endif]-->
     <h1>Alternative flash content</h1>
     <a href="http://get.adobe.com/flashplayer/"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" /></a>
   <!--[if !IE]>-->
     </object>
   <!--<![endif]-->
 </object>

This method uses two object tags. First object tag is for IE, second is for other browsers.


Usage
=====

Flash embedding with dojo is as simple as:

.. js ::
 
   dojo.require("dojo.parser");
   dojo.require("dojox.embed.Flash");
   dojo.ready(function(){
     var movie = new dojox.embed.Flash({
       path: '/path-to-swf/flash.swf',
       width: '100%',
       height: 700,
       params: {wmode: 'opaque'},
       vars: {customFlashVariable: 'value'}
     }, "flashContainer");
   });

.. html ::

 <div id="flashContainer">
   <h1>Alternative flash content</h1>
   <a href="http://get.adobe.com/flashplayer/"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" /></a>
 </div>

Constructor Parameters
----------------------

+------------------+------------------------------------------------------------------------------+---------------------------+
|**Parameter**     |**Description**                                                               |**Type**                   |
+------------------+------------------------------------------------------------------------------+---------------------------+
|path              |Path to swf flash file                                                        |String                     |
+------------------+------------------------------------------------------------------------------+---------------------------+
|id                |A unique key that will be used as the id of the created markup.               |String                     |
+------------------+------------------------------------------------------------------------------+---------------------------+
|width             |Width of the embedded flash.                                                  |Number | String            |
+------------------+------------------------------------------------------------------------------+---------------------------+
|height            |Height of the embedded flash                                                  |Number | String            |
+------------------+------------------------------------------------------------------------------+---------------------------+
|style             |Any CSS style information (i.e. style="background-color:transparent") you     |String                     |
|                  |want to define on the markup.                                                 |                           |
+------------------+------------------------------------------------------------------------------+---------------------------+
|params            |A set of key/value pairs that you want to define in the resultant markup      |Object                     |
+------------------+------------------------------------------------------------------------------+---------------------------+
|vars              |A set of key/value pairs that the Flash movie will interpret as FlashVars     |Object                     |
+------------------+------------------------------------------------------------------------------+---------------------------+
|expressInstall    |Whether or not to include any kind of expressInstall info. Default is false.  |Boolean                    |
+------------------+------------------------------------------------------------------------------+---------------------------+
|swLiveConnect     |Whether or not the browser should start Java. For FSCommand to work           |Boolean                    |
+------------------+------------------------------------------------------------------------------+---------------------------+
|allowScriptAccess |Controls from which domain script and html page are allowed to communicate    |String                     |
+------------------+------------------------------------------------------------------------------+---------------------------+
|minimumVersion    |The minimum targeted version of the Flash Player                              |Number                     |
+------------------+------------------------------------------------------------------------------+---------------------------+
|redirect          |Url to redirect the browser to if the current Flash version is not            |Number                     |
|                  |supported.                                                                    |                           |
+------------------+------------------------------------------------------------------------------+---------------------------+

Params
------

In constructor of dojox.embed.Flash there is params variable. For flash following params are possible:

* allowfullscreen - defines whether or not browser allows flash to go fullscreen
* allownetworking
* allowscriptaccess
* base
* bgcolor
* devicefont
* flashvars
* loop
* menu
* play
* quality
* salign
* seamlesstabbing
* scale
* swliveconnect
* wmode - ("transparent" | "opaque" | "window")
  

Examples
========

Programmatic example
--------------------

.. js ::
 
   dojo.require("dojox.embed.Flash");
   dojo.ready(function(){
     var movie = new dojox.embed.Flash({
       path: '/path-to-swf/flash.swf',
       width: '100%',
       height: 700,
       params: {wmode: 'opaque'},
       vars: {customFlashVariable: 'value'}
     }, "flashContainer");
   });

.. html ::

 <div id="flashContainer">
   <h1>Alternative flash content</h1>
   <a href="http://get.adobe.com/flashplayer/"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" /></a>
 </div>


Declarative example
-------------------

.. js ::
 
   dojo.require("dojo.parser");
   dojo.require("dojox.embed.Flash");

.. html ::

 <div data-dojo-type="dojox.embed.Flash" data-dojo-props="path:'/path-to-swf/flash.swf', width:'100%', height:300">
   <h1>Alternative flash content</h1>
   <a href="http://get.adobe.com/flashplayer/"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" /></a>
 </div>


See also
========

* :ref:`dojox.embed <dojox/embed>` Base code for embedding external objects like Flash, Quicktime
* http://kb2.adobe.com/cps/127/tn_12701.html - Flash object and embed tag
