---
title: "Productie Homelab, Tailscale Mesh & 9-GPU LLM Cluster — orion-o6"
description: "Debian 12 thuisserver met 30+ containers, een enterprise Zero-Trust Tailscale mesh-netwerk, subnet routing en een dedicated 9-GPU LLM inference cluster."
date: 2026-09-24
tags: ["Docker", "Linux", "Debian", "Tailscale", "Zero-Trust", "LLM", "llama.cpp", "GPU Cluster"]
featureimage: "./image.png"
---

**Aangetoonde Vaardigheden:** Zero-Trust Network Architecture (ZTNA), Tailscale (WireGuard Mesh VPN, Subnet Routers, Exit Nodes, ACL Policies), Gedistribueerde AI-Inference (9-GPU Cluster, 50+ GB VRAM, llama.cpp, GGUF/Layer Splitting), Docker Compose (30+ actieve containers), Linux Systeembeheer (Debian 12 Bookworm, systemd, ufw), Reverse Proxying & SSL-terminatie (Nginx/Traefik), Databasebeheer (PostgreSQL met VectorChord, Redis, Valkey, MongoDB), Systeem- en Poortmonitoring (PortTracker).

---

## 📸 Bewijs & Live Systeemmonitoring (Screenshots)

> **PortTracker Live Telemetrie Bewijs:** Onderstaande screenshot van de zelfontwikkelde monitoringtool (*PortTracker*) toont de actieve status van de `orion-o6` productieserver (`100.101.168.17:4999`). Het toont realtime inzicht in 33 actieve containers, 12 CPU-cores, 28.57 GB RAM en 190 gedetecteerde poorttoewijzingen (waaronder AI-workloads, mediastacks en netwerkservices).

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
      <div style="color:#58a6ff; font-size:13px; font-weight:600;">33 Draaiende Services</div>
    </div>
    <div style="background:#161b22; border:1px solid #30363d; border-radius:6px; padding:10px;">
      <div style="color:#8b949e; font-size:10px; text-transform:uppercase;">Mesh Netwerk</div>
      <div style="color:#e6edf3; font-size:13px; font-weight:600;">Tailscale Zero-Trust (20 Nodes)</div>
    </div>
  </div>
</div>

---

## 🔒 Tailscale Zero-Trust Mesh Architectuur

In plaats van kwetsbare publieke inkomende poorten open te zetten op residentiële firewalls of poorten te forwarden via dynamische DNS, maakt het homelab gebruik van een moderne **Zero-Trust Network Access (ZTNA)** topologie aangedreven door **Tailscale (WireGuard)**.

{{< mermaid >}}
graph TD
    subgraph ClientTier ["Client Tier: Geauthenticeerde Remote Endpoints"]
        DevPC["Werkstations & Laptops"]
        Mobile["Mobiele Apparaten - iOS/Android"]
    end

    subgraph Tailnet ["Tailscale Encrypted WireGuard Mesh (Tailnet)"]
        Router1["orion-o6 (100.101.x.x)<br>Subnet Router & Exit Node"]
        Router2["Secundaire Node (100.88.x.x)<br>Redundante Subnet Router"]
        GPUCluster["ubunt (100.113.x.x)<br>⚡ 9-GPU LLM Inference Cluster<br>50+ GB VRAM / llama.cpp Server"]
    end

    subgraph InternalApps ["Interne Applicaties & AI Ecosysteem (orion-o6)"]
        NginxProxy["Nginx / Traefik Reverse Proxy"]
        Containers["Docker Bridge Netwerk<br>• AI Workloads: LibreChat, Open-WebUI<br>• RAG Pipeline: rag_api, pgvector, Meilisearch<br>• Foto's & ML: Immich Server & ML VectorChord<br>• Media & Automatisering: Jellyfin, n8n, Questarr<br>• Databases: PostgreSQL 16 & 17, Redis, Valkey"]
        Monitoring["PortTracker Telemetrie Engine"]
    end

    DevPC -->|"Versleutelde WireGuard Peer-to-Peer"| Router1
    Mobile -->|"Versleutelde WireGuard Peer-to-Peer"| Router1
    DevPC -.-> Router2

    Router1 --> NginxProxy
    NginxProxy --> Containers
    Containers --> Monitoring

    %% Verbinding tussen AI frontends en 9-GPU cluster
    Containers <-->|"High-Speed Interne Tailnet Mesh<br>(OpenAI-Compatibele API)"| GPUCluster

    style Router1 fill:#1e3a8a,stroke:#3b82f6,stroke-width:2px,color:#fff
    style Router2 fill:#1e3a8a,stroke:#3b82f6,stroke-width:2px,color:#fff
    style GPUCluster fill:#581c87,stroke:#a855f7,stroke-width:2px,color:#fff
    style Containers fill:#1e293b,stroke:#475569,color:#fff
{{< /mermaid >}}

