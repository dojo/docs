#format dojo_rst

dojo.cookie
===========

:Status: Draft
:Version: 0.9

.. contents::
  :depth: 3

dojo.cookie is your one stop for handling client side cookies. Its usage is very simple and the following example should make it clear

Examples
--------

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
