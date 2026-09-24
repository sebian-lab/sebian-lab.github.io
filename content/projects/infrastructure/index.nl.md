---
title: "Cloud & Virtualisation Labs"
description: "Enterprise-grade hybrid infrastructure deployment projects across Microsoft Azure and VMware ESXi."
date: 2026-05-30
tags: ["Azure", "VMware", "Kubernetes", "AKS", "Active Directory", "IaC", "DevOps"]
featureimage: "./feature.png"
---

**Skills Demonstrated:** Microsoft Azure (VM, VNet, Subnet Segmentation, NSG, Storage Accounts, ACI, AKS), Infrastructure as Code (ARM Templates & Deployment Stacks), Kubernetes (kubectl, Load Balancers), VMware ESXi 8.0, Virtual Switching (vSwitch & Port Groups), Windows Server 2022, Active Directory Domain Services (AD DS, DNS, Identity Management).

---

## 🏛️ Introductie & Architectuur Context

Tijdens de opleiding **Toegepaste Informatica** aan **Odisee Hogeschool Brussel** heb ik een reeks diepgaande enterprise infrastructuurprojecten ontworpen en gerealiseerd. Deze labs simuleren een realistische **hybride enterprise-omgeving**, opgebouwd rond twee complementaire pijlers:

1. **Public Cloud Infrastructure (Microsoft Azure):**
   - Ontwerp van een veilig, gesegmenteerd cloudnetwerk met afzonderlijke frontend- en backend-subnets en strikte Network Security Groups (NSGs).
   - Uitrol van cloud-native containerworkloads via Azure Container Instances (ACI) en een managed **Azure Kubernetes Service (AKS)** cluster.
   - Automatisering via **Infrastructure as Code (IaC)** met behulp van JSON ARM Templates en herbruikbare Azure Deployment Stacks.

2. **Private Datacenter Virtualisatie (VMware ESXi & Active Directory):**
   - Implementatie van een bare-metal hypervisoromgeving met **VMware ESXi 8.0** op VMFS6 datastores.
   - Netwerkvirtualisatie met VMware vSwitches, dedicated VM Network port groups en statische subnetten.
   - Volledige inrichting van een **Windows Server 2022 Domain Controller** met **Active Directory Domain Services (AD DS)**, DNS-zones en gecentraliseerd identiteits- en toegangsbeheer.

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

## ☁️ Deel 1: Microsoft Azure Cloud Labs

> **Academisch Project** — Odisee Hogeschool Brussel, Toegepaste Informatica (Cloud Infrastructure)

In dit lab is een complete Azure cloudomgeving opgezet volgens het *least-privilege* en *network segmentation* principe.

---

### 1. Virtuele Machine (FreeVM01) met Beveiligde SSH-Toegang
Uitrol van een Ubuntu Linux VM in Azure datacenter *Switzerland North*. De toegang is strikt beveiligd met asymmetrische SSH-sleutels (geen wachtwoordauthenticatie op openbare poorten).

![Azure VM – SSH connection](/images/azure_lab_8.png)

---

### 2. Virtual Network (VNet) — Frontend & Backend Segmentatie
Ontwerp van een virtueel netwerk met gescheiden **Frontend** en **Backend** subnets. Het verkeer tussen de subnets en vanaf het internet wordt nauwgezet gefilterd met op maat geconfigureerde **Network Security Groups (NSGs)**.

![Azure VNet](/images/azure_lab_9.png)

---

### 3. Azure Container Instance (ACI) — webappcontainer
Serverless container deployment met behulp van Azure Container Instances. De container draait de `aci-helloworld` image in *Switzerland North* met dynamische DNS-naamgeving en automatische lifecycle-monitoring.

![Azure Container Instance](/images/azure_lab_13.png)

---

### 4. Storage Account & Blob Containers
Provisioning van een beveiligd Azure Storage Account (`sebianstor`) met een private blob container (`media`) voor gecentraliseerde cloudopslag van data-assets.

![Azure Storage Account — ARM Deployment Stack](/images/azure_lab_25.png)

---

