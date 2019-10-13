# Kubernetes-Ark

Kubernetes configuration & Docker images to manage an Ark : Survival Evolved server.

## Features :
 - Easy install and management with Ark Server Tools
 - Rcon Linux client
 - Custom Ark server config files

## Usage

Ark is deployed via a statefull set typically with pvc for persistence.

### Quick simple deployment for testing (no persistence)

    $ kubectl apply -f  https://raw.githubusercontent.com/cyrilbkr/k8s-ark/develop/namespace.yaml
    $ kubectl apply -f  https://raw.githubusercontent.com/cyrilbkr/k8s-ark/develop/service.yaml
    $ kubectl apply -f  https://raw.githubusercontent.com/cyrilbkr/k8s-ark/develop/statefullset.yaml
    

### Specific configuration

Alternative configurations are available in the k8s_alternative_config directoty.

#### Deployment in hostport with hostdir

## Env Variables

| Variables | Description | Default value  |
| ------------- | ------------- | ------------- |
| SESSIONNAME | Name of your ark server | Ark Docker |
| SERVERMAP | Map of your ark server | TheIsland |
| SERVERPASSWORD | Password of your ark server |  |
| ADMINPASSWORD | Admin password of your ark server | admin |
| SERVERPORT | Ark server port |  27015 |
| STEAMPORT | Steam server port | 7778 |

## Ports

Ports need to be mapped as environment variables. 

| Port | Description |
| Ark Udp | 27015 |
| Ark Tcp | 27015 |
| Steam Udp | 7778 |
| Steam Tcp | 7778 |
| Rcon Tcp | 32330 |

## Volumes

Everything is store in /ark, disk space depend of the map. Please check the k8s_alternative_config folder to see example of setting up persistence depending of your cloud provider.


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


__Arkmanager command list__ [here](https://github.com/FezVrasta/ark-server-tools/blob/master/README.md)






## Docker Images

## Usage
Fast & Easy server setup :   
`docker run -d -p 7778:7778 -p 7778:7778/udp -p 27015:27015 -p 27015:27015/udp -e SESSIONNAME=myserver -e ADMINPASSWORD="mypasswordadmin" --name ark turzam/ark`

You can map the ark volume to access config files :  
`docker run -d -p 7778:7778 -p 7778:7778/udp -p 27015:27015 -p 27015:27015/udp -e SESSIONNAME=myserver -v /my/path/to/ark:/ark --name ark turzam/ark`  
Then you can edit */my/path/to/ark/arkmanager.cfg* (the values override GameUserSetting.ini) and */my/path/to/ark/[GameUserSetting.ini/Game.ini]*

You can manager your server with rcon if you map the rcon port (you can rebind the rcon port with docker):  
`docker run -d -p 7778:7778 -p 7778:7778/udp -p 27015:27015 -p 27015:27015/udp -p 32330:32330  -e SESSIONNAME=myserver --name ark turzam/ark`  

You can change server and steam port to allow multiple servers on same host:  
*(You can't just rebind the port with docker. It won't work, you need to change STEAMPORT & SERVERPORT variable)*
`docker run -d -p 7779:7779 -p 7779:7779/udp -p 27016:27016 -p 27016:27016/udp -p 32331:32330  -e SESSIONNAME=myserver2 -e SERVERPORT=27016 -e STEAMPORT=7779 --name ark2 turzam/ark`  

You can easily configure automatic update and backup.  
If you edit the file `/my/path/to/ark/crontab` you can add your crontab job.  
For example :  
`# Update the server every hours`  
`0 * * * * arkmanager update --warn --update-mods >> /ark/log/crontab.log 2>&1`    
`# Backup the server each day at 00:00  `  
`0 0 * * * arkmanager backup >> /ark/log/crontab.log 2>&1`  
*You can check [this website](http://www.unix.com/man-page/linux/5/crontab/) for more information on cron.*

To add mods, you only need to change the variable ark_GameModIds in *arkmanager.cfg* with a list of your modIds (like this  `ark_GameModIds="987654321,1234568"`). If UPDATEONSTART is enable, just restart your docker or use `docker exec ark arkmanager update --update-mods`.

---

### Recommended Usage
- First run  
 `docker run -it -p 7778:7778 -p 7778:7778/udp -p 27015:27015 -p 27015:27015/udp -p 32330:32330 -e SESSIONNAME=myserver -e ADMINPASSWORD="mypasswordadmin" -e AUTOUPDATE=120 -e AUTOBACKUP=60 -e WARNMINUTE=30 -v /my/path/to/ark:/ark --name ark turzam/ark`  
- Wait for ark to be downloaded installed and launched, then Ctrl+C to stop the server.
- Edit */my/path/to/ark/GameUserSetting.ini and Game.ini*
- Edit */my/path/to/ark/arkserver.cfg* to add mods and configure warning time.
- Add auto update every day and autobackup by editing */my/path/to/ark/crontab* with this lines :  
`0 0 * * * arkmanager update --warn --update-mods >> /ark/log/crontab.log 2>&1`  
`0 0 * * * arkmanager backup >> /ark/log/crontab.log 2>&1`  
- `docker start ark`
- Check your server with :  
 `docker exec ark arkmanager status` 

--- 
