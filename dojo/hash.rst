.. _dojo/hash:

=========
dojo/hash
=========

:since: 1.4

.. contents ::
    :depth: 3

**dojo/hash** provides methods for monitoring and updating the hash (history) in the browser URL as well as back/forward support and *bookmarkability* for dynamic web applications.

Introduction
============

``dojo/hash`` is designed to make it easier to manage the browser history (hash) as well a provide cross-browser ways to support dynamics backwards and forwards navigation and *bookmarkability*.  This allows for creating of dynamic web applications that can be navigable both in a non-linear fashion, but allows for you to provide your users with a "URL" to be able to return to a particular point in the application without actually doing a full page reload.

HTML5 defines an ``onhashchange`` event that fires when the value of the hash segment of the URL changes. See `HTML5 History <http://www.w3.org/TR/html5/history.html#history-traversal>`_.  ``dojo/hash`` uses the native ``onhashchange`` event if the browser supports it, and emulates this support for older browsers using a polling loop.

Usage
=====

Running code when the browser hash changes works by loading the ``dojo/hash`` module and then subscribing to the appropriate topic:

.. js ::

  require(["dojo/hash", "dojo/topic"], function(hash, topic){
    topic.subscribe("/dojo/hashchange", function(changedHash){
      // Handle the has change publish
    });
  });

The value of the change of the hash will be passed as the first argument.

To manipulate the value of the hash, simply call ``dojo/hash`` with the new value.  It will be added to the browser history stack and it will publish a ``/dojo/hashchange`` topic, triggering anything subscribed:

.. js ::

  require(["dojo/hash"], function(hash){
    hash("someURL");
  });

In order to not to add to the history stack, pass ``true`` as the second parameter (``replace``).  This will update the current browser URL and replace the current history state:

.. js ::

  require(["dojo/hash"], function(hash){
    hash("someURL", true);
  });

To get the current value of the hash, simply call the function without any arguments:

.. js ::

  require(["dojo/hash"], function(hash){
    var currentHash = hash();
  });

Examples
========

1) Subscribe to the hashchange event:

   .. js ::
   
    require(["dojo/_base/connect", "dojo/hash"], function(connect, hash){
        connect.subscribe("/dojo/hashchange", context, callback);
    });

2) Set the hash using query notation:

   .. js ::
   
    require(["dojo/hash", "dojo/io-query"], function(hash, ioQuery){
        var obj = {
            firstParam: true,
            secondParam: false
        }
        hash(ioQuery.objectToQuery(obj));
    });

 Hash: #firstParam=true&secondParam=false


3) Parse this hash and add a parameter using query notation:

 Initial hash: #firstParam=true&secondParam=false

 .. js ::

    require(["dojo/hash", "dojo/io-query"], function(hash, ioQuery){
        function updateHash(){
            var obj = ioQuery.queryToObject(dojo.hash());  // get
            obj.someNewParam = true;
            hash(ioQuery.objectToQuery(obj));  // set
        }
    });

 End hash: #firstParam=true&secondParam=false&someNewParam=true

4) React to hashchange event (hash passed to callback as first param):

   .. js ::

    require(["dojo/hash", "dojo/io-query"], function(hash, ioQuery){
        function callback(hash){
            // hashchange event!
            var obj = ioQuery.queryToObject(hash);
            if(obj.firstParam){
                // do something
            }
        }
    });

5) Get and set the hash using slash notation:

 Initial hash:  #/firstSegment/secondSegment

 .. js ::

    require(["dojo/hash"], function(hash){
        function updateHash(){
            var obj = hash().split("/");
            obj.push("trailingSegment");
            hash(obj.join("/"));
        }
    });

 End hash:  #/firstSegment/secondSegment/trailingSegment

Notes
=====

Customizing the Polling Loop Frequency
--------------------------------------

For browsers that do not support the ``onhashchange`` event natively, a polling loops monitors the URL for changes. The default duration of this polling loop is 100 ms.  To customize this value, add ``hashPollFrequency`` to dojo config.

.. js ::

  dojoConfig = { hashPollFrequency: 200 };

Encoding/Decoding
-----------------

``dojo/hash`` does not attempt to do any encoding or decoding.  There are many cases where consumers of ``dojo/hash`` want unencoded slashes, etc, so it is up to the consumer to encode and decode where appropriate. Anything with HTML encoding (e.g. ``&amp;``) must be encoded with ``encodeURIComponent`` before being passed into ``dojo/hash`` due to discrepancies between browsers.  For example Firefox decodes HTML encoding automatically before setting the URL, IE does not.

.. js ::

  require(["dojo/hash"], function(hash){
    hash(encodeURIComponent("hash with &amp; HTML encoding"));
  });

See Also
========

* :ref:`dojo/back <dojo/back>` - Module for handling browser "back" events.

* :ref:`dojo/io-query <dojo/io-query>` - Module the contains URL processing functions.

* :ref:`dojo/router <dojo/router>` - Module that provides mapping of a hash to a callback.
