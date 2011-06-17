#format dojo_rst

dojox.grid.EnhancedGrid.plugins.Exporter
========================================

:Authors: Zhu Xiao Wen
:Project owner: Nathan Toone
:Available: since V.1.6

Exporter plugin provides functions to export the grid data into a given format.

.. contents::
   :depth: 2

============
Introduction
============

Exporter is a plugin for dojox.grid.EnhancedGrid. It is designed as a framework to help implement various export formats for grid, e.g. CSV, HTML table, MS Excel, odt etc. The plugin itself does not export anything, it only goes through the grid row by row calling the implementation's interface. It's the implementation's responsibility to transform the grid content to some desired format.
The following of this document first describes how to use the export functions of some existing implementations. And then introduces the API of this framework in detail.

.. code-example::
  :toolbar: themes, versions, dir
  :width: 600
  :height: 600 

  .. javascript::

	<script type="text/javascript">
		dojo.require("dojox.grid.EnhancedGrid");
		dojo.require("dojo.data.ItemFileWriteStore");
		dojo.require("dojox.grid.enhanced.plugins.exporter.CSVWriter");
	
		var data = {
			identifier: 'id',
			label: 'id',
			items: []
		};
		var data_list = [
			{"Heard": true, "Checked": "True", "Genre":"Easy Listening",	"Artist":"Bette Midler",	"Year":2003,	"Album":"Bette Midler Sings the Rosemary Clooney Songbook",	"Name":"Hey There",	"Length":"03:31",	"Track":4,	"Composer":"Ross, Jerry 1926-1956 -w Adler, Richard 1921-",	"Download Date":"1923/4/9",	"Last Played":"04:32:49"},
			{"Heard": true, "Checked": "True", "Genre":"Classic Rock",	"Artist":"Jimi Hendrix",	"Year":1993,	"Album":"Are You Experienced",	"Name":"Love Or Confusion",	"Length":"03:15",	"Track":4,	"Composer":"Jimi Hendrix",	"Download Date":"1947/12/6",	"Last Played":"03:47:49"},
			{"Heard": true, "Checked": "True", "Genre":"Jazz",	"Artist":"Andy Narell",	"Year":1992,	"Album":"Down the Road",	"Name":"Sugar Street",	"Length":"07:00",	"Track":8,	"Composer":"Andy Narell",	"Download Date":"1906/3/22",	"Last Played":"21:56:15"},
			{"Heard": true, "Checked": "True", "Genre":"Progressive Rock",	"Artist":"Emerson, Lake & Palmer",	"Year":1992,	"Album":"The Atlantic Years",	"Name":"Tarkus",	"Length":"20:40",	"Track":5,	"Composer":"Greg Lake/Keith Emerson",	"Download Date":"1994/11/29",	"Last Played":"03:25:19"},
			{"Heard": true, "Checked": "True", "Genre":"Rock",	"Artist":"Blood, Sweat & Tears",	"Year":1968,	"Album":"Child Is Father To The Man",	"Name":"Somethin' Goin' On",	"Length":"08:00",	"Track":9,	"Composer":"",	"Download Date":"1973/9/11",	"Last Played":"19:49:41"},
			{"Heard": true, "Checked": "True", "Genre":"Jazz",	"Artist":"Andy Narell",	"Year":1989,	"Album":"Little Secrets",	"Name":"Armchair Psychology",	"Length":"08:20",	"Track":5,	"Composer":"Andy Narell",	"Download Date":"2010/4/15",	"Last Played":"01:13:08"},
			{"Heard": true, "Checked": "True", "Genre":"Easy Listening",	"Artist":"Frank Sinatra",	"Year":1991,	"Album":"Sinatra Reprise: The Very Good Years",	"Name":"Luck Be A Lady",	"Length":"05:16",	"Track":4,	"Composer":"F. Loesser",	"Download Date":"2035/4/12",	"Last Played":"06:16:53"},
			{"Heard": true, "Checked": "True", "Genre":"Progressive Rock",	"Artist":"Dixie dregs",	"Year":1977,	"Album":"Free Fall",	"Name":"Sleep",	"Length":"01:58",	"Track":6,	"Composer":"Steve Morse",	"Download Date":"2032/11/21",	"Last Played":"08:23:26"},
			{"Heard": true, "Checked": "True", "Genre":"Classic Rock",	"Artist":"Black Sabbath",	"Year":2004,	"Album":"Master of Reality",	"Name":"Sweet Leaf",	"Length":"05:04",	"Track":1,	"Composer":"Bill Ward/Geezer Butler/Ozzy Osbourne/Tony Iommi",	"Download Date":"2036/5/26",	"Last Played":"22:10:19"},
			{"Heard": true, "Checked": "True", "Genre":"Blues",	"Artist":"Buddy Guy",	"Year":1991,	"Album":"Damn Right, I've Got The Blues",	"Name":"Five Long Years",	"Length":"08:27",	"Track":3,	"Composer":"Eddie Boyd/John Lee Hooker",	"Download Date":"1904/4/4",	"Last Played":"18:28:08"},
			{"Heard": true, "Checked": "True", "Genre":"Easy Listening",	"Artist":"Frank Sinatra",	"Year":1991,	"Album":"Sinatra Reprise: The Very Good Years",	"Name":"The Way You Look Tonight",	"Length":"03:23",	"Track":5,	"Composer":"D. Fields/J. Kern",	"Download Date":"1902/10/12",	"Last Played":"23:09:23"},
			{"Heard": true, "Checked": "True", "Genre":"World",	"Artist":"Andy Statman & David Grisman",	"Year":1995,	"Album":"Songs Of Our Fathers",	"Name":"Chassidic Medley: Adir Hu / Moshe Emes",	"Length":"04:14",	"Track":2,	"Composer":"Shlomo Carlebach; Trad.",	"Download Date":"2035/2/9",	"Last Played":"00:11:15"},
			{"Heard": true, "Checked": "True", "Genre":"Classic Rock",	"Artist":"Jimi Hendrix",	"Year":1968,	"Album":"Electric Ladyland",	"Name":"Long Hot Summer Night",	"Length":"03:27",	"Track":6,	"Composer":"Jimi Hendrix",	"Download Date":"1902/4/7",	"Last Played":"16:58:08"},
			{"Heard": true, "Checked": "True", "Genre":"Classical",	"Artist":"Andres Segovia",	"Year":2004,	"Album":"The Best Of Andres Segovia",	"Name":"Asturias (Suite Espanola, Op. 47)",	"Length":"06:25",	"Track":6,	"Composer":"Isaac Albeniz",	"Download Date":"1904/10/25",	"Last Played":"06:59:04"},
			{"Heard": true, "Checked": "True", "Genre":"Jazz",	"Artist":"Andy Narell",	"Year":1989,	"Album":"Little Secrets",	"Name":"We Kinda Music",	"Length":"08:22",	"Track":3,	"Composer":"Andy Narell",	"Download Date":"1905/5/22",	"Last Played":"23:43:08"},
			{"Heard": true, "Checked": "True", "Genre":"Pop and R&B",	"Artist":"Joni Mitchell",	"Year":2000,	"Album":"Both Sides Now",	"Name":"Comes Love",	"Length":"04:29",	"Track":3,	"Composer":"Charles Tobias/Sammy Stept/Lew Brown",	"Download Date":"1927/11/19",	"Last Played":"02:34:41"},
			{"Heard": true, "Checked": "True", "Genre":"Pop and R&B",	"Artist":"Joni Mitchell",	"Year":1974,	"Album":"Court And Spark",	"Name":"Court And Spark",	"Length":"02:46",	"Track":1,	"Composer":"Joni Mitchell",	"Download Date":"1927/5/24",	"Last Played":"13:27:11"},
			{"Heard": true, "Checked": "True", "Genre":"Easy Listening",	"Artist":"Frank Sinatra",	"Year":1962,	"Album":"Sinatra and Swinging Brass",	"Name":"Serenade in Blue",	"Length":"03:00",	"Track":10,	"Composer":"Harry Warren, Mack Gordon",	"Download Date":"1932/7/16",	"Last Played":"08:15:00"},
			{"Heard": true, "Checked": "True", "Genre":"Classical",	"Artist":"Julian Bream",	"Year":1957,	"Album":"Fret Works: Dowland & Villa-Lobos",	"Name":"Queen Elizabeth's Galliard",	"Length":"01:33",	"Track":1,	"Composer":"John Dowland",	"Download Date":"2022/6/9",	"Last Played":"08:40:19"},
			{"Heard": true, "Checked": "True", "Genre":"Progressive Rock",	"Artist":"Dixie dregs",	"Year":1977,	"Album":"Free Fall",	"Name":"Free Fall",	"Length":"04:41",	"Track":1,	"Composer":"Steve Morse",	"Download Date":"2022/6/6",	"Last Played":"01:27:11"},
			{"Heard": true, "Checked": "True", "Genre":"Classic Rock",	"Artist":"Black Sabbath",	"Year":2004,	"Album":"Master of Reality",	"Name":"After Forever",	"Length":"05:26",	"Track":2,	"Composer":"Tony Iommi",	"Download Date":"1996/4/7",	"Last Played":"03:53:26"},
			{"Heard": true, "Checked": "True", "Genre":"Classic Rock",	"Artist":"Jimi Hendrix",	"Year":1993,	"Album":"Are You Experienced",	"Name":"The Wind Cries Mary",	"Length":"03:23",	"Track":7,	"Composer":"Jimi Hendrix",	"Download Date":"1941/4/23",	"Last Played":"04:52:30"},
			{"Heard": true, "Checked": "True", "Genre":"Rock",	"Artist":"Dave Matthews",	"Year":1998,	"Album":"Before These Crowded Streets",	"Name":"Don't Drink the Water",	"Length":"07:01",	"Track":4,	"Composer":"Beauford, Carter/Matthews, David J.",	"Download Date":"2019/8/19",	"Last Played":"12:45:00"},
			{"Heard": true, "Checked": "True", "Genre":"Jazz",	"Artist":"Charlie Hunter",	"Year":2004,	"Album":"Friends Seen and Unseen",	"Name":"Eleven Bars for Gandhi",	"Length":"06:57",	"Track":7,	"Composer":"Charlie Hunter",	"Download Date":"1973/9/24",	"Last Played":"15:02:49"},
			{"Heard": true, "Checked": "True", "Genre":"World",	"Artist":"Andy Statman & David Grisman",	"Year":1995,	"Album":"Songs Of Our Fathers",	"Name":"L'Ma'an Achai V'Re'ei",	"Length":"05:56",	"Track":8,	"Composer":"Shlomo Carlebach",	"Download Date":"2007/10/27",	"Last Played":"20:23:26"},
			{"Heard": true, "Checked": "True", "Genre":"Jazz",	"Artist":"Bill Evans",	"Year":1958,	"Album":"Everybody Digs Bill Evans",	"Name":"Minority",	"Length":"05:22",	"Track":1,	"Composer":"Gigi Gryce",	"Download Date":"1912/6/9",	"Last Played":"09:30:56"},
			{"Heard": false, "Checked": "False", "Genre":"Classical",	"Artist":"Julian Bream",	"Year":1992,	"Album":"Nocturnal",	"Name":"Britten: Nocturnal - 1. Musingly (Meditativo)",	"Length":"02:14",	"Track":5,	"Composer":"Benjamin Britten",	"Download Date":"1943/9/16",	"Last Played":"12:14:04"},
			{"Heard": false, "Checked": "False", "Genre":"Classical",	"Artist":"Andres Segovia",	"Year":1955,	"Album":"The Art Of Segovia [Disc 1]",	"Name":"Tarrega: Recuerdos de la Alhambra",	"Length":"05:16",	"Track":1,	"Composer":"Francisco Tarrega",	"Download Date":"1946/10/11",	"Last Played":"09:14:04"},
			{"Heard": true, "Checked": "True", "Genre":"Rock",	"Artist":"Blood, Sweat & Tears",	"Year":1968,	"Album":"Child Is Father To The Man",	"Name":"Overture",	"Length":"01:32",	"Track":1,	"Composer":"",	"Download Date":"1967/12/16",	"Last Played":"23:23:26"},
			{"Heard": true, "Checked": "True", "Genre":"World",	"Artist":"Andy Statman Quartet",	"Year":2005,	"Album":"Between Heaven & Earth",	"Name":"Tzamah Nafshi",	"Length":"08:00",	"Track":8,	"Composer":"Karlin-Stolin",	"Download Date":"2002/10/10",	"Last Played":"01:21:34"},
			{"Heard": true, "Checked": "True", "Genre":"Blues",	"Artist":"B.B. King",	"Year":2005,	"Album":"80",	"Name":"The Thrill Is Gone",	"Length":"05:03",	"Track":3,	"Composer":"",	"Download Date":"1949/9/13",	"Last Played":"16:01:53"},
			{"Heard": true, "Checked": "True", "Genre":"Rock",	"Artist":"Dave Matthews",	"Year":1998,	"Album":"Before These Crowded Streets",	"Name":"Stay (Wasting Time)",	"Length":"05:35",	"Track":5,	"Composer":"Lessard, Stefan/Beauford, Carter/Moore, Leroi",	"Download Date":"2020/5/12",	"Last Played":"15:25:19"},
			{"Heard": true, "Checked": "True", "Genre":"Pop and R&B",	"Artist":"Joni Mitchell",	"Year":2000,	"Album":"Both Sides Now",	"Name":"Answer Me My Love",	"Length":"03:24",	"Track":5,	"Composer":"Carl Sigman/Gerhard Winkler/Fred Rauch",	"Download Date":"1962/4/10",	"Last Played":"19:52:30"},
			{"Heard": true, "Checked": "True", "Genre":"Rock",	"Artist":"Dave Matthews",	"Year":1996,	"Album":"Crash",	"Name":"Two Step",	"Length":"06:29",	"Track":2,	"Composer":"Dave Matthews",	"Download Date":"2025/6/27",	"Last Played":"12:14:04"},
			{"Heard": true, "Checked": "True", "Genre":"Progressive Rock",	"Artist":"Dixie dregs",	"Year":1978,	"Album":"What if",	"Name":"Little Kids",	"Length":"02:07",	"Track":6,	"Composer":"",	"Download Date":"2008/6/9",	"Last Played":"15:53:26"},
			{"Heard": true, "Checked": "True", "Genre":"Easy Listening",	"Artist":"Bette Midler",	"Year":2003,	"Album":"Bette Midler Sings the Rosemary Clooney Songbook",	"Name":"Come On-A My House",	"Length":"01:50",	"Track":6,	"Composer":"Saroyan, William 1908-1981 -w Bagdasarian, Ross 1919-1972",	"Download Date":"2018/8/13",	"Last Played":"19:21:34"},
			{"Heard": false, "Checked": "False", "Genre":"Classical",	"Artist":"Julian Bream",	"Year":1957,	"Album":"Fret Works: Dowland & Villa-Lobos",	"Name":"King of Denmark's Galliard",	"Length":"01:15",	"Track":8,	"Composer":"John Dowland",	"Download Date":"2008/12/29",	"Last Played":"18:33:45"},
			{"Heard": false, "Checked": "False", "Genre":"Classical",	"Artist":"Andres Segovia",	"Year":2004,	"Album":"The Best Of Andres Segovia",	"Name":"Recuerdos De La Alhambra",	"Length":"05:12",	"Track":5,	"Composer":"Francisco Tarrega",	"Download Date":"1906/3/11",	"Last Played":"17:54:23"},
			{"Heard": true, "Checked": "True", "Genre":"Classic Rock",	"Artist":"Jimi Hendrix",	"Year":1968,	"Album":"Electric Ladyland",	"Name":"Voodoo Chile",	"Length":"14:59",	"Track":4,	"Composer":"Jimi Hendrix",	"Download Date":"1904/12/18",	"Last Played":"03:00:00"},
			{"Heard": false, "Checked": "False", "Genre":"Classical",	"Artist":"Julian Bream",	"Year":1957,	"Album":"Fret Works: Dowland & Villa-Lobos",	"Name":"Fantasia",	"Length":"05:02",	"Track":7,	"Composer":"John Dowland",	"Download Date":"1907/4/11",	"Last Played":"17:37:30"},
			{"Heard": true, "Checked": "True", "Genre":"Blues",	"Artist":"B.B. King",	"Year":1997,	"Album":"Deuces Wild",	"Name":"There Must Be A Better World Somewhere",	"Length":"04:51",	"Track":7,	"Composer":"Rebennack/Pomus",	"Download Date":"1929/1/24",	"Last Played":"08:51:34"},
			{"Heard": true, "Checked": "True", "Genre":"Jazz",	"Artist":"Andy Narell",	"Year":1992,	"Album":"Down the Road",	"Name":"Green Ballet: 2nd Position for Steel Orchestra",	"Length":"03:41",	"Track":6,	"Composer":"Vince Mendoza",	"Download Date":"1921/3/29",	"Last Played":"13:38:26"},
			{"Heard": true, "Checked": "True", "Genre":"Jazz",	"Artist":"Bill Evans",	"Year":1962,	"Album":"Interplay",	"Name":"I'll Never Smile Again (Take 7)",	"Length":"06:33",	"Track":3,	"Composer":"Ruth Lowe",	"Download Date":"2019/4/14",	"Last Played":"16:21:34"},
			{"Heard": true, "Checked": "True", "Genre":"Blues",	"Artist":"Buddy Guy",	"Year":1993,	"Album":"Feels Like Rain",	"Name":"I Go Crazy",	"Length":"02:26",	"Track":2,	"Composer":"James Brown",	"Download Date":"1973/1/5",	"Last Played":"18:45:00"},
			{"Heard": true, "Checked": "True", "Genre":"Jazz",	"Artist":"Bill Evans",	"Year":1978,	"Album":"Affinity",	"Name":"The Other Side of Midnight (Noelle's Theme)",	"Length":"03:23",	"Track":7,	"Composer":"Michel Legrand",	"Download Date":"1938/6/17",	"Last Played":"10:04:41"},
			{"Heard": true, "Checked": "True", "Genre":"Classic Rock",	"Artist":"Jimi Hendrix",	"Year":1968,	"Album":"Electric Ladyland",	"Name":"...And the Gods Made Love",	"Length":"01:23",	"Track":1,	"Composer":"Jimi Hendrix",	"Download Date":"2015/2/12",	"Last Played":"00:39:23"},
			{"Heard": true, "Checked": "True", "Genre":"Pop and R&B",	"Artist":"Joni Mitchell",	"Year":2000,	"Album":"Both Sides Now",	"Name":"At Last",	"Length":"04:28",	"Track":2,	"Composer":"Mack Gordon/Harry Warren",	"Download Date":"1933/3/16",	"Last Played":"21:00:00"},
			{"Heard": true, "Checked": "True", "Genre":"Easy Listening",	"Artist":"Bette Midler",	"Year":1993,	"Album":"Experience the Divine",	"Name":"Miss Ottis Regrets",	"Length":"02:40",	"Track":8,	"Composer":"Cole Porter",	"Download Date":"2012/10/6",	"Last Played":"04:10:19"},
			{"Heard": true, "Checked": "True", "Genre":"Blues",	"Artist":"Buddy Guy",	"Year":1993,	"Album":"Feels Like Rain",	"Name":"Change in the Weather",	"Length":"04:38",	"Track":7,	"Composer":"John Fogerty",	"Download Date":"1917/9/28",	"Last Played":"09:42:11"},
			{"Heard": true, "Checked": "True", "Genre":"Easy Listening",	"Artist":"Bette Midler",	"Year":2003,	"Album":"Bette Midler Sings the Rosemary Clooney Songbook",	"Name":"This Ole House",	"Length":"03:03",	"Track":2,	"Composer":"Hamblen, Stuart 1908-1989",	"Download Date":"1946/8/23",	"Last Played":"06:30:56"},
			{"Heard": true, "Checked": "True", "Genre":"Progressive Rock",	"Artist":"Dixie dregs",	"Year":1977,	"Album":"Free Fall",	"Name":"Holiday",	"Length":"04:29",	"Track":2,	"Composer":"Steven J. Morse",	"Download Date":"2035/8/13",	"Last Played":"17:17:49"},
			{"Heard": true, "Checked": "True", "Genre":"Rock",	"Artist":"Blood, Sweat & Tears",	"Year":1969,	"Album":"Blood, Sweat & Tears",	"Name":"Smiling Phases",	"Length":"05:11",	"Track":2,	"Composer":"Jim Capaldi, Steve Winwood, Chris Wood",	"Download Date":"1993/6/13",	"Last Played":"03:28:08"},
			{"Heard": true, "Checked": "True", "Genre":"Jazz",	"Artist":"Andy Narell",	"Year":1992,	"Album":"Down the Road",	"Name":"Disorderly Conduct",	"Length":"06:40",	"Track":4,	"Composer":"Andy Narell",	"Download Date":"1996/8/31",	"Last Played":"03:39:23"},
			{"Heard": true, "Checked": "True", "Genre":"Classic Rock",	"Artist":"Jimi Hendrix",	"Year":1993,	"Album":"Are You Experienced",	"Name":"Purple Haze",	"Length":"02:53",	"Track":1,	"Composer":"Jimi Hendrix",	"Download Date":"2004/5/23",	"Last Played":"22:49:41"},
			{"Heard": true, "Checked": "True", "Genre":"Jazz",	"Artist":"Andy Narell",	"Year":1992,	"Album":"Down the Road",	"Name":"Green Ballet: 1st Position for Steel Orchestra",	"Length":"02:16",	"Track":5,	"Composer":"Vince Mendoza",	"Download Date":"1959/10/10",	"Last Played":"10:21:34"},
			{"Heard": true, "Checked": "True", "Genre":"Rock",	"Artist":"Blood, Sweat & Tears",	"Year":1968,	"Album":"Child Is Father To The Man",	"Name":"Just One Smile",	"Length":"04:38",	"Track":6,	"Composer":"",	"Download Date":"1997/6/25",	"Last Played":"20:57:11"},
			{"Heard": true, "Checked": "True", "Genre":"Rock",	"Artist":"Blood, Sweat & Tears",	"Year":1969,	"Album":"Blood, Sweat & Tears",	"Name":"More And More",	"Length":"03:04",	"Track":4,	"Composer":"Don Juan, Pea Vee",	"Download Date":"1901/5/3",	"Last Played":"10:27:11"},
			{"Heard": true, "Checked": "True", "Genre":"Classic Rock",	"Artist":"Jimi Hendrix",	"Year":1968,	"Album":"Electric Ladyland",	"Name":"Have You Ever Been (To Electric Ladyland)",	"Length":"02:10",	"Track":2,	"Composer":"Jimi Hendrix",	"Download Date":"1926/6/26",	"Last Played":"16:52:30"},
			{"Heard": true, "Checked": "True", "Genre":"Rock",	"Artist":"Blood, Sweat & Tears",	"Year":1968,	"Album":"Child Is Father To The Man",	"Name":"I Love You More Than You'll Ever Know",	"Length":"05:57",	"Track":2,	"Composer":"",	"Download Date":"1977/6/30",	"Last Played":"08:00:56"},
			{"Heard": true, "Checked": "True", "Genre":"Blues",	"Artist":"B.B. King",	"Year":1997,	"Album":"Deuces Wild",	"Name":"Rock Me Baby",	"Length":"06:38",	"Track":3,	"Composer":"B.B. King/Joe Josea",	"Download Date":"1997/12/14",	"Last Played":"01:13:08"},
			{"Heard": true, "Checked": "True", "Genre":"Blues",	"Artist":"Buddy Guy",	"Year":1993,	"Album":"Feels Like Rain",	"Name":"Sufferin' Mind",	"Length":"03:33",	"Track":6,	"Composer":"E. Jones",	"Download Date":"2016/4/6",	"Last Played":"18:28:08"},
			{"Heard": true, "Checked": "True", "Genre":"Pop and R&B",	"Artist":"Joni Mitchell",	"Year":2000,	"Album":"Both Sides Now",	"Name":"You're My Thrill",	"Length":"03:52",	"Track":1,	"Composer":"Jay Gorney/Sindney Clare",	"Download Date":"1906/9/20",	"Last Played":"21:16:53"},
			{"Heard": true, "Checked": "True", "Genre":"Easy Listening",	"Artist":"Bette Midler",	"Year":1993,	"Album":"Experience the Divine",	"Name":"Chapel Of Love",	"Length":"02:54",	"Track":4,	"Composer":"Ellie Greenwich/Jeff Barry/Phil Spector",	"Download Date":"1914/5/21",	"Last Played":"22:55:19"},
			{"Heard": true, "Checked": "True", "Genre":"Blues",	"Artist":"B.B. King",	"Year":2005,	"Album":"80",	"Name":"Hummingbird",	"Length":"04:42",	"Track":6,	"Composer":"",	"Download Date":"1913/1/27",	"Last Played":"13:49:41"},
			{"Heard": true, "Checked": "True", "Genre":"Progressive Rock",	"Artist":"Emerson, Lake & Palmer",	"Year":1996,	"Album":"Brain Salad Surgery [Rhino]",	"Name":"Jerusalem",	"Length":"02:44",	"Track":1,	"Composer":"Charles Hubert Hastings Parry/William Blake",	"Download Date":"2006/3/2",	"Last Played":"18:28:08"},
			{"Heard": true, "Checked": "True", "Genre":"Progressive Rock",	"Artist":"Emerson, Lake & Palmer",	"Year":"",	"Album":"The Atlantic Years",	"Name":"Fanfare For The Common Man",	"Length":"05:41",	"Track":9,	"Composer":"",	"Download Date":"2023/7/1",	"Last Played":"23:00:56"},
			{"Heard": true, "Checked": "True", "Genre":"Jazz",	"Artist":"Bill Evans",	"Year":1962,	"Album":"Interplay",	"Name":"Wrap Your Troubles In Dreams (And Dream Your Troubles Away)",	"Length":"06:21",	"Track":7,	"Composer":"Billy Moll/Harry Barris/Ted Koehler",	"Download Date":"1921/12/8",	"Last Played":"16:55:19"},
			{"Heard": true, "Checked": "True", "Genre":"Classical",	"Artist":"Andres Segovia",	"Year":2004,	"Album":"The Best Of Andres Segovia",	"Name":"Bouree (Suite In E Minor, BWV 996 - Bach)",	"Length":"01:32",	"Track":2,	"Composer":"Johann Sebastian Bach (1685-1750)",	"Download Date":"1976/5/5",	"Last Played":"15:42:11"},
			{"Heard": true, "Checked": "True", "Genre":"Rock",	"Artist":"Dave Matthews",	"Year":1996,	"Album":"Crash",	"Name":"Crash Into Me",	"Length":"05:18",	"Track":3,	"Composer":"Dave Matthews",	"Download Date":"1912/10/25",	"Last Played":"07:01:53"},
			{"Heard": true, "Checked": "True", "Genre":"Easy Listening",	"Artist":"Frank Sinatra",	"Year":1990,	"Album":"The Capitol Years [Disc 1]",	"Name":"Someone To Watch Over Me",	"Length":"02:57",	"Track":12,	"Composer":"George & Ira Gershwin/George Gershwin",	"Download Date":"1909/8/12",	"Last Played":"03:16:53"},
			{"Heard": true, "Checked": "True", "Genre":"Rock",	"Artist":"Dave Matthews",	"Year":1998,	"Album":"Before These Crowded Streets",	"Name":"The Last Stop",	"Length":"06:58",	"Track":3,	"Composer":"Lessard, Stefan/Beauford, Carter",	"Download Date":"1979/5/27",	"Last Played":"21:22:30"},
			{"Heard": true, "Checked": "True", "Genre":"Classic Rock",	"Artist":"Jimi Hendrix",	"Year":1968,	"Album":"Electric Ladyland",	"Name":"Crosstown Traffic",	"Length":"02:26",	"Track":3,	"Composer":"Jimi Hendrix",	"Download Date":"1989/6/5",	"Last Played":"04:24:23"},
			{"Heard": true, "Checked": "True", "Genre":"Jazz",	"Artist":"Bill Evans",	"Year":1978,	"Album":"Affinity",	"Name":"I Do It For Your Love",	"Length":"07:23",	"Track":1,	"Composer":"Paul Simon",	"Download Date":"1949/6/29",	"Last Played":"01:24:23"},
			{"Heard": true, "Checked": "True", "Genre":"World",	"Artist":"Andy Statman & David Grisman",	"Year":1995,	"Album":"Songs Of Our Fathers",	"Name":"Dovid Melech Yisrael",	"Length":"02:07",	"Track":6,	"Composer":"Shlomo Carlebach",	"Download Date":"2001/12/27",	"Last Played":"10:46:53"},
			{"Heard": true, "Checked": "True", "Genre":"Progressive Rock",	"Artist":"Dixie dregs",	"Year":1977,	"Album":"Free Fall",	"Name":"Dig the Ditch",	"Length":"03:51",	"Track":9,	"Composer":"Steven J. Morse",	"Download Date":"1994/10/6",	"Last Played":"18:00:00"},
			{"Heard": true, "Checked": "True", "Genre":"Rock",	"Artist":"Dave Matthews",	"Year":1996,	"Album":"Crash",	"Name":"Too Much",	"Length":"04:24",	"Track":4,	"Composer":"Dave Matthews",	"Download Date":"1926/1/4",	"Last Played":"00:02:49"},
			{"Heard": true, "Checked": "True", "Genre":"Classic Rock",	"Artist":"Black Sabbath",	"Year":2004,	"Album":"Master of Reality",	"Name":"Into the Void",	"Length":"06:12",	"Track":8,	"Composer":"Bill Ward/Geezer Butler/Ozzy Osbourne/Tony Iommi",	"Download Date":"1938/7/16",	"Last Played":"00:56:15"},
			{"Heard": true, "Checked": "True", "Genre":"Easy Listening",	"Artist":"Bette Midler",	"Year":1993,	"Album":"Experience the Divine",	"Name":"From A Distance",	"Length":"04:39",	"Track":3,	"Composer":"Julie Gold",	"Download Date":"2029/2/25",	"Last Played":"21:14:04"},
			{"Heard": true, "Checked": "True", "Genre":"Classical",	"Artist":"Julian Bream",	"Year":1957,	"Album":"Fret Works: Dowland & Villa-Lobos",	"Name":"Lachrimae Antiquae Galliard",	"Length":"02:59",	"Track":2,	"Composer":"John Dowland",	"Download Date":"1978/10/15",	"Last Played":"11:54:23"},
			{"Heard": true, "Checked": "True", "Genre":"Rock",	"Artist":"Dave Matthews",	"Year":1996,	"Album":"Crash",	"Name":"Let You Down",	"Length":"04:09",	"Track":8,	"Composer":"Dave Matthews",	"Download Date":"1906/1/5",	"Last Played":"20:20:38"},
			{"Heard": true, "Checked": "True", "Genre":"Jazz",	"Artist":"Bill Evans",	"Year":1958,	"Album":"Everybody Digs Bill Evans",	"Name":"Night and Day",	"Length":"07:35",	"Track":4,	"Composer":"Cole Porter",	"Download Date":"1953/5/20",	"Last Played":"10:24:23"},
			{"Heard": true, "Checked": "True", "Genre":"Classic Rock",	"Artist":"Black Sabbath",	"Year":2004,	"Album":"Black Sabbath",	"Name":"Black Sabbath",	"Length":"06:18",	"Track":1,	"Composer":"Bill Ward/Geezer Butler/Ozzy Osbourne/Tony Iommi",	"Download Date":"1908/7/24",	"Last Played":"16:38:26"},
			{"Heard": true, "Checked": "True", "Genre":"Blues",	"Artist":"Buddy Guy",	"Year":1993,	"Album":"Feels Like Rain",	"Name":"She's Nineteen Years Old",	"Length":"05:43",	"Track":4,	"Composer":"Muddy Waters",	"Download Date":"1971/2/24",	"Last Played":"01:01:53"},
			{"Heard": true, "Checked": "True", "Genre":"Jazz",	"Artist":"Bill Evans",	"Year":1978,	"Album":"Affinity",	"Name":"The Days of Wine and Roses",	"Length":"06:43",	"Track":4,	"Composer":"Henry Mancini, Johnny Mercer",	"Download Date":"1955/2/12",	"Last Played":"01:49:41"},
			{"Heard": true, "Checked": "True", "Genre":"Progressive Rock",	"Artist":"Emerson, Lake & Palmer",	"Year":"",	"Album":"The Atlantic Years",	"Name":"The Endless Enigma (Part 1)",	"Length":"06:41",	"Track":7,	"Composer":"",	"Download Date":"1961/12/22",	"Last Played":"23:40:19"},
			{"Heard": true, "Checked": "True", "Genre":"Easy Listening",	"Artist":"Frank Sinatra",	"Year":1991,	"Album":"Sinatra Reprise: The Very Good Years",	"Name":"It Was A Very Good Year",	"Length":"04:29",	"Track":9,	"Composer":"E. Drake",	"Download Date":"1943/9/1",	"Last Played":"15:59:04"},
			{"Heard": true, "Checked": "True", "Genre":"Pop and R&B",	"Artist":"Joni Mitchell",	"Year":1974,	"Album":"Court And Spark",	"Name":"Help Me",	"Length":"03:22",	"Track":2,	"Composer":"Joni Mitchell",	"Download Date":"2013/12/5",	"Last Played":"09:59:04"},
			{"Heard": true, "Checked": "True", "Genre":"Classical",	"Artist":"Julian Bream",	"Year":1965,	"Album":"Julian Bream Edition, Vol. 20",	"Name":"Bach: Lute Suite In A Minor, BWV 997 - Praeludium",	"Length":"03:06",	"Track":7,	"Composer":"Johann Sebastian Bach",	"Download Date":"2032/12/26",	"Last Played":"07:49:41"},
			{"Heard": true, "Checked": "True", "Genre":"Jazz",	"Artist":"Bill Evans",	"Year":1962,	"Album":"Interplay",	"Name":"You And The Night And The Music",	"Length":"07:05",	"Track":1,	"Composer":"Arthur Schwartz/Howard Dietz",	"Download Date":"2032/12/25",	"Last Played":"07:30:00"},
			{"Heard": false, "Checked": "False", "Genre":"Classical",	"Artist":"Julian Bream",	"Year":1965,	"Album":"Julian Bream Edition, Vol. 20",	"Name":"Bach: Lute Suite In E Minor, BWV 996 - Sarabande",	"Length":"04:45",	"Track":4,	"Composer":"Johann Sebastian Bach",	"Download Date":"2017/1/6",	"Last Played":"05:54:23"},
			{"Heard": true, "Checked": "True", "Genre":"Jazz",	"Artist":"Charlie Hunter",	"Year":2004,	"Album":"Friends Seen and Unseen",	"Name":"One for the Kelpers",	"Length":"06:31",	"Track":1,	"Composer":"John Ellis",	"Download Date":"1988/6/13",	"Last Played":"09:22:30"},
			{"Heard": true, "Checked": "True", "Genre":"Easy Listening",	"Artist":"Bette Midler",	"Year":2003,	"Album":"Bette Midler Sings the Rosemary Clooney Songbook",	"Name":"You'll Never Know",	"Length":"01:44",	"Track":1,	"Composer":"Warren, Harry 1893-1981 -w Gordon, Mac 1904-1959",	"Download Date":"1923/10/17",	"Last Played":"14:09:23"},
			{"Heard": true, "Checked": "True", "Genre":"Progressive Rock",	"Artist":"Emerson, Lake & Palmer",	"Year":1992,	"Album":"The Atlantic Years",	"Name":"Tank",	"Length":"06:47",	"Track":4,	"Composer":"Carl Palmer/Keith Emerson",	"Download Date":"1996/11/14",	"Last Played":"00:36:34"},
			{"Heard": true, "Checked": "True", "Genre":"Classic Rock",	"Artist":"Jimi Hendrix",	"Year":1968,	"Album":"Electric Ladyland",	"Name":"Come On, Pt. 1",	"Length":"04:10",	"Track":7,	"Composer":"Earl King",	"Download Date":"2008/3/1",	"Last Played":"14:48:45"},
			{"Heard": true, "Checked": "True", "Genre":"World",	"Artist":"Andy Statman & David Grisman",	"Year":1995,	"Album":"Songs Of Our Fathers",	"Name":"Der Rebbe",	"Length":"03:59",	"Track":9,	"Composer":"Trad.",	"Download Date":"2021/5/21",	"Last Played":"11:45:56"},
			{"Heard": true, "Checked": "True", "Genre":"Blues",	"Artist":"B.B. King",	"Year":2005,	"Album":"80",	"Name":"Early in the Morning",	"Length":"04:50",	"Track":1,	"Composer":"",	"Download Date":"2020/1/13",	"Last Played":"08:23:26"},
			{"Heard": true, "Checked": "True", "Genre":"Classical",	"Artist":"Julian Bream",	"Year":1992,	"Album":"Nocturnal",	"Name":"Martin: Quatre Pièces Breves - 3. Plainte: Sans Lenteur",	"Length":"02:59",	"Track":3,	"Composer":"Frank Martin",	"Download Date":"1986/5/4",	"Last Played":"20:54:23"},
			{"Heard": true, "Checked": "True", "Genre":"Jazz",	"Artist":"Bill Evans",	"Year":1958,	"Album":"Everybody Digs Bill Evans",	"Name":"What Is There to Say?",	"Length":"04:54",	"Track":8,	"Composer":"Duke",	"Download Date":"1900/8/15",	"Last Played":"04:01:53"},
			{"Heard": true, "Checked": "True", "Genre":"Jazz",	"Artist":"Andy Narell",	"Year":1989,	"Album":"Little Secrets",	"Name":"Don't Look Back",	"Length":"09:39",	"Track":6,	"Composer":"Andy Narell",	"Download Date":"1907/3/5",	"Last Played":"23:29:04"},
			{"Heard": true, "Checked": "True", "Genre":"Progressive Rock",	"Artist":"Dixie dregs",	"Year":1978,	"Album":"What if",	"Name":"What if",	"Length":"05:02",	"Track":3,	"Composer":"Steve Morse",	"Download Date":"1992/3/28",	"Last Played":"00:22:30"}
		];

		var i, len;
		for(i=0, len = data_list.length; i < len; ++i){
			data.items.push(dojo.mixin({'id': i + 1 }, data_list[i % len]));
		}

		function exportAll(){
			dijit.byId("grid").exportGrid("csv", function(str){
				dojo.byId("output").value = str;
			});
		};
		function exportSelected(){
			var str = dijit.byId("grid").exportSelected("csv");
			dojo.byId("output").value = str;
		};
		
		dojo.addOnLoad(function(){

			var store = new dojo.data.ItemFileWriteStore({data: data});
			
			var layout = [
				{ field: "id"},
				{ field: "Genre"},
				{ field: "Artist"},
				{ field: "Album"},
				{ field: "Name"},
				{ field: "Track"},
				{ field: "Download Date"},
				{ field: "Last Played"}
			];
			
			var grid = new dojox.grid.EnhancedGrid({
				id: 'grid',
				store: store,
				structure: layout,
				plugins: {
					exporter: true
				}
			});
			grid.placeAt('gridContainer');
			grid.startup();
		});
	</script>

  .. html::

	<div id="gridContainer"></div>
	<button onclick="exportAll()">Export all to CSV</button>
	<button onclick="exportSelected()">Export Selected Rows to CSV</button>
	<br />
	<textarea id="output"></textarea>

  .. css::

    <style type="text/css">
    @import "{{ baseUrl }}dojo/resources/dojo.css";
    @import "{{ baseUrl }}dijit/themes/{{ theme }}/{{ theme }}.css";
    @import "{{ baseUrl }}dijit/themes/{{ theme }}/document.css";
    @import "{{ baseUrl }}dojox/grid/enhanced/resources/{{ theme }}/EnhancedGrid.css";
    @import "{{ baseUrl }}dojox/grid/enhanced/resources/EnhancedGrid_rtl.css";
	
	#output{
		width: 100%;
		height: 150px;
	}
	#gridContainer{
		width: 100%; 
		height: 250px;
	}
    </style>


