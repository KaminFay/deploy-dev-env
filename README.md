# deploy-dev-env
A simple terraform setup to deploy a dev environment to digital ocean. 

The current setup allows the user to deploy a series of virtual machines to DigitalOcean. Currently it uses the sister repository [here](https://github.com/KaminFay/base-deploy-image-generation) to generate the original template for use here.

## What it generates:
- 3 vms:
    - 1 Loadbalancer vm that will eventually be loaded with something like HAProxy
    - 2 Application vms that will hold whatever dockerized applications you want.

## Why?

- Basically there were situations in my life where I wanted to be able to build containerized applications and test them in front of a load balanced system.

## How?
1. Complete the steps in the sister repository.
2. Move into the `applications/backend` folder
    ```bash
    cd applications/backend
    ```
3. Execute a terraform init:
    ```
    terraform init
    ```
4. Make sure you have your digital ocean api key set on an environmental variable:
    ```
    export do_token="TOKEN GOES HERE"
    ```
5. Manipulate the deployment variables as you see fit:
    ```
    vim env/dev.tfvars
    ```
6. Run a terraform apply (making sure to give it your tfvar file and you local env variable with your api key):
    ```
    terraform apply -var "do_token=${DO_PAT}" --var-file=/full/path/for/some/reason/required/env/dev.tfvars
    ```
7. Good to go to start testing the deployment out.

## Whats Next:
- Integrate a load balancer on the load balancer machine
- I started a method for moving files over to the deployed machines using optional provisioning but opted to keep it out of the inital push and will focus on it later.
- Setup a local docker registry machine perhaps to make the pushing of containers easier? Not sure