.. _dojox/grid/EnhancedGrid/plugins/Filter:

======================================
dojox.grid.EnhancedGrid.plugins.Filter
======================================

:Authors: Oliver Zhu
:Project owner: Evan Huang
:since: V.1.6

Filter plugin provides row filtering functionality for grid.

.. contents ::
    :depth: 2

Introduction
============

Filter is a plugin for dojox.grid.EnhancedGrid. It's designed to filter the grid data with a set of conditions. The grid data have types (number, string, date, time, and boolean) so, accordingly, users are able to specify filters with different conditions for different data types. This plugin not only provides a default client-side implementation, it also defines a simple protocol for server-side filtering to use where the data store is too large to be handled client-side. This plugin is independent of data store, just like grid itself. It only relies on the dojo.data.api.Read interface.

.. code-example::
  :toolbar: themes, versions, dir
  :width: 480
  :height: 500

  .. js ::

        dojo.require("dojo.data.ItemFileWriteStore");
        dojo.require("dojox.grid.EnhancedGrid");
        dojo.require("dojox.grid.enhanced.plugins.Filter");

        var data = {
            identifier: 'id',
            label: 'id',
            items: []
        };
        var data_list = [
            {"Heard": true, "Checked": "True", "Genre":"Easy Listening", "Artist":"Bette Midler", "Year":2003, "Album":"Bette Midler Sings the Rosemary Clooney Songbook", "Name":"Hey There", "Length":"03:31", "Track":4, "Composer":"Ross, Jerry 1926-1956 -w Adler, Richard 1921-", "Download Date":"1923/4/9", "Last Played":"04:32:49"},
            {"Heard": true, "Checked": "True", "Genre":"Classic Rock", "Artist":"Jimi Hendrix", "Year":1993, "Album":"Are You Experienced", "Name":"Love Or Confusion", "Length":"03:15", "Track":4, "Composer":"Jimi Hendrix", "Download Date":"1947/12/6", "Last Played":"03:47:49"},
            {"Heard": true, "Checked": "True", "Genre":"Jazz", "Artist":"Andy Narell", "Year":1992, "Album":"Down the Road", "Name":"Sugar Street", "Length":"07:00", "Track":8, "Composer":"Andy Narell", "Download Date":"1906/3/22", "Last Played":"21:56:15"},
            {"Heard": true, "Checked": "True", "Genre":"Progressive Rock", "Artist":"Emerson, Lake & Palmer", "Year":1992, "Album":"The Atlantic Years", "Name":"Tarkus", "Length":"20:40", "Track":5, "Composer":"Greg Lake/Keith Emerson", "Download Date":"1994/11/29", "Last Played":"03:25:19"},
            {"Heard": true, "Checked": "True", "Genre":"Rock", "Artist":"Blood, Sweat & Tears", "Year":1968, "Album":"Child Is Father To The Man", "Name":"Somethin' Goin' On", "Length":"08:00", "Track":9, "Composer":"", "Download Date":"1973/9/11", "Last Played":"19:49:41"},
            {"Heard": true, "Checked": "True", "Genre":"Jazz", "Artist":"Andy Narell", "Year":1989, "Album":"Little Secrets", "Name":"Armchair Psychology", "Length":"08:20", "Track":5, "Composer":"Andy Narell", "Download Date":"2010/4/15", "Last Played":"01:13:08"},
            {"Heard": true, "Checked": "True", "Genre":"Easy Listening", "Artist":"Frank Sinatra", "Year":1991, "Album":"Sinatra Reprise: The Very Good Years", "Name":"Luck Be A Lady", "Length":"05:16", "Track":4, "Composer":"F. Loesser", "Download Date":"2035/4/12", "Last Played":"06:16:53"},
            {"Heard": true, "Checked": "True", "Genre":"Progressive Rock", "Artist":"Dixie dregs", "Year":1977, "Album":"Free Fall", "Name":"Sleep", "Length":"01:58", "Track":6, "Composer":"Steve Morse", "Download Date":"2032/11/21", "Last Played":"08:23:26"},
            {"Heard": true, "Checked": "True", "Genre":"Classic Rock", "Artist":"Black Sabbath", "Year":2004, "Album":"Master of Reality", "Name":"Sweet Leaf", "Length":"05:04", "Track":1, "Composer":"Bill Ward/Geezer Butler/Ozzy Osbourne/Tony Iommi", "Download Date":"2036/5/26", "Last Played":"22:10:19"},
            {"Heard": true, "Checked": "True", "Genre":"Blues", "Artist":"Buddy Guy", "Year":1991, "Album":"Damn Right, I've Got The Blues", "Name":"Five Long Years", "Length":"08:27", "Track":3, "Composer":"Eddie Boyd/John Lee Hooker", "Download Date":"1904/4/4", "Last Played":"18:28:08"},
            {"Heard": true, "Checked": "True", "Genre":"Easy Listening", "Artist":"Frank Sinatra", "Year":1991, "Album":"Sinatra Reprise: The Very Good Years", "Name":"The Way You Look Tonight", "Length":"03:23", "Track":5, "Composer":"D. Fields/J. Kern", "Download Date":"1902/10/12", "Last Played":"23:09:23"},
            {"Heard": true, "Checked": "True", "Genre":"World", "Artist":"Andy Statman & David Grisman", "Year":1995, "Album":"Songs Of Our Fathers", "Name":"Chassidic Medley: Adir Hu / Moshe Emes", "Length":"04:14", "Track":2, "Composer":"Shlomo Carlebach; Trad.", "Download Date":"2035/2/9", "Last Played":"00:11:15"},
            {"Heard": true, "Checked": "True", "Genre":"Classic Rock", "Artist":"Jimi Hendrix", "Year":1968, "Album":"Electric Ladyland", "Name":"Long Hot Summer Night", "Length":"03:27", "Track":6, "Composer":"Jimi Hendrix", "Download Date":"1902/4/7", "Last Played":"16:58:08"},
            {"Heard": true, "Checked": "True", "Genre":"Classical", "Artist":"Andres Segovia", "Year":2004, "Album":"The Best Of Andres Segovia", "Name":"Asturias (Suite Espanola, Op. 47)", "Length":"06:25", "Track":6, "Composer":"Isaac Albeniz", "Download Date":"1904/10/25", "Last Played":"06:59:04"},
            {"Heard": true, "Checked": "True", "Genre":"Jazz", "Artist":"Andy Narell", "Year":1989, "Album":"Little Secrets", "Name":"We Kinda Music", "Length":"08:22", "Track":3, "Composer":"Andy Narell", "Download Date":"1905/5/22", "Last Played":"23:43:08"},
            {"Heard": true, "Checked": "True", "Genre":"Pop and R&B", "Artist":"Joni Mitchell", "Year":2000, "Album":"Both Sides Now", "Name":"Comes Love", "Length":"04:29", "Track":3, "Composer":"Charles Tobias/Sammy Stept/Lew Brown", "Download Date":"1927/11/19", "Last Played":"02:34:41"},
            {"Heard": true, "Checked": "True", "Genre":"Pop and R&B", "Artist":"Joni Mitchell", "Year":1974, "Album":"Court And Spark", "Name":"Court And Spark", "Length":"02:46", "Track":1, "Composer":"Joni Mitchell", "Download Date":"1927/5/24", "Last Played":"13:27:11"},
            {"Heard": true, "Checked": "True", "Genre":"Easy Listening", "Artist":"Frank Sinatra", "Year":1962, "Album":"Sinatra and Swinging Brass", "Name":"Serenade in Blue", "Length":"03:00", "Track":10, "Composer":"Harry Warren, Mack Gordon", "Download Date":"1932/7/16", "Last Played":"08:15:00"},
            {"Heard": true, "Checked": "True", "Genre":"Classical", "Artist":"Julian Bream", "Year":1957, "Album":"Fret Works: Dowland & Villa-Lobos", "Name":"Queen Elizabeth's Galliard", "Length":"01:33", "Track":1, "Composer":"John Dowland", "Download Date":"2022/6/9", "Last Played":"08:40:19"},
            {"Heard": true, "Checked": "True", "Genre":"Progressive Rock", "Artist":"Dixie dregs", "Year":1977, "Album":"Free Fall", "Name":"Free Fall", "Length":"04:41", "Track":1, "Composer":"Steve Morse", "Download Date":"2022/6/6", "Last Played":"01:27:11"},
            {"Heard": true, "Checked": "True", "Genre":"Classic Rock", "Artist":"Black Sabbath", "Year":2004, "Album":"Master of Reality", "Name":"After Forever", "Length":"05:26", "Track":2, "Composer":"Tony Iommi", "Download Date":"1996/4/7", "Last Played":"03:53:26"},
            {"Heard": true, "Checked": "True", "Genre":"Classic Rock", "Artist":"Jimi Hendrix", "Year":1993, "Album":"Are You Experienced", "Name":"The Wind Cries Mary", "Length":"03:23", "Track":7, "Composer":"Jimi Hendrix", "Download Date":"1941/4/23", "Last Played":"04:52:30"},
            {"Heard": true, "Checked": "True", "Genre":"Rock", "Artist":"Dave Matthews", "Year":1998, "Album":"Before These Crowded Streets", "Name":"Don't Drink the Water", "Length":"07:01", "Track":4, "Composer":"Beauford, Carter/Matthews, David J.", "Download Date":"2019/8/19", "Last Played":"12:45:00"},
            {"Heard": true, "Checked": "True", "Genre":"Jazz", "Artist":"Charlie Hunter", "Year":2004, "Album":"Friends Seen and Unseen", "Name":"Eleven Bars for Gandhi", "Length":"06:57", "Track":7, "Composer":"Charlie Hunter", "Download Date":"1973/9/24", "Last Played":"15:02:49"},
            {"Heard": true, "Checked": "True", "Genre":"World", "Artist":"Andy Statman & David Grisman", "Year":1995, "Album":"Songs Of Our Fathers", "Name":"L'Ma'an Achai V'Re'ei", "Length":"05:56", "Track":8, "Composer":"Shlomo Carlebach", "Download Date":"2007/10/27", "Last Played":"20:23:26"},
            {"Heard": true, "Checked": "True", "Genre":"Jazz", "Artist":"Bill Evans", "Year":1958, "Album":"Everybody Digs Bill Evans", "Name":"Minority", "Length":"05:22", "Track":1, "Composer":"Gigi Gryce", "Download Date":"1912/6/9", "Last Played":"09:30:56"},
            {"Heard": false, "Checked": "False", "Genre":"Classical", "Artist":"Julian Bream", "Year":1992, "Album":"Nocturnal", "Name":"Britten: Nocturnal - 1. Musingly (Meditativo)", "Length":"02:14", "Track":5, "Composer":"Benjamin Britten", "Download Date":"1943/9/16", "Last Played":"12:14:04"},
            {"Heard": false, "Checked": "False", "Genre":"Classical", "Artist":"Andres Segovia", "Year":1955, "Album":"The Art Of Segovia [Disc 1]", "Name":"Tarrega: Recuerdos de la Alhambra", "Length":"05:16", "Track":1, "Composer":"Francisco Tarrega", "Download Date":"1946/10/11", "Last Played":"09:14:04"},
            {"Heard": true, "Checked": "True", "Genre":"Rock", "Artist":"Blood, Sweat & Tears", "Year":1968, "Album":"Child Is Father To The Man", "Name":"Overture", "Length":"01:32", "Track":1, "Composer":"", "Download Date":"1967/12/16", "Last Played":"23:23:26"},
            {"Heard": true, "Checked": "True", "Genre":"World", "Artist":"Andy Statman Quartet", "Year":2005, "Album":"Between Heaven & Earth", "Name":"Tzamah Nafshi", "Length":"08:00", "Track":8, "Composer":"Karlin-Stolin", "Download Date":"2002/10/10", "Last Played":"01:21:34"},
            {"Heard": true, "Checked": "True", "Genre":"Blues", "Artist":"B.B. King", "Year":2005, "Album":"80", "Name":"The Thrill Is Gone", "Length":"05:03", "Track":3, "Composer":"", "Download Date":"1949/9/13", "Last Played":"16:01:53"},
            {"Heard": true, "Checked": "True", "Genre":"Rock", "Artist":"Dave Matthews", "Year":1998, "Album":"Before These Crowded Streets", "Name":"Stay (Wasting Time)", "Length":"05:35", "Track":5, "Composer":"Lessard, Stefan/Beauford, Carter/Moore, Leroi", "Download Date":"2020/5/12", "Last Played":"15:25:19"},
            {"Heard": true, "Checked": "True", "Genre":"Pop and R&B", "Artist":"Joni Mitchell", "Year":2000, "Album":"Both Sides Now", "Name":"Answer Me My Love", "Length":"03:24", "Track":5, "Composer":"Carl Sigman/Gerhard Winkler/Fred Rauch", "Download Date":"1962/4/10", "Last Played":"19:52:30"},
            {"Heard": true, "Checked": "True", "Genre":"Rock", "Artist":"Dave Matthews", "Year":1996, "Album":"Crash", "Name":"Two Step", "Length":"06:29", "Track":2, "Composer":"Dave Matthews", "Download Date":"2025/6/27", "Last Played":"12:14:04"},
            {"Heard": true, "Checked": "True", "Genre":"Progressive Rock", "Artist":"Dixie dregs", "Year":1978, "Album":"What if", "Name":"Little Kids", "Length":"02:07", "Track":6, "Composer":"", "Download Date":"2008/6/9", "Last Played":"15:53:26"},
            {"Heard": true, "Checked": "True", "Genre":"Easy Listening", "Artist":"Bette Midler", "Year":2003, "Album":"Bette Midler Sings the Rosemary Clooney Songbook", "Name":"Come On-A My House", "Length":"01:50", "Track":6, "Composer":"Saroyan, William 1908-1981 -w Bagdasarian, Ross 1919-1972", "Download Date":"2018/8/13", "Last Played":"19:21:34"},
            {"Heard": false, "Checked": "False", "Genre":"Classical", "Artist":"Julian Bream", "Year":1957, "Album":"Fret Works: Dowland & Villa-Lobos", "Name":"King of Denmark's Galliard", "Length":"01:15", "Track":8, "Composer":"John Dowland", "Download Date":"2008/12/29", "Last Played":"18:33:45"},
            {"Heard": false, "Checked": "False", "Genre":"Classical", "Artist":"Andres Segovia", "Year":2004, "Album":"The Best Of Andres Segovia", "Name":"Recuerdos De La Alhambra", "Length":"05:12", "Track":5, "Composer":"Francisco Tarrega", "Download Date":"1906/3/11", "Last Played":"17:54:23"},
            {"Heard": true, "Checked": "True", "Genre":"Classic Rock", "Artist":"Jimi Hendrix", "Year":1968, "Album":"Electric Ladyland", "Name":"Voodoo Chile", "Length":"14:59", "Track":4, "Composer":"Jimi Hendrix", "Download Date":"1904/12/18", "Last Played":"03:00:00"},
            {"Heard": false, "Checked": "False", "Genre":"Classical", "Artist":"Julian Bream", "Year":1957, "Album":"Fret Works: Dowland & Villa-Lobos", "Name":"Fantasia", "Length":"05:02", "Track":7, "Composer":"John Dowland", "Download Date":"1907/4/11", "Last Played":"17:37:30"},
            {"Heard": true, "Checked": "True", "Genre":"Blues", "Artist":"B.B. King", "Year":1997, "Album":"Deuces Wild", "Name":"There Must Be A Better World Somewhere", "Length":"04:51", "Track":7, "Composer":"Rebennack/Pomus", "Download Date":"1929/1/24", "Last Played":"08:51:34"},
            {"Heard": true, "Checked": "True", "Genre":"Jazz", "Artist":"Andy Narell", "Year":1992, "Album":"Down the Road", "Name":"Green Ballet: 2nd Position for Steel Orchestra", "Length":"03:41", "Track":6, "Composer":"Vince Mendoza", "Download Date":"1921/3/29", "Last Played":"13:38:26"},
            {"Heard": true, "Checked": "True", "Genre":"Jazz", "Artist":"Bill Evans", "Year":1962, "Album":"Interplay", "Name":"I'll Never Smile Again (Take 7)", "Length":"06:33", "Track":3, "Composer":"Ruth Lowe", "Download Date":"2019/4/14", "Last Played":"16:21:34"},
            {"Heard": true, "Checked": "True", "Genre":"Blues", "Artist":"Buddy Guy", "Year":1993, "Album":"Feels Like Rain", "Name":"I Go Crazy", "Length":"02:26", "Track":2, "Composer":"James Brown", "Download Date":"1973/1/5", "Last Played":"18:45:00"},
            {"Heard": true, "Checked": "True", "Genre":"Jazz", "Artist":"Bill Evans", "Year":1978, "Album":"Affinity", "Name":"The Other Side of Midnight (Noelle's Theme)", "Length":"03:23", "Track":7, "Composer":"Michel Legrand", "Download Date":"1938/6/17", "Last Played":"10:04:41"},
            {"Heard": true, "Checked": "True", "Genre":"Classic Rock", "Artist":"Jimi Hendrix", "Year":1968, "Album":"Electric Ladyland", "Name":"...And the Gods Made Love", "Length":"01:23", "Track":1, "Composer":"Jimi Hendrix", "Download Date":"2015/2/12", "Last Played":"00:39:23"},
            {"Heard": true, "Checked": "True", "Genre":"Pop and R&B", "Artist":"Joni Mitchell", "Year":2000, "Album":"Both Sides Now", "Name":"At Last", "Length":"04:28", "Track":2, "Composer":"Mack Gordon/Harry Warren", "Download Date":"1933/3/16", "Last Played":"21:00:00"},
            {"Heard": true, "Checked": "True", "Genre":"Easy Listening", "Artist":"Bette Midler", "Year":1993, "Album":"Experience the Divine", "Name":"Miss Ottis Regrets", "Length":"02:40", "Track":8, "Composer":"Cole Porter", "Download Date":"2012/10/6", "Last Played":"04:10:19"},
            {"Heard": true, "Checked": "True", "Genre":"Blues", "Artist":"Buddy Guy", "Year":1993, "Album":"Feels Like Rain", "Name":"Change in the Weather", "Length":"04:38", "Track":7, "Composer":"John Fogerty", "Download Date":"1917/9/28", "Last Played":"09:42:11"},
            {"Heard": true, "Checked": "True", "Genre":"Easy Listening", "Artist":"Bette Midler", "Year":2003, "Album":"Bette Midler Sings the Rosemary Clooney Songbook", "Name":"This Ole House", "Length":"03:03", "Track":2, "Composer":"Hamblen, Stuart 1908-1989", "Download Date":"1946/8/23", "Last Played":"06:30:56"},
            {"Heard": true, "Checked": "True", "Genre":"Progressive Rock", "Artist":"Dixie dregs", "Year":1977, "Album":"Free Fall", "Name":"Holiday", "Length":"04:29", "Track":2, "Composer":"Steven J. Morse", "Download Date":"2035/8/13", "Last Played":"17:17:49"},
            {"Heard": true, "Checked": "True", "Genre":"Rock", "Artist":"Blood, Sweat & Tears", "Year":1969, "Album":"Blood, Sweat & Tears", "Name":"Smiling Phases", "Length":"05:11", "Track":2, "Composer":"Jim Capaldi, Steve Winwood, Chris Wood", "Download Date":"1993/6/13", "Last Played":"03:28:08"},
            {"Heard": true, "Checked": "True", "Genre":"Jazz", "Artist":"Andy Narell", "Year":1992, "Album":"Down the Road", "Name":"Disorderly Conduct", "Length":"06:40", "Track":4, "Composer":"Andy Narell", "Download Date":"1996/8/31", "Last Played":"03:39:23"},
            {"Heard": true, "Checked": "True", "Genre":"Classic Rock", "Artist":"Jimi Hendrix", "Year":1993, "Album":"Are You Experienced", "Name":"Purple Haze", "Length":"02:53", "Track":1, "Composer":"Jimi Hendrix", "Download Date":"2004/5/23", "Last Played":"22:49:41"},
            {"Heard": true, "Checked": "True", "Genre":"Jazz", "Artist":"Andy Narell", "Year":1992, "Album":"Down the Road", "Name":"Green Ballet: 1st Position for Steel Orchestra", "Length":"02:16", "Track":5, "Composer":"Vince Mendoza", "Download Date":"1959/10/10", "Last Played":"10:21:34"},
            {"Heard": true, "Checked": "True", "Genre":"Rock", "Artist":"Blood, Sweat & Tears", "Year":1968, "Album":"Child Is Father To The Man", "Name":"Just One Smile", "Length":"04:38", "Track":6, "Composer":"", "Download Date":"1997/6/25", "Last Played":"20:57:11"},
            {"Heard": true, "Checked": "True", "Genre":"Rock", "Artist":"Blood, Sweat & Tears", "Year":1969, "Album":"Blood, Sweat & Tears", "Name":"More And More", "Length":"03:04", "Track":4, "Composer":"Don Juan, Pea Vee", "Download Date":"1901/5/3", "Last Played":"10:27:11"},
            {"Heard": true, "Checked": "True", "Genre":"Classic Rock", "Artist":"Jimi Hendrix", "Year":1968, "Album":"Electric Ladyland", "Name":"Have You Ever Been (To Electric Ladyland)", "Length":"02:10", "Track":2, "Composer":"Jimi Hendrix", "Download Date":"1926/6/26", "Last Played":"16:52:30"},
            {"Heard": true, "Checked": "True", "Genre":"Rock", "Artist":"Blood, Sweat & Tears", "Year":1968, "Album":"Child Is Father To The Man", "Name":"I Love You More Than You'll Ever Know", "Length":"05:57", "Track":2, "Composer":"", "Download Date":"1977/6/30", "Last Played":"08:00:56"},
            {"Heard": true, "Checked": "True", "Genre":"Blues", "Artist":"B.B. King", "Year":1997, "Album":"Deuces Wild", "Name":"Rock Me Baby", "Length":"06:38", "Track":3, "Composer":"B.B. King/Joe Josea", "Download Date":"1997/12/14", "Last Played":"01:13:08"},
            {"Heard": true, "Checked": "True", "Genre":"Blues", "Artist":"Buddy Guy", "Year":1993, "Album":"Feels Like Rain", "Name":"Sufferin' Mind", "Length":"03:33", "Track":6, "Composer":"E. Jones", "Download Date":"2016/4/6", "Last Played":"18:28:08"},
            {"Heard": true, "Checked": "True", "Genre":"Pop and R&B", "Artist":"Joni Mitchell", "Year":2000, "Album":"Both Sides Now", "Name":"You're My Thrill", "Length":"03:52", "Track":1, "Composer":"Jay Gorney/Sindney Clare", "Download Date":"1906/9/20", "Last Played":"21:16:53"},
            {"Heard": true, "Checked": "True", "Genre":"Easy Listening", "Artist":"Bette Midler", "Year":1993, "Album":"Experience the Divine", "Name":"Chapel Of Love", "Length":"02:54", "Track":4, "Composer":"Ellie Greenwich/Jeff Barry/Phil Spector", "Download Date":"1914/5/21", "Last Played":"22:55:19"},
            {"Heard": true, "Checked": "True", "Genre":"Blues", "Artist":"B.B. King", "Year":2005, "Album":"80", "Name":"Hummingbird", "Length":"04:42", "Track":6, "Composer":"", "Download Date":"1913/1/27", "Last Played":"13:49:41"},
            {"Heard": true, "Checked": "True", "Genre":"Progressive Rock", "Artist":"Emerson, Lake & Palmer", "Year":1996, "Album":"Brain Salad Surgery [Rhino]", "Name":"Jerusalem", "Length":"02:44", "Track":1, "Composer":"Charles Hubert Hastings Parry/William Blake", "Download Date":"2006/3/2", "Last Played":"18:28:08"},
            {"Heard": true, "Checked": "True", "Genre":"Progressive Rock", "Artist":"Emerson, Lake & Palmer", "Year":"", "Album":"The Atlantic Years", "Name":"Fanfare For The Common Man", "Length":"05:41", "Track":9, "Composer":"", "Download Date":"2023/7/1", "Last Played":"23:00:56"},
            {"Heard": true, "Checked": "True", "Genre":"Jazz", "Artist":"Bill Evans", "Year":1962, "Album":"Interplay", "Name":"Wrap Your Troubles In Dreams (And Dream Your Troubles Away)", "Length":"06:21", "Track":7, "Composer":"Billy Moll/Harry Barris/Ted Koehler", "Download Date":"1921/12/8", "Last Played":"16:55:19"},
            {"Heard": true, "Checked": "True", "Genre":"Classical", "Artist":"Andres Segovia", "Year":2004, "Album":"The Best Of Andres Segovia", "Name":"Bouree (Suite In E Minor, BWV 996 - Bach)", "Length":"01:32", "Track":2, "Composer":"Johann Sebastian Bach (1685-1750)", "Download Date":"1976/5/5", "Last Played":"15:42:11"},
            {"Heard": true, "Checked": "True", "Genre":"Rock", "Artist":"Dave Matthews", "Year":1996, "Album":"Crash", "Name":"Crash Into Me", "Length":"05:18", "Track":3, "Composer":"Dave Matthews", "Download Date":"1912/10/25", "Last Played":"07:01:53"},
            {"Heard": true, "Checked": "True", "Genre":"Easy Listening", "Artist":"Frank Sinatra", "Year":1990, "Album":"The Capitol Years [Disc 1]", "Name":"Someone To Watch Over Me", "Length":"02:57", "Track":12, "Composer":"George & Ira Gershwin/George Gershwin", "Download Date":"1909/8/12", "Last Played":"03:16:53"},
            {"Heard": true, "Checked": "True", "Genre":"Rock", "Artist":"Dave Matthews", "Year":1998, "Album":"Before These Crowded Streets", "Name":"The Last Stop", "Length":"06:58", "Track":3, "Composer":"Lessard, Stefan/Beauford, Carter", "Download Date":"1979/5/27", "Last Played":"21:22:30"},
            {"Heard": true, "Checked": "True", "Genre":"Classic Rock", "Artist":"Jimi Hendrix", "Year":1968, "Album":"Electric Ladyland", "Name":"Crosstown Traffic", "Length":"02:26", "Track":3, "Composer":"Jimi Hendrix", "Download Date":"1989/6/5", "Last Played":"04:24:23"},
            {"Heard": true, "Checked": "True", "Genre":"Jazz", "Artist":"Bill Evans", "Year":1978, "Album":"Affinity", "Name":"I Do It For Your Love", "Length":"07:23", "Track":1, "Composer":"Paul Simon", "Download Date":"1949/6/29", "Last Played":"01:24:23"},
            {"Heard": true, "Checked": "True", "Genre":"World", "Artist":"Andy Statman & David Grisman", "Year":1995, "Album":"Songs Of Our Fathers", "Name":"Dovid Melech Yisrael", "Length":"02:07", "Track":6, "Composer":"Shlomo Carlebach", "Download Date":"2001/12/27", "Last Played":"10:46:53"},
            {"Heard": true, "Checked": "True", "Genre":"Progressive Rock", "Artist":"Dixie dregs", "Year":1977, "Album":"Free Fall", "Name":"Dig the Ditch", "Length":"03:51", "Track":9, "Composer":"Steven J. Morse", "Download Date":"1994/10/6", "Last Played":"18:00:00"},
            {"Heard": true, "Checked": "True", "Genre":"Rock", "Artist":"Dave Matthews", "Year":1996, "Album":"Crash", "Name":"Too Much", "Length":"04:24", "Track":4, "Composer":"Dave Matthews", "Download Date":"1926/1/4", "Last Played":"00:02:49"},
            {"Heard": true, "Checked": "True", "Genre":"Classic Rock", "Artist":"Black Sabbath", "Year":2004, "Album":"Master of Reality", "Name":"Into the Void", "Length":"06:12", "Track":8, "Composer":"Bill Ward/Geezer Butler/Ozzy Osbourne/Tony Iommi", "Download Date":"1938/7/16", "Last Played":"00:56:15"},
            {"Heard": true, "Checked": "True", "Genre":"Easy Listening", "Artist":"Bette Midler", "Year":1993, "Album":"Experience the Divine", "Name":"From A Distance", "Length":"04:39", "Track":3, "Composer":"Julie Gold", "Download Date":"2029/2/25", "Last Played":"21:14:04"},
            {"Heard": true, "Checked": "True", "Genre":"Classical", "Artist":"Julian Bream", "Year":1957, "Album":"Fret Works: Dowland & Villa-Lobos", "Name":"Lachrimae Antiquae Galliard", "Length":"02:59", "Track":2, "Composer":"John Dowland", "Download Date":"1978/10/15", "Last Played":"11:54:23"},
            {"Heard": true, "Checked": "True", "Genre":"Rock", "Artist":"Dave Matthews", "Year":1996, "Album":"Crash", "Name":"Let You Down", "Length":"04:09", "Track":8, "Composer":"Dave Matthews", "Download Date":"1906/1/5", "Last Played":"20:20:38"},
            {"Heard": true, "Checked": "True", "Genre":"Jazz", "Artist":"Bill Evans", "Year":1958, "Album":"Everybody Digs Bill Evans", "Name":"Night and Day", "Length":"07:35", "Track":4, "Composer":"Cole Porter", "Download Date":"1953/5/20", "Last Played":"10:24:23"},
            {"Heard": true, "Checked": "True", "Genre":"Classic Rock", "Artist":"Black Sabbath", "Year":2004, "Album":"Black Sabbath", "Name":"Black Sabbath", "Length":"06:18", "Track":1, "Composer":"Bill Ward/Geezer Butler/Ozzy Osbourne/Tony Iommi", "Download Date":"1908/7/24", "Last Played":"16:38:26"},
            {"Heard": true, "Checked": "True", "Genre":"Blues", "Artist":"Buddy Guy", "Year":1993, "Album":"Feels Like Rain", "Name":"She's Nineteen Years Old", "Length":"05:43", "Track":4, "Composer":"Muddy Waters", "Download Date":"1971/2/24", "Last Played":"01:01:53"},
            {"Heard": true, "Checked": "True", "Genre":"Jazz", "Artist":"Bill Evans", "Year":1978, "Album":"Affinity", "Name":"The Days of Wine and Roses", "Length":"06:43", "Track":4, "Composer":"Henry Mancini, Johnny Mercer", "Download Date":"1955/2/12", "Last Played":"01:49:41"},
            {"Heard": true, "Checked": "True", "Genre":"Progressive Rock", "Artist":"Emerson, Lake & Palmer", "Year":"", "Album":"The Atlantic Years", "Name":"The Endless Enigma (Part 1)", "Length":"06:41", "Track":7, "Composer":"", "Download Date":"1961/12/22", "Last Played":"23:40:19"},
            {"Heard": true, "Checked": "True", "Genre":"Easy Listening", "Artist":"Frank Sinatra", "Year":1991, "Album":"Sinatra Reprise: The Very Good Years", "Name":"It Was A Very Good Year", "Length":"04:29", "Track":9, "Composer":"E. Drake", "Download Date":"1943/9/1", "Last Played":"15:59:04"},
            {"Heard": true, "Checked": "True", "Genre":"Pop and R&B", "Artist":"Joni Mitchell", "Year":1974, "Album":"Court And Spark", "Name":"Help Me", "Length":"03:22", "Track":2, "Composer":"Joni Mitchell", "Download Date":"2013/12/5", "Last Played":"09:59:04"},
            {"Heard": true, "Checked": "True", "Genre":"Classical", "Artist":"Julian Bream", "Year":1965, "Album":"Julian Bream Edition, Vol. 20", "Name":"Bach: Lute Suite In A Minor, BWV 997 - Praeludium", "Length":"03:06", "Track":7, "Composer":"Johann Sebastian Bach", "Download Date":"2032/12/26", "Last Played":"07:49:41"},
            {"Heard": true, "Checked": "True", "Genre":"Jazz", "Artist":"Bill Evans", "Year":1962, "Album":"Interplay", "Name":"You And The Night And The Music", "Length":"07:05", "Track":1, "Composer":"Arthur Schwartz/Howard Dietz", "Download Date":"2032/12/25", "Last Played":"07:30:00"},
            {"Heard": false, "Checked": "False", "Genre":"Classical", "Artist":"Julian Bream", "Year":1965, "Album":"Julian Bream Edition, Vol. 20", "Name":"Bach: Lute Suite In E Minor, BWV 996 - Sarabande", "Length":"04:45", "Track":4, "Composer":"Johann Sebastian Bach", "Download Date":"2017/1/6", "Last Played":"05:54:23"},
            {"Heard": true, "Checked": "True", "Genre":"Jazz", "Artist":"Charlie Hunter", "Year":2004, "Album":"Friends Seen and Unseen", "Name":"One for the Kelpers", "Length":"06:31", "Track":1, "Composer":"John Ellis", "Download Date":"1988/6/13", "Last Played":"09:22:30"},
            {"Heard": true, "Checked": "True", "Genre":"Easy Listening", "Artist":"Bette Midler", "Year":2003, "Album":"Bette Midler Sings the Rosemary Clooney Songbook", "Name":"You'll Never Know", "Length":"01:44", "Track":1, "Composer":"Warren, Harry 1893-1981 -w Gordon, Mac 1904-1959", "Download Date":"1923/10/17", "Last Played":"14:09:23"},
            {"Heard": true, "Checked": "True", "Genre":"Progressive Rock", "Artist":"Emerson, Lake & Palmer", "Year":1992, "Album":"The Atlantic Years", "Name":"Tank", "Length":"06:47", "Track":4, "Composer":"Carl Palmer/Keith Emerson", "Download Date":"1996/11/14", "Last Played":"00:36:34"},
            {"Heard": true, "Checked": "True", "Genre":"Classic Rock", "Artist":"Jimi Hendrix", "Year":1968, "Album":"Electric Ladyland", "Name":"Come On, Pt. 1", "Length":"04:10", "Track":7, "Composer":"Earl King", "Download Date":"2008/3/1", "Last Played":"14:48:45"},
            {"Heard": true, "Checked": "True", "Genre":"World", "Artist":"Andy Statman & David Grisman", "Year":1995, "Album":"Songs Of Our Fathers", "Name":"Der Rebbe", "Length":"03:59", "Track":9, "Composer":"Trad.", "Download Date":"2021/5/21", "Last Played":"11:45:56"},
            {"Heard": true, "Checked": "True", "Genre":"Blues", "Artist":"B.B. King", "Year":2005, "Album":"80", "Name":"Early in the Morning", "Length":"04:50", "Track":1, "Composer":"", "Download Date":"2020/1/13", "Last Played":"08:23:26"},
            {"Heard": true, "Checked": "True", "Genre":"Classical", "Artist":"Julian Bream", "Year":1992, "Album":"Nocturnal", "Name":"Martin: Quatre Pièces Breves - 3. Plainte: Sans Lenteur", "Length":"02:59", "Track":3, "Composer":"Frank Martin", "Download Date":"1986/5/4", "Last Played":"20:54:23"},
            {"Heard": true, "Checked": "True", "Genre":"Jazz", "Artist":"Bill Evans", "Year":1958, "Album":"Everybody Digs Bill Evans", "Name":"What Is There to Say?", "Length":"04:54", "Track":8, "Composer":"Duke", "Download Date":"1900/8/15", "Last Played":"04:01:53"},
            {"Heard": true, "Checked": "True", "Genre":"Jazz", "Artist":"Andy Narell", "Year":1989, "Album":"Little Secrets", "Name":"Don't Look Back", "Length":"09:39", "Track":6, "Composer":"Andy Narell", "Download Date":"1907/3/5", "Last Played":"23:29:04"},
            {"Heard": true, "Checked": "True", "Genre":"Progressive Rock", "Artist":"Dixie dregs", "Year":1978, "Album":"What if", "Name":"What if", "Length":"05:02", "Track":3, "Composer":"Steve Morse", "Download Date":"1992/3/28", "Last Played":"00:22:30"}
        ];

        var i, len;
        for(i=0, len = data_list.length; i < len; ++i){
            data.items.push(dojo.mixin({'id': i + 1 }, data_list[i % len]));
        }

        var layout = [
            { field: "id", datatype:"number"},
            { field: "Genre", datatype:"string"},
            { field: "Artist", datatype:"string",
                // Declare that we need the ComboBox for suggestions (autoComplete by default)
                autoComplete: true
            },
            { field: "Album", datatype:"string",
                // Declare that we need the ComboBox for suggestions
                autoComplete: true,
                // Configure the ComboBox, so that it does not auto-complete our input
                dataTypeArgs: {
                    autoComplete: false
                }
            },
            { field: "Name", datatype:"string",
                // Declare that we do not need the following conditions for this column
                disabledConditions: ["contains", "notcontains"]
            },
            { field: "Track", datatype:"number"},
            { field: "Download Date", datatype:"date",
                // Declare how the data in store should be parsed to a Date object.
                dataTypeArgs: {
                    datePattern: "yyyy/M/d"
                }
            },
            { field: "Last Played", datatype:"time",
                // Declare how the data in store should be parsed to a Date object.
                dataTypeArgs: {
                    timePattern: "HH:mm:ss"
                }
            }
        ];

        // In case you've close the filter bar, here's a way to bring it up.
        function showFilterBar(){
            dijit.byId('grid').showFilterBar(true);
        }

        dojo.ready(function(){

            var store = new dojo.data.ItemFileWriteStore({data: data});

            var grid = new dojox.grid.EnhancedGrid({
                id: 'grid',
                store: store,
                structure: layout,
                plugins: {
                    filter: {
                        // Show the closeFilterbarButton at the filter bar
                        closeFilterbarButton: true,
                        // Set the maximum rule count to 5
                        ruleCount: 5,
                        // Set the name of the items
                        itemsName: "songs"
                    }
                }
            });
            grid.placeAt('gridContainer');
            grid.startup();
        });

  .. html ::

    <div id="gridContainer" style="width: 100%; height: 400px;"></div>
    <button onclick='showFilterBar()'>Show Filter Bar</button>

  .. css ::

    @import "{{ baseUrl }}dojo/resources/dojo.css";
    @import "{{ baseUrl }}dijit/themes/{{ theme }}/{{ theme }}.css";
    @import "{{ baseUrl }}dijit/themes/{{ theme }}/document.css";
    @import "{{ baseUrl }}dojox/grid/enhanced/resources/{{ theme }}/EnhancedGrid.css";
    @import "{{ baseUrl }}dojox/grid/enhanced/resources/EnhancedGrid_rtl.css";


