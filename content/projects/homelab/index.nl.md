---
title: "Productie Homelab, Tailscale Mesh & 9-GPU LLM Cluster — orion-o6"
description: "Debian 12 thuisserver met 30+ containers, een enterprise Zero-Trust Tailscale mesh-netwerk, subnet routing en een dedicated 9-GPU LLM inference cluster."
date: 2026-09-24
tags: ["Docker", "Linux", "Debian", "Tailscale", "Zero-Trust", "LLM", "llama.cpp", "GPU Cluster"]
featureimage: "./image.png"
---

**Aangetoonde Vaardigheden:** Zero-Trust Network Architecture (ZTNA), Tailscale (WireGuard Mesh VPN, Subnet Routers, Exit Nodes, ACL Policies), Gedistribueerde AI-Inference (Multi-GPU Cluster, 50+ GB VRAM, llama.cpp, Layer Splitting), Docker Compose (30+ actieve containers), Linux Systeembeheer (Debian 12 Bookworm, systemd, ufw), Reverse Proxying & SSL-terminatie (Nginx/Traefik), Databasebeheer (PostgreSQL met VectorChord, Redis, Valkey, MongoDB), Gecentraliseerde Systeem- en Poorttelemetrie (PortTracker).

---

## 📋 Executive Summary (Overzicht voor Management & HR)

<div style="background:#0d1117; border:1px solid #30363d; border-radius:10px; padding:20px; margin-bottom:24px;">
  <div style="display:grid; grid-template-columns:repeat(auto-fit, minmax(240px, 1fr)); gap:16px;">
    <div>
      <h4 style="color:#58a6ff; margin:0 0 8px 0; font-size:15px;">🎯 De Uitdaging (Probleem)</h4>
      <p style="margin:0; font-size:14px; line-height:1.5; color:#c9d1d9;">
        Hoe host en beheer je 30+ bedrijfskritische containers en zware AI-workloads over meerdere machines, met 24/7 betrouwbaarheid, <strong>zonder kwetsbare inkomende poorten</strong> open te zetten naar het openbare internet?
      </p>
    </div>
    <div>
      <h4 style="color:#3fb950; margin:0 0 8px 0; font-size:15px;">👤 Mijn Rol & Verantwoordelijkheid</h4>
      <p style="margin:0; font-size:14px; line-height:1.5; color:#c9d1d9;">
        End-to-end architectuur en beheer: implementatie van een Zero-Trust WireGuard mesh-netwerk, container-orkestratie met Docker, geautomatiseerde backup- en storage-pipelines en het ontwikkelen van een op maat gemaakte poort- en servicemonitor (<strong>PortTracker</strong>).
      </p>
    </div>
    <div>
      <h4 style="color:#a855f7; margin:0 0 8px 0; font-size:15px;">📈 Bedrijfswaarde & Resultaat</h4>
      <p style="margin:0; font-size:14px; line-height:1.5; color:#c9d1d9;">
        <strong>Nul openbare inkomende poorten</strong> (100% gereduceerd extern aanvalsoppervlak), 99.9% continue beschikbaarheid over 30+ microservices, proactieve conflictpreventie en volledige datasoevereiniteit voor interne AI-modellen.
      </p>
    </div>
  </div>
</div>

### 📸 Visueel Bewijs & Live Systeemmonitoring

> **Gecentraliseerde Systeemtelemetrie:** Onderstaande weergave van het zelfontwikkelde monitoringplatform (*PortTracker*) toont de actieve status van de `orion-o6` productieserver. Het biedt realtime inzicht in containergezondheid, resourceconsumptie (12 CPU-cores, 28 GB RAM) en actieve serviceregistraties over geïsoleerde netwerkstacks.

![PortTracker Homelab Dashboard](./image.png)

<div style="background:#0d1117; color:#c9d1d9; padding:20px; border-radius:10px; font-family:monospace; border:1px solid #30363d; margin-top:20px; margin-bottom:28px;">
  <div style="display:flex; align-items:center; justify-content:space-between; border-bottom:1px solid #30363d; padding-bottom:12px; margin-bottom:14px;">
    <div style="display:flex; align-items:center; gap:10px;">
      <span style="font-size:20px;">🖥️</span>
      <strong style="color:#58a6ff; font-size:16px;">orion-o6 & Cluster Telemetrie</strong>
    </div>
    <span style="color:#3fb950; font-size:12px; font-weight:bold;">● 24/7 Productie Node</span>
  </div>
  <div style="display:grid; grid-template-columns:repeat(4,1fr); gap:12px;">
    <div style="background:#161b22; border:1px solid #30363d; border-radius:6px; padding:10px;">
      <div style="color:#8b949e; font-size:10px; text-transform:uppercase;">Host Systeem</div>
      <div style="color:#e6edf3; font-size:13px; font-weight:600;">Debian 12 (12 Cores / 28 GB)</div>
    </div>
    <div style="background:#161b22; border:1px solid #30363d; border-radius:6px; padding:10px;">
      <div style="color:#8b949e; font-size:10px; text-transform:uppercase;">GPU Compute Node</div>
      <div style="color:#a855f7; font-size:13px; font-weight:600;">9-GPU Cluster (50+ GB VRAM)</div>
    </div>
    <div style="background:#161b22; border:1px solid #30363d; border-radius:6px; padding:10px;">
      <div style="color:#8b949e; font-size:10px; text-transform:uppercase;">Actieve Containers</div>
      <div style="color:#58a6ff; font-size:13px; font-weight:600;">30+ Draaiende Services</div>
    </div>
    <div style="background:#161b22; border:1px solid #30363d; border-radius:6px; padding:10px;">
      <div style="color:#8b949e; font-size:10px; text-transform:uppercase;">Mesh Netwerk</div>
      <div style="color:#e6edf3; font-size:13px; font-weight:600;">Tailscale Zero-Trust (20 Nodes)</div>
    </div>
  </div>
