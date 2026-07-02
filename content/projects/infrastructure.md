---
title: "Cloud & Virtualisation Labs"
---

![Azure](https://img.shields.io/badge/Azure-0089D6?style=flat&logo=microsoft-azure&logoColor=white) ![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=flat&logo=kubernetes&logoColor=white) ![VMware](https://img.shields.io/badge/VMware-607078?style=flat&logo=vmware&logoColor=white)

## Overview

A series of advanced infrastructure laboratories demonstrating proficiency in cloud platforms, on-premise virtualisation, and Infrastructure as Code (IaC), documented thoroughly in technical reports.

## VMware ESXi & Windows Server Domain Lab
In this on-premise simulation:
- Deployed a **VMware ESXi 8.0** hypervisor as a nested VM inside VMware Workstation Pro.
- Provisioned a **Windows Server 2022** Domain Controller.
- Configured **Active Directory Domain Services (AD DS)** with Organization Units (OUs) and users.
- Set up a **DHCP** scope and successfully joined a Windows 10 Pro client machine to the domain.
- Configured virtual switches (vSwitch0) with security policies and NIC teaming.

## Azure Cloud Infrastructure Lab
Using the Azure for Students subscription, I completed a comprehensive portfolio of cloud deployments:
- **Virtual Machines**: Deployed Ubuntu Linux VMs in Switzerland North, accessing them securely via SSH keys.
- **Virtual Networks**: Designed VNets with segmented subnets (Frontend/Backend) and Network Security Groups (NSGs).
- **Container Instances**: Deployed public-facing web apps using Azure Container Instances with custom DNS configurations.
- **Infrastructure as Code**: Authenticated and deployed Azure Storage Accounts using JSON **ARM Templates** via Deployment Stacks.
- **Kubernetes (AKS)**: Provisioned an Azure Kubernetes Service cluster, managed nodes via `kubectl`, and deployed NGINX load balancer services using YAML manifests.

## Security & Governance Measures
- Network Security Groups (NSGs) with strictly scoped inbound SSH rules.
- Implementation of Azure Policies to restrict deployment regions and enforce compliance.
- Secure Storage Account deployments (LRS, hot access tier).
