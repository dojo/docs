#format dojo_rst

Describe dojox/rpc here. Yes yes yes

.. codeviewer::

  <script type="text/javascript">
		dojo.require("dojox.rpc.Service");
		dojo.require("dojo.io.script");

		// FIXME: we do this because Google API passes a list of params instead of just an object
		// this affects other io.script transports
		dojo.mixin(dojo.io.script,{
			_jsonpCallback:function(json){
				this.ioArgs.json = arguments.length > 0 ? arguments : json;
			}
		});

		var google, showLoader, hideLoader = null;
		function init(){

			google = new dojox.rpc.Service(dojo.moduleUrl("dojox.rpc","SMDLibrary/google.smd")); 
			
			showLoader = dojo.hitch(dojo,"style","loader","visibility","visible");
			hideLoader = dojo.hitch(dojo,"style","loader","visibility","hidden");

			dojo.connect(dojo.byId("doit"),"onclick", function(e){

				showLoader();
				dojo.style("loader","visibility","visible");
				
				dojo.query("li","top").forEach(function(item){
					dojo.byId("archive").appendChild(item);
				});

				var searchType = dojo.byId("searchType").value || "webSearch";
				google[searchType]({ q: dojo.byId("test").value,  })
					// generic succes handler:
					.addCallback(function(returned){
						var info = returned[1].cursor; 
						var data = returned[1].results || [];
						dojo.forEach(data,function(item){
							var li = dojo.doc.createElement('li');
							li.innerHTML = "<a target='_new' hr"+"ef='"+ (item.unescapedUrl || item.url) +"'>" + item.title + "</a><br />" +
								"<span class='summary'>" + (item.content || item.streetAddress || "unknown") + "</span>"; 
							
							//console.log(item);
							dojo.byId("top").appendChild(li);
						});
						hideLoader();
					})
					// something bad happened:
					.addErrback(function(err){
						console.warn('ooops', err);
						hideLoader();
					});
			});

		}
		dojo.addOnLoad(init);

	</script>
  
