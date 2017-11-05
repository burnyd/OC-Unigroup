export PYBINDPLUGIN=`/usr/bin/env python -c \
	'import pyangbind; import os; print "%s/plugin" % os.path.dirname(pyangbind.__file__)'`

sleep 5

sudo pyang --plugindir $PYBINDPLUGIN --format pybind -p /vagrant/yang/ -o /vagrant/yang/bgp/binding.py /vagrant/yang/bgp/openconfig-bgp.yang

