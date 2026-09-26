---
title: "Cloud & Virtualisation Labs"
description: "Enterprise-grade hybrid infrastructure deployment projects across Microsoft Azure and VMware ESXi."
date: 2026-05-30
tags: ["Azure", "VMware", "Kubernetes", "AKS", "Active Directory", "IaC", "DevOps"]
featureimage: "./feature.png"
---

**Skills Demonstrated:** Microsoft Azure (VM, VNet, Subnet Segmentation, NSG, Storage Accounts, ACI, AKS), Infrastructure as Code (ARM Templates & Deployment Stacks), Kubernetes (kubectl, Load Balancers), VMware ESXi 8.0, Virtual Switching (vSwitch & Port Groups), Windows Server 2022, Active Directory Domain Services (AD DS, DNS, Identity Management).

---

## 📋 Executive Summary (Management & Recruiter Overview)

<div style="background:#0d1117; border:1px solid #30363d; border-radius:10px; padding:20px; margin-bottom:24px;">
  <div style="display:grid; grid-template-columns:repeat(auto-fit, minmax(240px, 1fr)); gap:16px;">
    <div>
      <h4 style="color:#58a6ff; margin:0 0 8px 0; font-size:15px;">🎯 Business Challenge (The Problem)</h4>
      <p style="margin:0; font-size:14px; line-height:1.5; color:#c9d1d9;">
        Modern corporate enterprises rely on hybrid cloud models. How to architect, isolate, and interconnect scalable public cloud resources (Microsoft Azure & Kubernetes) seamlessly with secure on-premises virtualized datacenters (VMware ESXi & Active Directory)?
      </p>
    </div>
    <div>
      <h4 style="color:#3fb950; margin:0 0 8px 0; font-size:15px;">👤 My Role & Engineering Ownership</h4>
      <p style="margin:0; font-size:14px; line-height:1.5; color:#c9d1d9;">
        End-to-end infrastructure design and provisioning: cloud network architecture (VNets, NSGs, subnet tiers), Infrastructure as Code (declarative ARM Templates & Deployment Stacks), AKS container orchestration, bare-metal ESXi hypervisor virtualization, and central Active Directory identity management.
      </p>
    </div>
    <div>
      <h4 style="color:#a855f7; margin:0 0 8px 0; font-size:15px;">📈 Business Impact & Measurable Outcome</h4>
      <p style="margin:0; font-size:14px; line-height:1.5; color:#c9d1d9;">
        An enterprise-standard hybrid architecture with 100% reproducible IaC cloud deployments, strict network boundary defense (least-privilege firewall rules), and centralized enterprise directory governance.
      </p>
    </div>
  </div>
</div>

---

## 🏛️ Introduction & Architecture Context

During my **Applied Computer Science** degree at **Odisee University of Applied Sciences Brussels**, I designed and deployed a comprehensive suite of enterprise infrastructure projects. These labs simulate a realistic **hybrid enterprise architecture**, structured around two complementary pillars:

1. **Public Cloud Infrastructure (Microsoft Azure):**
   - Designed a secure, segmented cloud network featuring isolated frontend and backend subnets with strict Network Security Groups (NSGs).
   - Deployed cloud-native container workloads via Azure Container Instances (ACI) and a managed **Azure Kubernetes Service (AKS)** cluster.
   - Fully automated through **Infrastructure as Code (IaC)** using custom JSON ARM Templates and reusable Azure Deployment Stacks.

2. **Private Datacenter Virtualisation (VMware ESXi & Active Directory):**
   - Implemented a bare-metal hypervisor environment using **VMware ESXi 8.0** on VMFS6 datastores.
   - Network virtualisation with VMware vSwitches, dedicated VM Network port groups, and static subnets.
   - Full configuration of a **Windows Server 2022 Domain Controller** with **Active Directory Domain Services (AD DS)**, DNS zones, and centralized identity and access management.

{{< mermaid >}}
graph LR
    subgraph AzureCloud ["Public Cloud Environment (Microsoft Azure)"]
        VNet["Azure VNet (Switzerland North)<br>10.0.0.0/16"]
        Subnet1["Frontend Subnet + NSG<br>Web Tier / ACI"]
        Subnet2["Backend Subnet + NSG<br>Linux VM (FreeVM01)"]
        AKS["AKS Kubernetes Cluster<br>(aksdemo + NGINX Load Balancer)"]
        Storage["Storage Account (sebianstor)<br>Blob Container (media)"]
        IaC["IaC Deployment Stacks<br>(Custom ARM JSON Templates)"]

        VNet --> Subnet1
        VNet --> Subnet2
        VNet --> AKS
        IaC -.-> Storage
    end

    subgraph VMwareDC ["Private Virtualized Datacenter (VMware ESXi 8.0)"]
        vSwitch["vSwitch0 Network Topology<br>192.168.50.0/24"]
        DC["Windows Server 2022 (sebi2026-EXA-DC)<br>Primary Domain Controller (AD DS / DNS)"]
        WKS["Attached Client VM<br>(sebi2026-WKS-EX)"]
        Datastore["VMFS6 Datastore (200 GB SSD)"]

        vSwitch --> DC
        vSwitch --> WKS
        Datastore -.-> DC
        Datastore -.-> WKS
    end

    style VNet fill:#0078d4,stroke:#005a9e,color:#fff
    style AKS fill:#326ce5,stroke:#1d4ed8,color:#fff
    style vSwitch fill:#1e3a8a,stroke:#3b82f6,color:#fff
    style DC fill:#047857,stroke:#065f46,color:#fff
{{< /mermaid >}}