</div>

---

## ⚙️ Diepgaande Technische Architectuur (Voor Tech Leads & Engineers)

### 🔒 1. Zero-Trust Mesh & Netwerkbeveiliging (Tailscale / WireGuard)

In plaats van kwetsbare publieke poorten open te zetten op residentiële firewalls of poorten te forwarden via dynamische DNS, maakt de infrastructuur gebruik van een moderne **Zero-Trust Network Access (ZTNA)** architectuur aangedreven door **Tailscale (WireGuard)**.

{{< mermaid >}}
graph TD
    subgraph ClientTier ["Client Tier: Geauthenticeerde Remote Endpoints"]
        DevPC["Ontwikkelwerkstations & Laptops"]
        Mobile["Mobiele Apparaten (iOS / Android)"]
    end

    subgraph Tailnet ["Zero-Trust Encrypted WireGuard Mesh"]
        Router1["orion-o6 (Primaire Node)<br>Subnet Router & Dedicated Exit Node"]
        Router2["Secundaire Redundante Node<br>Failover Subnet Router"]
        GPUCluster["ubunt (Dedicated Compute Node)<br>⚡ 9-GPU LLM Inference Cluster<br>50+ GB VRAM / llama.cpp Server"]
    end

    subgraph InternalApps ["Interne Applicaties & Services (orion-o6)"]
        NginxProxy["Nginx / Traefik Reverse Proxy & TLS"]
        Containers["Docker Bridge Netwerk (Geïsoleerde Stacks)<br>• AI Workloads: LibreChat, Open-WebUI<br>• RAG Pipeline: rag_api, pgvector, Meilisearch<br>• Media & ML: Immich Server & ML VectorChord<br>• Ingestion & Workflows: n8n, Event Workers, Jellyfin<br>• Databases: PostgreSQL 16 & 17, Redis, Valkey"]
        Monitoring["PortTracker Telemetrie Engine"]
    end

    DevPC -->|"Versleutelde WireGuard Peer-to-Peer Tunnel"| Router1
    Mobile -->|"Versleutelde WireGuard Peer-to-Peer Tunnel"| Router1
    DevPC -.-> Router2

    Router1 --> NginxProxy
    NginxProxy --> Containers
    Containers --> Monitoring

    %% Private communicatie tussen AI frontends en 9-GPU cluster
    Containers <-->|"Private High-Speed Mesh Verbinding<br>(OpenAI-Compatibele REST API)"| GPUCluster

    style Router1 fill:#1e3a8a,stroke:#3b82f6,stroke-width:2px,color:#fff
    style Router2 fill:#1e3a8a,stroke:#3b82f6,stroke-width:2px,color:#fff
    style GPUCluster fill:#581c87,stroke:#a855f7,stroke-width:2px,color:#fff
    style Containers fill:#1e293b,stroke:#475569,color:#fff
{{< /mermaid >}}

#### Belangrijkste Netwerk- & Beveiligingspijlers:
- **Cross-Platform 20-Node Tailnet:** Het versleutelde mesh-netwerk verbindt **20 actieve endpoints** over heterogene omgevingen: Debian-servers, gespecialiseerde compute nodes, Windows-ontwikkelmachines en mobiele apparaten via directe STUN/ICE NAT traversal zonder publieke statische IP's.
- **Subnet Routing & Exit Node Functionaliteit:** `orion-o6` fungeert als Subnet Router, waardoor geautoriseerde remote clients direct toegang krijgen tot interne containers zonder dat elke individuele container een eigen VPN-client vereist. Daarnaast fungeert de node als beveiligde Exit Node voor versleutelde internetrouting op onbeveiligde netwerken.
- **Granulaire Toegangscontrole (ACL's) & Least Privilege:** Toegangsregels beperken specifieke gebruikers en machine-tags strikt tot geautoriseerde bestemmingen en poorten. Administratieve interfaces (SSH, databases, interne management-API's) zijn exclusief bereikbaar vanaf vertrouwde beheerapparaten, wat laterale verplaatsing (lateral movement) effectief voorkomt.
- **Zero Inbound Port Exposure:** De WAN-perimeter heeft **0 open inkomende poorten** naar het openbare internet. Elk verzoek wordt cryptografisch geverifieerd via WireGuard peer-to-peer authenticatie.