Configuration
=============

Prerequisites
-------------

This filter plugin is only available for EnhancedGrid. Use the following statements in the head of your HTML file:

.. js ::
  
  dojo.require("dojox.grid.EnhancedGrid");
  dojo.require("dojox.grid.enhanced.plugins.Filter");


Plugin Declaration
------------------

The declaration name of this plugin is ``filter`` . It is declared in the ``plugins`` property of grid.

If your grid is created declaratively:

.. html ::

    <div id="grid" data-dojo-type="dojox.grid.EnhancedGrid"
      store="mystore" structure="mystructure"
      plugins="{
        filter: /* a Boolean value or an configuration object */{}
    }" ></div>

If your grid is created in JavaScript:

.. js ::
  
  var grid = new dojox.grid.EnhancedGrid({
    id:"grid",
    store:"mystore",
    structure:"mystructure",
    plugins:{
      filter: /* a Boolean value or an configuration object */{}
    }
  });

As shown in the above code, you can simply set the ``filter`` property to true or false (disabled), or further configure it in an configuration object.

All the available configuration properties are:

=============================  ========  ===============  ================================================================================================================
Property                       Type      Default Value    Description
=============================  ========  ===============  ================================================================================================================
itemsName                      String    "items"          The name of the items in the data store.
                                                          For example, if the data in the store are records of songs, you may set it to "songs",
                                                          so the filter bar will display "10 of 100 songs" instead of "10 of 100 items" when there's some filter applied.
