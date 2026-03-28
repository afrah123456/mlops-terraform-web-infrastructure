# Web Application Infrastructure with Terraform - MLOps Lab5

## Project Description
Infrastructure as Code (IaC) project using Terraform to automate the deployment of web application infrastructure on Google Cloud Platform. Creates a complete web hosting environment with VM, storage, and networking in minutes.

## My Modifications
Instead of a basic VM instance, I created a complete web application infrastructure:
- **Nginx web server** with automated deployment via startup script
- **Cloud Storage bucket** for static files with unique naming
- **HTTP firewall rule** for public web access
- **Custom labels and tags** for resource organization
- **Full infrastructure lifecycle management** (create and destroy)

## Technologies Used
- **Terraform** - Infrastructure as Code
- **Google Cloud Platform** - Cloud provider
- **Compute Engine** - VM hosting (e2-micro, free tier)
- **Cloud Storage** - Object storage
- **VPC Networking** - Firewall configuration
- **Nginx** - Web server

## Resources Deployed
1. **VM Instance** - web-server-vm (Debian 11, nginx installed)
2. **Storage Bucket** - web-static-files-* (US multi-region)
3. **Firewall Rule** - allow-http-web-server (port 80)
4. **Random ID** - For unique bucket naming

## Deployment Results
- **VM Public IP**: 34.63.174.173
- **Storage Bucket**: web-static-files-a9095904
- **Deployment Time**: ~30 seconds
- **Web Server**: Successfully deployed and accessible via HTTP

## Commands Used
```bash
terraform init      # Initialize Terraform
terraform plan      # Preview changes
terraform apply     # Create infrastructure
terraform destroy   # Clean up resources
```

## Key Features
- Automated infrastructure deployment  
- Web server with custom HTML  
- Public internet access  
- Cloud storage integration  
- Complete lifecycle management  
- Free tier eligible  

## Screenshots
Verification screenshots in `output/` folder showing VM instance, storage bucket, firewall rule, and working web server.

## Author
Afrah Fathima

## Course
MLOps (IE-7374) - Lab5