=============
Configuration
=============

Prerequisites
-------------

This exporter plugin is only available for EnhancedGrid. So require the EnhancedGrid first:

.. code-block :: javascript
  :linenos:
  
  dojo.require("dojox.grid.EnhancedGrid");

Unlike other grid plugins, you don't need to ``require`` this plugins directly. Instead, you should ``require`` the specific implementations (i.e. writers). For example, if a CSV format implementation is available, then:

.. code-block :: javascript
  :linenos:
  
  dojo.require("dojox.grid.enhanced.plugins.exporter.CSVWriter");

This statement will automatically require "dojox.grid.enhanced.plugins.Exporter".

Plugin Declaration
------------------

The declaration name of this plugin is ``exporter`` . It is declared in the ``plugins`` property of grid.

If your grid is created declaratively:

.. code-block :: html
  :linenos:

  <div id="grid" dojoType="dojox.grid.EnhancedGrid" 
    store="mystore" structure="mystructure" 
    plugins="{
      exporter: true
  }" ></div>

If your grid is created in JavaScript:

.. code-block :: javascript
  :linenos:

  var grid = new dojox.grid.EnhancedGrid({
    id:"grid",
    store:"mystore",
    structure:"mystructure",
    plugins:{
      exporter: true
    }
  });

This plugin does not have any arguments.

