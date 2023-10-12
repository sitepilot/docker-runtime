#!/bin/bash

echo "
-------------------------------------
Runtime Info
-------------------------------------
User:       ${RUNTIME_USER} (uid: $(id -u $RUNTIME_USER))
Group:      ${RUNTIME_GROUP} (gid: $(id -g $RUNTIME_GROUP))
Workdir:    ${RUNTIME_WORKDIR}
-------------------------------------
"
