# Kubernetes-Ark

Kubernetes configuration & Docker images to manage an Ark : Survival Evolved server.

## Usage

The most common way to run Ark is using a single statefull set with a service attached.

This statefullset request at least 1 cpu core & 4 Gb ram free for running, you can customize this in the stefullset yaml files if needed.


### Quick simple setup for testing (no persistence) exposed with nodeport

    $ kubectl apply -f  https://raw.githubusercontent.com/cyrilbkr/k8s-ark/develop/namespace.yaml
    $ kubectl apply -f  https://raw.githubusercontent.com/cyrilbkr/k8s-ark/develop/service.yaml
    $ kubectl apply -f  https://raw.githubusercontent.com/cyrilbkr/k8s-ark/develop/statefullset.yaml
    
### GCP/GKE Production setup


### AWS/EKS Production setup


### Other setup configurations setup

Alternative configurations are available in the k8s_alternative_config directoty.

#### Deployment in hostport with hostdir

## Env Variables


| Variables | Description | Default value  |
| ------------- | ------------- | ------------- |
| SESSIONNAME | Name of your ark server | k8s-ark |
| SERVERMAP | Map of your ark server | TheIsland |
| NBPLAYERS | Number of player | 10 |
| SERVERPASSWORD | Password of your ark server |  |
| ADMINPASSWORD | Admin password of your ark server | admin |
| SERVERPORT | Ark server port |  27015 |
| STEAMPORT | Steam server port | 7778 |


## Ports

Ports need to be mapped as environment variables

| Port | Description |
| ------------- |:-------------:| 
| Ark Udp | 27015 |
| Steam Udp | 7778 |
| Rcon Tcp | 32330 |

## Volumes

* /ark

Disk space depend of the map, but ususally you need between 10 GB and 30 GB to be safe. This do not include mods if you hack this configuration.



## Customize Ark server parameter


## Commands

Check server status : 

    kubectl exec -n ark pod_name arkmanager status

Force save :

    kubectl exec -n ark pod_name arkmanager saveworld

Force update : 

    kubectl exec -n ark pod_name arkmanager update --force

Force backup : 

    kubectl exec -n ark pod_name arkmanager backup

Execute Rcon command : 

    kubectl exec -n ark pod_name arkmanager rconcmd ListPlayers



