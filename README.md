# CICD-Project
This repository is used to store code to launch my portfolio website using AWS infrastructure 

a

#my-directory
inside CICD-Project
|-- .github
|   `-- workflows
|       `-- main.yml          # GitHub Actions workflow definition
|-- infrastructure
        |--terraform 
            |-- .terraform.lock.hcl
|       |-- main.tf           # Terraform configuration for AWS infrastructure
|       |-- variables.tf      # Terraform variable definitions
|       `-- outputs.tf        # Terraform output definitions
|-- src                       # Source code for your application
|-- tests                     # Tests for your application
|-- Dockerfile                # Dockerfile to build your application container
|-- sonar-project.properties  # Configuration for SonarQube analysis
`-- README.md                 # Documentation of your project