closeFilterbarButton           Boolean   false            Whether to show the close-filterbar button.
ruleCount                      Number    3                The maximum rule count of a filter. Default to 3. If set to 0 or Infinity, infinite rules are supported.
ruleCountToConfirmClearFilter  Number    2                If the filter rule count is larger than or equal to this value, then a confirm dialog will show when
                                                          clearing filter. If set to less than 1 or null, then always show the confirm dialog. If set to Infinity,
                                                          then never show the confirm dialog. Default to 2.
disabledConditions             Object    undefined        Disable some condition for some type or "anycolumn", so the user will not see them in the condition Select box.
isServerSide                   Boolean   false            If this is true, the actual filtering work will be taken over by the server.
                                                          This is used to switch between client-side filter and server-side filter.
isStateful                     Boolean   false            If this is true, and isServerSide is set to true, the filter definition will only be sent when it is defined,
                                                          and it should be remembered at server side until it is changed.
url                            String    ""               When both isServerSide and isStateful are true, this is a place to set the server url,
                                                          if it cannot be retrieved by store.url.
setupFilterQuery               Function  undefined        If you'd like to use a stateless server side filter, you'll have to modify the request object, so as to add in
                                                          the filter definition. The signature of this function is setupFilterQuery(commands, request). See the last
                                                          section for details.
