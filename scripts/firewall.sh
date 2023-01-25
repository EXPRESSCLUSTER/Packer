#!/bin/bash -eux

echo 'Disabling firewalld'
systemctl disable firewalld
systemctl stop firewalld
