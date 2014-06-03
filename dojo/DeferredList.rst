.. _dojo/DeferredList:

=================
dojo/DeferredList
=================

.. contents ::
  :depth: 2

*Deprecated*  You should migrate to the new :ref:`dojo/promise <dojo/promise>` API.  
:ref:`dojo/promise/all <dojo/promise/all>` and :ref:`dojo/promise/first <dojo/promise/first>` replace the 
functionality provided by ``dojo/DeferredList``.

Introduction
============

*dojo/DeferredList* builds on :ref:`Deferred <dojo/_base/Deferred>`. ``Deferred`` objects make asynchronous programming
as easy as can be reasonably expected and ``DeferredList`` class builds on the "one answer to one question" contract of
``Deferred`` to provide a "one answer to many questions" system.

Usage
=====

.. js ::

  require(["dojo/DeferredList", "dojo/_base/Deferred"], function(DeferredList, Deferred){
    var d1 = new Deferred(),
        d2 = new Deferred();
    
    var dl = new DeferredList([d1, d2]);
    
    dl.then(function(result){
      // Executed when all deferred resolved
    });
    
    d1.resolve("some result");
    d2.resolve("some other result");
  });

Attributes
==========

================= ========= ===========================================================================================
Argument          Type      Description
================= ========= ===========================================================================================
list              Array     The list of ``Deferreds`` to be synchronized with this ``DeferredList``
fireOnOneCallback Boolean?  *Optional* Will cause the ``DeferredList`` callback to be fired as soon as any of the
                            ``Deferreds`` in its list have been fired instead of waiting until the entire list has
                            finished
fireOnOneErrback  Boolean?  *Optional* Will cause the errback to fire upon any of the ``Deferreds`` errback
consumeErrors     Boolean?  *Optional* Will fail silently on any errors from the ``Deferreds``
canceller         Function? *Optional* A ``Deferred`` canceller function, see 
                            :ref:`dojo/_base/Deferred <dojo/_base/Deferred>`.
================= ========= ===========================================================================================

Examples
========

One common task is notifying some listener when a list of resources pulled in by different services all become
available. For example, a search federated across several bookstores. Hearing about the results of a single search is a
good job for a :ref:`Deferred <dojo/_base/Deferred>`, but finding out about when they've all completed takes more
juggling.

Let's assume we've installed several proxies for search services on our server. Once all the stores have been searched,
we want to send an XHR call with search status to some logging service and provide the user an indication that we've
finished up all the work we were doing on their behalf.

The services are located at:

1. ``/books/amazon``
2. ``/books/bol``
3. ``/books/google``

Astute readers might be asking, "why provide different services when you could let the server do the coordination through a single URL?", for example:

1. ``/books/search``

which in return searches all three stores through the server. You, of course, could but in our case it might be that you
are accessing different servers. (e.g. `http://www.amazon.com/books/ <http://www.amazon.com/books/>`_ and
`http://www.bol.com/book <http://www.bol.com/book>`_ via JSON-P).

To give the user feedback about what's happening with the searches they issue, we have couple of options:

1. We could chain the XHR requests. Once the first request has been executed we run the second and the third and then
make the call to our server.

  *Drawback: this will take very long since you basically are executing 3 requests after each other. Imagine 2 searches
  are a bit slow. This is not good.*

2. We don't chain the requests and give each request a timeout and run the request to our server when one request is
complete.

  *Drawback: this is probably the worst thing you can do since there is no reliable way to tell whether the other
  requests executed.*

3. We use ``Deferreds`` to issue all the requests in parallel. As soon as all three requests have been executed we will
call our server, as in the following example:

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require(["dojo/DeferredList", "dojo/_base/Deferred", "dojo/dom", "dojo/on", "dojo/domReady!"],
    function(DeferredList, Deferred, dom, on){
      // stub search functions to simulate network latency
      function searchAmazon(){
        var d = new Deferred();
        setTimeout(function(){
          d.resolve("We found books at Amazon");
        }, 500);
        return d;
      }
      
      function searchBol(){
        var d = new Deferred();
        setTimeout(function(){
          d.resolve("We found books at bol");
        }, 700);
        return d;
      }
      
      function searchGoogle(){
        var d = new Deferred();
        setTimeout(function(){
          d.resolve("We found books at Google");
        }, 200);
        return d;
      }
      
      function search(){
        var d1 = searchAmazon(),
            d2 = searchBol(),
            d3 = searchGoogle();
        
        dom.byId("statusSearch").innerHTML = "Searching...";
        
        // create a DeferredList to aggregate the state
        var dl = new DeferredList([d1, d2, d3]);
        
        // a DeferredList has pretty much the same API as a Deferred
        dl.then(function(result){
          // "result" will be an array of results
          dom.byId("statusSearch").innerHTML = "Result: " + result[0][1] + ", " + result[1][1] + ", " + result[2][1];
          console.log(result);
        });
      }
      
      on(dom.byId("search"), "click", function(){
        search();
      });
    });
   
  .. html ::

    <button id="search" type="button">Search</button>
    <div style="margin: 10px;">Status: <span id="statusSearch"></span></div>

Now when you look at the code, you will see that the total amount of ``setTimeout`` milliseconds is 1400 which is 1.4
seconds. Since we used ``Deferred`` we were able to bring down the waiting time to 700 ms, which is roughly what we
might expect worst-case same-domain network lag to be. Instead of having to try to serialize a group of tasks,
``DeferredList`` objects let you do multiple things at once and only deal with the results.

To make the above example "live", you only need to note that calls to :ref:`dojo/_base/xhr <dojo/_base/xhr>` already
returned ``Deferred`` instances, so a function like ``searchAmazon`` might be re-written as:

.. js ::

  require(["dojo/_base/xhr"], function(xhr){
    function searchAmazon(query){
      return xhr("GET", {
        url: "/books/amazon",
        content: { q: query }
      });
    }
  });

Dojo makes these patterns easy to work with, reducing the pain of asynchronous programming by using the ``Deferred``
pattern ubiquitously.

See also
========

* `The Deferred Tutorial <http://dojotoolkit.org/documentation/tutorials/1.8/deferreds/>`_
* `The Promises Tutorial <http://dojotoolkit.org/documentation/tutorials/1.8/promises/>`_
* :ref:`dojo/_base/Deferred <dojo/_base/Deferred>`
* :ref:`dojo/_base/xhr <dojo/_base/xhr>`