=============================  ========  ===============  ================================================================================================================

Column Configuration
--------------------

Filter provides different conditions for different data types, but the store does not have any information of types. So users should explicitly declare the data types in the structure of grid.
For example:

.. js ::
  
  var structure = [{
    cells:[
      {field: "Name", datatype: "string", autoComplete: true },
      {field: "Age", datatype: "number" },
      {field: "Register Date", datatype: "date" },
      {field: "dummy", filterable: false}, // set this column to be not filterable
      {field: "Register Time", datatype: "time", disabledConditions: ["startsWith", "notStartsWith"]}
    ]
  }];

The following properties are available for column configuration:

====================================  ===================================  ========================================  ============================================================================================
Property                              Type                                 Default Value                             Description
====================================  ===================================  ========================================  ============================================================================================
filterable                            Boolean                              true                                      To set whether this column can be filtered.
datatype                              String                               "string"                                  The data type of this column, determining what conditions could be applied.
autoComplete                          Boolean                              false                                     Only valid for "string" type. If set to true, a ComboBox instead of a TextBox will be used.
disabledConditions                    String[]                             []                                        To disable some conditions for this column. For a full list of condition names, see below.
dataTypeArgs                          Object                               {}                                        A place to put data type specific arguments.
dataTypeArgs(for date/time type)      dojo.date.locale.__FormatOptions     {}                                        Defines how to parse the date/time data shown in the grid.
dataTypeArgs(for boolean type)        Object                               {trueLabel: "True", falseLabel: "False"}  Set the label text for true value or false value.
====================================  ===================================  ========================================  ============================================================================================

