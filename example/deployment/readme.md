# Docker Compose Setup for Loki and JaegerLe

This README provides a step-by-step guide to running Loki and JaegerLe using Docker Compose. The configuration ensures that logs from specified Kubernetes pods are aggregated and sent to Loki for analysis.

## Prerequisites

Ensure you have the following installed on your system:
- Docker
- Docker Compose

## File Descriptions

### `docker-compose.yaml`
This file defines the services Loki and JaegerLe:

- **Loki**: A horizontally scalable, highly available, multi-tenant log aggregation system.
- **JaegerLe**: A custom logging exporter that pushes logs from specific Kubernetes pods to Loki.

### `loki-config.yaml`
This is the configuration file for Loki, which sets up the server, storage, and other key components.

### `jaegerle-config.yaml`
This is the configuration file for JaegerLe, specifying the pods to monitor and log file paths to follow.

## Setup and Configuration

1. **Clone the repository** or copy the files to your local environment.

2. **Ensure the configuration files are correctly placed**:
    - `loki-config.yaml` should be in the same directory as `docker-compose.yaml`.
    - `jaegerle-config.yaml` should be available at `/var/jaegerle-config.yaml` on your host machine.

3. **Edit `jaegerle-config.yaml`** to include the correct IP address and pod details if necessary. Example:
    ```yaml
    loki:
      url: "http://<LOKI_HOST_IP>:3100"

    ssh:
      remoteHost: "<REMOTE_HOST_IP>"
      remotePort: "22"
      remoteUser: "asad"
      remotePassword: "Password"

    pods:
      - namespace: "nsp-psa-restricted"
        podName: "nspos-app2-tomcat"
        podNameWildCard: true
        containerName: "nspos-app2-tomcat"
        logFilePath: "tail -f /opt/nsp/os/app2-tomcat/logs/restconf.log"
      # Add more pods as needed
    ```

## Running the Docker Compose

1. **Start the services** by navigating to the directory containing `docker-compose.yaml` and running:
    ```bash
    docker compose up -d
    ```
    This will start both the Loki and JaegerLe containers in detached mode.

2. **Verify that the containers are running**:
    ```bash
    docker ps
    ```
    You should see both `loki` and `jaegerLe` containers up and running.

## Accessing and Monitoring Logs

1. **Access the JaegerLe container**:
    ```bash
    docker exec -it jaegerLe bash
    ```

2. **Check the logs** to ensure that logs are being forwarded to Loki correctly:
    ```bash
    tail -f /opt/jaegerLe/logs/jaegerLe.log
    ```

    Example output:
    ```text
    time=2024-08-26T09:28:20Z level=warning msg=Could not extract timestamp from log line:  at java.net.AbstractPlainSocketImpl.connectToAddress(AbstractPlainSocketImpl.java:206)
    time=2024-08-26T09:28:20Z level=info msg=Loki accepted the log with no content returned (204 No Content).
    ```

3. **Check Loki's status** to ensure it is receiving logs correctly.

## Stopping the Services

To stop the running containers, execute:
```bash
docker compose down
