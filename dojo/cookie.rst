.. _dojo/cookie:

===========
dojo/cookie
===========

.. contents ::
  :depth: 2

**dojo/cookie** is your one stop for handling client side cookies. Its usage is very simple and the following example
should make it clear.

Usage
=====

.. js ::
  
  require(["dojo/cookie"], function(cookie){
     // To set a cookie
     cookie(cookieName, cookieValue, cookieProps);
     // To get a cookie
     var cookieValue = cookie(cookieName);
  });

Example
=======

Set a cookie by clicking on the button, reload the page and click the "Get Cookie" button to check whether the cookie
got set.

*Note: cookies must be enabled for this to work ;)*

.. code-example ::
  :djConfig: async: true, parseOnLoad: false

  .. js ::

    require(["dojo/cookie", "dojo/dom", "dojo/on", "dojo/domReady!"], 
    function(cookie, dom, on){
      on(dom.byId("setCookie"), "click", function(){
        cookie("favouriteDish", "Noodles", { expires: 5 });
      });
      on(dom.byId("getCookie"), "click", function(){
        alert("The value of the cookies is: " + cookie("favouriteDish"));
      });
    });

  .. html ::

    <button id="setCookie">Set Cookie</button>
    <button id="getCookie">Get Cookie</button>

See also
========

* `Mozilla documentation about cookies <https://developer.mozilla.org/en/DOM/document.cookie>`_.
