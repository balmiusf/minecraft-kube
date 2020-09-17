#!/bin/bash
 
# update eula 
echo "eula=$EULA" >> eula.txt

exec "$@"