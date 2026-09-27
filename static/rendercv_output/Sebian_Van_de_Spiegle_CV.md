# Sebian Van de Spiegle's CV

- Phone: +32 468 43 93 10
- Email: [sebian.vandespiegle@student.odisee.be](mailto:sebian.vandespiegle@student.odisee.be)
- Location: Regio Landen / Geraardsbergen, België
- Website: [sebian-lab.github.io](https://sebian-lab.github.io/)
- GitHub: [sebian-lab](https://github.com/sebian-lab)
- LinkedIn: [sebian-van-de-spiegle-72620528a](https://linkedin.com/in/sebian-van-de-spiegle-72620528a)


# Profiel
- Ik ben een bachelorstudent Toegepaste Informatica (Hogeschool Odisee, voorheen HOGENT) en (ISC)² Candidate. Mijn passie ligt bij defensieve cybersecurity: ik wil niet alleen weten hoe iets werkt, maar ook hoe je het veilig en veerkrachtig maakt.

- In mijn vrije tijd bouw en beheer ik een professionele homelab met 30+ containers, Zero-Trust netwerktoegang via Tailscale/WireGuard en eigen monitoring. Daardoor heb ik hands-on ervaring met Linux, Docker, PostgreSQL, SQL, Power BI en het automatiseren van beveiligingsprocessen.

- Ik werk graag gestructureerd in Scrum/Kanban en communiceer open over voortgang en uitdagingen. Bij Cegeka wil ik mij graag verdiepen in vulnerability management, health check scenario's en het bouwen van rapportages en dashboards die het SOC echt vooruithelpen.

# Opleiding
## **Hogeschool Odisee**, Professionele Bachelor in Toegepaste Informatica (Cloud Computing & Security) -- Brussel, België
Jan 2026 – Jun 2027

- Focus op Cloud Computing (Azure, AKS), Protocol- & Pakketanalyse (Wireshark), Hybride Datacenters (VMware ESXi 8.0) en Infrastructure as Code.

- Ik koos voor deze richting omdat ik security niet als losstaand iets wil zien, maar als onderdeel van de hele infrastructuur.



## **HOGENT**, Professionele Bachelor in Toegepaste Informatica -- Gent, België
Sep 2023 – Jan 2026

- Data-analyse & Dashboard Project (Jan 2025 – Jun 2025): Gegevens geëxtraheerd uit PDF-bronnen, gemodelleerd en geanalyseerd via SQL (elektriciteitssector BE) en omgezet naar interactieve Power BI overzichten; samengewerkt in een Scrum/Kanban team van 4 met Jira.

- Fundament in software engineering, relationele databases & SQL, Linux-systeembeheer en computernetwerken.



# Technische Vaardigheden
**Cybersecurity & Kwetsbaarheidsbeheer:** Vulnerability Scanning (Trivy), Secret Detection (Gitleaks), Statische Code-analyse (Bandit SAST), Zero-Trust (ZTNA, Tailscale WireGuard Mesh, ACL's), Protocolanalyse (Wireshark), Secrets Management (geen plain-text credentials in git).

**Databases, SQL & Dashboarding:** SQL (data-extractie, relationele datamodellering, complexe queries), Power BI (interactieve overzichten & KPI-dashboards), PostgreSQL (16 & 17), Redis.

**Netwerkinspectie & Monitoring:** Poort- & Container-monitoring (o.a. PortTracker, Docker inspect), netwerkinspectie (Wireshark), loganalyse, Prometheus, Grafana, Docker container-status.

**Cloud & Datacenter:** Microsoft Azure (VNets, Subnets, ACI), VMware ESXi 8.0 (vSwitch, Virtual Machines), Windows Server 2022 (Active Directory Domain Services, DNS), Linux (Debian 12, Ubuntu), Docker & Docker Compose.

**Automatisering & CI/CD:** GitHub Actions CI/CD (geautomatiseerde tests, linting, build-validatie), Python (FastAPI, scripting), Infrastructure as Code (ARM Templates), Git, Bash, PowerShell.

# Projecten & Praktijkervaring
## **[AlphaTracer Financial API — Backend & DevSecOps Pipeline](https://github.com/sebian-lab/alphatracer-financial-api)** -- **Zelfstandig Project**

Jan 2026 – heden

Een zelfstandig softwareproject waarin ik een financiële API bouwde met FastAPI en PostgreSQL. Ik wilde van bij het begin security en automatisering serieus nemen.

- DevSecOps & Shift-Left Security: Geautomatiseerde secret scanning via Gitleaks, Python SAST-beveiligingscontroles met Bandit en container CVE-scanning via Trivy in pre-commit en GitHub Actions.

- Veilige Configuratie & Monitoring: Volledige uitsluiting van plain-text credentials uit git via runtime injectie; basis telemetrie-export via Prometheus en Grafana.



## **[AlphaTracer Mobile — Financiële Android App](https://github.com/sebian-lab/alphatracer-mobile)** -- **Academisch Semesterproject**

Jan 2026 – Jun 2026

Academisch semesterproject; native Android app voor portfoliobeheer met focus op veilige dataopslag en encryptie.

- Architectuur & API-integratie: Native Android-applicatie in Kotlin (MVVM, Jetpack Compose) met veilige REST-communicatie via Retrofit.

- Mobiele Beveiliging: Implementatie van biometrische authenticatie (BiometricPrompt API) en veilige opslag van tokens via EncryptedSharedPreferences.



## **[Homelab & Zero-Trust Tailscale Mesh — orion-o6](https://sebian-lab.github.io/projects/homelab/)** -- **Zelfstandig Project**

Jan 2024 – heden

Mijn homelab is mijn leeromgeving: een private labomgeving met 30+ containers, multi-GPU hardware en 20 Tailnet endpoints. Ik beheer alles zelf en probeer enterprise-principes toe te passen.

- Zero-Trust Architectuur: Geen open poorten op het internet; end-to-end versleutelde WireGuard mesh met Tailscale ACL's en subnet routing. Toegang via strikte verificatie (Google-account).

- Service- & Containerbeheer: Beheer van 30+ Docker-containers en PostgreSQL-databases; implementatie van PortTracker voor realtime inzicht in actieve services, attack surface en poortallocaties binnen de private infrastructuur.



## **[Enterprise Cloud & Datacenter Virtualisation Labs](https://sebian-lab.github.io/projects/infrastructure/)** -- **Odisee Hogeschool**

Jan 2026 – Jun 2026

Academisch project (Jan 2026 – Jun 2026); enterprise-infrastructuur met Microsoft Azure en VMware ESXi 8.0. Ik heb hier geleerd hoe cloud en datacenter samenkomen.

- Azure Cloud Segregatie & IaC: Gesegmenteerde VNets met basis NSG-configuratie, AKS Kubernetes en geautomatiseerde uitrol via ARM Templates.

- Enterprise Identity & Datacenter: Opzet van VMware ESXi 8.0 hypervisor met vSwitch0 en configuratie van een Windows Server 2022 Primary Domain Controller met AD DS, DNS en Kerberos.



# Certificaten
## **[(ISC)² Candidate](https://www.credly.com/badges/182b7df3-0eed-480b-81dd-3966bd800728)**

2026

Uitgegeven door (ISC)² (International Information System Security Certification Consortium)

- Officiële verificatie via Credly; gecommitteerd aan de (ISC)² Code of Ethics en actief in voorbereiding op verdiepende cybersecurity-certificeringen.



# Competenties
**Methodieken & Samenwerking:** Scrum, Kanban, Jira, Incident- & Wijzigingsbeheer, Agile sprintplanning, Git-flow, gestructureerde communicatie.

**Talenkennis:** Nederlands (Moedertaal), Engels (Vloeiend in woord en geschrift).

# Interesses & Passies
**Vulnerability Research & Threat Hunting:** Proactief kwetsbaarheden onderzoeken, analyse van CVE-bulletins en hardening van enterprise-services.

**Homelabbing & Self-Hosting:** 24/7 private infrastructuur beheren, container-orkestratie, Zero-Trust netwerkarchitecturen en telemetrie.

**AI & Lokale LLM Inference:** Bare-metal hardware, multi-GPU VRAM-pooling en lokale inferentie via open-source modellen (llama.cpp).
