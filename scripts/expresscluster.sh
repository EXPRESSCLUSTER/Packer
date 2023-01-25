#!/bin/bash -eux

ECX_RPM='/tmp/expresscls-5.0.2-1.x86_64.rpm'
BASE_LICENSE='/tmp/base-license.key'
REPL_LICENSE='/tmp/repl-license.key'

echo 'Installing EXPRESSCLUSTER'
rpm -i $ECX_RPM

echo 'Registering licneses of EXPRESSCLUSTER'
clplcnsc -i $BASE_LICENSE $REPL_LICENSE
