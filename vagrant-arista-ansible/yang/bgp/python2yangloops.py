#!/usr/bin/python

from binding import openconfig_bgp
import json
ocbgp = openconfig_bgp()

localas = 1
routerid = "1.1.1.1"
neighborlist = ['10.0.11.3']

ocbgp.bgp.global_.config.as_ = 1 #Configures the rw bgp - > global - > config passes in the oc-inet:as-number
ocbgp.bgp.global_.config.router_id = "1.1.1.1" #Passes in the rw bgp - > global - > config - > router-id passes in the oc-yang:dotted-quad
ocbgp.bgp.global_.graceful_restart.config.enabled = True # rw bgp - > global - > graceful-restart - > config - > enabled #Boolean either true or false.
ocbgp.bgp.global_.use_multiple_paths.config.enabled = True # rw bgp - > global - > graceful-restart - > config - > enabled #Boolean either true or false.

def create_bgp():
    for i in neighborlist:
        neighbor = {}
        neighbor = {'peer':i, 'peer_as':10, 'description':'spine', 'community':'EXTENDED' }
        return neighbor

structurejson = create_bgp()

ocbgp.bgp.neighbors.neighbor.add(str(structurejson['peer']))
ocbgp.bgp.neighbors.neighbor[(str(structurejson['peer']))].config.peer_as = (str(structurejson['peer_as']))
ocbgp.bgp.neighbors.neighbor[(str(structurejson['peer']))].config.description = (str(structurejson['description']))
ocbgp.bgp.neighbors.neighbor[(str(structurejson['peer']))].config.send_community = (str(structurejson['community']))

print json.dumps(ocbgp.get(filter=True), indent=4)