### 1. Cross-Platform 20-Node Tailnet
- **Multi-OS Mesh:** Het versleutelde netwerk verbindt **20 actieve endpoints** over heterogene omgevingen: Debian-servers, gespecialiseerde Linux-rekenknooppunten, Windows-ontwikkelmachines en mobiele apparaten.
- **NAT Traversal & DERP Terugval:** Gebruikmakend van interactieve STUN/ICE-technieken om directe peer-to-peer UDP WireGuard-verbindingen op te zetten door dubbele NAT heen, zonder afhankelijkheid van publieke statische IP-adressen.

### 2. Subnet Routing & Exit Node Functionaliteit
- **Subnet Router:** `orion-o6` adverteert private subnetroutes, waardoor geautoriseerde externe clients op het Tailnet direct toegang hebben tot interne containernetwerken zonder dat elke individuele container een eigen VPN-client vereist.
- **Dedicated Exit Nodes:** Belangrijke servers fungeren als **Exit Nodes**, wat veilige, versleutelde routing van al het internetverkeer mogelijk maakt via betrouwbare thuisserververbindingen op onbeveiligde publieke wifi-netwerken.

### 3. Granulaire Toegangscontrole (ACL's)
- **Principle of Least Privilege:** Geconfigureerd met declaratieve Tailscale Access Control Lists (ACL's). Toegangsregels beperken specifieke gebruikers en apparaat-tags strikt tot hun geautoriseerde doelknooppunten en poorten.
- **Beheersisolatie:** Administratieve poorten (SSH poort 22, database-poorten, interne API-interfaces) zijn exclusief toegankelijk vanaf geverifieerde beheerdersapparaten, wat laterale verplaatsing (lateral movement) voorkomt.
- **Sleutelverval & Machine Posture:** Apparaatautorisatie vereist periodieke cryptografische sleutelvernieuwing, waardoor inactieve of buiten gebruik gestelde machines automatisch worden geblokkeerd.

### 4. Nul Open Inkomende Poorten
- **Volledige Eliminatie van het Aanvalsoppervlak:** De WAN-router heeft **0 geforwarde poorten** naar het openbare internet. Al het verkeer wordt cryptografisch geverifieerd en end-to-end versleuteld vóór het enige interne service kan bereiken.

---

## ⚡ 9-GPU LLM Inference Cluster (`ubunt`)

Een van de speerpunten van het netwerk is **`ubunt`** (`100.113.x.x`), een dedicated bare-metal Linux compute node die specifiek is ingericht als een **gedistribueerd 9-GPU LLM inference cluster**:

- **Hardware & VRAM Pool:** Bevat **9 afzonderlijke GPU's die samen een pool van meer dan 50 GB VRAM** leveren.
- **Hosting van Grote Modellen (50+ GB Modellen):** Ontworpen om zware gekwantiseerde parametermodellen (zoals LLaMA-3 70B, Qwen 72B, Mixtral 8x22B, Command-R+) volledig in GPU-geheugen te draaien, zonder terugval naar traag CPU-systeemgeheugen.
- **High-Throughput Runtime:** Aangedreven door een **llama.cpp** server met behulp van GPU-tensor- en layer-splitting om geheugenbandbreedte en tokens-per-seconde generatiesnelheden te maximaliseren.
- **Naadloze Tailnet-Integratie:** Het cluster communiceert privaat via het Tailscale mesh-netwerk met `orion-o6` en stelt OpenAI-compatibele endpoints direct beschikbaar aan interne AI-clients (**LibreChat**, **Open-WebUI**, en de **RAG API** pipeline met `pgvector` en `Meilisearch`).
- **Volledige Datasoevereiniteit:** Geen enkele afhankelijkheid van externe commerciële API's; enterprise-grade intelligentie die volledig binnen een private, zelf-gehoste perimeter draait.

---

## 📦 Gecontaineriseerd Service-Ecosysteem (30+ Services op `orion-o6`)

Elke workload op `orion-o6` draait geïsoleerd in Docker-containers, verdeeld over gesegmenteerde custom bridge-netwerken en continu gemonitord:

| Domein | Belangrijkste Containers | Architectuur & Doel |
| :--- | :--- | :--- |
| **AI & LLM Workloads** | `LibreChat`, `open-webui`, `rag_api`, `pgvector`, `chat-mongodb`, `chat-meilisearch` | Private AI-assistent interfaces, retrieval-augmented generation (RAG) pipelines en vectordatabase-embeddings gekoppeld aan de 9-GPU inference node. |
| **Media & ML Pipeline** | `immich_server`, `immich_machine_learning`, `immich_postgres` (VectorChord), `immich_redis` | Zelf-gehoste fotobibliotheek met lokale ML-gezichtsherkenning en vector-gebaseerde semantische zoekfunctie. |
| **Media Automatisering** | `jellyfin`, `jellyseerr`, `radarr`, `radarr-4k`, `sonarr`, `prowlarr`, `qbittorrent`, `unpackerr` | Volledig geautomatiseerd mediastreaming- en beheerplatform. |
| **Databases & Caching** | `postgres:16-alpine`, `postgres:17`, `redis:7-alpine`, `valkey:9-alpine` | Hoge-beschikbaarheid relationele opslag, cachinglagen en sessiebackends. |
| **Automatisering & Scraping** | `n8n`, `changedetection`, `browserless/chrome`, `searxng-core` | Geautomatiseerde webhook-workflows, headless browser rendering en private meta-zoekmachine. |
| **Systeem & Monitoring** | `portracker`, `webtop`, `debian_web_stream`, `librespeed`, `wealthfolio` | Realtime poorttelemetrie, beveiligde webbrowser streaming en systeemdiagnostiek. |

---

## 🔍 Continue Telemetrie met PortTracker

Om alle 30+ services over **22+ interne poorten** continu te bewaken, draait op `orion-o6` de monitoringtool **PortTracker**. Zoals te zien op de bovenstaande dashboard-screenshot:
- **Poortconflict-Detectie:** Monitort poorttoewijzingen tussen stacks (`arr-stack`, `dashboard-stack`, `librechat`, `questarr`, `sitetrack`).
- **Health Checks & Status:** Directe melding bij container-degradatie of herstartlussen.
- **Interne Tailnet Binding:** Garandeert dat services uitsluitend luisteren op interne Tailscale IP-interfaces (`100.101.x.x`) en lokale containernetwerken in plaats van openbare interfaces.

---

## 💡 Waarom Dit Relevant Is voor Cloud & DevOps Rollen

Het beheren van dit productielab biedt dagelijkse, praktische ervaring met enterprise infrastructuurvereisten:
- **Zero-Trust Netwerkbeveiliging:** Implementatie van WireGuard mesh-netwerken, least-privilege ACL-regels en architecturen zonder open poorten.
- **Geavanceerde AI-Infrastructuur:** Opzetten en beheren van multi-GPU clusters, VRAM-pooling en tensor-parallelle inferentie-pipelines.
- **Betrouwbaarheid & Hoge Beschikbaarheid:** Borgen van 24/7 uptime over multi-tier applicaties, persistente opslag en geautomatiseerde migraties.
