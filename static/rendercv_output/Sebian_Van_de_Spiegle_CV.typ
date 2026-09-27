// Import the rendercv function and all the refactored components
#import "@preview/rendercv:0.3.0": *

// Apply the rendercv template with custom configuration
#show: rendercv.with(
  name: "Sebian Van de Spiegle",
  title: "Sebian Van de Spiegle - CV",
  footer: context { [#emph[Sebian Van de Spiegle -- #str(here().page())\/#str(counter(page).final().first())]] },
  top-note: [ #emph[Laatst bijgewerkt Sep 2026] ],
  locale-catalog-language: "nl",
  text-direction: ltr,
  page-size: "us-letter",
  page-top-margin: 0.7in,
  page-bottom-margin: 0.7in,
  page-left-margin: 0.7in,
  page-right-margin: 0.7in,
  page-show-footer: false,
  page-show-top-note: true,
  colors-body: rgb(0, 0, 0),
  colors-name: rgb(0, 0, 0),
  colors-headline: rgb(0, 0, 0),
  colors-connections: rgb(0, 0, 0),
  colors-section-titles: rgb(0, 0, 0),
  colors-links: rgb(0, 0, 0),
  colors-footer: rgb(128, 128, 128),
  colors-top-note: rgb(128, 128, 128),
  typography-line-spacing: 0.6em,
  typography-alignment: "justified",
  typography-date-and-location-column-alignment: right,
  typography-font-family-body: "XCharter",
  typography-font-family-name: "XCharter",
  typography-font-family-headline: "XCharter",
  typography-font-family-connections: "XCharter",
  typography-font-family-section-titles: "XCharter",
  typography-font-size-body: 10pt,
  typography-font-size-name: 25pt,
  typography-font-size-headline: 10pt,
  typography-font-size-connections: 10pt,
  typography-font-size-section-titles: 1.2em,
  typography-small-caps-name: false,
  typography-small-caps-headline: false,
  typography-small-caps-connections: false,
  typography-small-caps-section-titles: false,
  typography-bold-name: false,
  typography-bold-headline: false,
  typography-bold-connections: false,
  typography-bold-section-titles: true,
  links-underline: true,
  links-show-external-link-icon: false,
  header-alignment: center,
  header-photo-width: 3.5cm,
  header-space-below-name: 0.7cm,
  header-space-below-headline: 0.7cm,
  header-space-below-connections: 0.7cm,
  header-connections-hyperlink: true,
  header-connections-show-icons: false,
  header-connections-display-urls-instead-of-usernames: true,
  header-connections-separator: "|",
  header-connections-space-between-connections: 0.5cm,
  section-titles-type: "with_full_line",
  section-titles-line-thickness: 0.5pt,
  section-titles-space-above: 0.5cm,
  section-titles-space-below: 0.3cm,
  sections-allow-page-break: true,
  sections-space-between-text-based-entries: 0.15cm,
  sections-space-between-regular-entries: 0.42cm,
  entries-date-and-location-width: 4.15cm,
  entries-side-space: 0cm,
  entries-space-between-columns: 0.1cm,
  entries-allow-page-break: false,
  entries-short-second-row: false,
  entries-degree-width: 1cm,
  entries-summary-space-left: 0cm,
  entries-summary-space-above: 0.08cm,
  entries-highlights-bullet:  text(13pt, [•], baseline: -0.6pt) ,
  entries-highlights-nested-bullet:  text(13pt, [•], baseline: -0.6pt) ,
  entries-highlights-space-left: 0cm,
  entries-highlights-space-above: 0.08cm,
  entries-highlights-space-between-items: 0.08cm,
  entries-highlights-space-between-bullet-and-text: 0.3em,
  date: datetime(
    year: 2026,
    month: 9,
    day: 27,
  ),
)


= Sebian Van de Spiegle

  #headline([Kandidaat Stage: Vulnerability Management Engineer | Cegeka Modern SOC])

#connections(
  [Regio Landen \/ Geraardsbergen, België],
  [#link("mailto:sebian.vandespiegle@student.odisee.be", icon: false, if-underline: false, if-color: false)[sebian.vandespiegle\@student.odisee.be]],
  [#link("tel:+32-468-43-93-10", icon: false, if-underline: false, if-color: false)[0468 43 93 10]],
  [#link("https://sebian-lab.github.io/", icon: false, if-underline: false, if-color: false)[sebian-lab.github.io]],
  [#link("https://github.com/sebian-lab", icon: false, if-underline: false, if-color: false)[github.com\/sebian-lab]],
  [#link("https://linkedin.com/in/sebian-van-de-spiegle-72620528a", icon: false, if-underline: false, if-color: false)[linkedin.com\/in\/sebian-van-de-spiegle-72620528a]],
)


== Profiel

- Ik ben een bachelorstudent Toegepaste Informatica (Hogeschool Odisee, voorheen HOGENT) en (ISC)² Candidate. Mijn passie ligt bij defensieve cybersecurity: ik wil niet alleen weten hoe iets werkt, maar ook hoe je het veilig en veerkrachtig maakt.

- In mijn vrije tijd bouw en beheer ik een professionele homelab met 30+ containers, Zero-Trust netwerktoegang via Tailscale\/WireGuard en eigen monitoring. Daardoor heb ik hands-on ervaring met Linux, Docker, PostgreSQL, SQL, Power BI en het automatiseren van beveiligingsprocessen.

- Ik werk graag gestructureerd in Scrum\/Kanban en communiceer open over voortgang en uitdagingen. Bij Cegeka wil ik mij graag verdiepen in vulnerability management, health check scenario's en het bouwen van rapportages en dashboards die het SOC echt vooruithelpen.

== Opleiding

#education-entry(
  [
    #strong[Hogeschool Odisee], Professionele Bachelor in Toegepaste Informatica (Cloud Computing & Security) -- Brussel, België

  ],
  [
    Jan 2026 – Jun 2027

  ],
  main-column-second-row: [
    - Focus op Cloud Computing (Azure, AKS), Protocol- & Pakketanalyse (Wireshark), Hybride Datacenters (VMware ESXi 8.0) en Infrastructure as Code.

    - Ik koos voor deze richting omdat ik security niet als losstaand iets wil zien, maar als onderdeel van de hele infrastructuur.

  ],
)

#education-entry(
  [
    #strong[HOGENT], Professionele Bachelor in Toegepaste Informatica -- Gent, België

  ],
  [
    Sep 2023 – Jan 2026

  ],
  main-column-second-row: [
    - Data-analyse & Dashboard Project (Jan 2025 – Jun 2025): Gegevens geëxtraheerd uit PDF-bronnen, gemodelleerd en geanalyseerd via SQL (elektriciteitssector BE) en omgezet naar interactieve Power BI overzichten; samengewerkt in een Scrum\/Kanban team van 4 met Jira.

    - Fundament in software engineering, relationele databases & SQL, Linux-systeembeheer en computernetwerken.

  ],
)

== Technische Vaardigheden

#strong[Cybersecurity & Kwetsbaarheidsbeheer:] Vulnerability Scanning (Trivy), Secret Detection (Gitleaks), Statische Code-analyse (Bandit SAST), Zero-Trust (ZTNA, Tailscale WireGuard Mesh, ACL's), Protocolanalyse (Wireshark), Secrets Management (geen plain-text credentials in git).

#strong[Databases, SQL & Dashboarding:] SQL (data-extractie, relationele datamodellering, complexe queries), Power BI (interactieve overzichten & KPI-dashboards), PostgreSQL (16 & 17), Redis.

#strong[Netwerkinspectie & Monitoring:] Poort- & Container-monitoring (o.a. PortTracker, Docker inspect), netwerkinspectie (Wireshark), loganalyse, Prometheus, Grafana, Docker container-status.

#strong[Cloud & Datacenter:] Microsoft Azure (VNets, Subnets, ACI), VMware ESXi 8.0 (vSwitch, Virtual Machines), Windows Server 2022 (Active Directory Domain Services, DNS), Linux (Debian 12, Ubuntu), Docker & Docker Compose.

#strong[Automatisering & CI\/CD:] GitHub Actions CI\/CD (geautomatiseerde tests, linting, build-validatie), Python (FastAPI, scripting), Infrastructure as Code (ARM Templates), Git, Bash, PowerShell.

== Projecten & Praktijkervaring

#regular-entry(
  [
    #strong[#link("https://github.com/sebian-lab/alphatracer-financial-api")[AlphaTracer Financial API — Backend & DevSecOps Pipeline]] -- #strong[Zelfstandig Project]

  ],
  [
    Jan 2026 – heden

  ],
  main-column-second-row: [
    #summary[Een zelfstandig softwareproject waarin ik een financiële API bouwde met FastAPI en PostgreSQL. Ik wilde van bij het begin security en automatisering serieus nemen.]

    - DevSecOps & Shift-Left Security: Geautomatiseerde secret scanning via Gitleaks, Python SAST-beveiligingscontroles met Bandit en container CVE-scanning via Trivy in pre-commit en GitHub Actions.

    - Veilige Configuratie & Monitoring: Volledige uitsluiting van plain-text credentials uit git via runtime injectie; basis telemetrie-export via Prometheus en Grafana.

  ],
)

#regular-entry(
  [
    #strong[#link("https://github.com/sebian-lab/alphatracer-mobile")[AlphaTracer Mobile — Financiële Android App]] -- #strong[Academisch Semesterproject]

  ],
  [
    Jan 2026 – Jun 2026

  ],
  main-column-second-row: [
    #summary[Academisch semesterproject; native Android app voor portfoliobeheer met focus op veilige dataopslag en encryptie.]

    - Architectuur & API-integratie: Native Android-applicatie in Kotlin (MVVM, Jetpack Compose) met veilige REST-communicatie via Retrofit.

    - Mobiele Beveiliging: Implementatie van biometrische authenticatie (BiometricPrompt API) en veilige opslag van tokens via EncryptedSharedPreferences.

  ],
)

#regular-entry(
  [
    #strong[#link("https://sebian-lab.github.io/projects/homelab/")[Homelab & Zero-Trust Tailscale Mesh — orion-o6]] -- #strong[Zelfstandig Project]

  ],
  [
    Jan 2024 – heden

  ],
  main-column-second-row: [
    #summary[Mijn homelab is mijn leeromgeving: een private labomgeving met 30+ containers, multi-GPU hardware en 20 Tailnet endpoints. Ik beheer alles zelf en probeer enterprise-principes toe te passen.]

    - Zero-Trust Architectuur: Geen open poorten op het internet; end-to-end versleutelde WireGuard mesh met Tailscale ACL's en subnet routing. Toegang via strikte verificatie (Google-account).

    - Service- & Containerbeheer: Beheer van 30+ Docker-containers en PostgreSQL-databases; implementatie van PortTracker voor realtime inzicht in actieve services, attack surface en poortallocaties binnen de private infrastructuur.

  ],
)

#regular-entry(
  [
    #strong[#link("https://sebian-lab.github.io/projects/infrastructure/")[Enterprise Cloud & Datacenter Virtualisation Labs]] -- #strong[Odisee Hogeschool]

  ],
  [
    Jan 2026 – Jun 2026

  ],
  main-column-second-row: [
    #summary[Academisch project (Jan 2026 – Jun 2026); enterprise-infrastructuur met Microsoft Azure en VMware ESXi 8.0. Ik heb hier geleerd hoe cloud en datacenter samenkomen.]

    - Azure Cloud Segregatie & IaC: Gesegmenteerde VNets met basis NSG-configuratie, AKS Kubernetes en geautomatiseerde uitrol via ARM Templates.

    - Enterprise Identity & Datacenter: Opzet van VMware ESXi 8.0 hypervisor met vSwitch0 en configuratie van een Windows Server 2022 Primary Domain Controller met AD DS, DNS en Kerberos.

  ],
)