Here is a list of all the condition names (case insensitive)

======================    ===================================
Condition Name            Available Data Types
======================    ===================================
equalTo                   number, string, date, time, boolean
lessThan                  number, date, time
lessThanOrEqualTo         number
largerThan                number, date, time
largerThanOrEqualTo       number
contains                  string
startsWith                string
endsWith                  string
notEqualTo                number, string
notContains               string
notStartsWith             string
notEndsWith               string
range                     date, time
isEmpty                   number, string, date, time, boolean
======================    ===================================

Usage
=====

The UI of this plugin consists of 3 components: a filter bar within the grid, a definition dialog, and a status tooltip.

Filter Bar
----------

.. image :: filterbar-1.png

Clicking the button on the filter bar will show the Filter Definition Dialog with a default value of "Any Column".

.. image :: filterbar-definefilterbtn-1.png

Clicking directly on the filter bar will also show the Filter Definition Dialog, but setting the value of the "Column" field to the column that the mouse is over.

.. image :: filterbar-somecolumn-1.png

Hovering over the filterbar for 300 msec will trigger the Filter Status Tooltip.

.. image :: filterbar-showtooltip-1.png

When there's a filter defined, the clear filter button will be shown, and the status tip will look like this:

.. image :: filterbar-clearbtn-1.png