=====
Usage
=====

When this plugin is enabled, the following 2 methods are available for a grid widget:

exportGrid(type, args, onExported):
	Export required rows(args.fetchArgs) to a kind of format(type), using the corresponding writer with given arguments(args.writerArgs), then pass the exported text to a given function(onExported).

==============  ==================  ==========================  ===========================================================
Arguments       Type                Optional/Mandatory          Description
==============  ==================  ==========================  ===========================================================
type            String              Mandatory                   A registered export format name.
args            Object              Optional(default to {})     An argument to define fetchArgs and writerArgs like:
                                                                { fetchArgs: {...}, writerArgs: {...} }
                                                                fetchArgs is some arguments for store.fetch.
                                                                writerArgs is some arguments for the current wirter.
onExported      function(string)    Mandatory                   Call back function when export result is ready.
==============  ==================  ==========================  ===========================================================

exportSelected(type, writerArgs):
	Export only the selected rows of a grid to the specified format. Returns the exported string.

==============  ==================  ==========================  =======================================
Arguments       Type                Optional/Mandatory          Description
==============  ==================  ==========================  =======================================
type            String              Mandatory                   A registered export format name.
writerArgs      Object              Optional(default to {})     Some arguments for the current wirter.
==============  ==================  ==========================  =======================================

