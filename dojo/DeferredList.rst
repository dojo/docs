## page was renamed from 1.2/dojo/Deferred
#format dojo_rst

dojo.DeferredList
=================

:Status: Draft
:Version: 1.2

.. contents::
  :depth: 3

`dojo.Deferred <dojo.Deferred>`_ objects make asynchronous programming as easy as can be reasonably expected. The `dojo.DeferredList <dojo.DeferredList>`_ class builds on the "one answer to one question" contract of `dojo.Deferred <dojo.Deferred>`_ to provide a "one answer to many questions" system. Lets look at some cases when you might need such a thing:

One common taks is notifying some listener when a list of resources pulled in by different services all become available. For example, a search federated across several bookstores. Hearing about the results of a single search is a good job for a `Deferred <dojo.Deferred>`_, but finding out about when they've all completed takes more juggling.

Lets assume we've installed several proxies for search services on our server. Once all the stores have been searched, we want to send an xhr call with search status to some logging service and provide the user an indication that we've finished up all the work we were doing on their behalf.

The services are located at:

1. /books/amazon
2. /books/bol
3. /books/google

Astute readers are now asking, "why provide different services when you could let the server do the coordination through a single URL?", e.g.:

1. /books/search

which in return searches all three stores through the server. You, of course, could but in our case it might be that you are accessing different servers. E.g. http://www.amazon.com/books/ and http://www.bol.com/book via JSON-P.

To give the user feedback about what's happening with the searches they issue, we have couple of options:

1. We could chain the xhr requests. Once the first request has been executed we run the second and the third and then make the call to our server

*Drawback: this will take very long since you basically are executing 3 requests after each other. Imagine 2 searches are a bit slow. This is not good*

2. We don't chain the requests and give each request a timeout and run the request to our server when one request is complete

*Drawback: this is probably the worst thing you can do since there is no reliable way to tell whether the other requests executed.*

3. We use dojo.Deferreds to issue all the requests in parallel. As soon as all 3 requests have been executed we will call our server:

.. cv-compound::


  .. cv:: javascript

  <script type="text/javascript">
    dojo.require("dojo.DeferredList");
    dojo.require("dijit.form.Button");
    dojo.addOnLoad(function(){

      // stub search functions to simulate network delay

      function searchAmazon(){
        var d = new dojo.Deferred();
        setTimeout(function(){
          d.callback("We found books at amazon");
        }, 500);
        return d;
      }

      function searchBol(){
        var d = new dojo.Deferred();
        setTimeout(function(){
          d.callback("We found books at bol");
        }, 700);
        return d;
      }

      function searchGoogle(){
        var d = new dojo.Deferred();
        setTimeout(function(){
          d.callback("We found books at google");
        }, 200);
        return d;
      }

      dojo.connect(dijit.byId("search"), "onClick", function(){
        var d1 = searchAmazon(),
            d2 = searchBol(),
            d3 = searchGoogle();

        dojo.byId("statusSearch").innerHTML = "Searching....";

        // create a deferred list to aggregate the state
        var dl = new dojo.DeferredList([d1, d2, d3]);

        // a DeferredList has much the same API as a Deferred
        dl.addCallback(function(res){
          // "res" is an array of results
          dojo.byId("statusSearch").innerHTML = "Result: "+res[0][1]+", "+res[1][1]+", "+res[2][1];
          console.log(res);
        });
      });
    });
  </script>
 
  .. cv:: html
   
  <button dojoType="dijit.form.Button" id="search">Search</button>
  <div style="margin: 10px;">Status: <span id="statusSearch"></span></div>

Now when you look at the code, you will see that the total amount of setTimeout miliseconds is 1400 which is 1.4 seconds. Since we used dojo.Deferred we were able to bring down the waiting time to 700 ms, which is roughly what we might expect worst-case same-domain network lag to be. Instead of having to try to serialize a group of tasks, `DeferredList` objects let you do multiple things at once and only deal with the results.

To make the above example "live", you only need to note that calls to `dojo.xhr <dojo/xhr>`_ already returned `Deferred` instances, so a function like `searchAmazon` might be re-written as:

.. cv:: javascript

  function searchAmazon(query){
    return dojo.xhr("GET", {
      url: "/books/amazon",
      content: { q: query }
    });
  }

Dojo makes these patterns easy to work with, reducing the pain of asynchronous programming by using the `Deferred` pattern ubiquitiously.
