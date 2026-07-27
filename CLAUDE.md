# CLAUDE.md — Timothy Olubiyi | Professional Portfolio & Blog

## Project Overview
Build a modern, responsive **React portfolio + blog website** for Timothy Olubiyi — IT Project Manager, Cloud/DevOps Engineer & Cybersecurity Specialist. The site showcases his professional profile, career history, certifications, projects, and a blog, backed by a lightweight backend so content can be updated/versioned after launch without a full redeploy.

**Deployment target:** Static HTML/CSS portfolio website deployed to AWS using S3 and CloudFront, provisioned with Terraform, and automated via GitHub Actions.

Real resume, certification, and career data has been supplied (see below) — use this actual content, not placeholders, when building the site. Where a link or asset hasn't been supplied yet (Medium, X/Twitter, company websites), leave a clearly marked `[EDIT: add link]` placeholder in the Links section below.


# Project Overview

This project deploys a React portfolio website using a fully serverless Infrastructure as Code (IaC) approach.

Architecture:

React Application
↓
GitHub Repository
↓
GitHub Actions
↓
Terraform
↓
Amazon S3 (Private Bucket)
↓
CloudFront
↓
AWS Certificate Manager (ACM)
↓
Domain (Route 53 or External DNS)

This project intentionally does **not** use:

- EC2
- Nginx
- Application Load Balancer
- RDS
- Manual production deployments

GitHub Actions is responsible for automating infrastructure deployment and application delivery after code is pushed to the approved production branch.

---

# Deployment Workflow

Always follow this sequence:

1. Read project configuration
2. Validate Terraform
3. Validate React application
4. Review GitHub Actions workflow
5. Generate Terraform execution plan
6. Human reviews infrastructure changes
7. Human approves production deployment
8. GitHub Actions executes:
   - Terraform deployment
   - React build
   - Upload build artifacts to S3
   - CloudFront cache invalidation
9. Verify production website
10. Confirm deployment success

Never skip validation before deployment.

---

# GitHub Actions Responsibilities

The CI/CD pipeline is responsible for:

## Infrastructure

- Terraform Format
- Terraform Validate
- Terraform Plan
- Terraform Apply (after approval)

## Application

- Install Node.js dependencies
- Build React application
- Upload build files to Amazon S3
- Invalidate CloudFront cache
- Verify deployment success

All AWS credentials must be stored in GitHub Secrets.

Never store credentials inside the repository.

---

# Operational Safety Rules

Claude must never:

- Execute terraform apply
- Execute terraform destroy
- Push commits
- Merge pull requests
- Modify GitHub Actions workflows
- Delete AWS resources
- Modify DNS records
- Delete S3 buckets
- Delete CloudFront distributions
- Edit production infrastructure
- Edit Terraform state

Claude may:

- Validate Terraform
- Review infrastructure
- Review GitHub Actions
- Recommend deployment commands
- Explain Terraform plans
- Recommend verification commands

Production deployment always requires human approval.

---

# Security Requirements

Always verify:

- Private S3 bucket
- HTTPS enabled
- ACM certificate attached
- CloudFront Origin Access Control enabled
- Public access blocked
- Least privilege IAM permissions
- No hardcoded AWS credentials

Report any security violations before recommending deployment.

---

# Output Rules

When reviewing the project, always provide:

1. Architecture Summary
2. Terraform Validation Results
3. React Build Status
4. GitHub Actions Review
5. Infrastructure Security Review
6. Deployment Readiness
7. Recommended Deployment Commands
8. Production Verification Commands
9. Risks and Recommendations
10. Next Safe Action

Every recommendation must be supported by validation results.

Never assume a deployment is safe without evidence.


---