If ``closeFilterbarButton`` is true, there will be a close-filterbar button at the right end of the filter bar.

.. image :: filterbar-closebtn-1.png

When the filter bar is hidden, there is a function to bring it out: ``showFilterBar``

Actually there's a set of APIs related to filterbar:

showFilterBar(toShow, useAnim, animArgs):
    Show/Hide filter bar

==============  ==================  ==========================  =============================================
Arguments       Type                Optional/Mandatory          Description
==============  ==================  ==========================  =============================================
toShow          Boolean             Mandatory                   To show or to hide
useAnim         Boolean             Optional(default to true)   When showing/hiding, whether to use animation.
animArgs        dojo.__AnimArgs     Optional                    Customized animation properties.
==============  ==================  ==========================  =============================================

toggleFilterBar(useAnim, animArgs):
    Toggle the filter bar. Will call ``showFilterBar``. Please refer to the useAnim/animArgs arguments for showFilterBar method.

isFilterBarShown():
    Check the visibility of filter bar. Return boolean.


Filter Definition Dialog
------------------------

.. image :: defdialog.png

The Filter Definition Dialog is designed to define filter conditions with either of the following structures:

1. [rule 1 for column A] and [rule 2 for column B] and [rule 3 for column C]

2. [rule 1 for column A] or [rule 2 for column B] or [rule 3 for column C]

