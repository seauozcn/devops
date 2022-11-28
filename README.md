# devops

## Docker Images
- docker pull [pattybro/devops:v0.0.1](https://hub.docker.com/r/pattybro/devops)
- docker pull [seauozcn/devops:v0.0.1](https://hub.docker.com/r/seauozcn/devops)
- docker pull [sgtmate/devops:v0.0.1](https://hub.docker.com/r/sgtmate/devops)

## Azure Web-App
Erst Deployment erstellen, dann Web-App Erstellen.
- WEBSITES_PORT=5000
Dannach Abreißen mit Instanz löschen und App Service Plan löschen.

### Terraform Deployment on Azure
- Initialize Terraform project: `terraform init`
- Validate main.tf file: `terraform validate`
- Deploy App: `terraform apply`
    - `image` and `image_tag` -> use the one from your dockerhub
    - `location` -> `eastus2`
- Shutdown deployment: `terraform destroy`

## Tests
### Python Tests

### SonarQube
- Run on docker: `docker run -d --name sonarqube -e SONAR_ES_BOOTSTRAP_CHECKS_DISABLE=true -p 9000:9000
sonarqube:latest`
- Open in Webbrowser: `http://localhost:9000`
    - user: `admin`
    - pwd: `admin`
- 

