#!/bin/bash -ex

#Color print
function echocolor {
    echo "$(tput setaf 3)##### $1 #####$(tput sgr0)"
}


# Ham sua file cau hinh cua OpenStack
function ops_edit {
    crudini --set $1 $2 $3 $4
}

# How to use
## Syntax:		ops_edit_file $path [SECTION] [PARAMETER] [VALUAE]
## Example:
###			filekeystone=/etc/keystone/keystone.conf
###			ops_edit_file $filekeystone DEFAULT rpc_backend rabbit


#Delete a variable
function ops_del {
    crudini --del $1 $2 $3
}
