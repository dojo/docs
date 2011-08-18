#format dojo_rst

AMD Module Returns
==================

.. contents::
  :depth: 2

This page documents the new locations for Dojo methods, that have traditionally been accessed through the Dojo base object, which are now available as separate modules. As part of the move to full AMD support, in 1.7 and beyond, Dojo's base modules need to be explicitly given as individually module dependencies.

Each section below corresponds to a single AMD module, listing the methods returned along with their pre-AMD location.

================
dojo/_base/array
================

=====================================================   ============================   ====================================
1.x syntax                                              2.0 module                     2.0 syntax
=====================================================   ============================   ====================================
dojo.forEach                                            dojo/_base/array               array.forEach
dojo.map                                                dojo/_base/array               array.map
dojo.filter                                             dojo/_base/array               array.filter
dojo.every                                              dojo/_base/array               array.every
dojo.some                                               dojo/_base/array               array.some
dojo.indexOf                                            dojo/_base/array               array.indexOf
=====================================================   ============================   ====================================

==================
dojo/_base/declare
==================

=====================================================   ============================   ====================================
1.x syntax                                              2.0 module                     2.0 syntax
=====================================================   ============================   ====================================
dojo.declare                                            dojo/_base/declare             declare
=====================================================   ============================   ====================================

===================
dojo/_base/Deferred
===================

=====================================================   ============================   ====================================
1.x syntax                                              2.0 module                     2.0 syntax
=====================================================   ============================   ====================================
dojo.Deferred                                           dojo/_base/Deferred            Deferred
dojo.when                                               dojo/_base/Deferred            Deferred.when
=====================================================   ============================   ====================================

================
dojo/_base/event
================

=====================================================   ============================   ====================================
1.x syntax                                              2.0 module                     2.0 syntax
=====================================================   ============================   ====================================
dojo.fixEvent                                           dojo/_base/event               event.fix
dojo.stopEvent                                          dojo/_base/event               event.stop
=====================================================   ============================   ====================================

================
dojo/_base/fx
================

=====================================================   ============================   ====================================
1.x syntax                                              2.0 module                     2.0 syntax
=====================================================   ============================   ====================================
dojo._Line                                              dojo/_base/fx                  fx._Line
dojo.Animation                                          dojo/_base/fx                  fx.Animation
dojo._fade                                              dojo/_base/fx                  fx._fade
dojo.fadeIn                                             dojo/_base/fx                  fx.fadeIn
dojo.fadeOut                                            dojo/_base/fx                  fx.fadeOut
dojo._defaultEasing                                     dojo/_base/fx                  fx._defaultEasing
dojo.animateProperty                                    dojo/_base/fx                  fx.animateProperty
dojo.anim                                               dojo/_base/fx                  fx.anim
=====================================================   ============================   ====================================

=================
dojo/_base/kernel
=================

=====================================================   ============================   ====================================
1.x syntax                                              2.0 module                     2.0 syntax
=====================================================   ============================   ====================================
dojo.deprecated                                         dojo/_base/kernel              kernel.deprecated
dojo.experimental                                       dojo/_base/kernel              kernel.experimental
dojo.version                                            dojo/_base/kernel              kernel.version
=====================================================   ============================   ====================================


================
dojo/_base/lang
================

=====================================================   ============================   ====================================
1.x syntax                                              2.0 module                     2.0 syntax
=====================================================   ============================   ====================================
dojo.extend                                             dojo/_base/lang                lang.extend
dojo._hitchArgs                                         dojo/_base/lang                lang._hitchArgs
dojo.hitch                                              dojo/_base/lang                lang.hitch
dojo.delegate                                           dojo/_base/lang                lang.delegate
dojo._toArray                                           dojo/_base/lang                lang._toArray
dojo.partial                                            dojo/_base/lang                lang.partial
dojo.clone                                              dojo/_base/lang                lang.clone
dojo.trim                                               dojo/_base/lang                lang.trim
dojo.replace                                            dojo/_base/lang                lang.replace
dojo.mixin                                              dojo/_base/lang                lang.mixin
dojo._mixin                                             dojo/_base/lang                lang._mixin
dojo.exists                                             dojo/_base/lang                lang.exists
dojo.getObject                                          dojo/_base/lang                lang.getObject
dojo.setObject                                          dojo/_base/lang                lang.setObject
=====================================================   ============================   ====================================


================
dojo/_base/sniff
================