## Tech Stack
- **Frontend:** React (Vite) + Tailwind CSS
- **Routing:** React Router — needed now since this is a **multi-page site** (Home/Portfolio, Blog index, Blog post detail, Admin)
- **Icons:** lucide-react
- **Animations:** Framer Motion (subtle — fades/slide-ins on scroll)
- **Backend:** Node.js + Express REST API (see Backend section below) for profile content, projects, and blog post CRUD + versioning
- **Database:** PostgreSQL (or SQLite for a lighter single-server setup) — stores profile content, projects, blog posts, and a version history table
- **Web server:** Nginx — serves the built static frontend (`dist/`) and reverse-proxies `/api/*` to the Node backend (typically run via PM2 or a systemd service)
- **Images:** stored in an `/images` directory (see Images section below), served as static assets

---

## Site Structure / Sections

### Portfolio (Home)
1. **Hero** — Name, dual title (IT Project Manager / Cloud & DevOps Engineer / Cybersecurity Specialist), one-line value proposition, CTA buttons (View Projects / Read Blog / Contact / Download Resume)
2. **About** — Professional summary, core competencies grid (Networking, Project Management, Security & Compliance, Cloud & DevOps, CI/CD & Automation, Containerization, Monitoring & Ops)
3. **Experience** — Timeline: company, role, dates, highlight bullets (see Career Data below)
4. **Companies / Ventures** — Stackprime Consulting Ltd and Electric Gigs Technologies (see Companies section below), with CTAs for "Request a Consultation" (mailto:stackprimeconsulting@gmail.com) and the Cloud/Cybersecurity/DevOps Professional Training sign-up form
5. **Projects** — Cards pulling from Projects Success Highlights + Notion projects link
6. **Certifications** — Grid of certification badges/names grouped by category (Cybersecurity, Cloud & DevOps, Networking, Project Management)
7. **Education**
8. **Contact** — Email, phone, LinkedIn, GitHub, Notion, Medium, X, WhatsApp Community
9. **Footer** — Social links + copyright 

├── index.html          # Main portfolio page (hero, about, experience, companies / Ventures, Projects, Certifications, Education, Contact, Footer sections)
├── privacy.html        # Privacy policy page
├── terms.html          # Terms of service page
├── style.css           # All styling (responsive design, animations)
├── images/             # Portfolio assets
│   ├── stackprime-logo.png # Company logo
│   ├── Profile.png
│   ├── Electric-gigs-logo.png  # Company logo
│   └── other images
└── README.md           # Deployment guide for DevOps

### Blog
- Blog index page — list of posts (title, excerpt, date, cover image from `/images`)
- Blog post detail page — full content, rendered from backend-stored Markdown/HTML
- Posts are managed via the backend (create/edit/version) rather than hardcoded

### Admin (lightweight, authenticated)
- Simple protected route/page to update profile content, add/edit projects, and write/edit blog posts
- Every save creates a new version entry rather than overwriting history (see Backend section)

---

## Links (Markdown — fill in as provided)

```markdown
- **LinkedIn:** https://www.linkedin.com/in/timothy-olubiyi-05b9ba123/
- **GitHub:** https://github.com/Timothyolubiyi?tab=repositories
- **Notion (Projects/Resources):** https://www.notion.so/PROJECTS-1304dd074bcf808b902bd980fa961eba?source=copy_link
- **Medium:** https://medium.com/@timothyolubiyi
- **X (Twitter):** https://x.com/olubiyi_timothy
- **Email:** timothyolubiyi@gmail.com
- **Phone:** +234 814 440 1544
- **Stackprime Consulting Ltd (company website):** [EDIT: add link]
- **Electric Gigs Technologies (company website):** [EDIT: add link]
- **Consultation Request:** mailto:stackprimeconsulting@gmail.com
- **Cloud, Cybersecurity, DevOps Professional Training (sign-up form):** [Register here]( ) https://forms.gle/aPrJhXLNAtGPkJ31A
- **WhatsApp Community:** https://chat.whatsapp.com/JyqNhqVBnwg7x7uCtNDKtV
```

