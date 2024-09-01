# 🚀 AWS EKS Cluster with ArgoCD, Prometheus, and More - Terraform Project
[![LinkedIn](https://img.shields.io/badge/Connect%20with%20me%20on-LinkedIn-blue.svg)](https://www.linkedin.com/in/aman-devops/)
[![Discord](https://img.shields.io/badge/Discord-7289DA?style=for-the-badge&logo=discord&logoColor=white)](https://discord.com/invite/jdzF8kTtw2)
[![Medium](https://img.shields.io/badge/Medium-12100E?style=for-the-badge&logo=medium&logoColor=white)](https://medium.com/@amanpathakdevops)
[![GitHub](https://img.shields.io/github/stars/AmanPathak-DevOps.svg?style=social)](https://github.com/AmanPathak-DevOps)
[![Serverless](https://img.shields.io/badge/Serverless-%E2%9A%A1%EF%B8%8F-blueviolet)](https://www.serverless.com)
[![AWS](https://img.shields.io/badge/AWS-%F0%9F%9B%A1-orange)](https://aws.amazon.com)
[![Terraform](https://img.shields.io/badge/Terraform-%E2%9C%A8-lightgrey)](https://www.terraform.io)

Welcome to the Terraform project repository for setting up a fully functional, private AWS EKS cluster integrated with essential tools like ArgoCD, Prometheus, and Grafana. This repository provides everything you need to deploy and manage a secure and scalable Kubernetes environment on AWS.

## 🌟 Overview

This project automates the provisioning of a private EKS cluster on AWS, along with the deployment of key Kubernetes management and monitoring tools using Terraform and Helm. The infrastructure is designed to be robust, allowing you to easily manage, scale, and monitor your Kubernetes resources.

### Key Features:
- **Private EKS Cluster**: A secure EKS setup running within a private VPC.
- **Infrastructure as Code**: Automated deployment using Terraform, ensuring repeatability and scalability.
- **Helm Integration**: Deployment of ArgoCD, Prometheus, and Grafana using Helm charts.
- **Modular Design**: The project is structured into reusable modules for easier management and customization.

### Architecture Diagram
![Architecture Diagram](./assets/architecture-diagram.gif)

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:

- **Terraform**: Infrastructure as Code tool to automate deployment.
- **AWS CLI**: To interact with your AWS account.
- **Kubectl**: Kubernetes command-line tool.
- **Helm**: Kubernetes package manager.

### Quickstart

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-repo/eks-terraform-project.git
   cd eks-terraform-project

2. **Deploy VPC and EC2: Run the following commands to deploy the VPC and an EC2 instance**:
   ```bash
   terraform init
   terraform validate
   terraform plan -var-file=variables.tfvars
   terraform apply -auto-approve -var-file=variables.tfvars

3. **Deploy EKS Cluster and Tools: After setting up the VPC and EC2, run the following commands to deploy the EKS cluster and tools**:
   ```bash
   terraform init
   terraform validate
   terraform plan -var-file=variables.tfvars
   terraform apply -auto-approve -var-file=variables.tfvars

4. **Access Deployed Resources: Use kubectl to interact with your EKS cluster and the deployed tools (ArgoCD, Prometheus, Grafana, etc.).**

### 📖 Detailed Guide

For a complete step-by-step guide, including screenshots and detailed explanations, please refer to the [blog post](https://amanpathakdevops.medium.com/). This post covers all the necessary steps to successfully implement this project.

## Contributing
We welcome contributions! If you have ideas for enhancements or find any issues, please open a pull request or file an issue.

## License
This project is licensed under the [MIT License](LICENSE).

## Contact

If you have any questions, suggestions, or feedback, please feel free to join the [Discord Server](https://lnkd.in/dsEdxpst).