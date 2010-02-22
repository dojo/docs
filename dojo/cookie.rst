#format dojo_rst

dojo.cookie
===========

:Status: Draft
:Version: 0.9

.. contents::
  :depth: 3

``dojo.cookie`` is your one stop for handling client side cookies. Its usage is very simple and the following example should make it clear

=====
Usage
=====

.. code-block :: javascript
  
  // To set a cookie
  dojo.cookie(cookieName, cookieValue, cookieProps);
  // To get a cookie
  var cookieValue = dojo.cookie(cookieName);

=============  ===============  ==================================================
Parameter      Type             Description
=============  ===============  ==================================================
cookieName     String           Name of the cookie to set/get
cookieValue    String           Value of the cookie to set.
cookieProps    Object           Poperties of the cookie (optional, can contain any of ``expire`` (number of days, date or UTC string indicating when the cookie will expire), ``path``, ``domain`` or ``secure`` (boolean) attributes. Use ``expire: -1`` to delete a cookie.

=============  ===============  ==================================================

Examples
--------

Set a cookie by clicking on the button, reload the page and click the "Get Cookie" button to check whether the cookie got set. 

*Note: cookies must be enabled for this to work ;)*

.. cv-compound::

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dijit.form.Button"); // this is there only to make things look fancy
    dojo.require("dojo.cookie");

    setCookie = function(){
      dojo.cookie("favouriteDish", "Nudels", {expires: 5});
    };

    getCookie = function(){
      alert("The value of the cookie is: "+dojo.cookie("favouriteDish"));
    };
    </script>

  .. cv:: html

    <button dojoType="dijit.form.Button" onClick="setCookie();">Set Cookie</button> <button dojoType="dijit.form.Button" onClick="getCookie();">Get Cookie</button>

========
See also
========

`Mozilla documentation about cookies <https://developer.mozilla.org/en/DOM/document.cookie>`_.