These should be pulled into a single `src/content/links.js` (or `.json`) file so every component (footer, contact section, nav) references the same source instead of hardcoding URLs in multiple places.

---

## Companies / Ventures
Include a dedicated section (on the About or a standalone "Ventures" section) for:
- **Stackprime Consulting Ltd** — [EDIT: add short description of the company/services once provided]. Website link per the Links section above. Include two CTAs:
  - **"Request a Consultation"** button → `mailto:stackprimeconsulting@gmail.com`
  - **"Cloud, Cybersecurity, DevOps Professional Training"** button → links to the sign-up form (see Links section — placeholder until form link is provided)
- **Electric Gigs Technologies** — [EDIT: add short description of the company/services once provided]. Website link per the Links section above (currently none supplied).
- **WhatsApp Community** — a "Join our Community" CTA linking to the WhatsApp group (see Links section) can sit alongside the above, either in this section or the Contact section/footer.

---

## Career Data (from resume — use as authoritative source content)

**Name:** Timothy Olubiyi (Olubiyi Timothy Oludare)
**Titles:** IT Project Manager | Cloud/DevOps Engineer | Cybersecurity Specialist | Senior DevSecOps & Cloud Infrastructure Engineer | Network Engineer 
**Location:** Lagos, Nigeria

### Professional Summary
Experienced IT Project Manager, DevOps (DevSecOps) Engineer and Cybersecurity Specialist with 9+ years across IT, telecommunications, cloud infrastructure, and cybersecurity. Track record leading end-to-end network deployments, migrations, and infrastructure optimization projects. Strong background in AWS, network engineering, cybersecurity, and automation (Terraform, Kubernetes, Docker, Ansible, Jenkins, ArgoCD, Workflow Automation). Skilled in DevSecOps practices, CI/CD pipeline security, vulnerability assessment and penetration testing (VAPT), and compliance with ISO/IEC 27001, PCI DSS, and NIST frameworks, and a seasoned Trainer.

### Core Competencies
- **Security & Compliance:** IAM, vulnerability management, incident response, ISO/IEC 27001/27032/31000, PCI DSS, NIST
- **AI Cybersecurity Workflow:** n8n, Docker Desktop, ngrok
- **Cloud & DevOps:** AWS (EC2, VPC, IAM, S3, RDS, Lambda, CloudFormation), Terraform, Ansible
- **CI/CD & Automation:** Jenkins, GitHub Actions, Python, AWS CodePipeline, GitLab CI/CD
- **Containerization & Orchestration:** Docker, Kubernetes, Amazon ECS/EKS, ArgoCD
- **Monitoring & Operations:** AWS CloudWatch, CloudTrail, Splunk, Wireshark, Nagios, UNMS, cnmaestro
- **Networking:** LAN/WAN, MPLS, VPN, Routing/Switching (Cisco, MikroTik, Ubiquiti, Cambium), PTP/PTMP wireless
- **Virtualization & Systems:** VMware, VirtualBox, Windows/Linux server administration
- **Project Management:** PMP, CPMP, technical reporting, team leadership

### Experience

**StackPrime Consulting Ltd** — Lagos, Nigeria 
*Founder & Chief Consultant* | Apr 2026 – Present
- Founded and lead a technology consulting and professional training firm specializing in cloud computing, DevOps engineering, cybersecurity, networking, and Linux server administration
- Design and deliver structured IT training programs, including Linux Server Administration curriculum, resulting in measurable skill acquisition for enrolled participants
- Develop and manage end-to-end training operations, including curriculum design, pricing strategy, marketing materials, and participant enrollment via digital channels
- Build and maintain the company's brand identity, including visual design, marketing collateral, and professional documentation aligned with industry standards
- Provide cloud computing, DevOps, cybersecurity, and networking consulting services to clients seeking to strengthen their IT infrastructure
- Oversee business development initiatives, including partnership proposals, service expansion, and go-to-market strategy for training and consulting offerings

