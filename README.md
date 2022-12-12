# devops

## Docker Images

- docker pull [pattybro/devops:v0.0.1](https://hub.docker.com/r/pattybro/devops)
- docker pull [seauozcn/devops:v0.0.1](https://hub.docker.com/r/seauozcn/devops)
- docker pull [sgtmate/devops:v0.0.1](https://hub.docker.com/r/sgtmate/devops)

## Vagrant und Ansible

Das [Vagrantfile](./Vagrantfile) startet eine VM mit einer Ubuntu Box (2 Kerne, 2GB RAM), dann wird das [Ansible Playbook](./playbook.yml) ausgeführt, welches Python updatet und die App startet. Anschließend wird die App auf Port 8080 des Hosts gemappt.

Ausführen mit `vagrant init` und `vagrant up`, anschließend die App im Browser unter `http://localhost:8080` aufrufen.
## Azure Web-App

Erst Deployment erstellen, dann Web-App Erstellen. Im Deployment die folgenden Einstellungen vornehmen:
- `WEBSITES_PORT=5000`
- Image: `sgtmate/devops:v0.0.1`
Dannach Abreißen mit Instanz löschen und App Service Plan löschen.

### Terraform Deployment auf Azure

Schritte zum Deployment, der App auf Azure mit Terraform:
- Azure CLI installieren: `https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest`
- Azure CLI Login: `az login`
- Terrraform Projekt initialisieren: `terraform init`
- [main.tf](./main.tf) validieren: `terraform validate`
- App ausrollen: `terraform apply`
    - `image` -> `sgtmate/devops`, `image_tag` -> `v0.0.1`
    - `location` -> `eastus2` (vorgegeben, da Gratis-Account)
- App Deployment löschen: `terraform destroy`

## Testen

### Unit Tests
Verwendet wird [pytest](https://docs.pytest.org/en/latest/). Die Unit Tests sind in [test_unit_example.py](./tests/unit/test_unit_example.py) definiert. Diese testen die Funktionen der App. HIER FEHLT WAS!!!!

### Integration Tests
Verwendet wird [pytest](https://docs.pytest.org/en/latest/). In [test_index.py](./tests/functional/test_index.py) sind die Integration Tests definiert. Diese testen ob die Endpunkte der App funktionieren (/index, /hello).

### SonarQube

- Run on docker: `docker run -d --name sonarqube -e SONAR_ES_BOOTSTRAP_CHECKS_DISABLE=true -p 9000:9000 sonarqube:latest`
sonarqube:latest`
- Open in Webbrowser: `http://localhost:9000`
    - user: `admin`
    - pwd: `admin`

## CI/CD
Im github Repo sind die Github Actions definiert. Diese werden bei jedem Push und Pull Request auf dem Main Branch ausgeführt. Die Actions sind in [ci.yml](./.github/workflows/ci.yml) und [cd.yml](./.github/workflows/cd.yml) definiert.

### CI
Startet eine Ubuntu VM, installiert Python und führt die Unit Tests aus. Wenn die Tests erfolgreich sind, wird der Code in den Main Branch gepusht.

### CD (Azure)
Startet eine Ubuntu VM, loggt sich mit hinterlegten Credentials bei DockerHub ein baut das Docker Image und pusht es auf DockerHub. Anschließend wird das Docker Image auf Azure geholt und als Web-App deployed.

## Monitoring
Beim Deployment werden Metriken mittels Prometeus gesammelt und in Grafana visualisiert. Hierfür werden durch Docker Compose drei Container in folgender Reihenfolge gestartet:
- App
    - Port: 5000
    - Image `sgtmate/devops:v0.0.1`
- Prometeus
    - Port: 9090
    - Image `prom/prometheus`
- Grafana
    - Port: 3000
    - Image `grafana/grafana`

