Dockerized NFS Server
================

### Table of Contents
* [Start Server](#Start-server)
* [Set your own exports](#Set-your-own-exports)
* [Stop Server](#Stop-server)
* [Troubleshoot & Debug](#Troubleshoot-&-Debug)
* [General Info](#General-Info)

### Prerequisites
[**Get docker !**](https://docs.docker.com/linux/started/)

### Note
This nfs server is not secured and using docker `privileged` flag in order to allow mount NFS filesystem and export it as docker volume (also for use by other containers).  
Originally created for testing, playground, development ..etc.

Start server
=====
Activate the server by running the script **start.sh**.  
For your convenience, it can also be sourced (e.g. `source start.sh`) which will set the environment variable `MYNFSIP` with the server's ip.  

Behind stage it will automatically pull the docker image from [_Docker hub_](https://hub.docker.com/r/erezhorev/dockerized_nfs_server/) and start the nfs server container named 'mynfs' with the default export point: `/exports`.  
(Docker internal run command: `docker run -d --name mynfs --privileged erezhorev/dockerized_nfs_server`)

Set your own exports
-----
Optional arguments are allowed and transformed to export points with the default export  (`/exports`) as their root base path.
* Legal arguments form:  
`start.sh share1 /share2 /some/share3 some/more/share4`.  

* Arguments are allowed to include preceding Slash-'/' but its just the same as without it, each given argument transforms to an active export point under `/exports`.  
example:  `share1 /share2` -> `/exports/share1 /exports/share2`

Stop server
-----
Run: **stop.sh**     (or `docker stop mynfs ; docker rm mynfs`).  
Note it also removes the server container with all its data!  
To stop and preserve data, just run `docker stop mynfs` instead.

Troubleshoot & Debug
=====
#### Server's status
Run `status.sh` as it includes the following info:  
export points, server's stdout and running processes.

#### Test mount
Run: `mount -v -t nfs -o proto=tcp,port=2049 [nfs server ip]:/exports/share1 /mnt/target_dir`

#### Get inside container's shell
Run: `docker exec -ti mynfs bash`


General Info
=====
* Based on ubuntu nfs-kernel-server.
* Current export point options are hard coded and consist of the following: ```rw,sync,insecure,no_subtree_check,no_root_squash```
* [_Docker hub reference_](https://hub.docker.com/r/erezhorev/dockerized_nfs_server/)