.. image :: defdialog-rulerelation.png

Use the "Add Rule" button to add a rule. If there are already 3 rules, this button will be disabled.
Every rule is regarded as a simple sentence with the following structure:

``[Column] [Condition Verb] [Value]``

For example: ``Column "Age", "is less than", 26``

Different data types have different sets of conditions and different kinds of form widgets.

The value field for Number type only accepts number.

.. image :: defdialog-numbervaluebox-1.png

The value field for String type can have auto-complete capability (if set autoComplete in the grid structure).

.. image :: defdialog-stringvaluebox.png

DateTextBox and TimeTextBox are used for Date and Time types, respectively.

.. image :: defdialog-timevaluebox.png

And the ``range`` condition for ``date`` and ``time`` types represents a closed range.

.. image :: defdialog-rangevaluebox.png


Filter Status Tooltip
---------------------

.. image :: statustooltip-multirule.png

When a filter exists, the Filter Status Tooltip shows every rule of the current filter. If there are multiple rules, you can delete some of them by clicking the red 'X' at the right side of every rule.


Introduction to Server-Side Filtering
=====================================

If the store is too big to perform efficient client-side filtering, you can implement your own server-side filter logic along with your data store implementation.

To enable server-side filtering, just set the ``isServerSide`` property to true.

Basic Protocol
--------------

By default, the server side is assumed to be stateless (REST style). In this case, you should send the filter definition to server side along with the fetch request of the store.
You can do this by modifying the request object every time before store.fetch is called.

For example:

.. js ::
  
  var grid = new dojox.grid.EnhancedGrid({
    id:"grid",
    store:"mystore",
    structure:"mystructure",
    plugins:{
      filter: {
        isServerSide: true,
        setupFilterQuery: setupFilter
      }
    }
  });
  var setupFilter = function(commands, request){
    // the commands object here is the same as the POSTed commands object for stateful server, see below.
    if(commands.filter && commands.enable){
      // some filter is defined and valid. You can modify the request object here.
    }else{
      // no filter is valid.
    }
  };

