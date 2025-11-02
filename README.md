# 🌍 Multi-Region AWS Network Infrastructure using Terraform

This project automates the provisioning of a **multi-region network architecture on AWS** using **Terraform**.  
It creates two **Virtual Private Clouds (VPCs)** in different AWS regions (Ireland and Frankfurt), each with its own subnet, Internet Gateway, and Transit Gateway (TGW).  
The two TGWs are connected via **Transit Gateway Peering**, enabling **private inter-region communication** between both networks.

---

## 🏗️ Architecture Overview

<p align="center">
  <img src="./assets/terraform export.png" alt="AWS Multi-Region Architecture" width="700"/>
</p>

**Regions Used:**
- 🇮🇪 **Ireland (eu-west-1)**
- 🇩🇪 **Frankfurt (eu-central-1)**

Each region contains:
- 1 VPC and 1 public subnet  
- 1 Internet Gateway and route table  
- 1 Transit Gateway (TGW)  
- TGW VPC attachment  
- TGW peering for private connectivity  

---

## ✨ Features

- 🏗️ **Fully automated provisioning** using Terraform  
- 🌐 **Multi-region setup** (Ireland ↔ Frankfurt)  
- 🔄 **Transit Gateway Peering** for private inter-region routing  
- ☁️ **Modular design** — reusable `vpc` and `tgw` Terraform modules  
- 🔒 **Isolated infrastructure** with unique CIDR blocks per region  
- 🧹 **Easy cleanup** with a single `terraform destroy`  

---

## 📂 Project Structure

