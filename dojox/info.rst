## page was renamed from 1.2/dojox
#format dojo_rst

dojox
=====

:Status: Contributed, Draft
:Version: 1.0

DojoX is an area for development of extensions to the Dojo toolkit.  It acts as an incubator for new ideas, a testbed for experimental additions to the main toolkit, as well as a repository for more stable and mature extensions.  Unlike Dojo and Dijit, DojoX is managed by subprojects, each of which has at least one module, a sponsor and a mission statement.  [Release cycle policy TBD]  The subprojects may have dependencies on Dojo and Dijit code or other subprojects in DojoX.  Some subprojects may choose to keep their dependencies on Dojo minimal, perhaps only depending on Dojo Base, and remain largely toolkit agnostic.  Other DojoX sub-projects directly extend Dojo or Dijit components, like the `Flickr data store </dojox/data/FlickrRestStore>`_ and `dojox.Color </dojox/color>`_.  

Some caveats of using DojoX:
----------------------------

* The condition and level of support of DojoX code will vary, from **experimental** through **production**.  DojoX subprojects may disappear entirely if unsuccessful or abandoned.
* Unlike Dojo and Dijit, DojoX modules are **not** guaranteed to be fully accessible or internationalized<
* DojoX subprojects may be moved to Dijit or Dojo Core, subject to project lead approval, the needs of the toolkit and the capacity of those teams to absorb additional code.
* Fully mature, production level code will typically remain in DojoX.
* Not all modules in DojoX will be documented, since they are lower priority than Base and Core.  

Browse the <a href="http://api.dojotoolkit.org/jsdoc/dojox/HEAD/dojox">API documentation</a> and <a href="http://svn.dojotoolkit.org/src/dojox/trunk/">repository</a> directly for a more complete list.

A DojoX subproject's status can be found within the README file within the top directory of the subproject.  README files are mandatory, and status changes must be approved by the DojoX BDFL.  These are the possible states for a DojoX subproject:

* **experimental**. A subproject which may be new or a proof of concept.  It is somewhat functional but may also be highly unstable and subject to change or removal without notice.
* **alpha**.  A subproject in alpha status shows a higher level of commitment than experimental, but is still subject to change without notice.  Unit tests are required, but may not all run successfully.
* **beta**.  A subproject in beta status is considered somewhat stable.  API changes may occur as needed, but will be documented at release.  For a subproject to be considered for beta, <strong>unit tests</strong> must all pass and full inline documentation is required.
* **production**.  A production level subproject follows the same conventions as Dojo Core and Dijit: a major release cycle and deprecation cycle is required for all incompatible API changes.  i18n and a11y compliance are desirable, but not required, and will be documented in the README.  An entry in the Dojo Documentation is **required**.
