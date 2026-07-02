---
title: "Homelab (orion-o6)"
---

<div style="background:#1e1e2f; color:#fff; padding:20px; border-radius:12px; font-family:monospace; margin-bottom: 30px;">
  <h3 style="color:#00d4ff; margin-top: 0;">🖥️ orion‑o6 – Homelab Dashboard</h3>
  <div style="display:grid; grid-template-columns:1fr 1fr 1fr; gap:10px;">
    <div>CPU: 12 cores</div>
    <div>RAM: 28.57 GB</div>
    <div>Containers: 30 running / 102 total</div>
  </div>
  <table style="width:100%; color:#ccc; margin-top:15px; border-collapse: collapse;">
    <tr style="text-align: left; border-bottom: 1px solid #333;">
      <th style="padding-bottom: 10px;">Service</th>
      <th style="padding-bottom: 10px;">Port</th>
      <th style="padding-bottom: 10px;">Status</th>
    </tr>
    <tr><td style="padding: 5px 0;">Jellyfin</td><td>1900</td><td>🟢 Running</td></tr>
    <tr><td style="padding: 5px 0;">Immich</td><td>2283</td><td>🟢 Running</td></tr>
    <tr><td style="padding: 5px 0;">LibreChat</td><td>3080</td><td>🟢 Running</td></tr>
    <tr><td style="padding: 5px 0;">Debian Web Stream</td><td>4111</td><td>🟢 Running</td></tr>
    <tr><td style="padding: 5px 0;">Portracker</td><td>4999</td><td>🟢 Running</td></tr>
    <tr><td style="padding: 5px 0;">Questarr App</td><td>5000</td><td>🟢 Running</td></tr>
    <tr><td style="padding: 5px 0;">Jellyseerr</td><td>5055</td><td>🟢 Running</td></tr>
    <tr><td style="padding: 5px 0;">Questarr DB</td><td>5432</td><td>🟢 Running</td></tr>
  </table>
</div>

## Key Services
- **Jellyfin** (port 1900) – media server
- **Immich** (port 2283) – photo management
- **LibreChat** (port 3080) – AI chat
- **PortTracker** (port 4999) – custom monitoring app
- **Questarr** (arr stack) – media automation

## Why it matters
Demonstrates real‑world experience with Docker, networking, and system administration.
