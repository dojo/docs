#format dojo_rst

dojo.string
===========

:Status: Draft
:Version: 1.0

.. contents::
   :depth: 2

TODO: short summary of the component/class/method


============
Introduction
============

String utilities for the Dojo toolkit

.. cv-compound::
  
  .. cv:: javascript

    <script type="text/javascript">
        dojo.addOnLoad(function(){
            console.log(dojo.string.trim(dojo.byId("foo").innerHTML));
        });
    </script>

  .. cv:: html

    <div id="foo">  Hi dojo.beercamp </div>

  .. cv:: css

    <style type="text/css">
      #foo {
          color: red;
      }    
    </style>