**Sentient Network Limited** — Lagos, Nigeria
*Project Manager / Cybersecurity & IT Project Manager* | Mar 2025 – Mar 2026
- Managed end-to-end core network projects (design, implementation, deployment) achieving 100% SLA compliance
- Maintained 98% system availability across network management and IT infrastructure
- Led enterprise cybersecurity controls and data protection strategy, ensuring ISO/IEC 27001, PCI DSS, and NIST compliance
- Conducted VAPT, identifying and remediating critical security gaps
- Designed and deployed CI/CD pipelines with Jenkins and GitHub Actions, integrating automated security scanning
- Implemented Infrastructure as Code (Terraform, Ansible) for repeatable, auditable deployments
- Deployed and managed containerized workloads with Docker and Kubernetes
- Conducted comprehensive Vulnerability Assessments and Penetration Testing (VAPT), identifying critical security gaps and implementing remediation measures to strengthen overall security posture.
- Supervised IT team and external vendors; developed project plans, timelines, and budgets

**Tizeti Network Limited** — Lagos, Nigeria
*Network Operations Center Supervisor & Cybersecurity Specialist* | Oct 2018 – Mar 2025
- Engineered and deployed PTP/PTMP wireless network solutions, improving performance and reliability
- Maintained 99.9% service availability while resolving critical network and security incidents
- Proactively monitored infrastructure for vulnerabilities and threats; performed risk assessments on critical assets
- Increased infrastructure uptime and service availability from 78% to 96% through optimization initiatives
- Supervised NOC shift planning and team coordination
- Delivered security awareness training programs organization-wide
- Ensured compliance with ISO and PCI DSS standards

**Mastercard — Forage Cybersecurity Virtual Experience Program**
*Cybersecurity Analyst (Virtual Internship, remote)* | Sept 2024
- Applied risk assessment methodologies, threat analysis, and security awareness strategies in a simulated Security Analyst role
- Monitored and analyzed phishing campaigns and social engineering threats
- Developed targeted security awareness programs and policies

**Hagital Consulting** — Lagos, Nigeria
*Cybersecurity Internship (remote)* | Jun 2024 – Dec 2024
- Conducted network, workstation, server, API, and mobile application penetration testing
- Performed risk assessments and VAPT, following up on remediation of discovered vulnerabilities
- Applied ISO 27001, GDPR, HIPAA, and PCI DSS frameworks to safeguard network and business operations
- Used SIEM tools, Linux, Splunk, Pentest, HostedScan, Nmap, and Wireshark for vulnerability scanning

**First City Monument Bank (FCMB)** — Lagos, Nigeria
*IT Support Officer (Internship)* | Nov 2016 – May 2017
- Supported deployment, configuration, and maintenance of Asterisk IP PBX infrastructure across 250+ branch locations
- Monitored PBX servers, IVR servers, gateways, and IP phone systems for high availability
- Conducted remote monitoring of UPS systems and power equipment via secure VPN

### Projects Success Highlights
- Directed large-scale WAN/MPLS and VPN deployment and optimization for leading Nigerian financial institutions
- Led network optimization initiatives increasing infrastructure uptime from 78% to 96%
- Deployed Mikrowizard and Nagios monitoring platforms on Proxmox virtualized infrastructure
- Deployed broadband wireless service (PTP, PTMP) using Ubiquiti, MikroTik, Cambium, Airfibre radios
- Designed and built a cross-platform LAN/WLAN Scanner application in Python for automated network perimeter scanning and device discovery (Windows, macOS, Linux)
- Deployed a Jenkins CI/CD server on AWS using Terraform and Ansible (IaC, DevSecOps-compliant)
- Deployed NGINX infrastructure using Terraform for scalable, automated provisioning
- Implemented AI-enhanced cybersecurity workflow automation using n8n and Docker

*(Full project write-ups/case studies available via the Notion Projects link — see Links section.)*

