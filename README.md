# WayDevOps - Simple TODO Web Application on AWS

[![GitHub license](https://img.shields.io/github/license/ricardobf/waydevops)](https://github.com/ricardobf/waydevops/blob/production/LICENSE)
[![GitHub issues](https://img.shields.io/github/issues/ricardobf/waydevops)](https://github.com/ricardobf/waydevops/issues)
[![GitHub stars](https://img.shields.io/github/stars/ricardobf/waydevops)](https://github.com/ricardobf/waydevops/stargazers)

This repository uses Terraform and GitHub Actions to deploy a simple TODO application to AWS.
The backend was performed in Python 3.8 and FastAPI, can be deployed using docker (local),
docker-compose (local) or via Terraform (/infra folder) and GitHub Actions (image deploy) to AWS ECS. 
The frontend was developed using React and can be deployed to AWS S3 (static website) via Terraform 
(bucket configuration) and GitHub Actions (deploy build to bucket).

An example of the application is running on [ricardobf.me](http://ricardobf.me)

An example of the API is running on [api.ricardobf.me](http://api.ricardobf.me)

**Table of Contents**

1. [Requirements](#requirements)
1. [Installation](#installation)
1. [License](#license)

## Requirements

- Python 3.8; (for local installation)
- Docker; (for local installation)
- Docker Compose; (for local installation)
- nodejs, npm; (for local installation)
- Terraform;
- AWS account with administrator previleges.

## Installation

### Install and run only the `backend` module locally:

Using Docker Compose:

1. Navigate to backend folder:
```shell
# cd backend
```

2. Run `docker-compose` command:
```shell
# docker-compose up
```

3. On your browser navigate to [localhost](http://localhost)

### Install and run only the `frontend` module locally:

1. Navigate to frontend folder:
```shell
# cd frontend/react-to-do
```

2. Change the API addresses on file `TodosContainer.js` to "localhost":
```shell
# nano frontend/react-to-do/src/components/TodosContainer.js
```

3. Install
```shell
# npm install
```

4. Run
```shell
# npm run
```

5. On your browser navigate to [localhost:3000](http://localhost:3000)


### Install and run all modules on AWS with Terraform:

1. Navigate to infra folder:
```shell
# cd infra
```

2. Change the `terraform.tfvars` to best fit your configuration schema:
```shell
# nano terraform.tfvars
```

3. Initialize Terraform:
```shell
# terraform init
```

4. Run Terraform plan to verify changes:
```shell
# terraform plan
```

5. Apply all configuration to AWS:
```shell
# terraform apply
```

6. Navigate to your hosted zone on browser: [example.com](http://example.com)



## License

See [LICENSE](https://github.com/ricardobf/waydevops/LICENSE).