---
title: "Production Homelab, Tailscale Mesh & 9-GPU LLM Cluster — orion-o6"
description: "Debian 12 home server running 30+ containers with an enterprise Zero-Trust Tailscale mesh network, subnet routing, and a dedicated 9-GPU LLM inference cluster."
date: 2026-09-24
tags: ["Docker", "Linux", "Debian", "Tailscale", "Zero-Trust", "LLM", "llama.cpp", "GPU Cluster"]
featureimage: "./image.png"
---

**Skills Demonstrated:** Zero-Trust Network Architecture (ZTNA), Tailscale (WireGuard Mesh VPN, Subnet Routers, Exit Nodes, ACL Policies), Distributed AI Inference (Multi-GPU Cluster, 50+ GB VRAM, llama.cpp, Layer Splitting), Docker Compose (30+ active containers), Linux System Administration (Debian 12 Bookworm, systemd, ufw), Reverse Proxying & SSL Termination (Nginx/Traefik), Database Administration (PostgreSQL with VectorChord, Redis, Valkey, MongoDB), Centralized System & Port Telemetry (PortTracker).

---

## 📋 Executive Summary (Management & Recruiter Overview)

<div style="background:#0d1117; border:1px solid #30363d; border-radius:10px; padding:20px; margin-bottom:24px;">
  <div style="display:grid; grid-template-columns:repeat(auto-fit, minmax(240px, 1fr)); gap:16px;">
    <div>
      <h4 style="color:#58a6ff; margin:0 0 8px 0; font-size:15px;">🎯 Business Challenge (The Problem)</h4>
      <p style="margin:0; font-size:14px; line-height:1.5; color:#c9d1d9;">
        How to reliably host and operate 30+ mission-critical microservices and heavy AI workloads across heterogeneous nodes with 24/7 uptime, <strong>without exposing vulnerable open inbound ports</strong> to the public internet?
      </p>
    </div>
    <div>
      <h4 style="color:#3fb950; margin:0 0 8px 0; font-size:15px;">👤 My Role & Engineering Ownership</h4>
      <p style="margin:0; font-size:14px; line-height:1.5; color:#c9d1d9;">
        End-to-end architecture & administration: architected an encrypted Zero-Trust WireGuard mesh overlay, orchestrated container stacks via Docker Compose, automated storage tiers, and deployed continuous port and service telemetry via <strong>PortTracker</strong>.
      </p>
    </div>
    <div>
      <h4 style="color:#a855f7; margin:0 0 8px 0; font-size:15px;">📈 Business Impact & Measurable Outcome</h4>
      <p style="margin:0; font-size:14px; line-height:1.5; color:#c9d1d9;">
        <strong>Zero public inbound open ports</strong> (total attack surface reduction), 99.9% uptime across 30+ services, proactive port conflict prevention, and complete on-premises data sovereignty for self-hosted AI models.
      </p>
    </div>
  </div>
</div>

### 📸 Visual Verification & Live Telemetry

> **Centralized Infrastructure Telemetry:** The live dashboard view below from the active monitoring tool (*PortTracker*) shows the production host status for `orion-o6`. It gives real-time visibility into container health, system resource utilization (12 CPU cores, 28 GB RAM), and active service registrations across isolated networks.

![PortTracker Homelab Dashboard](./image.png)

<div style="background:#0d1117; color:#c9d1d9; padding:20px; border-radius:10px; font-family:monospace; border:1px solid #30363d; margin-top:20px; margin-bottom:28px;">
  <div style="display:flex; align-items:center; justify-content:space-between; border-bottom:1px solid #30363d; padding-bottom:12px; margin-bottom:14px;">
    <div style="display:flex; align-items:center; gap:10px;">
      <span style="font-size:20px;">🖥️</span>
      <strong style="color:#58a6ff; font-size:16px;">orion-o6 & Cluster Telemetry</strong>
    </div>
    <span style="color:#3fb950; font-size:12px; font-weight:bold;">● 24/7 Production Node</span>
  </div>
  <div style="display:grid; grid-template-columns:repeat(4,1fr); gap:12px;">
    <div style="background:#161b22; border:1px solid #30363d; border-radius:6px; padding:10px;">
      <div style="color:#8b949e; font-size:10px; text-transform:uppercase;">Host System</div>
      <div style="color:#e6edf3; font-size:13px; font-weight:600;">Debian 12 (12 Cores / 28 GB)</div>
    </div>
    <div style="background:#161b22; border:1px solid #30363d; border-radius:6px; padding:10px;">
      <div style="color:#8b949e; font-size:10px; text-transform:uppercase;">GPU Compute Node</div>
      <div style="color:#a855f7; font-size:13px; font-weight:600;">9-GPU Cluster (50+ GB VRAM)</div>
    </div>
    <div style="background:#161b22; border:1px solid #30363d; border-radius:6px; padding:10px;">
      <div style="color:#8b949e; font-size:10px; text-transform:uppercase;">Active Containers</div>
      <div style="color:#58a6ff; font-size:13px; font-weight:600;">30+ Running Services</div>
    </div>
    <div style="background:#161b22; border:1px solid #30363d; border-radius:6px; padding:10px;">
      <div style="color:#8b949e; font-size:10px; text-transform:uppercase;">Mesh Network</div>
      <div style="color:#e6edf3; font-size:13px; font-weight:600;">Tailscale Zero-Trust (20 Nodes)</div>
    </div>
  </div>
