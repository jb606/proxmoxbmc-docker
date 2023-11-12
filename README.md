# proxmoxbmc-docker

A docker container to run agnon/proxmoxbmc daemon (https://github.com/agnon/proxmoxbmc)


## Usage

Command Line:
```
docker run -itd --rm --name pbmc --p 10001-10128:10001-10128/udp -v $(pwd):/config ghcr.io/jb606/proxmoxbmc-docker
```

## VM Management

Run ```docker exec -it <name of container> pbmc``` to enter the pbmc shell and follow the directions on Agon's page here (https://github.com/agnon/proxmoxbmc#usage) to add virtual machines.  The example above allows for 128 VMs, feel free to adjust the port ranges as needed.