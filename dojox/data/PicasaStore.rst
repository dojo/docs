#format dojo_rst

dojo.data.PicasaStore
=====================

.. contents::
  :depth: 3

Dojo has several examples of browser in-memory stores, such as `dojo.data.ItemFileReadStore <dojo/data/ItemFileReadStore>`_, `dojox.data.CsvStore <dojox/data/CsvStore>`_, <dojox/data/FlickrStore>`_, and `dojox.data.OpmlStore <dojox/data/OpmlStore>`_. While these stores are useful and great examples of how data stores can be used to wrapper accessing data, they are not the only way data is served and processed. In many cases, data stores can wrapper external services. It is those services that perform the querying and filtering of data, and then provide only that as a subset back to the data store for presentation as items.

PicasaStore is one such store. The purpose of PicasaStore is to wrapper the public photo feed of the Picasa service. Then by simply using the PicasaStore store, as you would any data store in Dojo, you now have access to querying the vast repository of public photos made available by others on the Web.

**Note: While this store wraps making calls to the Picasa service, as a user, you should still verify that you agree to the terms and conditions by which you are using the public picasa photo service. Review their terms and conditions, and the API terms and conditions.**

The Picasa service provides its data back in a wide variety of formats (for example, ATOM, RSS, and JSON) but PicasaStore only makes use of the JSON format. The following example shows a query that PicasaStore processes and the response:

=============================
Brief intro to the Picasa API
=============================

Query
-----

Query (all pictures with tags animals, foxes, and cute):

.. code-block :: javascript
  
  http://picasaweb.google.com/data/feed/api/all?alt=jsonm&pp=1&psc=G&start-index=1&q=animals%2Cfoxes%2Ccute&max-results=5&callback=jsonpCallback

Response
--------

.. code-block :: javascript 

    jsonpCallback({
     "encoding": "UTF-8",
     "feed": {
      "id": "http://picasaweb.google.com/data/feed/api/all",
      "updated": "2009-04-08T20:07:20.000Z",
      "title": "Search Results",
      "link": [
       {
        "rel": "http://schemas.google.com/g/2005#feed",
        "type": "application/atom+xml",
        "href": "http://picasaweb.google.com/data/feed/api/all"
       },
       {
        "rel": "self",
        "type": "application/atom+xml",
        "href": "http://picasaweb.google.com/data/feed/api/all?alt\u003djsonm\u0026q\u003danimals%2Cfoxes%2Ccute\u0026start-index\u003d1\u0026max-results\u003d5\u0026psc\u003dG\u0026callback\u003ddojo.io.script.jsonp_dojoIoScript2._jsonpCallback\u0026pp\u003d1"
       },
       {
        "rel": "next",
        "type": "application/atom+xml",
        "href": "http://picasaweb.google.com/data/feed/api/all?alt\u003djsonm\u0026q\u003danimals%2Cfoxes%2Ccute\u0026start-index\u003d6\u0026max-results\u003d5\u0026psc\u003dG\u0026callback\u003ddojo.io.script.jsonp_dojoIoScript2._jsonpCallback\u0026pp\u003d1"
       }
      ],
      "generator": "Picasaweb",
      "generator$version": "1.00",
      "generator$uri": "http://picasaweb.google.com/",
      "totalResults": 34,
      "startIndex": 1,
      "itemsPerPage": 5,
      "crowdedLength": 34,
      "entry": [
       {
        "id": "http://picasaweb.google.com/data/entry/api/user/heidi.haas/albumid/5322414235966258241/photoid/5322414700192663826?alt\u003djsonm",
        "published": "2009-04-08T20:07:20.000Z",
        "updated": "2009-04-08T20:07:20.000Z",
        "category": [
         {
          "scheme": "http://schemas.google.com/g/2005#kind",
          "term": "http://schemas.google.com/photos/2007#photo"
         }
        ],
        "title": "H2W-YNP-118-H2W_0649.jpg",
        "summary": "cute fox in the Interior making a run for it",
        "content$src": "http://lh3.ggpht.com/_feanDHO1Syk/Sd0D-HBNCRI/AAAAAAAABJQ/ns-gkdSE13A/H2W-YNP-118-H2W_0649.jpg",
        "link": [
         {
          "rel": "http://schemas.google.com/g/2005#feed",
          "type": "application/atom+xml",
          "href": "http://picasaweb.google.com/data/feed/api/user/heidi.haas/albumid/5322414235966258241/photoid/5322414700192663826?alt\u003djsonm"
         },
         {
          "rel": "alternate",
          "type": "text/html",
          "href": "http://picasaweb.google.com/heidi.haas/YellowstoneInWinter#5322414700192663826"
         },
         {
          "rel": "http://schemas.google.com/photos/2007#canonical",
          "type": "text/html",
          "href": "http://picasaweb.google.com/lh/photo/g68j-ESNvfdbt_auH5_Qsw"
         },
         {
          "rel": "self",
          "type": "application/atom+xml",
          "href": "http://picasaweb.google.com/data/entry/api/user/heidi.haas/albumid/5322414235966258241/photoid/5322414700192663826?alt\u003djsonm"
         },
         {
          "rel": "http://schemas.google.com/photos/2007#report",
          "type": "text/html",
          "href": "http://picasaweb.google.com/lh/reportAbuse?uname\u003dheidi.haas\u0026aid\u003d5322414235966258241\u0026iid\u003d5322414700192663826"
         }
        ],
        "author": [
         {
          "name": "Heidi",
          "uri": "http://picasaweb.google.com/heidi.haas",
          "email": "heidi.haas",
          "user": "heidi.haas",
          "nickname": "Heidi",
          "thumbnail": "http://lh4.ggpht.com/_feanDHO1Syk/AAAASfvC6bo/AAAAAAAAAAA/6Wv0CyhG1Gg/s48-c/heidi.haas.jpg"
         }
        ],
        "gphoto$id": "5322414700192663826",
        "albumId": "5322414235966258241",
        "access": "public",
        "width": "1024",
        "height": "686",
        "timestamp": "1234429543000",
        "commentingEnabled": "true",
        "commentCount": 0,
        "exif": {
         "fstop": "5.6",
         "make": "NIKON CORPORATION",
         "model": "NIKON D200",
         "exposure": "0.0080",
         "flash": "false",
         "focalLength": "260.0",
         "iso": "100",
         "time": "1234429543000"
        },
        "media": {
         "content": [
          {
           "url": "http://lh3.ggpht.com/_feanDHO1Syk/Sd0D-HBNCRI/AAAAAAAABJQ/ns-gkdSE13A/H2W-YNP-118-H2W_0649.jpg",
           "height": 686,
           "width": 1024,
           "type": "image/jpeg",
           "medium": "image"
          }
         ],
         "credit": [
          "Heidi"
         ],
         "description": "cute fox in the Interior making a run for it",
         "description$type": "plain",
         "keywords": "Animals, Fox, Wildlife, Yellowstone National Park",
         "thumbnail": [
          {
           "url": "http://lh3.ggpht.com/_feanDHO1Syk/Sd0D-HBNCRI/AAAAAAAABJQ/ns-gkdSE13A/s72/H2W-YNP-118-H2W_0649.jpg",
           "height": 49,
           "width": 72
          },
          {
           "url": "http://lh3.ggpht.com/_feanDHO1Syk/Sd0D-HBNCRI/AAAAAAAABJQ/ns-gkdSE13A/s144/H2W-YNP-118-H2W_0649.jpg",
           "height": 97,
           "width": 144
          },
          {
           "url": "http://lh3.ggpht.com/_feanDHO1Syk/Sd0D-HBNCRI/AAAAAAAABJQ/ns-gkdSE13A/s288/H2W-YNP-118-H2W_0649.jpg",
           "height": 193,
           "width": 288
          }
         ],
         "title": "H2W-YNP-118-H2W_0649.jpg",
         "title$type": "plain"
        },
        "georss$where": {
         "gml$Point": {
          "gml$pos": "44.771151 -110.577383"
         }
        },
        "albumTitle": "Yellowstone in Winter",
        "albumCTitle": "YellowstoneInWinter",
        "gphoto$albumdesc": {
         "$t": "Yellowstone in Winter Feb 09"
        },
        "location": "Yellowstone National Park",
        "snippet": "\u003cb\u003eAnimals\u003c/b\u003e, \u003cb\u003eFox\u003c/b\u003e ...",
        "snippetType": "PHOTO_TAGS",
        "truncated": "0"
       },
       {
        "id": "http://picasaweb.google.com/data/entry/api/user/heidi.haas/albumid/5322414235966258241/photoid/5322414697748906370?alt\u003djsonm",
        "published": "2009-04-08T20:07:19.000Z",
        "updated": "2009-04-08T20:07:19.000Z",
        "category": [
         {
          "scheme": "http://schemas.google.com/g/2005#kind",
          "term": "http://schemas.google.com/photos/2007#photo"
         }
        ],
        "title": "H2W-YNP-116-H2W_0643.jpg",
        "summary": "cute fox in the Interior mousing - all in!",
        "content$src": "http://lh5.ggpht.com/_feanDHO1Syk/Sd0D996kQYI/AAAAAAAABJA/BxFkVFBC4MY/H2W-YNP-116-H2W_0643.jpg",
        "link": [
         {
          "rel": "http://schemas.google.com/g/2005#feed",
          "type": "application/atom+xml",
          "href": "http://picasaweb.google.com/data/feed/api/user/heidi.haas/albumid/5322414235966258241/photoid/5322414697748906370?alt\u003djsonm"
         },
         {
          "rel": "alternate",
          "type": "text/html",
          "href": "http://picasaweb.google.com/heidi.haas/YellowstoneInWinter#5322414697748906370"
         },
         {
          "rel": "http://schemas.google.com/photos/2007#canonical",
          "type": "text/html",
          "href": "http://picasaweb.google.com/lh/photo/MAsj7YkmeHpv7i1Xd72ADg"
         },
         {
          "rel": "self",
          "type": "application/atom+xml",
          "href": "http://picasaweb.google.com/data/entry/api/user/heidi.haas/albumid/5322414235966258241/photoid/5322414697748906370?alt\u003djsonm"
         },
         {
          "rel": "http://schemas.google.com/photos/2007#report",
          "type": "text/html",
          "href": "http://picasaweb.google.com/lh/reportAbuse?uname\u003dheidi.haas\u0026aid\u003d5322414235966258241\u0026iid\u003d5322414697748906370"
         }
        ],
        "author": [
         {
          "name": "Heidi",
          "uri": "http://picasaweb.google.com/heidi.haas",
          "email": "heidi.haas",
          "user": "heidi.haas",
          "nickname": "Heidi",
          "thumbnail": "http://lh4.ggpht.com/_feanDHO1Syk/AAAASfvC6bo/AAAAAAAAAAA/6Wv0CyhG1Gg/s48-c/heidi.haas.jpg"
         }
        ],
        "gphoto$id": "5322414697748906370",
        "albumId": "5322414235966258241",
        "access": "public",
        "width": "1024",
        "height": "686",
        "timestamp": "1234428836000",
        "commentingEnabled": "true",
        "commentCount": 0,
        "exif": {
         "fstop": "5.6",
         "make": "NIKON CORPORATION",
         "model": "NIKON D200",
         "exposure": "0.0020",
         "flash": "false",
         "focalLength": "400.0",
         "iso": "100",
         "time": "1234428836000"
        },
        "media": {
         "content": [
          {
           "url": "http://lh5.ggpht.com/_feanDHO1Syk/Sd0D996kQYI/AAAAAAAABJA/BxFkVFBC4MY/H2W-YNP-116-H2W_0643.jpg",
           "height": 686,
           "width": 1024,
           "type": "image/jpeg",
           "medium": "image"
          }
         ],
         "credit": [
          "Heidi"
         ],
         "description": "cute fox in the Interior mousing - all in!",
         "description$type": "plain",
         "keywords": "Animals, Fox, Wildlife, Yellowstone National Park",
         "thumbnail": [
          {
           "url": "http://lh5.ggpht.com/_feanDHO1Syk/Sd0D996kQYI/AAAAAAAABJA/BxFkVFBC4MY/s72/H2W-YNP-116-H2W_0643.jpg",
           "height": 49,
           "width": 72
          },
          {
           "url": "http://lh5.ggpht.com/_feanDHO1Syk/Sd0D996kQYI/AAAAAAAABJA/BxFkVFBC4MY/s144/H2W-YNP-116-H2W_0643.jpg",
           "height": 97,
           "width": 144
          },
          {
           "url": "http://lh5.ggpht.com/_feanDHO1Syk/Sd0D996kQYI/AAAAAAAABJA/BxFkVFBC4MY/s288/H2W-YNP-116-H2W_0643.jpg",
           "height": 193,
           "width": 288
          }
         ],
         "title": "H2W-YNP-116-H2W_0643.jpg",
         "title$type": "plain"
        },
        "georss$where": {
         "gml$Point": {
          "gml$pos": "44.771151 -110.577383"
         }
        },
        "albumTitle": "Yellowstone in Winter",
        "albumCTitle": "YellowstoneInWinter",
        "gphoto$albumdesc": {
         "$t": "Yellowstone in Winter Feb 09"
        },
        "location": "Yellowstone National Park",
        "snippet": "\u003cb\u003eAnimals\u003c/b\u003e, \u003cb\u003eFox\u003c/b\u003e ...",
        "snippetType": "PHOTO_TAGS",
        "truncated": "0"
       },
       {
        "id": "http://picasaweb.google.com/data/entry/api/user/heidi.haas/albumid/5322414235966258241/photoid/5322414686398432594?alt\u003djsonm",
        "published": "2009-04-08T20:07:17.000Z",
        "updated": "2009-04-08T20:07:17.000Z",
        "category": [
         {
          "scheme": "http://schemas.google.com/g/2005#kind",
          "term": "http://schemas.google.com/photos/2007#photo"
         }
        ],
        "title": "H2W-YNP-112-DSC_1314.jpg",
        "summary": "cute fox in the Interior mousing",
        "content$src": "http://lh4.ggpht.com/_feanDHO1Syk/Sd0D9ToZxVI/AAAAAAAABIg/tOQ_2leFf4Q/H2W-YNP-112-DSC_1314.jpg",
        "link": [
         {
          "rel": "http://schemas.google.com/g/2005#feed",
          "type": "application/atom+xml",
          "href": "http://picasaweb.google.com/data/feed/api/user/heidi.haas/albumid/5322414235966258241/photoid/5322414686398432594?alt\u003djsonm"
         },
         {
          "rel": "alternate",
          "type": "text/html",
          "href": "http://picasaweb.google.com/heidi.haas/YellowstoneInWinter#5322414686398432594"
         },
         {
          "rel": "http://schemas.google.com/photos/2007#canonical",
          "type": "text/html",
          "href": "http://picasaweb.google.com/lh/photo/SbPVjlmoIZneNybjBcx6nw"
         },
         {
          "rel": "self",
          "type": "application/atom+xml",
          "href": "http://picasaweb.google.com/data/entry/api/user/heidi.haas/albumid/5322414235966258241/photoid/5322414686398432594?alt\u003djsonm"
         },
         {
          "rel": "http://schemas.google.com/photos/2007#report",
          "type": "text/html",
          "href": "http://picasaweb.google.com/lh/reportAbuse?uname\u003dheidi.haas\u0026aid\u003d5322414235966258241\u0026iid\u003d5322414686398432594"
         }
        ],
        "author": [
         {
          "name": "Heidi",
          "uri": "http://picasaweb.google.com/heidi.haas",
          "email": "heidi.haas",
          "user": "heidi.haas",
          "nickname": "Heidi",
          "thumbnail": "http://lh4.ggpht.com/_feanDHO1Syk/AAAASfvC6bo/AAAAAAAAAAA/6Wv0CyhG1Gg/s48-c/heidi.haas.jpg"
         }
        ],
        "gphoto$id": "5322414686398432594",
        "albumId": "5322414235966258241",
        "access": "public",
        "width": "1024",
        "height": "680",
        "timestamp": "1234427368000",
        "commentingEnabled": "true",
        "commentCount": 0,
        "exif": {
         "fstop": "4.5",
         "make": "NIKON CORPORATION",
         "model": "NIKON D90",
         "exposure": "3.125E-4",
         "flash": "false",
         "focalLength": "500.0",
         "iso": "400",
         "time": "1234427368000"
        },
        "media": {
         "content": [
          {
           "url": "http://lh4.ggpht.com/_feanDHO1Syk/Sd0D9ToZxVI/AAAAAAAABIg/tOQ_2leFf4Q/H2W-YNP-112-DSC_1314.jpg",
           "height": 680,
           "width": 1024,
           "type": "image/jpeg",
           "medium": "image"
          }
         ],
         "credit": [
          "Heidi"
         ],
         "description": "cute fox in the Interior mousing",
         "description$type": "plain",
         "keywords": "Animals, Fox, Wildlife, Yellowstone National Park",
         "thumbnail": [
          {
           "url": "http://lh4.ggpht.com/_feanDHO1Syk/Sd0D9ToZxVI/AAAAAAAABIg/tOQ_2leFf4Q/s72/H2W-YNP-112-DSC_1314.jpg",
           "height": 48,
           "width": 72
          },
          {
           "url": "http://lh4.ggpht.com/_feanDHO1Syk/Sd0D9ToZxVI/AAAAAAAABIg/tOQ_2leFf4Q/s144/H2W-YNP-112-DSC_1314.jpg",
           "height": 96,
           "width": 144
          },
          {
           "url": "http://lh4.ggpht.com/_feanDHO1Syk/Sd0D9ToZxVI/AAAAAAAABIg/tOQ_2leFf4Q/s288/H2W-YNP-112-DSC_1314.jpg",
           "height": 192,
           "width": 288
          }
         ],
         "title": "H2W-YNP-112-DSC_1314.jpg",
         "title$type": "plain"
        },
        "georss$where": {
         "gml$Point": {
          "gml$pos": "44.771151 -110.577383"
         }
        },
        "albumTitle": "Yellowstone in Winter",
        "albumCTitle": "YellowstoneInWinter",
        "gphoto$albumdesc": {
         "$t": "Yellowstone in Winter Feb 09"
        },
        "location": "Yellowstone National Park",
        "snippet": "\u003cb\u003eAnimals\u003c/b\u003e, \u003cb\u003eFox\u003c/b\u003e ...",
        "snippetType": "PHOTO_TAGS",
        "truncated": "0"
       },
       {
        "id": "http://picasaweb.google.com/data/entry/api/user/heidi.haas/albumid/5322414235966258241/photoid/5322414696906780770?alt\u003djsonm",
        "published": "2009-04-08T20:07:19.000Z",
        "updated": "2009-04-08T20:07:19.000Z",
        "category": [
         {
          "scheme": "http://schemas.google.com/g/2005#kind",
          "term": "http://schemas.google.com/photos/2007#photo"
         }
        ],
        "title": "H2W-YNP-115-DSC_1349.jpg",
        "summary": "cute fox in the Interior mousing - going for the jump",
        "content$src": "http://lh3.ggpht.com/_feanDHO1Syk/Sd0D96xycGI/AAAAAAAABI4/WnWy_PcKHA4/H2W-YNP-115-DSC_1349.jpg",
        "link": [
         {
          "rel": "http://schemas.google.com/g/2005#feed",
          "type": "application/atom+xml",
          "href": "http://picasaweb.google.com/data/feed/api/user/heidi.haas/albumid/5322414235966258241/photoid/5322414696906780770?alt\u003djsonm"
         },
         {
          "rel": "alternate",
          "type": "text/html",
          "href": "http://picasaweb.google.com/heidi.haas/YellowstoneInWinter#5322414696906780770"
         },
         {
          "rel": "http://schemas.google.com/photos/2007#canonical",
          "type": "text/html",
          "href": "http://picasaweb.google.com/lh/photo/XDREvRW1xprpPz2EBy_ZQg"
         },
         {
          "rel": "self",
          "type": "application/atom+xml",
          "href": "http://picasaweb.google.com/data/entry/api/user/heidi.haas/albumid/5322414235966258241/photoid/5322414696906780770?alt\u003djsonm"
         },
         {
          "rel": "http://schemas.google.com/photos/2007#report",
          "type": "text/html",
          "href": "http://picasaweb.google.com/lh/reportAbuse?uname\u003dheidi.haas\u0026aid\u003d5322414235966258241\u0026iid\u003d5322414696906780770"
         }
        ],
        "author": [
         {
          "name": "Heidi",
          "uri": "http://picasaweb.google.com/heidi.haas",
          "email": "heidi.haas",
          "user": "heidi.haas",
          "nickname": "Heidi",
          "thumbnail": "http://lh4.ggpht.com/_feanDHO1Syk/AAAASfvC6bo/AAAAAAAAAAA/6Wv0CyhG1Gg/s48-c/heidi.haas.jpg"
         }
        ],
        "gphoto$id": "5322414696906780770",
        "albumId": "5322414235966258241",
        "access": "public",
        "width": "1024",
        "height": "680",
        "timestamp": "1234428835000",
        "commentingEnabled": "true",
        "commentCount": 0,
        "exif": {
         "fstop": "4.5",
         "make": "NIKON CORPORATION",
         "model": "NIKON D90",
         "exposure": "2.5E-4",
         "flash": "false",
         "focalLength": "500.0",
         "iso": "400",
         "time": "1234428835000"
        },
        "media": {
         "content": [
          {
           "url": "http://lh3.ggpht.com/_feanDHO1Syk/Sd0D96xycGI/AAAAAAAABI4/WnWy_PcKHA4/H2W-YNP-115-DSC_1349.jpg",
           "height": 680,
           "width": 1024,
           "type": "image/jpeg",
           "medium": "image"
          }
         ],
         "credit": [
          "Heidi"
         ],
         "description": "cute fox in the Interior mousing - going for the jump",
         "description$type": "plain",
         "keywords": "Animals, Fox, Wildlife, Yellowstone National Park",
         "thumbnail": [
          {
           "url": "http://lh3.ggpht.com/_feanDHO1Syk/Sd0D96xycGI/AAAAAAAABI4/WnWy_PcKHA4/s72/H2W-YNP-115-DSC_1349.jpg",
           "height": 48,
           "width": 72
          },
          {
           "url": "http://lh3.ggpht.com/_feanDHO1Syk/Sd0D96xycGI/AAAAAAAABI4/WnWy_PcKHA4/s144/H2W-YNP-115-DSC_1349.jpg",
           "height": 96,
           "width": 144
          },
          {
           "url": "http://lh3.ggpht.com/_feanDHO1Syk/Sd0D96xycGI/AAAAAAAABI4/WnWy_PcKHA4/s288/H2W-YNP-115-DSC_1349.jpg",
           "height": 192,
           "width": 288
          }
         ],
         "title": "H2W-YNP-115-DSC_1349.jpg",
         "title$type": "plain"
        },
        "georss$where": {
         "gml$Point": {
          "gml$pos": "44.771151 -110.577383"
         }
        },
        "albumTitle": "Yellowstone in Winter",
        "albumCTitle": "YellowstoneInWinter",
        "gphoto$albumdesc": {
         "$t": "Yellowstone in Winter Feb 09"
        },
        "location": "Yellowstone National Park",
        "snippet": "\u003cb\u003eAnimals\u003c/b\u003e, \u003cb\u003eFox\u003c/b\u003e ...",
        "snippetType": "PHOTO_TAGS",
        "truncated": "0"
       },
       {
        "id": "http://picasaweb.google.com/data/entry/api/user/heidi.haas/albumid/5322414235966258241/photoid/5322414693102823106?alt\u003djsonm",
        "published": "2009-04-08T20:07:18.000Z",
        "updated": "2009-04-08T20:07:18.000Z",
        "category": [
         {
          "scheme": "http://schemas.google.com/g/2005#kind",
          "term": "http://schemas.google.com/photos/2007#photo"
         }
        ],
        "title": "H2W-YNP-114-DSC_1348.jpg",
        "summary": "cute fox in the Interior mousing - i hear you!",
        "content$src": "http://lh6.ggpht.com/_feanDHO1Syk/Sd0D9sm2psI/AAAAAAAABIw/JFxIP_WZyMs/H2W-YNP-114-DSC_1348.jpg",
        "link": [
         {
          "rel": "http://schemas.google.com/g/2005#feed",
          "type": "application/atom+xml",
          "href": "http://picasaweb.google.com/data/feed/api/user/heidi.haas/albumid/5322414235966258241/photoid/5322414693102823106?alt\u003djsonm"
         },
         {
          "rel": "alternate",
          "type": "text/html",
          "href": "http://picasaweb.google.com/heidi.haas/YellowstoneInWinter#5322414693102823106"
         },
         {
          "rel": "http://schemas.google.com/photos/2007#canonical",
          "type": "text/html",
          "href": "http://picasaweb.google.com/lh/photo/lBtTpbYvFv0DK65yAB2hAg"
         },
         {
          "rel": "self",
          "type": "application/atom+xml",
          "href": "http://picasaweb.google.com/data/entry/api/user/heidi.haas/albumid/5322414235966258241/photoid/5322414693102823106?alt\u003djsonm"
         },
         {
          "rel": "http://schemas.google.com/photos/2007#report",
          "type": "text/html",
          "href": "http://picasaweb.google.com/lh/reportAbuse?uname\u003dheidi.haas\u0026aid\u003d5322414235966258241\u0026iid\u003d5322414693102823106"
         }
        ],
        "author": [
         {
          "name": "Heidi",
          "uri": "http://picasaweb.google.com/heidi.haas",
          "email": "heidi.haas",
          "user": "heidi.haas",
          "nickname": "Heidi",
          "thumbnail": "http://lh4.ggpht.com/_feanDHO1Syk/AAAASfvC6bo/AAAAAAAAAAA/6Wv0CyhG1Gg/s48-c/heidi.haas.jpg"
         }
        ],
        "gphoto$id": "5322414693102823106",
        "albumId": "5322414235966258241",
        "access": "public",
        "width": "1024",
        "height": "680",
        "timestamp": "1234428833000",
        "commentingEnabled": "true",
        "commentCount": 0,
        "exif": {
         "fstop": "4.5",
         "make": "NIKON CORPORATION",
         "model": "NIKON D90",
         "exposure": "2.5E-4",
         "flash": "false",
         "focalLength": "500.0",
         "iso": "400",
         "time": "1234428833000"
        },
        "media": {
         "content": [
          {
           "url": "http://lh6.ggpht.com/_feanDHO1Syk/Sd0D9sm2psI/AAAAAAAABIw/JFxIP_WZyMs/H2W-YNP-114-DSC_1348.jpg",
           "height": 680,
           "width": 1024,
           "type": "image/jpeg",
           "medium": "image"
          }
         ],
         "credit": [
          "Heidi"
         ],
         "description": "cute fox in the Interior mousing - i hear you!",
         "description$type": "plain",
         "keywords": "Animals, Fox, Wildlife, Yellowstone National Park",
         "thumbnail": [
          {
           "url": "http://lh6.ggpht.com/_feanDHO1Syk/Sd0D9sm2psI/AAAAAAAABIw/JFxIP_WZyMs/s72/H2W-YNP-114-DSC_1348.jpg",
           "height": 48,
           "width": 72
          },
          {
           "url": "http://lh6.ggpht.com/_feanDHO1Syk/Sd0D9sm2psI/AAAAAAAABIw/JFxIP_WZyMs/s144/H2W-YNP-114-DSC_1348.jpg",
           "height": 96,
           "width": 144
          },
          {
           "url": "http://lh6.ggpht.com/_feanDHO1Syk/Sd0D9sm2psI/AAAAAAAABIw/JFxIP_WZyMs/s288/H2W-YNP-114-DSC_1348.jpg",
           "height": 192,
           "width": 288
          }
         ],
         "title": "H2W-YNP-114-DSC_1348.jpg",
         "title$type": "plain"
        },
        "georss$where": {
         "gml$Point": {
          "gml$pos": "44.771151 -110.577383"
         }
        },
        "albumTitle": "Yellowstone in Winter",
        "albumCTitle": "YellowstoneInWinter",
        "gphoto$albumdesc": {
         "$t": "Yellowstone in Winter Feb 09"
        },
        "location": "Yellowstone National Park",
        "snippet": "\u003cb\u003eAnimals\u003c/b\u003e, \u003cb\u003eFox\u003c/b\u003e ...",
        "snippetType": "PHOTO_TAGS",
        "truncated": "0"
       }
      ]
     }
    }
    );

===========
PicasaStore
===========

PicasaStore's role is to process the query parameters passed to the dojo.data.api.Read API and generate the appropriate service URL. It then processes the response from the service and handles accessing the items returned from the query. It also provides simple attribute access to all the values.

Constructor Parameters
----------------------

+---------------------------+--------------------------------------------------------------------+---------------------+
|**Attribute**              |**Description**                                                     |Since                |
+---------------------------+--------------------------------------------------------------------+---------------------+
|label                      |The item attribute to use as the label of the Picasa item.          |Dojo 1.1             |
|                           |Defaults to 'title'                                                 |                     |
+---------------------------+--------------------------------------------------------------------+---------------------+
|urlPreventCache            |Flag controlling whether preventCache of dojo.io.script is used to  |Dojo 1.4             |
|                           |prevent browser caching.  Default is true.                          |                     |
+---------------------------+--------------------------------------------------------------------+---------------------+
|maxResults                 |Total number of results to allow to return from a call to the       |Dojo 1.4             |
|                           |service.  The default is 20.                                        |                     |
+---------------------------+--------------------------------------------------------------------+---------------------+

Item Attributes
---------------
All items returned from PicasaStore have the following attributes that can be accessed using the dojo.data.api.Read API to retrieve data about the item:

+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| title         |The title of the photo.                                                                                                      |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| author        |The person who published the photo to Picasa.                                                                                |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| description   |A description of the photo. This will generally contain HTML formatted text.                                                 |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| dateTaken     |A JavaScript date object representing the date the photo was taken.                                                          |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| datePublished |A JavaScript date object representing the date the photo was published to Picasa.                                            |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| tags          |The tags that are assigned to this photo. flickrStore.getValue(item, "tags") returns the first tag,                          |
|               |flickrStore.getValues(item, "tags") returns all tags.                                                                        |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| imageUrl      |A URL to the full resolution photo image.                                                                                    |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| imageUrlSmall |A URL to the small (icon sized) resolution photo image.                                                                      |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| imageUrlMedium|A URL to the mid resolution photo image.                                                                                     |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| link          |A URL linking to the Picasa page displaying the image.                                                                       |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+

Query Syntax
------------

The fetch method query syntax for PicasaStore is simple and straightforward. It allows the following attributes to be queried against:

+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| userid        |Picasa userid to use to narrow the search scope. This is optional.                                                           |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| userids       |A comma separated list of IDs used to narrow search scope. This is optional.                                                 |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| tags          |A comma separated list of tags to search for matches on. This is optional.                                                   |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+
| lang          |Specifies the language to return the results in. This is optional.                                                           |
+---------------+-----------------------------------------------------------------------------------------------------------------------------+

**Note:** Unlike all the other example stores, the PicasaStore store cannot do wild-card matching of the attributes. This is because the Picasa public photo feed service cannot do it. In an ideal service implementation, the Picasa service would provide a mechanism by with to pass in wild cards as part of its query parameters. Also, the Picasa public feed API limits the number of returned photos to a maximum of twenty.

========
Examples
========

Sample 1:  Listing nature pictures
----------------------------------

.. cv-compound ::
  
  .. cv :: javascript

    <script>
      dojo.require("dojox.data.PicasaStore");
      dojo.require("dijit.form.Button");

      //This function performs some basic dojo initialization.  In this case it connects the button
      //onClick to a function which invokes the fetch().  The fetch function queries for all items 
      //and provides callbacks to use for completion of data retrieval or reporting of errors.
      function init () {
         //Function to perform a fetch on the datastore when a button is clicked
         function getAllItems () {

           //Callback to perform an action when the data items are starting to be returned:
           function clearOldList(size, request) {
             var list = dojo.byId("list");
             if (list) { 
               while (list.firstChild) {
                 list.removeChild(list.firstChild);
               }
             }
           }
  
           //Callback for processing a returned list of items.
           function gotItems(items, request) {
             var list = dojo.byId("list");
             if (list) { 
               var i;
               for (i = 0; i < items.length; i++) {
                 var item = items[i];
                 var image = document.createElement("img");
                 list.appendChild(image);
                 image.setAttribute("src", flickrStore.getValue(item, "imageUrlMedium"));
                 list.appendChild(document.createElement("br"));
               }
             }
           }
          
           //Callback for if the lookup fails.
           function fetchFailed(error, request) {
             alert("lookup failed.");
           }
             
           //Fetch the images.  
           flickrStore.fetch({query:{ tags: "nature"}, onBegin: clearOldList, onComplete: gotItems, onError: fetchFailed});
         }
         //Link the click event of the button to driving the fetch.
         dojo.connect(button, "onClick", getAllItems);
      }
      //Set the init function to run when dojo loading and page parsing has completed.
      dojo.addOnLoad(init);
    </script>

  .. cv :: html 

    <div dojoType="dojox.data.PicasaStore" jsId="flickrStore"></div>
    <div dojoType="dijit.form.Button" jsId="button">Find nature pictures!</div>
    <br>
    <br>
    <span id="list">
    </span>