=====================================================   ============================   ====================================
1.x syntax                                              2.0 module                     2.0 syntax
=====================================================   ============================   ====================================
dojo.isOpera                                            dojo/_base/sniff               has("opera")
dojo.isAIR                                              dojo/_base/sniff               has("air")
dojo.isKhtml                                            dojo/_base/sniff               has("khtml")
dojo.isWebKit                                           dojo/_base/sniff               has("webkit")
dojo.isChrome                                           dojo/_base/sniff               has("chrome")
dojo.isMac                                              dojo/_base/sniff               has("mac")
dojo.isSafari                                           dojo/_base/sniff               has("safari")
dojo.isMozilla                                          dojo/_base/sniff               has("mozilla")
dojo.isMoz                                              dojo/_base/sniff               has("mozilla")
dojo.isIE                                               dojo/_base/sniff               has("ie")
dojo.isFF                                               dojo/_base/sniff               has("ff")
dojo.isAndroid                                          dojo/_base/sniff               has("android")
dojo.isBB                                               dojo/_base/sniff               has("bb")
dojo.isIpad                                             dojo/_base/sniff               has("ipad")
dojo.isIphone                                           dojo/_base/sniff               has("iphone")
dojo.isIpod                                             dojo/_base/sniff               has("ipod")
dojo.isQuirks                                           dojo/_base/sniff               dojo/_base/kernel
dojo.isIos                                              dojo/_base/sniff               has("ios")
=====================================================   ============================   ====================================

=================
dojo/_base/unload
=================

=====================================================   ============================   ====================================
1.x syntax                                              2.0 module                     2.0 syntax
=====================================================   ============================   ====================================
dojo.addOnUnload                                        dojo/_base/unload              unload.addOnUnload
dojo.addOnWindowUnload                                  dojo/_base/unload              unload.addOnWindowUnload
=====================================================   ============================   ====================================

=================
dojo/_base/window
=================

=====================================================   ============================   ====================================
1.x syntax                                              2.0 module                     2.0 syntax
=====================================================   ============================   ====================================
dojo.global                                             dojo/_base/window              window.global
dojo.doc                                                dojo/_base/window              window.doc
dojo.body                                               dojo/_base/window              window.body
dojo.setContext                                         dojo/_base/window              window.setContext
dojo.withGlobal                                         dojo/_base/window              window.withGlobal
dojo.withDoc                                            dojo/_base/window              window.withDoc
=====================================================   ============================   ====================================

================
dojo/_base/xhr
================

=====================================================   ============================   ====================================
1.x syntax                                              2.0 module                     2.0 syntax
=====================================================   ============================   ====================================
dojo.contentHandlers                                    dojo/_base/xhr                 xhr.contentHandlers
dojo._ioSetArgs                                         dojo/_base/xhr                 xhr._ioSetArgs
dojo._ioCancelAll                                       dojo/_base/xhr                 xhr._ioCancelAll
dojo._ioNotifyStart                                     dojo/_base/xhr                 xhr._ioNotifyStart
dojo._ioWatch                                           dojo/_base/xhr                 xhr._ioWatch
dojo._ioAddQueryToUrl                                   dojo/_base/xhr                 xhr._ioAddQueryToUrl
dojo.xhrGet                                             dojo/_base/xhr                 xhr.get
dojo.xhrPost                                            dojo/_base/xhr                 xhr.post
dojo.xhrPut                                             dojo/_base/xhr                 xhr.put
dojo.xhrDelete                                          dojo/_base/xhr                 xhr.del
dojo._xhrObj                                            dojo/_base/xhr                 xhr._xhrObj
=====================================================   ============================   ====================================

================
dojo/dom
================

=====================================================   ============================   ====================================
1.x syntax                                              2.0 module                     2.0 syntax
=====================================================   ============================   ====================================
dojo.byId                                               dojo/dom                       dom.byId
dojo.isDescendant                                       dojo/dom                       dom.isDescendant
dojo.setSelectable                                      dojo/dom                       dom.setSelectable
=====================================================   ============================   ====================================

================
dojo/dom-attr
================

=====================================================   ============================   ====================================
1.x syntax                                              2.0 module                     2.0 syntax
=====================================================   ============================   ====================================
dojo.attr(node, attr)                                   dojo/dom-attr                  attr.get(node, attr)
dojo.attr(node, attr, val)                              dojo/dom-attr                  attr.set(node, attr, val)
dojo.hasAttr                                            dojo/dom-attr                  attr.has
dojo.removeAttr                                         dojo/dom-attr                  attr.remove
=====================================================   ============================   ====================================

================
dojo/dom-class
================