---

### ⚡ 2. Gedistribueerd 9-GPU LLM Inference Cluster (`ubunt`)

Een belangrijk speerpunt van het netwerk is een dedicated bare-metal Linux compute node (`ubunt`), ingericht als een **gedistribueerd 9-GPU inference cluster**:

- **Hardware & VRAM Pooling:** Bevat **9 afzonderlijke GPU's die samen een pool van meer dan 50 GB VRAM** leveren.
- **Local Large-Model Hosting:** Ontworpen om zware gekwantiseerde LLM's (LLaMA-3 70B, Qwen 72B, Mixtral 8x22B) volledig in GPU-geheugen te draaien, zonder terugval naar traag CPU-systeemgeheugen.
- **High-Throughput Runtime:** Aangedreven door een **llama.cpp** server met behulp van GPU-tensor- en layer-splitting om geheugenbandbreedte en tokens-per-seconde generatiesnelheden te maximaliseren.
- **Naadloze Mesh-Integratie:** Het cluster communiceert privaat via het Tailscale mesh-netwerk met `orion-o6` en stelt OpenAI-compatibele endpoints direct beschikbaar aan interne AI-clients (**LibreChat**, **Open-WebUI**, en de **RAG API** pipeline met `pgvector` en `Meilisearch`).
- **Volledige Datasoevereiniteit:** Geen enkele afhankelijkheid van externe commerciële API's; enterprise-grade intelligentie die volledig binnen een private perimeter draait.

---

### 📦 3. Gecontaineriseerd Service-Ecosysteem (30+ Services op `orion-o6`)

Elke workload op `orion-o6` draait geïsoleerd in Docker-containers, verdeeld over gesegmenteerde custom bridge-netwerken:

| Domein | Belangrijkste Containers | Architectuur & Doel |
| :--- | :--- | :--- |
| **AI & LLM Workloads** | `LibreChat`, `open-webui`, `rag_api`, `pgvector`, `chat-mongodb`, `chat-meilisearch` | Private AI-assistent interfaces, retrieval-augmented generation (RAG) pipelines en vectordatabase-embeddings gekoppeld aan de 9-GPU inference node. |
| **Media & ML Pipeline** | `immich_server`, `immich_machine_learning`, `immich_postgres` (VectorChord), `immich_redis` | Zelf-gehoste fotobibliotheek met lokale ML-gezichtsherkenning en vector-gebaseerde semantische zoekfunctie. |
| **Automated Ingestion & Media Pipeline** | `jellyfin`, `n8n`, `storage-worker` | Asynchrone streaming- en pipeline-architectuur met event-driven verwerking en geoptimaliseerde storage caching. |
| **Databases & Caching** | `postgres:16-alpine`, `postgres:17`, `redis:7-alpine`, `valkey:9-alpine` | Hoge-beschikbaarheid relationele opslag, cachinglagen en sessiebackends. |
| **Automatisering & Workflows** | `n8n`, `changedetection`, `browserless/chrome`, `searxng-core` | Geautomatiseerde webhook-workflows, headless browser rendering en private data-ingestie. |
| **Systeem & Telemetrie** | `portracker`, `webtop`, `debian_web_stream`, `librespeed`, `wealthfolio` | Realtime container- en servicetelemetrie, beveiligde browser streaming en systeemdiagnostiek. |

---

### 🔍 4. Gecentraliseerde Telemetrie & Conflictpreventie (PortTracker)

Om alle 30+ services en afzonderlijke netwerkstacks continu te bewaken, draait op `orion-o6` de monitoringtool **PortTracker**:
- **Poortconflict-Detectie & Toewijzingsbewaking:** Monitort poorttoewijzingen en voorkomt netwerkconflicten tussen onafhankelijke Docker Compose stacks (`media-pipeline`, `telemetry-stack`, `librechat`, `sitetrack`).
- **Health Checks & Lifecycle Status:** Realtime detectie van haperende containers, statusdegradatie of herstartlussen.
- **Private Interface Binding:** Garandeert dat alle interne services strikt binden aan geïsoleerde lokale netwerken en private mesh-interfaces in plaats van publiek toegankelijke adressen.

---

### 💡 Waarom Dit Relevant Is voor Cloud & DevOps Rollen

Het ontwerpen en beheren van deze 24/7 infrastructuur toont directe praktische beheersing van enterprise eisen:
- **Zero-Trust Netwerkbeveiliging:** Bewezen ervaring met WireGuard mesh-netwerken, least-privilege ACL-regels en architecturen zonder openbare aanvalsoppervlakken.
- **Geavanceerde Compute & AI-Infrastructuur:** Opzetten en beheren van multi-GPU clusters, VRAM-pooling en tensor-parallelle inferentie-pipelines.
- **Betrouwbaarheid & Systeeminzicht:** Borgen van 24/7 uptime over multi-tier applicaties, persistente volumes en continue telemetrie.
