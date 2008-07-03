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

			

		}
		dojo.addOnLoad(init);

	</script>
  
