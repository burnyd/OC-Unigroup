#!/usr/bin/python
from binding import openconfig_bgp
import json

oc_bgp = openconfig_bgp()
oc_bgp.bgp.global_.config.as_ = 10

oc_bgp.bgp.neighbors.neighbor.add("10.0.0.100")
oc_bgp.bgp.neighbors.neighbor["10.0.0.100"].config.peer_as = 1


print json.dumps(oc_bgp.get(filter=True), indent=4)
