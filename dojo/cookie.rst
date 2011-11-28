.. _dojo/cookie:

===========
dojo.cookie
===========

.. contents::
  :depth: 3

``dojo.cookie`` is your one stop for handling client side cookies. Its usage is very simple and the following example should make it clear

Usage
=====

.. js ::
  
  // dojo 1.7 (AMD)
  require(["dojo/cookie"], function(cookie){
     // To set a cookie
     cookie(cookieName, cookieValue, cookieProps);
     // To get a cookie
     var cookieValue = cookie(cookieName);
  });

  // dojo < 1.7
  // To set a cookie
  dojo.cookie(cookieName, cookieValue, cookieProps);
  // To get a cookie
  var cookieValue = dojo.cookie(cookieName);

=============  ===============  ==================================================
Parameter      Type             Description
=============  ===============  ==================================================
cookieName     String           Name of the cookie to set/get
cookieValue    String           Value of the cookie to set.
cookieProps    Object           Poperties of the cookie (optional, can contain any of ``expires`` (number of days, date or UTC string indicating when the cookie will expire), ``path``, ``domain`` or ``secure`` (boolean) attributes. Use ``expires: -1`` to delete a cookie.
=============  ===============  ==================================================

Examples
--------

Set a cookie by clicking on the button, reload the page and click the "Get Cookie" button to check whether the cookie got set.

*Note: cookies must be enabled for this to work ;)*

.. code-example ::

  .. js ::

    <script type="text/javascript">
    dojo.require("dijit.form.Button"); // this is there only to make things look fancy
    dojo.require("dojo.cookie");

    setCookie = function(){
      dojo.cookie("favouriteDish", "Noodles", {expires: 5});
    };

    getCookie = function(){
      alert("The value of the cookie is: "+dojo.cookie("favouriteDish"));
    };
    </script>

  .. html ::

    <button data-dojo-type="dijit.form.Button" data-dojo-props="onClick:setCookie">Set Cookie</button> <button data-dojo-type="dijit.form.Button" data-dojo-props="onClick:getCookie">Get Cookie</button>

See also
========

`Mozilla documentation about cookies <https://developer.mozilla.org/en/DOM/document.cookie>`_.