</div>

---

## ⚙️ In-Depth Technical Architecture (For Tech Leads & Engineers)

### 🔒 1. Zero-Trust Mesh & Network Security (Tailscale / WireGuard)

Rather than opening vulnerable public inbound ports on residential firewalls or relying on unencrypted dynamic DNS, the infrastructure operates a **Zero-Trust Network Access (ZTNA)** topology powered by **Tailscale (WireGuard)**.

{{< mermaid >}}
graph TD
    subgraph ClientTier ["Client Tier: Authenticated Remote Endpoints"]
        DevPC["Engineering Workstations & Laptops"]
        Mobile["Mobile Devices (iOS / Android)"]
    end

    subgraph Tailnet ["Zero-Trust Encrypted WireGuard Mesh"]
        Router1["orion-o6 (Primary Node)<br>Subnet Router & Dedicated Exit Node"]
        Router2["Secondary Redundant Node<br>Failover Subnet Router"]
        GPUCluster["ubunt (Dedicated Compute Node)<br>⚡ 9-GPU LLM Inference Cluster<br>50+ GB VRAM / llama.cpp Server"]
    end

    subgraph InternalApps ["Internal Applications & Services (orion-o6)"]
        NginxProxy["Nginx / Traefik Reverse Proxy & TLS"]
        Containers["Docker Bridge Networks (Isolated Stacks)<br>• AI Workloads: LibreChat, Open-WebUI<br>• RAG Pipeline: rag_api, pgvector, Meilisearch<br>• Media & ML: Immich Server & ML VectorChord<br>• Ingestion & Workflows: n8n, Event Workers, Jellyfin<br>• Databases: PostgreSQL 16 & 17, Redis, Valkey"]
        Monitoring["PortTracker Telemetry"]
    end

    DevPC -->|"Encrypted WireGuard Peer-to-Peer Tunnel"| Router1
    Mobile -->|"Encrypted WireGuard Peer-to-Peer Tunnel"| Router1
    DevPC -.-> Router2

    Router1 --> NginxProxy
    NginxProxy --> Containers
    Containers --> Monitoring

    %% Private communication between AI frontends and 9-GPU cluster
    Containers <-->|"Private High-Speed Mesh Interconnect<br>(OpenAI-Compatible REST API)"| GPUCluster

    style Router1 fill:#1e3a8a,stroke:#3b82f6,stroke-width:2px,color:#fff
    style Router2 fill:#1e3a8a,stroke:#3b82f6,stroke-width:2px,color:#fff
    style GPUCluster fill:#581c87,stroke:#a855f7,stroke-width:2px,color:#fff
    style Containers fill:#1e293b,stroke:#475569,color:#fff
{{< /mermaid >}}

#### Core Network & Security Principles:
- **Cross-Platform 20-Node Tailnet:** Encrypted mesh connects **20 active endpoints** across heterogeneous environments: Debian server hosts, dedicated GPU nodes, Windows developer PCs, and mobile devices via interactive STUN/ICE NAT traversal without public static IPs.
- **Subnet Routing & Exit Node Capabilities:** `orion-o6` broadcasts private subnet routes, allowing authorized remote clients to access container subnets directly without individual container VPN agents. In addition, the node functions as a hardened Exit Node for encrypted egress when on untrusted public networks.
- **Granular Access Control Policies (ACLs) & Least Privilege:** Declarative ACLs strictly restrict user and machine tags to specific destination services and ports. Administrative control interfaces (SSH, databases, backend management APIs) are restricted exclusively to authenticated management devices, preventing lateral movement.
- **Zero Inbound Port Exposure:** The WAN perimeter maintains **0 open forwarded ports** to the public internet. All traffic is authenticated and verified end-to-end at the cryptographic layer.

