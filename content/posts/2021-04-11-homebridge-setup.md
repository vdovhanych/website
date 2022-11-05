---
title: HomeBridge setup
date: 2021-04-11 09:00:00
tags:
    - network
categories:
- infrastructure
keywords:
    - HomeKit
    - homebridge
    - unsupported HomeKit
cover:
    image: "posts/images/homebridge.jpg" # image path/url
    alt: "" # alt text
    caption: "[homebridge/homebridge](https://github.com/homebridge/homebridge)" # display caption under cover
    relative: false # when using page bundles set this to true
    hidden: false # only hide on current single page
---

## HomeBridge setup and supported accessories.


### Homebridge instalation.

 Simple way to install it, is using docker and docker compose.

```docker
version: '2'
services:
  homebridge:
    image: oznu/homebridge:ubuntu
    restart: always
    network_mode: host
    environment:
      - PGID=1000
      - PUID=1000
      - HOMEBRIDGE_CONFIG_UI=1
      - HOMEBRIDGE_CONFIG_UI_PORT=8581
      - TZ=Canberra/Australia
    volumes:
      - ./volumes/homebridge:/homebridge
```

For more ways to install and for configuration options head to the official docs of HomeBridge [here](https://github.com/homebridge/homebridge/wiki).