### Education
**Higher National Diploma (HND), Electrical/Electronic Engineering Technology — Distinction** (2016)
Lagos State University of Science and Technology (formerly LASPOTECH), Lagos, Nigeria

### Certifications (group into categories on the Certifications page)
- **Cybersecurity:** ISC2 Certified in Cybersecurity (CC); ISC2 CCSP (Domains 1–6 + Conclusion); Splunk Security Operations and the Defense Analyst; EC-Council Ethical Hacking Essentials; ISO/IEC 27001:2022 ISMS Foundation; ISO/IEC 27032:2012 Cybersecurity Foundation; ISO 31000:2018 Risk Management Foundation; OPSWAT ICIP; CISA Cybersecurity Within IT and ICS Domains; MITRE ATT&CK Defender (MAD) Fundamentals (Cybrary); Hagital Consulting Certificate in Cybersecurity
- **Cloud & DevOps:** Aviatrix ACE — Multicloud Network Associate; AWS Cloud Infrastructure Solutions (CSN Bootcamp 2025); AWS Cloud Computing (CompTIA); LinkedIn Learning — Cloud Computing: Cloud Storage
- **Networking:** Cisco CCNA (Routing & Switching + Certificate of Completion); MikroTik MTCNA; Fortinet NSE 1/2; Advanced Cisco Networks and Wireless Communication Centre — CCNA
- **Project Management:** Chartered PMP (CIPM/PMI) — Postgraduate Diploma in Project Management; CPMP; Chartered Institute of Environmental Health and Safety (CIEHS) — Associate Membership
- **Other Training:** Udemy — Mastering Kali Linux for Ethical Hackers; Udemy — Windows Command Mastery for Ethical Hackers; Cisco Networking Academy — Introduction to Cybersecurity

### Technical Tools
Cloud & DevOps: AWS (EC2, VPC, S3, RDS, ECS, IAM, Lambda), Linux, Ubuntu, Terraform, Ansible, Jenkins, GitHub Actions, Docker, Kubernetes, ArgoCD, Python, IaC, n8n, ngrok
Security: SIEM, Splunk, Nessus, Acunetix, Qualys, Pentest, HostedScan, Burp Suite concepts
Networking & Monitoring: NAGIOS, UNMS, LibreNMS, cnMaestro, MikroTik, Cisco, Wireshark, Nmap, UISP Design
Productivity: Microsoft 365, Google Workspace, Slack, Jira, Microsoft Office Suite

---

## Images
- All portfolio and blog images live under an `/images` directory (e.g. `public/images/` in the Vite project, organized as `public/images/blog/`, `public/images/certifications/`, `public/images/projects/`).
- Reference images by relative path from this folder in both the frontend components and any blog post content stored in the backend.
- Certification badge images can be sourced from the uploaded certification PDFs (exported as image files) and placed in `public/images/certifications/`.

---

## Backend — Content & Versioning API

Purpose: allow Timothy to update profile info, add/edit projects, and publish/edit blog posts after the site is live, without redeploying the frontend, while keeping a version history of every change.

### Structure
- **Node.js + Express** REST API (`/api`)
- **Database:** PostgreSQL (recommended for a VPS/EC2 + Nginx setup) or SQLite for simplicity on a single small instance
- **Auth:** Simple JWT-based auth for the admin-only write endpoints (single-user login — Timothy only)

### Core Tables
- `profile` — current profile fields (summary, competencies, contact info, etc.)
- `experience` — work history entries
- `projects` — project entries
- `certifications` — certification entries
- `blog_posts` — id, title, slug, excerpt, content (Markdown), cover_image, published_at, status (draft/published)
- `content_versions` — generic version history table: `entity_type` (profile/project/blog_post/etc.), `entity_id`, `content_snapshot` (JSON), `edited_at`, `edited_by`. Every write to any of the above tables inserts a new row here rather than deleting history, so past versions can be viewed or restored.

