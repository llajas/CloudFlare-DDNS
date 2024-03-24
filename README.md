# DDNS Updater

The DDNS Updater is a tool designed to automatically update a single DNS record on Cloudflare. The included Helm Chart runs the script as a kubernetes cronjob, leveraging cloudflare's API to update DNS records based on the current external IP of your Kubernetes cluster.

## Features

- Automatically updates a single DNS record on Cloudflare
- Configurable update interval (Default 15 minutes)
- Securely manages Cloudflare API keys and account details
- Lightweight Docker image based on Ruby Alpine

## Prerequisites

- Kubernetes cluster
- Helm 3
- Docker
- Access to Cloudflare account with API key

## Getting Started

### Building the Docker Image

1. Clone the repository:

```bash
git clone <repository-url>
cd ddns-updater
```

2. Build the Docker Image:

```bash
docker build -t <your-docker-username>/ddns:latest .
```

3. Push the Docker image to your registry:

```bash
docker push <your-docker-username>/ddns:latest
```

## Deploying with Helm

1. Navigate to the Helm chart directory:

```bash
cd chart
```

2. Install the Helm Chart:

```bash
helm install ddns-updater . -f values.yaml
```

### Configuration

The application and Helm chart can be configured via environment variables and values.yaml, respectively.

Environment Variables

	•	CLOUDFLARE_API_KEY: Your Cloudflare API key.
	•	CLOUDFLARE_EMAIL: Email associated with your Cloudflare account.
	•	DOMAIN_NAME: The domain name to update.
	•	DNS_RECORD: The DNS record to update.

These values should be stored in a Kubernetes Secret and referenced in the values.yaml file under the env section.

values.yaml

The values.yaml file contains the following configurations:

	•	image.repository: The Docker image repository.
	•	image.tag: The Docker image tag.
	•	schedule: The schedule on which the DNS record is updated, in cron format.

Troubleshooting

	•	Ensure all environment variables are correctly set in the Kubernetes Secret.
	•	Verify the Docker image is correctly built and pushed to your Docker registry.
	•	Check the logs of the CronJob pods if there are issues with DNS updates.

Contributing

Contributions are welcome! Feel free to open issues or pull requests to improve the DDNS updater tool.
