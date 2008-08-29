## page was renamed from 1.2/dojo/Deferred
#format dojo_rst

dojo.Deferred
=============

:Status: Contributed, Draft
:Version: 1.0

Dojo deferreds is a feature which you will find incredible useful for your daily client side development.
Lets start right off with an example where and why you would use dojo.Deferred.

Lets look at following use case:

You are providing a list of resources pulled in by different services. Lets base our example on a book search using several bookstores.
To simplify we will have installed several searching services on our server. An important fact about our example is that once all other stores have been searched you want to send a xhr call to some other server with the results. Remember this fact since this will be the reason why we will use dojo.Deferred.
Now lets look at our services:

1. /books/amazon
2. /books/bol
3. /books/google

Of course you now are saying, why provide different services when I could just provide

1. /books/search

which in return searches all three stores through the server.
You are right about that, but in our case it might be that you are accessing different servers. E.g. http://www.amazon.com/books/ and http://www.bol.com/book

Now we have three options to provide the ultimate user experience when a user wants to search for books in all three stores

1. We chain the xhr requests. Once the first request has been executed we run the second and the third and then make the call to our server

*Drawback: this will take very long since you basically are executing 3 requests after each other. Imagine 2 searches are a bit slow. This is not good*

2. We don't chain the requests and give each request a timeout and run the request to our server when on erequest is complete

*Drawback: this is probably the worst thing you can do since there is no reliable way to tell whether the other requests executed. DO NOT USE SUCH A TECHNIQUE*

3. We use dojo.Deferreds so all requests get executed at the same time. As soon as all 3 requests have been executed we will call our server:

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dojo.DeferredList");
    dojo.require("dijit.Button");
    dojo.addOnLoad(function(){
    function searchAmazon(){
      var d = new dojo.Deferred();
      setTimeout(function(){
        d.callback("We found books at amazon");
      }, 5000);
      return d;
    }

    function searchBol(){
      var d = new dojo.Deferred();
      setTimeout(function(){
        d.callback("We found books at bol");
      }, 7000);
      return d;
    }

    function searchGoogle(){
      var d = new dojo.Deferred();
      setTimeout(function(){
        d.callback("We found books at google");
      }, 2000);
      return d;
    }

    var d1 = searchAmazon();
    var d2 = searchBol();
    var d3 = searchGoogle();

    function search() {
      var dl = new dojo.DeferredList([d1, d2, d3]);
      dl.addCallback(function(res){
        console.log(res);
      });
    }
    });
    </script>
 
  .. cv:: html
   
    <button dojoType="dijit.form.Button" onClick="search()">Search</button>