### API Endpoints (baseline)
- `GET /api/profile`, `PUT /api/profile` (admin)
- `GET /api/experience`, `POST/PUT/DELETE /api/experience/:id` (admin)
- `GET /api/projects`, `POST/PUT/DELETE /api/projects/:id` (admin)
- `GET /api/certifications`, `POST/PUT/DELETE /api/certifications/:id` (admin)
- `GET /api/blog`, `GET /api/blog/:slug`, `POST/PUT/DELETE /api/blog/:id` (admin)
- `GET /api/versions/:entity_type/:entity_id` — view version history for any entity (admin)
- `POST /api/versions/:entity_type/:entity_id/restore/:version_id` — roll back to a prior version (admin)
- `POST /api/auth/login` — admin login, returns JWT

### Frontend integration
- Public pages (Portfolio, Blog) fetch from the read (`GET`) endpoints
- Admin page (protected route) uses the write endpoints, gated by the JWT

---

## Design Guidelines
**This site must look and feel professional and polished — it's a credibility asset for both Timothy's personal brand and Stackprime Consulting Ltd, and will be shared with prospective clients, employers, and training sign-ups. Avoid anything that reads as a generic template or student project.**

- Clean, minimal, generous whitespace — avoid the generic "template" look (no stock gradient hero + centered text + 3 icon cards cliché)
- One deliberate accent color + neutral base palette, consistent across every page (Portfolio, Blog, Admin) — include a dark mode toggle
- Distinctive, well-paired typography (not just default sans-serif) — strong hierarchy between headings, body text, and metadata
- Polished micro-details: consistent spacing/grid, subtle hover states, smooth section transitions, well-aligned icons — these small touches are what separate "professional" from "template"
- High-quality visual treatment for certifications and projects (proper badge/card layout, not a plain list) — this is a credentials-heavy profile, so present it with visual weight
- Mobile-first responsive layout — test the Hero, Certifications grid, and Blog cards specifically at mobile widths since they're the most content-dense sections
- Fast load — optimize images, lazy-load below-the-fold sections and blog images
- Consistent, confident tone in all UI copy (button labels, empty states, form confirmations) — no placeholder-sounding text left in the shipped site

---

## Build Sequence (Prompts to follow in order)
1. Scaffold Vite + React + Tailwind + React Router project structure
2. Scaffold Node/Express backend with database schema (profile, experience, projects, certifications, blog_posts, content_versions)
3. Seed the database with the real Career Data content above
4. Build backend CRUD + versioning endpoints, plus JWT auth for admin routes
5. Build frontend components: Hero → About → Experience → Companies/Ventures → Projects → Certifications → Education → Contact → Footer
6. Build Blog index + Blog post detail pages (fetching from backend)
7. Build the protected Admin page for content editing
8. Wire up navigation/routing
9. Add responsive styling + polish animations
10. Test production build (`npm run build`) and run backend + serve `dist/` locally via Nginx config to validate before deploying
11. Write a `DEPLOY.md` with step-by-step EC2 + Nginx deployment instructions (see below)

---