== Certificaten

#regular-entry(
  [
    #strong[#link("https://www.credly.com/badges/182b7df3-0eed-480b-81dd-3966bd800728")[(ISC)² Candidate]]

  ],
  [
    2026

  ],
  main-column-second-row: [
    #summary[Uitgegeven door (ISC)² (International Information System Security Certification Consortium)]

    - Officiële verificatie via Credly; gecommitteerd aan de (ISC)² Code of Ethics en actief in voorbereiding op verdiepende cybersecurity-certificeringen.

  ],
)

== Competenties

#strong[Methodieken & Samenwerking:] Scrum, Kanban, Jira, Incident- & Wijzigingsbeheer, Agile sprintplanning, Git-flow, gestructureerde communicatie.

#strong[Talenkennis:] Nederlands (Moedertaal), Engels (Vloeiend in woord en geschrift).

== Interesses & Passies

#strong[Vulnerability Research & Threat Hunting:] Proactief kwetsbaarheden onderzoeken, analyse van CVE-bulletins en hardening van enterprise-services.

#strong[Homelabbing & Self-Hosting:] 24\/7 private infrastructuur beheren, container-orkestratie, Zero-Trust netwerkarchitecturen en telemetrie.

#strong[AI & Lokale LLM Inference:] Bare-metal hardware, multi-GPU VRAM-pooling en lokale inferentie via open-source modellen (llama.cpp).
