graph TD;
 subgraph "Azure Kubernetes Service (AKS)"
 AKS_dev[Dev AKS]
 AKS_stage[Staging AKS]
 AKS_prod[Production AKS]
 end

 subgraph "Azure Functions"
 Function1[Azure Function 1]
 Function2[Azure Function 2]
 end

 subgraph "Azure API Management"
 API[API Management]
 end

 subgraph "Azure App Service"
 AppService_dev[Dev Web App]
 AppService_stage[Staging Web App]
 AppService_prod[Prod Web App]
 end

 subgraph "Azure SignalR Service"
 SignalR_dev[Dev SignalR Service]
 SignalR_stage[Staging SignalR Service]
 SignalR_prod[Prod SignalR Service]
 end

 subgraph "Azure Front Door"
 FrontDoor[Front Door]
 end

 subgraph "Azure Cosmos DB"
 CosmosDB[Cosmos DB]
 end

 subgraph "Azure DevOps and CI/CD Pipeline"
 GitHub[GitHub]
 CI[CI Pipeline]
 CD_dev[Dev CD Pipeline]
 CD_stage[Stage CD Pipeline]
 CD_prod[Prod CD Pipeline]
 ACR[Azure Container Registry]
 Terraform[Terraform - IaC]
 Monitor[Azure Monitor]
 end

 GitHub -->|Trigger| CI
 CI -->|Build & Test| ACR
 ACR -->|Pull Image| CD_dev
 ACR -->|Pull Image| CD_stage
 ACR -->|Pull Image| CD_prod
 CD_dev -->|Deploy| AKS_dev
 CD_stage -->|Deploy| AKS_stage
 CD_prod -->|Deploy| AKS_prod
 Terraform -->|Provision Infrastructure| AKS_dev
 Terraform -->|Provision Infrastructure| AKS_stage
 Terraform -->|Provision Infrastructure| AKS_prod
 AKS_prod -->|Monitor| Monitor
 Monitor -->|Logging & Metrics| AppService_prod

 % Connect Dev, Stage, and Prod services to respective SignalR and Front Door
 AppService_dev --> SignalR_dev
 AppService_stage --> SignalR_stage
 AppService_prod --> SignalR_prod
 SignalR_dev --> FrontDoor
 SignalR_stage --> FrontDoor
 SignalR_prod --> FrontDoor

 % Connect Functions to API Management
 Function1 --> API
 Function2 --> API

 % Connection from CosmosDB to Functions, indicative of data flow or triggers
 CosmosDB -.-> Function1
 CosmosDB -.-> Function2

 % Development, Staging, and Production labels for differentiation
 subgraph "Development Environment"
 AKS_dev
 AppService_dev
 SignalR_dev
 end

 subgraph "Staging Environment"
 AKS_stage
 AppService_stage
 SignalR_stage
 end

 subgraph "Production Environment"
 AKS_prod
 AppService_prod
 SignalR_prod
 FrontDoor
 end