For example:

.. code-block :: javascript
  :linenos:
  
  //Export the whole grid to CSV format, with separator of ":".
  grid.exportGrid("csv", {writerArgs: {separator:":"}}, function(str){
    // do something interesting with str
  });
  //Export the first 10 rows to CSV format.
  grid.exportGrid("csv", {fetchArgs: {start: 0, count: 10}}, function(str){
    // do something interesting with str
  });
  //Only export the selected rows to CSV format.
  var str = grid.exportSelected("csv", {separator:":"});

===================================================
Create Export Writer -- A Framework for Grid Export
===================================================

To create your own exporter, you should use this export framework by extending an abstract class: _ExportWriter.

_ExportWriter – The Base Class
------------------------------

This is an abstract class for all of the writers used in the Exporter plugin. It applies the strategy pattern to break the export work into several stages, and provides interfaces for all of them. Implementations might choose to override some of the functions in this class thus providing their own functionality. The Exporter will go through the grid row by row. In every row, all the Views will be reached and the header row is only handled once. The APIs exposed by this class to implementors is shown below. You can implement them by extending "dojox.grid.enhanced.plugins.exporter._ExportWriter".

beforeHeader(grid):
	We are going to start moving through the grid. Is there anything we should do now?

=========  ========================  ==============================================================
Arguments  Type                      Description
=========  ========================  ==============================================================
grid       dojox.grid.EnhancedGrid   The grid widget.
[return]   Boolean                   true: go on handling the header row and then call afterHeader.
                                     false: skip the header row, won't call afterHeader.
