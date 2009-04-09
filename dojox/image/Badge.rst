#format dojo_rst

dojox.image.Badge
=================

:Status: Draft
:Version: 1.0
:Project owner: ?--
:Available: since V?

.. contents::
   :depth: 2

Attach images or background images, and let them loop


============
Introduction
============

TODO: introduce the component/class/method


=====
Usage
=====

TODO: how to use the component/class/method

.. cv-compound::

  .. cv:: javascript

        <script type="text/javascript">
      		dojo.require("dojox.image.Badge"); 
		dojo.require("dojox.data.FlickrStore");
                dojo.require("dojox.image.Lightbox");
	</script>

	<script type="text/javascript">
  
		// programatic flickrstore implementation [basic]
		function onComplete(items,request){
			if (items.length>0){
				dojo.forEach(items,function(item){                                        
					var part = {
						title: flickrStore.getValue(item,"title"),
						href: flickrStore.getValue(item,"imageUrl")
					};
					
					dijit.byId('fromStore')._attachedDialog.addImage(part,"flickrStore");
				});
				dojo.byId('flickrButton').disabled = false; 
			}
		}

		function onError(error,request){
			console.warn(error,request);
		}

		function init(){
                             
                                                
			var flickrRequest = {
				query: {},
				onComplete: onComplete,
				onError: onError,
				userid: "dylans",
				tags: "dojotoolkit,italy",
				count: 12
			};
			flickrStore.fetch(flickrRequest);
		}
		dojo.addOnLoad(init);
                
	</script>

  .. cv:: html

     <h2>[4x3] threads:3</h2>
       <div class="noBorderWrapper">
         <div dojoType="dojox.image.Badge" threads="2" rows="4" cols="3">
              <div class="dojoxBadgeImage"></div><div class="dojoxBadgeImage"></div><div class="dojoxBadgeImage"></div>
              <div class="dojoxBadgeImage"></div><div class="dojoxBadgeImage"></div><div class="dojoxBadgeImage"></div>
              <div class="dojoxBadgeImage"></div><div class="dojoxBadgeImage"></div><div class="dojoxBadgeImage"></div>
              <div class="dojoxBadgeImage"></div><div class="dojoxBadgeImage"></div><div class="dojoxBadgeImage"></div>
              
        </div>
    </div>

    <div dojoType="dojox.data.FlickrStore" jsId="flickrStore" label="title"></div>
    <div id="fromStore" dojoType="dojox.image.Lightbox" store="flickrStore" group="flickrStore"></div>

		<div id="prog"></div>
		<div dojoType="dojox.image.Badge">

			<a href="images/imageVert.jpg" dojoType="dojox.image.Lightbox" title="More Guatemala...">tall</a>
			<a href="images/imageHoriz.jpg" dojoType="dojox.image.Lightbox" title="Antigua, Guatemala">4:3 image</a>
			<a href="images/broken.jpg" dojoType="dojox.image.Lightbox" title="broken href example">Broken link</a>

			<a href="images/huuuge.png" dojoType="dojox.image.Lightbox" title="a large image">large than viewport?</a>
			<a href="images/imageHoriz2.jpg" dojoType="dojox.image.Lightbox" group="group1" title="Amsterdam Train Depot">wide image</a>
			<a href="images/square.jpg" dojoType="dojox.image.Lightbox" group="group1" title="1:1 aspect">square</a>

			<a href="images/extraWide.jpg" dojoType="dojox.image.Lightbox" group="group1" title="Greeneville, TN">wide image</a>
			<a href="images/broken.jpg" dojoType="dojox.image.Lightbox" group="group1" title="broken href example">Broken link</a>
			<a href="images/imageHoriz2.jpg" dojoType="dojox.image.Lightbox" group="group2" title="Amsterdam Train Depot">wide image</a>

			<a href="images/square.jpg" dojoType="dojox.image.Lightbox" group="group2" title="1:1 aspect">square</a>
			<a href="images/imageHoriz.jpg" dojoType="dojox.image.Lightbox" group="group2" title="Antigua, Guatemala">4:3 image</a>
			<a href="images/imageVert.jpg" dojoType="dojox.image.Lightbox" group="group2" title="More Guatemala...">tall</a>

		</div>


     

  .. cv:: css

   <style>
    @import "/moin_static163/js/dojo/trunk/release/dojo/dojox/image/resources/image.css";
    
    img.thing { width:50px; height:50px; }
    
    .noBorderWrapper .dojoxBadge {
      		border:none;
    }
   </style>




========
Examples
========

Programmatic example
--------------------

TODO: example

Declarative example
-------------------

TODO: example


========
See also
========

* TODO: links to other related articles