---

## ☁️ Part 1: Microsoft Azure Cloud Labs

> **Academic Project** — Odisee University of Applied Sciences Brussels, Applied Informatics (Cloud Infrastructure)

In this lab, a complete Azure cloud environment was provisioned following the principles of *least privilege* and *network segmentation*.

---

### 1. Virtual Machine (FreeVM01) with Secure SSH Access
Deployment of an Ubuntu Linux VM in Azure datacenter *Switzerland North*. Access is strictly secured via asymmetric SSH key pairs (no password authentication on public ports).

![Azure VM – SSH connection](/images/azure_lab_8.png)

---

### 2. Virtual Network (VNet) — Frontend & Backend Segmentation
Design of a virtual network with segregated **Frontend** and **Backend** subnets. Traffic flow between subnets and from the public internet is filtered via custom-tailored **Network Security Groups (NSGs)**.

![Azure VNet](/images/azure_lab_9.png)

---

### 3. Azure Container Instance (ACI) — webappcontainer
Serverless container deployment using Azure Container Instances. The container runs the `aci-helloworld` image in *Switzerland North* with dynamic FQDN assignment and automated lifecycle monitoring.

![Azure Container Instance](/images/azure_lab_13.png)

---

### 4. Storage Account & Blob Containers
Provisioning of an Azure Storage Account (`sebianstor`) with a private blob container (`media`) for centralized cloud asset storage.

![Azure Storage Account — ARM Deployment Stack](/images/azure_lab_25.png)

---

### 5. Infrastructure as Code (IaC) — ARM Templates & Deployment Stacks
Fully automated deployment of Azure resources via Infrastructure as Code. The entire topology is declared in JSON **ARM Templates** and rolled out through **Azure Deployment Stacks** for idempotent, reproducible, and version-controlled infrastructure management.

![Azure ARM Deployment](/images/azure_lab_31.png)

---

### 6. Azure Kubernetes Service (AKS) Cluster — aksdemo
Provisioning and administration of a managed Kubernetes cluster (`aksdemo`) in *Switzerland North*. Managed via `kubectl` with automated provisioning of worker node pools and an NGINX web server exposed as an external load-balanced service endpoint.

![AKS Cluster creation – Node pools](/images/azure_lab_30.png)

---

## 🖥️ Part 2: VMware ESXi 8.0 & Active Directory Datacenter Lab

> **Academic Project** — Odisee University of Applied Sciences Brussels, Applied Informatics (Networks & Virtualisation)

In this lab, a locally virtualized datacenter was built from the hypervisor layer up to centralized domain identity and access administration.

---

### 1. Nested VMware ESXi 8.0 Hypervisor
Installation and configuration of a nested VMware ESXi 8.0 hypervisor inside VMware Workstation Pro. The host is configured with static IP addressing (`192.168.50.20`) and a local 200 GB VMFS6 datastore for high-performance VM storage.

![ESXi – Datastore creation (200 GB VMFS6)](/images/vmware_lab_19.jpeg)

---

### 2. Virtual Switch (vSwitch0) & Port Group Topology
Configuration of virtual switch `vSwitch0` with the *VM Network* port group. Server and workstation VMs (`sebi2026-SRV-EX` and `sebi2026-WKS-EX`) are connected within an isolated internal subnet with static IP allocations.

![ESXi – vSwitch topology (sebi2026-SRV-EX, sebi2026-WKS-EX)](/images/vmware_lab_22.png)

---

### 3. Windows Server 2022 — Static IP & Network Setup
Installation of Windows Server 2022 Datacenter Edition as a dedicated server VM (`192.168.50.10`) with static DNS and gateway assignment in preparation for Domain Controller promotion.

![Windows Server – Static IP 192.168.50.10](/images/vmware_lab_10.png)

---

### 4. Active Directory Domain Services (AD DS) — Domain se26-DC-ESX.EXA
Promotion of Windows Server to Primary Domain Controller within the enterprise domain `se26-DC-ESX.EXA`. Provisioned Active Directory Domain Services (AD DS), integrated DNS forward/reverse lookup zones, and created administrative accounts (`AdminUser@se26-DC-ESX.EXA`).

![AD DS – Create AdminUser@se26-DC-ESX.EXA](/images/vmware_lab_30.png)

---

### 5. Domain & Hostname Conventions (sebi2026-EXA-DC)
Standardized renaming and synchronization of the domain controller host name to `sebi2026-EXA-DC` conforming to enterprise naming conventions, including verification of Kerberos and DNS SRV resource records.

![Windows Server rename to sebi2026-EXA-DC](/images/vmware_lab_26.png)

---

## 🎯 Learning Outcomes & Professional Relevance

This combined lab demonstrates the capability to independently design, deploy, and maintain scalable, secure, and reproducible systems across both **public cloud environments (Azure/Kubernetes)** and **on-premise datacenter infrastructure (VMware/Windows Server)**:
- **Cloud-Native & IaC:** Hands-on experience with ARM Templates, Kubernetes (AKS), and container orchestration.
- **Enterprise Identity & Access:** Comprehensive knowledge of Active Directory Domain Services, DNS, and user management.
- **Network Architecture:** Practical expertise with subnetting, virtual switching, NSG firewall policies, and secure SSH/RDP access controls.
