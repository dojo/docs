#format dojo_rst

dojox.av.FLAudio
================

:Status: Draft
:Version: 1.0
:Project owner: Mike Wilcox, Tom Trenka
:Author: Mike Wilcox
:Available: since 1.3

.. contents::
   :depth: 2

dojo.av.FLAudio provides the ability of implementing MP3 sounds into your dojo applications through an embedded SWF, built in the DEFT project. This class provides the sound and programmatic control only - there is no user interface or widget. 


============
Introduction
============

After requiring dojox.av.FLAudio in your file, it is initialized programmatically, with a few optional parameters that set the initial volume and pan, the frequency of the status update, and whether to be in debug mode or not. 

After initializing the class, MP3 files are added one at a time:

.. code-block :: javascript
 :linenos:

 mySound.load({url:"../tests/audio/Ola.mp3", id:'Ola'});
 mySound.load({url:"../tests/audio/Hio.mp3", id:"Hio"});

It's important to note that the Flash SWF expects the MP3 files to be relative to it - not to the index.html nor dojo.js. An absolute URL works best. The two parameters passed are the URL, and an optional (though suggested) ID which is used in targeting a specific sound resource in your playlist. If you are only using one sound, an identifier is not necessary, as SWF will default to the first audio file in the index.

You can check on the load status of your files by connecting to onLoadStatus(). This will always provide an Array, whether it is one or more files, with each element of the Array containing the identifiers of the audio (ID, URL, index), the status of the file (loading, loaded) and the percentage loaded. Alternatively, onAllLoaded() will fire once when all files have finished loading (it will reset and fire again if you load another file later).

There are standard methods provided to control the playlist: pause(), stop(), setVolume() and setPan(). These all work as you would expect, with the exception that you optionally pass an object that contains an identifier of which audio in your playlist to control, as well as the parameter, such as pan:-.5 or volume: .7.

play() is the key method for controlling the playlist. As usual, an object is passed with the identifier, and if that alone is passed, the audio will play or resume. Optional parameters in the play object include: position - indicates where in the file to start in milliseconds, including 0 to start over from the beginning, volume, pan. To control multiple audio items at once, simply call them in sequence:

.. code-block :: javascript
 :linenos:

 mySound.doPlay({id:'Ola', position:0, volume:.9, pan:-1});
 mySound.doPlay({id:'Hio', position:0, volume:.8, pan:1});

And they will effectively play simultaneously.

To find the status of the audio files, connect to onPlayStatus(). This provides an Array of all files, with each element including an Object with the identifier, URL, volume, pan, position in milliseconds, and status. Status is a string that will return an audio status such as "playing", "paused", "stopped", etc.

Note, this class is still experimental, and the APIs could change in future versions. There is currently no ability to include this class as markup - it may be implemented in the future if the need is there.


========
Examples
========

Programmatic example
--------------------


.. cv-compound::
 
  The JavaScript:

  .. cv:: javascript

    <script type="text/javascript">
    dojo.require("dojox.av.FLAudio");
    var mySound;
    dojo.addOnLoad(function(){
        mySound = new dojox.av.FLAudio({initialVolume:.5, autoPlay:false, isDebug:false, statusInterval:500});
        mySound.load({url:"http://docs.dojocampus.org/moin_static163/js/dojo/trunk/dojox/av/tests/audio/Ola.mp3", id:'Ola'});
        mySound.load({url:"http://docs.dojocampus.org/moin_static163/js/dojo/trunk/dojox/av/tests/audio/Hio.mp3", id:"Hio"});
    });
    </script>

  The HTML:

  .. cv:: html
    
    <button onclick="mySound.doPlay({index:0, volume:1, pan:-1})">Ola Left</button>
    <button onclick="mySound.doPlay({index:0, volume:.1})">Ola Quiet</button>
    <button onclick="mySound.doPlay({index:1})">Hio</button>
    <button onclick="mySound.doPlay({id:'Ola', volume:1, pan:-1}); doPlay({id:'Hio', volume:1, pan:1});">Ola Left - Hio Right</button>
    <button onclick="mySound.doPlay({index:0, volume:1})">Ola Loud</button>
    <button onclick="mySound.doPlay({id:'Ola', volume:1, pan:1})">Ola Right</button>


========
See also
========

* `dojox.av <dojox/av>`_
* `dojox.av.FLVideo <dojox/av/FLVideo>`_
* `dojox.av.widget <dojox/av/widget>`_
