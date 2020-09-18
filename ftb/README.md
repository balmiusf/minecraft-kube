# Minecraft Feed the Beast Server

**This Minecraft Feed the Beast Server uses itzg docker image (https://github.com/itzg/docker-minecraft-server)**
Tested on Minikube and Google Kubernetes Engine using FTB Interactions Modpack (https://www.curseforge.com/minecraft/modpacks/ftb-interactions)

To use a different modpack you just need to change: 
- **FTB_MODPACK_ID** environmental variable with the modpack id you want and you might need to change.
- **FTB_MODPACK_VERSION_ID** if you need a specific modpack version else latest will be used.

## How to run on Minikube
This is assuming you have minikube installed. 
Steps:
 - Clone this repository and change kubernetes context to **minikube**.
 - kubectl apply -f ftb.service.yml (using NodePort)
 - kubectl apply -f ftb.stateful.yml

Open the minikube dashboard (run command **minikube dashboard**) and check on the deployments. 
Check the logs to see the progress and to find out when the server is operational. 
When its in the green run **minikube service minecraft-ftb-headless --url** and from the output you will find the address to access your server. 
Open your Minecraft client and paste that address in the address bar and enjoy!

**Note:** Make sure Minikube has enough resources to run the server.

## How to run on Google Kubernetes Engine
This is assuming you have a Google Cloud account setup. (You can get 300$ in credits for 3 months if you are setting up for the first time, https://cloud.google.com/free,  sadly Always Free will not be sufficient for this but the 300$ in credits are very useful)

For this I recommend a node with at least 1 vCPU and around 4gb of RAM (even though minecraft servers might not benefit from multiple vCPU remember that Kubernetes still requires resources in order to run so using the bare minimum might not be ideal. I used a **n1-standard-2** machine (https://cloud.google.com/compute/docs/machine-types)
Steps:
 - Clone this repository 
 - gcloud container clusters get-credentials <cluster_id> --zone=<zone_id>
 - If context is not switched automatically then switch it
 - kubectl apply -f ftb.service.yml (using NodePort)
 - kubectl apply -f ftb.stateful.yml
 - Create a firewall rule to allow traffic to go through the node port.
 
 Open your GKE dashboard and check how the deployments are going. 
 Check the logs to see the progress and to find out when the server is operational. 
Your server address will be **<external_node_ip>:<node_port>**. You can find the **external_node_ip** by checking the **VM instances** in the **Google Compute Engine** (GCE) dashboard.
Open your Minecraft client and paste that address in the address bar and enjoy!