=========  ========================  ==============================================================

afterHeader():
	The header has been handled.

beforeContent(items):
	We are ready to go through all the contents(items).
	
=========  ========================  ==============================================================
Arguments  Type                      Description
=========  ========================  ==============================================================
items      Array                     All the items fetched from the store.
[return]   Boolean                   true: go on handling the contents and then call afterContent.
                                     false: skip all the contents, won't call afterContent.
=========  ========================  ==============================================================

afterContent():
	We have finished the entire grid travel. Do some clean up work if you need to.
	
beforeContentRow(argObj):
	Before handling a line of data (not a header).

=========  ========================  =========================================================================
Arguments  Type                      Description
=========  ========================  =========================================================================
argObj     Object                    An object with at least the following context properties available:
                                     { grid, isHeader, row,rowIdx, spCols }
[return]   Boolean                   true: go on handling the current data row and then call afterContentRow.
                                     false: skip the current data row, won't call afterContentRow.
=========  ========================  =========================================================================

afterContentRow(argObj):
	After handling a line of data (not header).

=========  ========================  =========================================================================
Arguments  Type                      Description
=========  ========================  =========================================================================
argObj     Object                    An object with at least the following context properties available:
                                     { grid, isHeader, row,rowIdx, spCols }
=========  ========================  =========================================================================

