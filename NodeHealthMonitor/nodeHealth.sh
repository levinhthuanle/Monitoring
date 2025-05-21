#!/bin/bash

######################################
# Author: Le Vinh Thuan
# Date: 20/5/2025
#
# This script output the node health
#
# Version: v1
#######################################

set -x # Debug mode

echo "Print the disk space"
df -h

echo "Print the memory"
free -g

echo "Print the cpu"
nproc



