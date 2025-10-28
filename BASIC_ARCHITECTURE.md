                   ┌────────────────────────────┐
                   │      Raspberry Pi          │
                   │  (Kubernetes Cluster Node) │
                   └────────────┬───────────────┘
                                │
         ┌──────────────────────┴──────────────────────┐
         │                                             │
 ┌────────────────────────┐                  ┌────────────────────────┐
 │   Spring Boot Service  │                  │   MQTT Broker (Pod)    │
 │ (LED Controller API)   │                  │ (e.g. Eclipse Mosquitto)│
 │------------------------│                  │-------------------------│
 │ • Runs in K8s Pod      │                  │ • Listens on port 1883  │
 │ • Exposes REST API     │                  │ • Handles pub/sub       │
 │ • Publishes MQTT msgs  │───────────────►  │   between devices       │
 │   topic: led/control   │                  │                         │
 └────────────────────────┘                  └────────────────────────┘
                                                          │
                                                          │  Wi-Fi / LAN
                                                          ▼
                                         ┌────────────────────────────┐
                                         │          ESP32             │
                                         │----------------------------│
                                         │ • Subscribes to topic      │
                                         │   `led/control`            │
                                         │ • Parses JSON command      │
                                         │   e.g. {"cmd":"SET_MODE",  │
                                         │         "mode":"fire"}     │
                                         │ • Executes local LED mode  │
                                         │   (Adafruit_NeoPixel)      │
                                         └──────────────┬─────────────┘
                                                        │
                                                        ▼
                                           ┌────────────────────────┐
                                           │   WS2812B LED Strip    │
                                           │------------------------│
                                           │ Controlled via GPIO    │
                                           │ Animations / effects   │
                                           └────────────────────────┘

