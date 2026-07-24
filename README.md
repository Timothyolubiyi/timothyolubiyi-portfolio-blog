### Timothy Olubiyi Portfolio Website ###

# Overview

This repository contains the source code for the official personal portfolio and blog of Timothy Olubiyi—an experienced IT Project Manager, DevOps (DevSecOps) Engineer, Cybersecurity Specialist, and Network Engineer. The portfolio is designed to showcase Timothy's professional experience, technical expertise, certifications, projects, and thought leadership while serving as a central platform for consulting services, professional training, and career opportunities.

The project follows a modern Infrastructure as Code (IaC) approach, combining a React frontend with an automated AWS deployment pipeline. The solution is designed for high availability, scalability, security, and maintainability, leveraging cloud-native services and DevOps best practices.

## Objectives ##

The portfolio aims to:

Showcase Timothy's professional profile and technical expertise.
Highlight enterprise infrastructure, cloud, cybersecurity, and DevOps projects.
Publish technical articles and educational content through an integrated blog.
Promote StackPrime Consulting Ltd's consulting and professional training services.
Demonstrate modern DevOps practices using automated CI/CD and Infrastructure as Code.

## Architecture ##

The website is built using a fully automated serverless deployment architecture:

React Application
        │
        ▼
 GitHub Repository
        │
        ▼
 GitHub Actions
        │
        ▼
Terraform (IaC)
        │
        ▼
 Amazon S3 (Private Bucket)
        │
        ▼
 CloudFront CDN
        │
        ▼
 AWS Certificate Manager
        │
        ▼
Custom Domain

The deployment intentionally avoids traditional web servers and infrastructure such as EC2, Nginx, Application Load Balancers, and RDS for hosting the static frontend, enabling a secure, low-maintenance, and cost-effective architecture.

## Features ##
- Responsive portfolio website
- Professional blog with version-controlled content
- Project showcase
- Professional certifications gallery
- Career timeline
- Companies and ventures section
- Contact and consultation page
- Administrative dashboard for content management
- Automated CI/CD deployment pipeline
- Infrastructure as Code using Terraform
- Secure AWS hosting with CloudFront and ACM
- Mobile-first responsive design
- Modern UI with animations and dark mode support

## Technology Stack ##
- Frontend
- React (Vite)
- Tailwind CSS
- React Router
- Framer Motion
- Lucide React
- Backend
- Node.js
- Express.js
- PostgreSQL / SQLite
- JWT Authentication
- Cloud & DevOps
- AWS
- Amazon S3
- CloudFront
- WHOGOHOST Domain Name
- AWS Certificate Manager (ACM)
- GitHub Actions
- Terraform
- Security
- IAM
- HTTPS/TLS
- CloudFront Origin Access Control
- GitHub Secrets
- Least Privilege Access
- Secure CI/CD Pipeline
- CI/CD Pipeline

The application deployment is fully automated using GitHub Actions.

# Deployment workflow includes:

- Validate Terraform configuration
- Validate React application
- Build React application
- Generate Terraform execution plan
- Human approval
- Provision AWS infrastructure
- Upload application to Amazon S3
- Invalidate CloudFront cache
- Verify production deployment

Production deployments always require human approval before infrastructure changes are applied.

## Security ##

Security is integrated throughout the project lifecycle.

Implemented security controls include:

- Private Amazon S3 bucket
- HTTPS encryption
- AWS Certificate Manager
- CloudFront Origin Access Control
- IAM Least Privilege
- GitHub Secrets
- Infrastructure validation

## Secure deployment workflow ##

The project follows security best practices to ensure infrastructure integrity and protect deployment credentials.

## Professional Profile ##

Timothy Olubiyi is an experienced IT Project Manager, DevSecOps Engineer, Cybersecurity Specialist, and Network Engineer with over nine years of experience across IT infrastructure, telecommunications, cloud computing, networking, and cybersecurity.

His expertise includes:

AWS Cloud Infrastructure
DevOps & DevSecOps
Infrastructure as Code
Enterprise Networking
Cybersecurity
CI/CD Automation
Kubernetes
Docker
Linux Administration
Security Compliance
Technical Project Management
Enterprise Infrastructure Deployment
Core Competencies
Cloud Computing
Infrastructure Automation
DevOps Engineering
DevSecOps
Cybersecurity
Identity & Access Management
Vulnerability Assessment & Penetration Testing (VAPT)
Network Infrastructure
Enterprise Security
CI/CD Pipelines
Containerization
Infrastructure Monitoring
Technical Leadership
Project Management
Professional Experience

The portfolio highlights Timothy's professional journey, including:

- Founder & Chief Consultant — StackPrime Consulting Ltd
- Project Manager / Cybersecurity & IT Project Manager — Sentient Network Limited
- Network Operations Center Supervisor & Cybersecurity Specialist — Tizeti Network Limited
- Cybersecurity Analyst — Mastercard Forage Virtual Experience
- Cybersecurity Intern — Hagital Consulting
- IT Support Officer — First City Monument Bank (FCMB)


## Key Projects ##


Featured projects include:

Enterprise WAN/MPLS Deployment
Network Optimization
AWS Infrastructure Automation
Jenkins CI/CD Server Deployment
NGINX Infrastructure Provisioning
Python LAN/WLAN Scanner
AI-powered Cybersecurity Workflow Automation
Kubernetes and Docker Deployments
Infrastructure as Code using Terraform and Ansible

## Certifications ##

Professional certifications are organized into the following categories:

Cybersecurity
Cloud & DevOps
Networking
Project Management

The portfolio showcases industry-recognized certifications from ISC2, AWS, Cisco, MikroTik, Fortinet, Aviatrix, EC-Council, ISO, Splunk, and other leading technology providers.

## Deployment ##

The project is deployed using:

- Agentic AI (Claude.ai)
- AWS S3
- Amazon CloudFront
- AWS Certificate Manager
- Terraform
- GitHub Actions

Infrastructure provisioning and application deployment are fully automated to ensure consistency, repeatability, and secure delivery.

## Future Enhancements ##

Planned improvements include:

- Enhanced blog editor
- Expanded project case studies
- Additional cloud architecture diagrams
- Interactive certification gallery
- AI-powered portfolio assistant
- Advanced analytics dashboard
- Continuous platform optimization


##  Author ##

Timothy Olubiyi

IT Project Manager | DevOps (DevSecOps) Engineer | Cybersecurity Specialist | Network Engineer

GitHub: https://github.com/Timothyolubiyi
LinkedIn: https://www.linkedin.com/in/timothy-olubiyi-05b9ba123/
Email: timothyolubiyi@gmail.com
Portfolio: https://timothyolubiyi.name.ng (upon deployment)
License

This project is intended for personal branding, professional showcase, and educational purposes. Unauthorized redistribution or commercial use of the content without permission is prohibited.