### 5. Infrastructure as Code (IaC) — ARM Templates & Deployment Stacks
Volledig geautomatiseerde uitrol van Azure resources via Infrastructure as Code. De configuratie is vastgelegd in een declaratieve JSON **ARM Template** en uitgerold via **Azure Deployment Stacks** voor idempotente, reproduceerbare en versiebeheerde infrastructuur.

![Azure ARM Deployment](/images/azure_lab_31.png)

---

### 6. Azure Kubernetes Service (AKS) Cluster — aksdemo
Opzetten en beheren van een managed Kubernetes-cluster (`aksdemo`) in *Switzerland North*. Beheerd via `kubectl` met geautomatiseerde provisioning van worker node pools en een NGINX-webserver als extern load-balanced service endpoint.

![AKS Cluster creation – Node pools](/images/azure_lab_30.png)

---

## 🖥️ Deel 2: VMware ESXi 8.0 & Active Directory Datacenter Lab

> **Academisch Project** — Odisee Hogeschool Brussel, Toegepaste Informatica (Netwerken & Virtualisatie)

In dit lab is een lokaal gevirtualiseerd datacenter ingericht vanaf de hypervisorlaag tot aan de gecentraliseerde domein- en gebruikersadministratie.

---

### 1. Nested VMware ESXi 8.0 Hypervisor
Installatie en configuratie van een nested VMware ESXi 8.0 hypervisor binnen VMware Workstation Pro. De host is voorzien van een statische IP-configuratie (`192.168.50.20`) en een lokale 200 GB VMFS6 datastore voor high-performance VM storage.

![ESXi – Datastore creation (200 GB VMFS6)](/images/vmware_lab_19.jpeg)

---

### 2. Virtual Switch (vSwitch0) & Port Group Topologie
Configuratie van de virtuele switch `vSwitch0` met de *VM Network* port group. De server- en werkstation-VM's (`sebi2026-SRV-EX` en `sebi2026-WKS-EX`) zijn gekoppeld binnen een geïsoleerd intern subnet met statische IP-adressering.

![ESXi – vSwitch topology (sebi2026-SRV-EX, sebi2026-WKS-EX)](/images/vmware_lab_22.png)

---

### 3. Windows Server 2022 — Statische IP & Netwerkconfiguratie
Installatie van Windows Server 2022 Datacenter Edition als dedicated server-VM (`192.168.50.10`) met statische DNS- en gateway-toewijzing ter voorbereiding op de promotie naar Domain Controller.

![Windows Server – Static IP 192.168.50.10](/images/vmware_lab_10.png)

---

### 4. Active Directory Domain Services (AD DS) — Domein se26-DC-ESX.EXA
Promotie van de Windows Server tot Primary Domain Controller binnen het enterprise-domein `se26-DC-ESX.EXA`. Inrichting van Active Directory Domain Services (AD DS), geïntegreerde DNS-zones en aanmaak van administratieve gebruikersaccounts (`AdminUser@se26-DC-ESX.EXA`).

![AD DS – Create AdminUser@se26-DC-ESX.EXA](/images/vmware_lab_30.png)

---

### 5. Domein- en Hostnaam Conventie (sebi2026-EXA-DC)
Uniforme hernoeming en synchronisatie van de domeincontroller-naam naar `sebi2026-EXA-DC` conform enterprise naamgevingsconventies, inclusief validatie van Kerberos- en DNS SRV-records.

![Windows Server rename to sebi2026-EXA-DC](/images/vmware_lab_26.png)

---

## 🎯 Leerdoelen & Professionele Relevantie

Dit gecombineerde lab toont aan dat ik zowel in **publieke cloudomgevingen (Azure/Kubernetes)** als in **on-premise datacenterinfrastructuren (VMware/Windows Server)** zelfstandig schaalbare, veilige en reproduceerbare systemen kan bouwen en beheren:
- **Cloud-Native & IaC:** Ervaring met ARM Templates, Kubernetes (AKS) en container orchestratie.
- **Enterprise Identity & Access:** Diepgaand begrip van Active Directory Domain Services, DNS en gebruikersbeheer.
- **Netwerkarchitectuur:** Praktijkervaring met subnetting, vSwitches, NSG firewall rules en veilige SSH/RDP access controls.