beforeView(argObj):
	Before handling a view.

=========  ========================  =========================================================================
Arguments  Type                      Description
=========  ========================  =========================================================================
argObj     Object                    An object with at least the following context properties available:
                                     { grid, isHeader, row, rowIdx, spCols }
[return]   Boolean                   true: go on handling the current view and then call afterView.
                                     false: skip the current view, won't call afterView.
=========  ========================  =========================================================================

afterView(argObj):
	After handling a view.

=========  ========================  =========================================================================
Arguments  Type                      Description
=========  ========================  =========================================================================
argObj     Object                    An object with at least the following context properties available:
                                      { grid, isHeader, row, rowIdx, spCols }
=========  ========================  =========================================================================

beforeSubrow(argObj):
	Before handling a subrow (defined in the grid structure as "rows").

=========  ========================  =========================================================================
argObj     Object                    An object with at least the following context properties available:
                                     { grid, isHeader, row, rowIdx, view, viewIdx, subrow, subrowIdx, spCols }
[return]   Boolean                   true: go on handling the current subrow and then call afterSubrow.
                                     false: skip the current subrow, won't call afterSubrow.
=========  ========================  =========================================================================

afterSubrow(argObj):
	After handling a subrow (defined in the grid structure as "rows").

=========  ========================  =========================================================================
Arguments  Type                      Description
=========  ========================  =========================================================================
argObj     Object                    An object with at least the following context properties available:
                                     { grid, isHeader, row, rowIdx, view, viewIdx, subrow, subrowIdx, spCols }
