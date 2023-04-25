---
title: "Terraform DNS Cloudflare"
date: 2023-04-24 09:00:00
tags:
    - terraform
    - dns
    - cloudfare
categories:
- automation
keywords:
    - terraform
    - cloudfare
    - dns
cover:
    image: "posts/images/cf-dns-terraform.png" # image path/url
    alt: "cf-records-module" # alt text
    caption: "cf-records-module" # display caption under cover
    relative: false # when using page bundles set this to true
    hidden: false # only hide o n current single page
---

# Terraform DNS Cloudflare

Terraform automates Cloudflare DNS record creation and management, saving time and reducing errors for large domains.

A custom module is used to create records for the "example.com" domain. The zone ID is retrieved via the "cloudflare_zone" data source and passed to the module along with the records to create.
Records are organized by type (A, CNAME, MX, and TXT) and created as separate resources with the appropriate parameters.
Terraform also provides version control for DNS records and easy rollback capability. Overall, Terraform and Cloudflare together offer a powerful, scalable solution for managing DNS records as code.

## Terraform Cloudflare DNS Records Module

The module is used to create DNS records for a given domain. The zone ID is passed to the module and used to create the records.
`main.tf` file.

```bash
resource "cloudflare_record" "A" {
  zone_id  = var.zone_id
  for_each = var.records_A
  type     = "A"
  name     = split("--", each.key)[0]
  value    = each.value[0]
  proxied  = each.value[1]
  ttl      = 1
}

resource "cloudflare_record" "CNAME" {
  zone_id  = var.zone_id
  for_each = var.records_CNAME
  type     = "CNAME"
  name     = split("--", each.key)[0]
  value    = each.value[0]
  proxied  = each.value[1]
  ttl      = 1
}

resource "cloudflare_record" "TXT" {
  zone_id  = var.zone_id
  for_each = var.records_TXT
  type     = "TXT"
  name     = split("--", each.key)[0]
  value    = each.value[0]
  ttl      = 1
  proxied  = false
}

resource "cloudflare_record" "MX" {
  zone_id  = var.zone_id
  for_each = var.records_MX
  type     = "MX"
  name     = split("--", each.key)[0]
  value    = each.value[0]
  priority = each.value[1]
  ttl      = 1
  proxied  = false
}
```
The reason why we use split is because we want to be able to create multiple records with the same name but different types. For example, we want to create an MX record for `example.com` and second MX record for `example.com`. If we didn't use split, the second record would overwrite the first one. We then add this unique identifier to the end of the name in the cloudflare_records_example_com module.

You also need to create a `variables.tf` file to define the variables used in the module.

```bash
variable "zone_id" {
  description = "The zone ID of the domain"
  type        = string
}

variable "records_A" {
  description = "A records to create"
  type        = map(list(string))
  default     = {}
}

variable "records_CNAME" {
  description = "CNAME records to create"
  type        = map(list(string))
  default     = {}
}

variable "records_TXT" {
  description = "TXT records to create"
  type        = map(list(string))
  default     = {}
}

variable "records_MX" {
  description = "MX records to create"
  type        = map(list(string))
  default     = {}
}
```
The module is then called from the `cf-records.tf` file in your terraform configuration folder.

```bash
# First, we define the data source to retrieve the zone ID for the domain.
data "cloudflare_zone" "example_com" {
  name = "example.com"
}

# Next, we create a custom module to manage our DNS records.
module "cloudflare_records_example_com" {
  source  = "../modules/cloudflare-records"
  zone_id = data.cloudflare_zone.example_com.id

  # Define our DNS records by type (A, CNAME, MX, TXT).
  records_A = {
    "example.com--0" = [null, true]
  }
  records_CNAME = {
    "example.com" = ["example.com", true]
    "www"         = ["example.com", true]
  }
  records_MX = {
    "example.com--0" = ["mx1.example.com", 10],
    "example.com--1" = ["mx2.example.com", 20],
  }
  records_TXT = {
    "example.com--0" = ["example-text-record"],
  }
}
```
