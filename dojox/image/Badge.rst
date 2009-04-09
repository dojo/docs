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
				userid: "jetstreet",
				tags: "jetstreet",
				count: 10
			};
			flickrStore.fetch(flickrRequest);
		}
		dojo.addOnLoad(init);
                
	</script>


  .. cv:: html

     <h2>[6x6] threads:3</h2>
       <div class="noBorderWrapper">
         <div dojoType="dojox.image.Badge" threads="2" rows="6" cols="6">
         <div class="dojoxBadgeImage"></div><div class="dojoxBadgeImage"></div><div class="dojoxBadgeImage"></div><div class="dojoxBadgeImage"></div><div class="dojoxBadgeImage"></div><div class="dojoxBadgeImage"></div>
         <div class="dojoxBadgeImage"></div><div class="dojoxBadgeImage"></div><div class="dojoxBadgeImage"></div><div class="dojoxBadgeImage"></div><div class="dojoxBadgeImage"></div><div class="dojoxBadgeImage"></div>
         <div class="dojoxBadgeImage"></div><div class="dojoxBadgeImage"></div><div class="dojoxBadgeImage"></div><div class="dojoxBadgeImage"></div><div class="dojoxBadgeImage"></div><div class="dojoxBadgeImage"></div>
         <div class="dojoxBadgeImage"></div><div class="dojoxBadgeImage"></div><div class="dojoxBadgeImage"></div><div class="dojoxBadgeImage"></div><div class="dojoxBadgeImage"></div><div class="dojoxBadgeImage"></div>
         <div class="dojoxBadgeImage"></div><div class="dojoxBadgeImage"></div><div class="dojoxBadgeImage"></div><div class="dojoxBadgeImage"></div><div class="dojoxBadgeImage"></div><div class="dojoxBadgeImage"></div>
         <div class="dojoxBadgeImage"></div><div class="dojoxBadgeImage"></div><div class="dojoxBadgeImage"></div><div class="dojoxBadgeImage"></div><div class="dojoxBadgeImage"></div><div class="dojoxBadgeImage"></div>
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