## Deployment Notes (Nginx)
- **Server:** AWS EC2 instance (or equivalent VPS) running Ubuntu, with Nginx installed
- **Frontend:** `npm run build` → copy `dist/` to something like `/var/www/portfolio`; Nginx serves this as static files, with a fallback to `index.html` for React Router's client-side routes
- **Backend:** Run the Node/Express API as a background service (PM2 or a systemd unit) on an internal port (e.g. `3001`); Nginx reverse-proxies `/api/` to `http://localhost:3001`
- **SSL:** Use Certbot (Let's Encrypt) for a free TLS certificate on the custom domain, with Nginx configured to redirect HTTP → HTTPS
- **Database:** PostgreSQL running on the same instance (or a managed RDS instance if scaling matters later)
- **Process management:** Keep both the Node backend and Nginx configured to restart on boot/crash (PM2 `startup`/`save`, or systemd `Restart=always`)
- **CI/CD (optional future step):** Create a GitHub Actions workflow to SSH into the instance, pull latest code, rebuild frontend, restart backend service on push to `main` for site maintenance

---

## Deployment (Ubuntu + Nginx)

```bash
# SSH into Ubuntu VM
ssh user@public-ip

# Install Nginx
sudo apt update && sudo apt install nginx -y

# Copy files to web root
sudo cp -r * /var/www/html/

# Start Nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Access at https://timothyolubiyi.name.ng # Domain name

---

## Key Requirement: Ownership Proof

**Before deployment, Developer MUST edit the footer in `index.html`** to add their details. This is a StackPrime Consulting Ltd requirement to prove ownership.

Look for the footer section (typically near the end of index.html) and ensure it displays something like:
```html
<p><strong>Deployed by:</strong>StackPrime Consulting Ltd</p>
```

This must be visible in browser screenshots submitted as proof of deployment.

---

## Out of Scope (for now)
- Multi-user accounts — admin access is single-user (Timothy only)
- Rich WYSIWYG editor for blog posts — start with Markdown input, upgrade later if needed

...........................................................
Do not edit or modify any existing files.

This is for new web page content. Make it professional
### Consulting Page 
I have created consulting.html file.  Add professional Core services below to the page. Create Different sections for each services and Write a brief detailed write-up of one paragraph to give overview, scope and neccessity for the sercices in their organization. Image mark down show be provide to add images to each sub-sections.

## Core Services

# Enterprise Security 
- Cloud Security Consulting
- Vulnerability Assessment & Penetration Testing (VAPT)
- DevSecOps Implementation
- AWS Security & Architecture
- Infrastructure Security Hardening
- Linux Server Security
- Network Security Assessment
- Security Monitoring & SIEM
- Identity & Access Management (IAM)
- Security Compliance & Risk Assessment
- Incident Response Planning
- Secure Cloud Migration


# Cloud & DevOps Services #
- Cloud Infrastructure: Designing secure, scalable, and highly available cloud environments on AWS.
- CI/CD Automation: Building automated pipelines with GitHub Actions, Jenkins, and GitLab CI/CD for faster, reliable software delivery.
- Containerization & Kubernetes: Deploying and managing containerized applications using Docker, Kubernetes, and Amazon EKS.
- Infrastructure as Code: Automating cloud infrastructure provisioning with Terraform and reusable infrastructure modules.
- Linux Server Administration: Provisioning, securing, optimizing, and maintaining Linux servers for production workloads.
- Monitoring & Observability: Implementing centralized logging, metrics, dashboards, and alerting using Prometheus, Grafana, and the ELK Stack.
- DevSecOps: Embedding security throughout the software delivery lifecycle with secure CI/CD, vulnerability scanning, and cloud security best practices.
- Application Deployment: Deploying modern web applications with Nginx, SSL/TLS, DNS, reverse proxies, and GitOps workflows using Argo CD.

# Website Development & Hosting
I Design, develop, deploy, and maintain secure, high-performance websites and web applications with modern technologies and cloud infrastructure.
- Website Development: Corporate Website, Business Website and Portfolio Website Development
- 
- Website Hosting & Deployment: AWS EC2 Website Hosting, Nginx Web Server Configuration, Apache Web Server Configuration, CloudFront CDN Deployment, Domain & DNS Configuration, SSL/TLS Certificate Installation, and HTTPS Implementation
- DevOps for Web Applications: CI/CD Pipeline for Websites, GitHub Actions Deployment, Dockerized Website Deployment, Kubernetes Website Deployment, Automated Deployment, Infrastructure as Code (Terraform), Blue-Green Deployment, Zero-Downtime Deployment
- Website Security: Web Server Hardening, SSL Security, Security Headers Configuration, Firewall Configuration, DDoS Protection, Vulnerability Assessment, Secure Authentication, Regular Security Updates
- Maintenance & Support: Website Maintenance, Backup & Disaster Recovery, Monitoring & Uptime Checks, Performance Monitoring, Security Monitoring, Bug Fixes, Content Updates, Technical Support

# Email Hosting
- Business Email Setup: Custom Domain Email Setup, Professional Business Email Creation, Mailbox Configuration, Email Account Migration, Email Alias Configuration, Shared Mailboxes, Distribution Lists, Catch-All Email Configuration
- Domain & DNS Configuration: MX Record Configuration, SPF Record Setup, DKIM Configuration, DMARC Policy Implementation, DNS Verification, Email Routing Configuration, Domain Verification
- Email Platforms: Zoho Mail Setup, Google Workspace (Gmail) Configuration, Microsoft 365 (Outlook) Configuration

# IT Projects in Telecommunications
- Network Infrastructure Deployment: Enterprise Network Design & Implementation, ISP Network Deployment, LAN/WAN Infrastructure Implementation, MPLS Network Deployment, Wireless Broadband Network Deployment, Campus Network Design, Branch Office Network Connectivity
- Wireless Network Projects: Point-to-Point (PtP) Wireless Links, Point-to-Multipoint (PtMP) Deployments, Wi-Fi Network Design & Optimization, Last-Mile Connectivity Solutions, Microwave Radio Installation, LTE Network Support, Fixed Wireless Access (FWA), Wireless Network Capacity Planning.
- Cloud & Infrastructure Projects: Cloud Migration for Telecom Applications, AWS Infrastructure Deployment, Virtual Server Deployment,Linux Server Administration, High Availability Infrastructure, Disaster Recovery Implementation, Cloud Monitoring & Alerting, Infrastructure Automation
- Network Security Projects: Firewall Deployment & Hardening, VPN Implementation, Network Segmentation, Security Audits, Vulnerability Assessments, Identity & Access Management (IAM), Security Monitoring
- Systems Administration: Linux Server Deployment, Windows Server Administration, DNS & DHCP Configuration, Active Directory Administration, Email Server Deployment, and Web Server (Nginx/Apache) Deployment
- Network Monitoring & Operations: Network Operations Center (NOC) Monitoring, LibreNMS Deployment, Zabbix Monitoring, PRTG Network Monitor, SolarWinds Monitoring, Grafana Dashboards, Prometheus Monitoring, and Network Performance Optimization.


Add consultation request form and email address (contact@timothyolubiyi.name.ng) and WhatsApp link
......................................................................................................................

This section to be replace with Certifications Secction in the index.html

## Skills & Tools Section
Replace the Professional Certifications Section with Skills and Tools Section then add brief introduction. Add the following in sub sections with auto slides transistion. add icons to them all.

# DevOps 
- Jenkin
- Terraform
- Ansible
- Jenkins
- GitHub Actions
- GitLab CI/CD
- AWS CodePipeline
- ArgoCD
- Helm

# Security
- Splunk (SIEM)
- Nessus 
- Qualys 
- Acunetix 
- HostedScan 
- Wireshark 
- Nmap
- Burp Suite

# Cloud Security
- AWS IAM
- VPC 
- Security Groups
- CloudTrail
- CloudWatch 
- S3 Bucket Policies
- Security Hub

# Containerization
- Docker
- Kubernetes
- Amazon ECS/EKS

# Scripting & Automation
- Python
- Bash
- n8n Workflow
- Infrastructure as Code (IaC)

# Monitoring & Ops
- Nagios
- Prometheus
- LibreNMS
- Grafana
- CloudWatch 
- Splunk 
- Amazon CloudWatch
- AWS CloudTrail
- Proxmox
- Qualys

# OS & Virtualization
- Linux (Ubuntu/CentOS)
- Windows Server
- VMware
- VirtualBox
- Proxmox,
- Kali Linux.