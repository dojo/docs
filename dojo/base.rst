## page was renamed from 1.2/dojo/base
#format dojo_rst

dojo._base
==========

:Status: Contributed, Draft
:Version: 1.0

dojo._base is a roll-up file, and is used to create the core dojo.js after a build. You should never directly dojo.require("dojo._base") as all the functionality is provided by simply including dojo.js on a page:

:code:
<!-- load dojo.js from AOL CDN -->
<script src="http://o.aolcdn.com/dojo/1.1/dojo/dojo.xd.js"></script>