=========  ========================  =========================================================================

handleCell(argObj):
	Handle a header cell or data cell.

=========  ========================  =========================================================================
Arguments  Type                      Description
=========  ========================  =========================================================================
argObj     Object                    An object with at least the following context properties available:
                                     { grid, isHeader, row, rowIdx, view, viewIdx, subrow,subrowIdx, 
                                     cell, cellIdx, spCols, colOffset }
=========  ========================  =========================================================================

toString():
	Export to a string.
	
=========  ========================  ===========================
Arguments  Type                      Description
=========  ========================  ===========================
[return]   String                    The exported result string.
=========  ========================  ===========================

The argument ``argObj`` represents the context of each function when they are called and may have the following properties:

===========  ========================  ===========================  ==========================================================================================================================
Name         Data Type                 When Available               Description
===========  ========================  ===========================  ==========================================================================================================================
grid         dojox.grid.EnhancedGrid   Always                       The grid widget we are now handling.
isHeader     Boolean                   Always                       Indicating which context we're handling, header or content.
view         dojox.grid._View          beforeView                   Reference to the current _View object.
                                       afterView
                                       beforeSubrow
                                       afterSubrow
                                       handleCell
viewIdx      Integer                   beforeView                   The index of the current _View object in the views array.
                                       afterView                    If the grid does not have any rowselector view, it conforms to the index in the _ViewManager.views.
                                       beforeSubrow
                                       afterSubrow
                                       handleCell
