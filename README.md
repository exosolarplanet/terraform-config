# Terraform Configuration for BornIn Application

This repository maintains the GCP infrastructure configration through utilising Github Actions and Terraform Cloud. 

```mermaid
mindmap
    root((BornIn))
        App Engine
        Cloud SQL
            Instance
                Database
        VPC Network
            Private IP Address
            Private VPC Connection
            VPC Access Connector

```

# Architecture Diagram

![Diagram](docs/diagram.png)

## Monitoring, Logging and Tracing
Google App Engine has various built-in tools for visualising and analysing the metrics of your application.

### Network Traffic Monitoring
You can monitor the traffic of you application and responses
![Logging](docs/monitoring.png)

### Billing Monitoring
Keeping a close eye on billing is easy with the built-in billing status information on App Engine dashboard
![Billing](docs/billing.png)

### Tracing
You can trace the load on your URIs 
![Tracing](docs/tracing.png)

### Logging
Even see the errors that your application has encountered the most and trace them back to the application logs
![AppErrors](docs/app_errors.png)

## Security
Enabling web securty scans on your URIs allows you scan them for vulnerabilities by testing them with many user inputs and event handlers
![Scanning](docs/scanning.png)

> The Cloud SQL instance has a private IP and resides in a private VPC network

## Scalability 
With App Engine it's easy to scale applications up and down, making it a great option for high-demand & no-downtime applications. When a new App Engine deployment is made, 
![Scalability](docs/scalability.png)
app engine warm up inbound services
rollback - migrate traffic

## Further Improvements
access to app engine endpoints - should be secured with IAP

