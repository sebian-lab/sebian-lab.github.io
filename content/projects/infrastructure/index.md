---
title: "Cloud & Virtualisation Labs"
description: "Enterprise-grade infrastructure deployment projects across Azure and VMware."
date: 2026-05-30
tags: ["Azure", "VMware", "Kubernetes", "AKS", "Active Directory"]
---

**Skills Demonstrated:** Azure VM, VNet, NSG provisioning, Azure Container Instances (ACI), Infrastructure as Code (ARM Templates, Deployment Stacks), Azure Kubernetes Service (AKS), VMware ESXi 8.0, Active Directory Domain Services (AD DS) administration, vSwitch networking.

---

## Azure Cloud Labs

> **School project** — Odisee Brussel, Toegepaste Informatica

---

### 1. Virtual Machine (FreeVM01) with SSH

Deployed an Ubuntu Linux VM in Azure Switzerland North. Accessed securely via SSH keys.

![Azure VM – SSH connection](/images/azure_lab_8.png)

---

### 2. Virtual Network — Frontend & Backend Subnets

Designed a VNet with segmented Frontend and Backend subnets + Network Security Groups.

![Azure VNet](/images/azure_lab_9.png)

---

### 3. Azure Container Instance — webappcontainer

Deployed `webappcontainer` running the `aci-helloworld` image in Switzerland North.

![Azure Container Instance](/images/azure_lab_13.png)

---

### 4. Storage Account + Blob container

Created a Storage Account (`sebianstor`) in Switzerland North with a blob container (`media`).

![Azure Storage Account — ARM Deployment Stack](/images/azure_lab_25.png)

---

### 5. Infrastructure as Code — ARM Template (Deployment Stack)

Deployed the storage account using a custom JSON ARM template as a Deployment Stack.

![Azure ARM Deployment](/images/azure_lab_31.png)

---

### 6. AKS Cluster — aksdemo

Provisioned a full Kubernetes cluster (`aksdemo`) in Switzerland North, managed via `kubectl`, with NGINX deployed as a load-balanced service.

![AKS Cluster creation – Node pools](/images/azure_lab_30.png)

---

## VMware ESXi Lab

> **School project** — Odisee Brussel, Toegepaste Informatica

---

### 1. Nested ESXi Hypervisor on VMware Workstation Pro

Deployed VMware ESXi 8.0 as a nested VM inside Workstation Pro. Configured the host with a static IP (192.168.50.20) and local datastore.

![ESXi – Datastore creation (200 GB VMFS6)](/images/vmware_lab_19.jpeg)

---

### 2. vSwitch & VM Network Configuration

Configured `vSwitch0` with the VM Network port group. Both VMs (`sebi2026-SRV-EX` and `sebi2026-WKS-EX`) attached with static IPs.

![ESXi – vSwitch topology (sebi2026-SRV-EX, sebi2026-WKS-EX)](/images/vmware_lab_22.png)

---

### 3. Windows Server 2022 — Static IP Configuration

Assigned a static IP (192.168.50.10) to the Windows Server 2022 VM acting as Domain Controller.

![Windows Server – Static IP 192.168.50.10](/images/vmware_lab_10.png)

---

### 4. Active Directory Domain Services — Domain se26-DC-ESX.EXA

Promoted the Windows Server to a Domain Controller with domain `se26-DC-ESX.EXA`. Created an AD user `AdminUser@se26-DC-ESX.EXA`.

![AD DS – Create AdminUser@se26-DC-ESX.EXA](/images/vmware_lab_30.png)

---

### 5. Domain Rename (sebi2026-EXA-DC)

Renamed the Windows Server VM to `sebi2026-EXA-DC` to match the domain naming convention.

![Windows Server rename to sebi2026-EXA-DC](/images/vmware_lab_26.png)
