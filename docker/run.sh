#!/bin/bash
set -e

export_base="/exports/"

### Handle `docker stop` for graceful shutdown
function shutdown {
    echo "- Shutting down nfs-server.."
    service nfs-kernel-server stop
    echo "- Nfs server is down"
    exit 0
}

trap "shutdown" SIGTERM
####

echo "Export points:"
#### Add Root SharePoint
echo "$export_base *(rw,sync,insecure,fsid=0,no_subtree_check,no_root_squash)" | tee /etc/exports

#### Add Folders from Docker start command and add config for folder in /etc/exports
read -a exports <<< "${@}"
for export in "${exports[@]}"; do
    src=`echo "$export" | sed 's/^\///'` # trim the first '/' if given in export path
    src="$export_base$src" #add export_base
    mkdir -p $src
    chmod 777 $src
	line="$src "
	while IFS=',' read -ra HOSTS; do
		for i in "${HOSTS[@]}"; do
			line="$line $i$NFS_CONFIG_TEMPLATE"
		done
	done <<< $NFS_CONFIG_HOSTS
    echo "$line" | tee -a /etc/exports
done

echo -e "\n- Initializing nfs server.."
rpcbind
service nfs-kernel-server start

echo "- Nfs server is up and running.."

## Run forever
sleep infinity