=====================================================   ============================   ====================================
1.x syntax                                              2.0 module                     2.0 syntax
=====================================================   ============================   ====================================
dojo.addClass                                           dojo/dom-class                 domClass.add
dojo.hasClass                                           dojo/dom-class                 domClass.contains
dojo.removeClass                                        dojo/dom-class                 domClass.remove
dojo.replaceClass                                       dojo/dom-class                 domClass.replace
dojo.toggleClass                                        dojo/dom-class                 domClass.toggle
=====================================================   ============================   ====================================

==================
dojo/dom-construct
==================

=====================================================   ============================   ====================================
1.x syntax                                              2.0 module                     2.0 syntax
=====================================================   ============================   ====================================
dojo.toDom                                              dojo/dom-construct             construct.toDom
dojo.place                                              dojo/dom-construct             construct.place
dojo.create                                             dojo/dom-construct             construct.create
dojo.empty                                              dojo/dom-construct             construct.empty
dojo.destroy                                            dojo/dom-construct             construct.destroy
=====================================================   ============================   ====================================

================
dojo/dom-form
================

=====================================================   ============================   ====================================
1.x syntax                                              2.0 module                     2.0 syntax
=====================================================   ============================   ====================================
dojo.fieldToObject                                      dojo/dom-form                  form.fieldToObject
dojo.formToObject                                       dojo/dom-form                  form.formToObject
dojo.formToQuery                                        dojo/dom-form                  form.toQuery
dojo.formToJson                                         dojo/dom-form                  form.toJson
=====================================================   ============================   ====================================


=================
dojo/dom-geometry
=================

=====================================================   ============================   ====================================
1.x syntax                                              2.0 module                     2.0 syntax
=====================================================   ============================   ====================================
dojo._getPadExtents                                     dojo/dom-geometry              geometry.getPadExtents
dojo._getBorderExtents                                  dojo/dom-geometry              geometry.getBorderExtents
dojo._getPadBorderExtents                               dojo/dom-geometry              geometry.getPadBorderExtents
dojo._getMarginExtents                                  dojo/dom-geometry              geometry.getMarginExtents
dojo._getMarginSize                                     dojo/dom-geometry              geometry.getMarginSize
dojo._getMarginBox                                      dojo/dom-geometry              geometry.getMarginBox
dojo._setMarginBox                                      dojo/dom-geometry              geometry.setMarginBox
dojo.marginBox(node)                                    dojo/dom-geometry              geometry.getMarginBox(node)
dojo.marginBox(node,size)                               dojo/dom-geometry              geometry.setMarginBox(node,size)
dojo._getContentBox                                     dojo/dom-geometry              geometry.getContentBox
dojo.setContentSize                                     dojo/dom-geometry              geometry.setContentSize
dojo.contentBox(node)                                   dojo/dom-geometry              geometry.getContentBox(node)
dojo.contentBox(node,size)                              dojo/dom-geometry              geometry.setContentSize(node,size)
dojo.position                                           dojo/dom-geometry              geometry.position
dojo._isBodyLtr                                         dojo/dom-geometry              geometry.isBodyLtr
dojo._docScroll                                         dojo/dom-geometry              geometry.docScroll
dojo._getIeDocumentElementOffset                        dojo/dom-geometry              geometry.getIeDocumentElementOffset
dojo._fixIeBiDiScrollLeft                               dojo/dom-geometry              geometry.fixIeBiDiScrollLeft
=====================================================   ============================   ====================================

================
dojo/dom-style
================

=====================================================   ============================   ====================================
1.x syntax                                              2.0 module                     2.0 syntax
=====================================================   ============================   ====================================
dojo.style(node, attr)                                  dojo/dom-style                 style.get(node, attr)
dojo.style(node, attr, val)                             dojo/dom-style                 style.set(node, attr, val)
dojo.style(node, hash)                                  dojo/dom-style                 style.set(node, hash)
dojo.getComputedStyle                                   dojo/dom-style                 style.getComputedStyle
dojo._toPixelValue                                      dojo/dom-style                 style.toPixelValue
=====================================================   ============================   ====================================

================
dojo/io-query
================

=====================================================   ============================   ====================================
1.x syntax                                              2.0 module                     2.0 syntax
=====================================================   ============================   ====================================
dojo.queryToObject                                      dojo/io-query                  ioQuery.queryToObject
dojo.objectToQuery                                      dojo/io-query                  ioQuery.objectToQuery
=====================================================   ============================   ====================================

================
dojo/json
================

