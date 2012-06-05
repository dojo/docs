.. _build/webkit-mobile:

===================================
Special Dojo Build: WebKit Mobile
===================================

This is a simple build to remove branches of code designed to accommodate Internet Explorer, Firefox, etc.
It should be used when:

    - target is only webkit mobile platforms (iOS and Android)
    - document is in standards mode (i.e., with <!DOCTYPE html>)

To create this special build:

.. code-block :: bash

  $ cd util/buildscripts/
  $ ./build.sh releaseDir=... action=release optimize=closure profile=webkitMobile


 