row          data item                 beforeContentRow             The current row of data (logically), a.k.a.: current item.
                                       afterContentRow
                                       beforeSubrow
                                       afterSubrow
                                       handleCell
rowIdx       Integer                   beforeContentRow             The index of the current row (item).
                                       afterContentRow
                                       beforeSubrow
                                       afterSubrow
                                       handleCell
subrow       dojox.grid.cells._base[]  beforeSubrow                 Reference to the current subrow.
                                       afterSubrow                  A subrow describe the innter structure of a row in a view, it's an array of cells
                                       handleCell
subrowIdx    Integer                   beforeSubrow                 The index of the current subrow in the subrow array: _View.structure.cells.
                                       afterSubrow
                                       handleCell
cell         dojox.grid.cells._base    handleCell                   Reference to the current cell.
cellIdx      Integer                   handleCell                   The index of the current cell in the current subrow.
                                                                    It's different from cell.index, which is the index in the whole line.
spCols       Integer[]                 beforeContentRow             The header line has been handled. An array of special column indexes(flat,not regarding structure).
                                       afterContentRow              Special columns are typically attached to grid as a kind of UI facility by the grid widget, instead of some real data.
                                       beforeView                   For example: indirect selectors and row indexers.
                                       afterView                    Users can choose to export it or not.
                                       beforeSubrow
                                       afterSubrow
                                       handleCell
colOffset    Integer                   handleCell                   If the grid has a _RowSelector view or something else, this view will NOT be passed to the user in argObj. 
                                                                    So the column index (cell.index) will appear shifted (start from 1 instead of 0). 
                                                                    This colOffset is provided to remove this shift.
===========  ========================  ===========================  ==========================================================================================================================

Register Your Own Writer
------------------------

Once you have implemented your own export writer, tell the framework about the name of your format. For the "CSV" case, you should write the following line in your implementation file:

.. code-block :: javascript
  :linenos:
  
  dojox.grid.enhanced.plugins.Exporter.registerWriter("csv", "dojox.grid.enhanced.plugins.exporter.CSVWriter");

Available Export Writers
------------------------

The following writers are currently available in the dojox/grid/enhanced/plugins/exporter package: 

===============  ==============  =====================
Writer Class     Format Name     Writer Argument
===============  ==============  =====================
CSVWriter        "csv"           "separator"
TableWriter      "table"         HTML table attributes
===============  ==============  =====================

Example
-------

Here is the structure of the implementation file of the CSVWriter, demonstrating how to write an export writer. It only implements 3 interfaces. 

.. code-block :: javascript
  :linenos:

  //First delcare your class.
  dojo.provide("dojox.grid.enhanced.plugins.exporter.CSVWriter");

  //Require the base class.
  dojo.require("dojox.grid.enhanced.plugins.exporter._ExportWriter");

  //Register the CSV format name.
  dojox.grid.enhanced.plugins.Exporter.registerWriter("csv",
    "dojox.grid.enhanced.plugins.exporter.CSVWriter");

  //Extend from the base class.
  dojo.declare("dojox.grid.enhanced.plugins.exporter.CSVWriter",
  dojox.grid.enhanced.plugins.exporter._ExportWriter,{
    //Separator is the only argument.
    _separator: ',',

    constructor: function(/* object? */writerArgs){
      //Handle arguments (separator in this case), and do some initialization here.
    },

    _formatCSVCell: function(/* string */cellValue){
      //Format cell value to follow CSV standard.
      //See: http://en.wikipedia.org/wiki/Comma-separated_values
    },

    beforeContentRow: function(/* object */argObj){
      //Overrided from _ExportWriter
      //For each column,
      //	get the cell data of the current row, and format them with _formatCSVCell
      //Join these cell data together with the separater.
      //Save the result.
      //return false, because we don't need to go into the row. Thus improves the performance.
    },

    handleCell: function(/* object */arg_obj){
      // summary:
      //		Overrided from _ExportWriter
      //Check if arg_obj.isHeader is true. We have already handled content cells in the above function, 
      //here we only need to deal with the header cells.
      //You can get the header name by arg_obj.cell.name.
    },

    toString: function(){
      //Overrided from _ExportWriter
      //Join all the saved result together and return.
    }
  });

========
See Also
========

* `dojox.grid.DataGrid <dojox/grid/DataGrid>`_ - The base grid
* `dojox.grid.EnhancedGrid <dojox/grid/EnhancedGrid>`_ - The enhanced grid supporting plugins
* `dojox.grid.EnhancedGrid.plugins <dojox/grid/EnhancedGrid/plugins>`_ - Overview of the plugins of enhanced grid
* `dojox.grid.TreeGrid <dojox/grid/TreeGrid>`_ - Grid with collapsable rows and model-based (`dijit.tree.ForestStoreModel <dijit/tree/ForestStoreModel>`_) structure