=====================================================   ============================   ====================================
1.x syntax                                              2.0 module                     2.0 syntax
=====================================================   ============================   ====================================
dojo.fromJson                                           dojo/json                      json.parse
dojo.toJson                                             dojo/json                      json.stringify
=====================================================   ============================   ====================================

================
dojo/keys
================

=====================================================   ============================   ====================================
1.x syntax                                              2.0 module                     2.0 syntax
=====================================================   ============================   ====================================
dojo.keys                                               dojo/keys                      keys
=====================================================   ============================   ====================================

================
dojo/NodeList
================

=====================================================   ============================   ====================================
1.x syntax                                              2.0 module                     2.0 syntax
=====================================================   ============================   ====================================
dojo.NodeList                                           dojo/NodeList                  NodeList
=====================================================   ============================   ====================================


================
dojo/on
================

=====================================================   ============================   ====================================
1.x syntax                                              2.0 module                     2.0 syntax
=====================================================   ============================   ====================================
dojo.connect(node,"onclick",cb)                         dojo/on                        on(node,"click",cb)
dojo.publish("/foo", [1,2,3])                           dojo/on                        on.emit("/foo", 1, 2, 3)
dojo.subscribe("/foo", callback)                        dojo/on                        on("/foo", callback)
=====================================================   ============================   ====================================

================
dojo/ready
================

=====================================================   ============================   ====================================
1.x syntax                                              2.0 module                     2.0 syntax
=====================================================   ============================   ====================================
dojo.addOnLoad                                          dojo/ready                     ready
=====================================================   ============================   ====================================

================
dojo/_Url
================

=====================================================   ============================   ====================================
1.x syntax                                              2.0 module                     2.0 syntax
=====================================================   ============================   ====================================
dojo._Url                                               dojo/_Url                      _Url
=====================================================   ============================   ====================================

======================
TODO
======================

=====================================================   ============================   ====================================
1.x syntax                                              2.0 module                     2.0 syntax
=====================================================   ============================   ====================================
dojo.window                                             dojo/window                    window
dojo.Color                                              dojo/_base/Color               Color
dojo.cookie                                             dojo/cookie                    cookie
dojo.data.*                                             dojo/data/*                    ...
dojo.date.locale                                        dojo/date/locale               
dojo.date.stamp                                         dojo/date/stamp                
dojo.date                                               dojo/date                      
dojo.dnd.*                                              dojo/dnd/*                     
dojo.DeferredList                                       dojo/DeferredList              
dojo.fx.*                                               dojo/fx                        fx.*
dojo.hash                                               dojo/hash                      hash
dojo.html                                               dojo/html                      html
dojo.i18n                                               dojo/i18n                      i18n
dojo.currency                                           dojo/currency                  currency
dojo.number                                             dojo/number                    number
dojo.parser                                             dojo/parser                    parser
dojo.string                                             dojo/string                    string
dojo.Stateful                                           dojo/Stateful                  Stateful
dojo.ready                                              dojo/ready                     ready
dojo.query("li").connect("onclick",cb)                  dojo/query                     query.on("click",cb)
dojo.window.*                                           dojo/window                    window.*
dojo.mouseButtons.is***()                               dojo/mouse                     mouse.is***()
dojo.connect(obj,method,cb)                             dojo/aspect                    aspect.after(obj,method,cb)
dojo.config                                             dojo/_base/config              config
dojo.moduleUrl("dijit", "foo.template.html)             require                        require.toUrl("dijit/foo/template.html")
=====================================================   ============================   ====================================

======================
Removed/Orphaned/Misc.
======================

=====================================================   ============================   ====================================
1.x syntax                                              2.0 module                     2.0 syntax
=====================================================   ============================   ====================================
dojo.isString(val)                                                                     typeof val == "string"
dojo.isArray(val)                                                                      val instanceof Array
dojo.isFunction(val)                                                                   typeof val == "function"
dojo.isObject(val)                                                                     typeof val == "object" || typeof val == "function"
dojo.isArrayLike(val)                                                                  'length' in val
dojo.isAlien(val)                                                                      no substitute
dojo.unsubscribe(handle)                                                               handle.remove()
dojo.disconnect(handle)                                                                handle.remove();
dojo.connectPublisher                                   ?                              ?
dojo.isCopyKey                                          ?                              ?
=====================================================   ============================   ====================================


Notes
-----

Generated from:
   - dojo core/base: http://oksoclap.com/siWDgVDJjI
   - dijit (in progress): http://oksoclap.com/fEK8S2HvGp
   - awk script to convert from raw data to REST format is http://oksoclap.com/LSETyLpsex

TODO: roll in changes from there

TODO: rename this page
