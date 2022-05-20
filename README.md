# Kubernetes, Docker, Ruby

In this project, we will dockerize a ruby app and deploy it on a Kubernetes cluster with the following structure.

![struc](https://raw.githubusercontent.com/AbdEl-RahmanKhaled/Kubernetes-Docker-Ruby/master/imgs/struc.png)

# Tools Used

<p align="center">
<a href="https://www.docker.com/" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/AbdEl-RahmanKhaled/AbdEl-RahmanKhaled/main/icons/docker/docker-original-wordmark.svg" alt="docker" width="40" height="40"/> </a> <a href="https://kubernetes.io" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/AbdEl-RahmanKhaled/AbdEl-RahmanKhaled/main/icons/kubernetes/kubernetes-icon.svg" alt="kubernetes" width="40" height="40"/> </a> <a href="https://www.ruby-lang.org/en/" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/AbdEl-RahmanKhaled/AbdEl-RahmanKhaled/da14bfcb29c534da73d14178236b0650f28870df/icons/ruby/ruby-original.svg" alt="Ruby" width="40" height="40"/> </a>
</p> 


# This repository contains

* `drkiq` which is a simple ruby app
* `kubernetes` dir that contains
    * ### Deployments
        - `drkiq-deployment` with 2 replicas and `initContainer` to migrate the database
        - `sidekiq-deployment` with 2 replicas
    * ### Pods
        - `nginx-pod` configured as reverse proxy server
        - `postgres-pod` with mounted `HostPath` volume to presist the data
        - `redis-pod` with mounted `HostPath` volume to presist the data
    * ### Secrets
        - `app-sec` to store the sensitive data that used in database and the app like (`SECRET_TOKEN`, `POSTGRES_PASSWORD`)
    * ### ConfigMaps
        - `app-conf` to store the configuration values used in the app like (`POSTGRES_DB`, `LISTEN_ON`)
    * ### Services
        - `drkiq-svc` ClusterIP sevice to expose the drkiq app deployment
        - `postgres-svc` ClusterIP service to expose postgres database pod
        - `redis-svc` ClusterIP service to expose redis pod
        - `nginx-np` NodePort service to expose Nginx pod to access it from the browser at port `30020`

* `Dockerfile` that build `drkiq` docker image

* `Dockerfile` that build `Nginx` proxy server image

* `Docker-compose.yaml` file to build and run all required images

* `run.sh` simple shell script to
    - Export `Environment Variables`
    - Run `docker-compose`
    - Migrate the database

# Get Started

## Clone the project
    
```bash
get clone https://github.com/AbdEl-RahmanKhaled/Kubernetes-Docker-Ruby.git
```

## Deploy on docker

All you need to do is run
```bash
source ./run.sh
```
after finsh you can access the app from http://localhost:8020

## Deploy on kubernetes

Using [Minikube](https://minikube.sigs.k8s.io/docs/start/) cluster or any cluster and configured [kubectl](https://kubernetes.io/docs/tasks/tools/) tool you can deploy the app by run

```bash
kubectl apply -f kubernetes/config-map
```

```bash
kubectl apply -f kubernetes/secrets
```

```bash
kubectl apply -f kubernetes/deployments_pods
```

```bash
kubectl apply -f kubernetes/services
```
now, you can access the app from http://<MINIKUBE_IP>:30020

```python
# NOTE
You can get minikube ip by run `minikube ip`
```