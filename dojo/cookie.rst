.. _dojo/cookie:

===========
dojo.cookie
===========

.. contents ::
  :depth: 3

``dojo.cookie`` is your one stop for handling client side cookies. Its usage is very simple and the following example should make it clear

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

Set a cookie by clicking on the button, reload the page and click the "Get Cookie" button to check whether the cookie got set.

*Note: cookies must be enabled for this to work ;)*

.. code-example ::

  .. js ::

    dojo.require("dijit.form.Button"); // this is there only to make things look fancy
    dojo.require("dojo.cookie");

    setCookie = function(){
      dojo.cookie("favouriteDish", "Noodles", {expires: 5});
    };

    getCookie = function(){
      alert("The value of the cookie is: "+dojo.cookie("favouriteDish"));
    };

  .. html ::

    <button data-dojo-type="dijit/form/Button" data-dojo-props="onClick:setCookie">Set Cookie</button> <button data-dojo-type="dijit/form/Button" data-dojo-props="onClick:getCookie">Get Cookie</button>

.. api-inline :: dojo.cookie

See also
========

`Mozilla documentation about cookies <https://developer.mozilla.org/en/DOM/document.cookie>`_.
