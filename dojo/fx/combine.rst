#dojo_rst

dojo.fx.combine
===============

:Status: Draft
:Version: 1.0
:Authors: Peter Higgins, Nikolai Onken, Marcus Reimann, Jared Jurkiewicz
:Developers: Bryan Forbes, Peter Higgins, Eugene Lazutkin, Bill Keese, Adam Peller, Alex Russell, Dylan Schiemann, sjmiles
:Available: since V1.0

.. contents::
    :depth: 2

The *dojo.fx.combine()* is a helper function that can take a list of dojo._Animation objects and combine them so that their effects all run in parallel.  With this function animations that affect multiple nodes can be generated and executed at the same time.
