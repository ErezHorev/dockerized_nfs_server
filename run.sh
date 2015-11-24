#!/bin/bash
set -e

export_base="/exports/"

### Handle `docker stop` for graceful shutdown
function shutdown {
    echo "Shutting down nfs-server.."
    service nfs-kernel-server stop

    echo "Bye.."
    exit 0
}

trap "shutdown" SIGTERM
####

echo "Running nfs server.."
echo "Export points:"
echo "$export_base *(rw,sync,insecure,fsid=0,no_subtree_check,no_root_squash)" >> /etc/exports

read -a exports <<< "${@}"
for export in "${exports[@]}"; do
    src=`echo "$export" | sed 's/^\///'` # trim the first '/' if given in export path
    src="$export_base$src"
    mkdir -p $src
    chmod 777 $src
    echo "$src *(rw,sync,insecure,no_subtree_check,no_root_squash)" | tee -a /etc/exports
done

rpcbind
service nfs-kernel-server start

## Run until signaled to stop...
sleep infinity
