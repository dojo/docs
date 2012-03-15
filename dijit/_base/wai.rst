.. _dijit/_base/wai:

===============
dijit/_base/wai
===============

*Deprecated*.

Use the following replacements instead:

=====================================================                                  ====================================
1.x syntax                                                                             2.0 syntax
=====================================================                                  ====================================
dijit.hasWaiRole(node, role)                                                           node.getAttribute("role")==role
dijit.getWaiRole(node)                                                                 node.getAttribute("role")
dijit.setWaiRole(node, role)                                                           node.setAttribute("role", role)
dijit.removeWaiRole                                                                    node.setAttribute(role, "")
dijit.hasWaiState("selected")                                                          node.hasAttribute("aria-selected")
dijit.getWaiState("describedby")                                                       node.getAttribute("aria-describedby")
dijit.setWaiState("describedby", desc)                                                 node.getAttribute("aria-describedby", desc)
dijit.removeWaiState("selected")                                                       node.removeAttribute("aria-selected")
=====================================================                                  ====================================
