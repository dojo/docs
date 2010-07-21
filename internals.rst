#format dojo_rst

Behind the scenes
=================

``TODOC``

The documentation process
-------------------------

Other notes
-----------
So the Wiki is up the next phase would be to discuss:

1. What should be on it (and write a page about it here)
2. How it should be structured (see bellow for a beginning of this)
3. Choose some monitors from the community to watch changes and revert destructive behaviour.
4. Open it up to the wider community

Perhaps an IRC meeting to talk about each of these would be a good idea?


Process before Structure proposal
---------------------------------
I was talking to an academic friend of mine who is doing his Ph.D on online collaboration and the business processes involved in making it happen. After much talking (and a couple of beer(s)) we got to the point of agreeing that its all well and good to setup community tech. like Wiki's and forums but there needs to be a process to make them used and effective. Its also thought that instead of imposing some artificial structure on the content of a site its better to get it all in and then when there is enough to see groups forming segment into smaller parts.

So I would suggest that here we just post everything to this front page (i.e. here) to begin with and as it builds up we can see more easily what should be branched off into its own page(s) and then replace them with a link here to the new page(s). This process means we don't need to figure out how to organise the content right now and any/all can start to input content.

How about it?

  *I like the idea as a general approach. Besides that we should translate the dojo namespace into urls such as /dijit/layout/ContentPane or dojox/grid so it will be trivial for anyone to find content specifically regarding certain dojo modules. Besides that an open approach is good I think*


Structure
---------
This is great. Now some of the tutorials such as the DnD one can be updated to work in Dojo 1.0 etc. I wouldn't hold back until its all pretty, that can happen at anytime now. Lets just get it up and started. I guess the things that have to be considered are:

1. Structure, so:

  * Q.A. in the IRC can be put up quickly and in the right place. 
  * Articles/tutorials can find their place and be updated/corrected as they are used/reused. 
  * API doc/notes can find their place.

2. Dojo versions (so its clear what article is relavent to which verion of Dojo)


Perhaps ideas about these things can start to go up and then be organised into groups naturally as they form instead of trying to predict how this will be used and forcing the content into some unnatural order. 

What happened to the notes from the last temp. Wiki on structure?

Questions
---------

1. (a) IS there anyway to import this: http://docs.google.com/View?docid=d764479_11fcs7s397
   with like some sort of screen scrpper. Would make sucking part or all of the documentation lying around fast and easy?

   *Sure, we almost finished implementing inline code examples so this would be the next step - it might take you a few reloads until you seen an example, the implementation is still a bit buggy* http://docs.dojocampus.org/dijit/Tree

   (b) Ah yes, thats looking good! What that link I posted was is the "dojo.dnd 1.2 technical documentation" (which is on Google Docs for some reason?!) and I thought this would be an excellent candidate to bring in here. The on;y thing is that its a long page and has sections and other formatting that would be good to keep but copy/paste the HTML won't work in this Wiki, so whats a good way to get it in here?

2. How does one create a new page, or do you have to copy another one?

   *Create a new page by just entering the URL you wish to use e.g. http://docs.dojocampus.org/newpage - it will show you an existing page if there, otherwise will ask you whether you want to create a new one*


Index
-----

This is the start of the index:

DojoBook

Proposals
---------

  * `dojo.node <dojo/node>`_
  * `dojo.store <dojo/store>`_
