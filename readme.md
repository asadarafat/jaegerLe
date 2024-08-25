JaegerLe Little Jaeger
JaegerLe Little Jaeger is a lightweight tool designed to tail log files and send the log data directly to Loki, enabling seamless integration with Grafana for log monitoring and analysis.

Features
- Log Tailing: Continuously monitors and tails specified log files.
- Loki Integration: Sends tailed logs directly to a Loki instance.
- Grafana Ready: Logs sent to Loki can be easily visualized and analyzed in Grafana.
- Flexible Configuration: Supports YAML-based configuration for specifying log file paths, Loki endpoint, and more.
- CLI Tool: Command-line interface for easy operation and configuration management.

Usage
Prerequisites
- A running instance of Loki to receive log data.
- Optionally, a Grafana setup configured with Loki as a data source for log visualization.



Configuration
JaegerLe Little Jaeger uses a YAML configuration file to specify the log files to be tailed and the Loki server details. Below is an example configuration:

yaml
Copy code
loki:
  url: "http://localhost:3100"

ssh:
  remoteHost: "your-remote-host"
  remotePort: "22"
  remoteUser: "username"
  remotePassword: "password"

pods:
  - namespace: "your-namespace"
    podName: "your-pod-name"
    podNameWildCard: true
    containerName: "your-container-name"
    logFilePath: "/path/to/your/logfile.log"
Running the Tool
Use the following command to run JaegerLe Little Jaeger, specifying the path to your configuration file:

bash
Copy code
./jaegerLe --config /path/to/your/config.yaml
Example
To tail logs from a remote server and send them to Loki:

Update the configuration file with your server and log details.
Run the tool:
bash
Copy code
./jaegerLe --config ./config.yaml
Contributing
Contributions are welcome! Please fork the repository and submit a pull request.

License
This project is licensed under the MIT License.