Thus the filter definition will be sent to the server along with the request.
  
If you'd like to use a stateful server, which means the filter definition will only be sent when it is defined, and it should be remembered at serverside until it is changed, you can set the '''isStateful''' property:

.. js ::
  
  var grid = new dojox.grid.EnhancedGrid({
    id:"grid",
    store:"mystore",
    structure:"mystructure",
    plugins:{
      filter: {
        isServerSide: true,
        isStateful: true
      }
    }
  });

Then the filter store layer will send the commands via POST before normal store fetch. There are at most 4 fields in this posted data:

==========  ===========  =================  ===================  ==========================================================================================================
Name        Data Type    Always Available   Value For Example    Description
==========  ===========  =================  ===================  ==========================================================================================================
cmdlayer    String       Yes                "filter"             The name of the current store layer. In this case, it's always "filter".
enable      Integer      Yes                true                 A command to enable/disable the current store layer (in this case, the filter layer).
                                                                 If it is false, the server-side should not filter the data. This field is always valid.
clear       Boolean      No                 true                 Only meaningful for stateful server. A command to clear the filter definition.
                                                                 When this field exists and equals to true, it means the user has cleared the filter,
                                                                 so the server should return unfiltered data in later fetches.
                                                                 This field should not co-exist with the "filter" field.
                                                                 If they both exist, the "filter" field has higher priority
filter      JSON String  No                 {...}                A command to set the filter definition.
                                                                 When this field exists, it means the user has defined a new filter,
                                                                 so the server should re-filter the data using this new filter, and return filtered data in later fetches.
                                                                 This field should not co-exist with the "clear" field. If they both exist, this field has higher priority.
==========  ===========  =================  ===================  ==========================================================================================================

When the web page loads, the first POST that the server receives is the ``clear`` command. It ensures that there's no filter defined in the session.

Every time the user defines a filter, the server will receive a ``filter`` command. This command contains a JSON string representing the filter definition, which is covered in the next section.

After receiving the filter command, the server should respond with the count of filtered rows in this format:

.. js ::
  
  200,1000

The first number is the count of the filtered rows, while the second is the total count of rows in store.

Note that stateless servers don't need to do this, because the filter definition is sent together with the fetch arguments.


The Filter Definition
---------------------

The Filter plugin will create a JSON object for the defined filter with the following recursive structure:

.. image :: serverfilter-datastruct.png

This structure represents an expression, which consists of operators and operands (data). The operands can further contain expressions, that is, deeper level of operators and operands.

All available properties in this filter definition JSON are listed below:

=====  ==========  =================  ==================  =====================================================================================================================================
Name   Data Type   Always Available   Value For Example   Description
=====  ==========  =================  ==================  =====================================================================================================================================
op     String      Yes                "equal"             The name of an operator or a data type. Currently supported operators are:
                                                          and | or | not | all | any | equal | less | lessEqual | larger | largerEqual | contains | startsWith | endsWith
                                                          Currently supported datatypes are:
                                                          string | number | date | time | boolean
data   Object      Yes                {...}               The data of the corresponding "op".
                                                          If "op" is actually an operator, this field must be an array, which contains a list of deeper level filter expressions.
                                                          If "op" is a data type, and there is no "isCol" field, this "data" field is a value of this type.
isCol  Boolean     No                 true                If "op" is a datatype, and the property "isCol" is true, this "data" field represents the field name of a column in the data store,
                                                          so the server implementer can get the value of this field, and transform it to the specified datatype.
=====  ==========  =================  ==================  =====================================================================================================================================


So the JSON object is nothing more than an object with 2 fields: ``op`` and ``data``. For example, The following filter definition means:

The data of the "Field Name" column, whose data type is string, equals to "some message".

.. js ::
  
  {
    // op: String
    // The name of an operator or a data type. Currently supported operators are:
    //  and | or | not | all | any | equal | less | lessEqual | larger | largerEqual | contains | startsWith | endsWith
    // Currently supported datatypes are:
    //  string | number | date | time
    op: "equal",
    
    // data: Array | string | number
    // The data of the corresponding "op". If "op" is actually an operator, this field must be an array,
    // which contains a list of deeper level filter expressions.
    data: [
      {
        op: "string",
        
        // data: Array | string | number
        // If "op" is a datatype, and there is no "isCol" field, this "data" field is a value of this type.
        data: "some message"
      },
      {
        op: "string",
        
        // isCol: Boolean
        // If this field exists and is, or can be converted to, true,
        // then this expression represents a column in the store,
        // and the corresponding "data" field represents the field name of this column.
        isCol: true,
        
        // data: Array | string | number
        // If "op" is a datatype, and the property "isCol" is true,
        // this "data" field represents the field name of a column in the data store,
        // so the server implementer can get the value of this field, and transform it to the specified datatype.
        data: "Field Name"
      }
    ]
  }

Supported Operators
-------------------

Here is a summary of all supported operators used in filter definition. The "Name" of each operator is passed as the ``op`` field in the filter definition.

===========  ====================================  =======================  ================================================================================
Name         Valid Data Types                      Number of Operands       Meaning
===========  ====================================  =======================  ================================================================================
and          boolean                               2                        Logic AND
or           boolean                               2                        Logic OR
not          boolean                               1                        Logic NOT
all          boolean                               1 ~ ruleCount            A general version of "and"
any          boolean                               1 ~ ruleCount            A general version of "or"
equal        string, number, date, time, boolean   2                        The value of 2 operands are equal
less         number, date, time                    2                        The value of the 1st operand is less than that of the 2nd operand
lessEqual    number                                2                        The value of the 1st operand is less than or equal to that of the 2nd operand
larger       number, date, time                    2                        The value of the 1st operand is larger than that of the 2nd operand
largerEqual  number                                2                        The value of the 1st operand is larger than or equal to that of the 2nd operand
contains     string                                2                        The value of the 1st operand contains that of the 2nd operand
startsWith   string                                2                        The value of the 1st operand starts with that of the 2nd operand
endsWith     string                                2                        The value of the 1st operand ends with that of the 2nd operand
isEmpty      string, number, date, time, boolean   1                        The value is empty
===========  ====================================  =======================  ================================================================================


See Also
========

* :ref:`dojox.grid.DataGrid <dojox/grid/DataGrid>` - The base grid
* :ref:`dojox.grid.EnhancedGrid <dojox/grid/EnhancedGrid>` - The enhanced grid supporting plugins
* :ref:`dojox.grid.EnhancedGrid.plugins <dojox/grid/EnhancedGrid/plugins>` - Overview of the plugins of enhanced grid
* :ref:`dojox.grid.TreeGrid <dojox/grid/TreeGrid>` - Grid with collapsible rows and model-based (:ref:`dijit.tree.ForestStoreModel <dijit/tree/ForestStoreModel>`) structure