---

### ⚡ 2. Distributed 9-GPU LLM Inference Cluster (`ubunt`)

A high-performance pillar of the network is a dedicated bare-metal Linux compute node (`ubunt`), engineered as a **distributed 9-GPU LLM inference cluster**:

- **Hardware & VRAM Pooling:** Combines **9 discrete GPUs delivering an aggregate pool of over 50 GB VRAM**.
- **Local Large-Model Hosting:** Designed to run heavy quantized models (LLaMA-3 70B, Qwen 72B, Mixtral 8x22B) offloaded across GPU memory without falling back to slow CPU system RAM.
- **High-Throughput Runtime:** Powered by **llama.cpp** server using GPU tensor and layer splitting to maximize memory bandwidth and tokens-per-second generation rates.
- **Seamless Mesh Integration:** The cluster communicates privately across the Tailscale mesh to `orion-o6`, exposing OpenAI-compatible endpoints directly to internal AI clients (**LibreChat**, **Open-WebUI**, and the **RAG API** pipeline with `pgvector` and `Meilisearch`).
- **Complete Data Sovereignty:** Zero proprietary cloud API dependencies; enterprise-grade intelligence running entirely within a private, self-hosted perimeter.

---

### 📦 3. Containerized Service Ecosystem (30+ Services on `orion-o6`)

Every workload on `orion-o6` is containerized, isolated into custom Docker bridge networks, and monitored continuously:

| Domain | Key Container Services | Architecture & Purpose |
| :--- | :--- | :--- |
| **AI & LLM Workloads** | `LibreChat`, `open-webui`, `rag_api`, `pgvector`, `chat-mongodb`, `chat-meilisearch` | Private AI assistant interfaces, retrieval-augmented generation (RAG) pipelines, and vector database embeddings connected to the 9-GPU inference node. |
| **Media & ML Pipeline** | `immich_server`, `immich_machine_learning`, `immich_postgres` (VectorChord), `immich_redis` | High-performance self-hosted photo library with local ML facial recognition and vector-based semantic image search. |
| **Automated Ingestion & Media Pipeline** | `jellyfin`, `n8n`, `storage-worker` | Asynchronous media streaming and pipeline architecture with event-driven execution and optimized cache tiers. |
| **Databases & Caching** | `postgres:16-alpine`, `postgres:17`, `redis:7-alpine`, `valkey:9-alpine` | High-availability persistent relational storage, caching tiers, and session backends. |
| **Automation & Workflows** | `n8n`, `changedetection`, `browserless/chrome`, `searxng-core` | Automated webhook workflows, headless browser rendering, and private data ingestion. |
| **System & Telemetry** | `portracker`, `webtop`, `debian_web_stream`, `librespeed`, `wealthfolio` | Real-time container and port telemetry, secure web-based browser streaming, and system performance diagnostics. |

---

### 🔍 4. Centralized Telemetry & Conflict Prevention (PortTracker)

To continuously monitor all 30+ services across segregated Docker stacks, `orion-o6` runs **PortTracker**:
- **Port Conflict Detection & Allocation Auditing:** Tracks service bindings across independent Docker Compose stacks (`media-pipeline`, `telemetry-stack`, `librechat`, `sitetrack`) to proactively detect collisions.
- **Health Checks & Lifecycle Status:** Instant detection of container degradation, resource bottlenecks, or restart loops.
- **Private Interface Binding:** Verifies that all internal services bind strictly to isolated local container subnets and private mesh interfaces rather than public wildcard addresses.

---

### 💡 Why This Matters for Cloud & Security Roles

Operating this production infrastructure provides daily, hands-on mastery of enterprise requirements:
- **Zero-Trust Network Defense:** Implementing WireGuard mesh networking, least-privilege ACL rules, and zero-inbound-port architectures.
- **Advanced Compute & AI Infrastructure:** Deploying and operating multi-GPU clusters, VRAM pooling, and tensor-parallel inference pipelines.
- **Reliability & System Observability:** Maintaining 24/7 uptime across multi-tier applications, persistent storage volumes, and automated telemetry.
