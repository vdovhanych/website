---
title: "Raspberry Pi 4 Kubernetes cluster"
date: 2022-04-10 09:00:00
tags:
    - raspberrypi
    - k3s
    - kubernetes
categories:
- automation
keywords:
    - kubernetes
    - cluster
    - raspberrypi
cover:
    image: "posts/images/pi-cluster/cover.jpeg" # image path/url
    alt: "pi-cluster" # alt text
    caption: "pi-cluster" # display caption under cover
    relative: false # when using page bundles set this to true
    hidden: false # only hide on current single page
---

# Installation

## Prepare the image for Raspberry Pi

Download [Pi imager](https://www.raspberrypi.com/software/)

Setup each nodes SD card

![pi-imager1](/posts/images/pi-cluster/pi-imager-os.png)
![pi-imager2](/posts/images/pi-cluster/pi-imager-settings.png)

## k3s Install
To install k3s on Raspberry pi-cluster i have used awesome opensource project
![k3s-ansible-cover](https://camo.githubusercontent.com/1d58775f8b90fa83b237600ddc6112cad2e93e912d4b6b754e991a036631aa64/68747470733a2f2f696d672e796f75747562652e636f6d2f76692f43626b455763555a377a4d2f302e6a7067)
[k3s-ansible](https://github.com/techno-tim/k3s-ansible)

Follow the instructions on how to install k3s in the projects readme.
