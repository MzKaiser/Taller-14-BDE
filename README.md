Profe, no me dé tan duro en la calificación :'(

# PostGIS Spatial Indexing & Query Optimization 🚀🌍

## 📌 Project Overview
This repository demonstrates the critical performance impact of spatial indexing in PostgreSQL/PostGIS. It includes real-world benchmarking for spatial joins, proximity searches, and geometry intersections using cadastral and incident data from Bogotá, Colombia.

## 🛠️ Tech Stack & Parameters
* **Database:** PostgreSQL + PostGIS
* **Language:** Advanced SQL
* **Coordinate Reference System (CRS):** EPSG:3116 (MAGNA-SIRGAS / Bogotá)[cite: 3]
* **Study Area:** Rafael Uribe Uribe, Bogotá[cite: 3]

## 🚀 Core Implementations

### 1. Spatial Benchmarking (`EXPLAIN ANALYZE`)
* Engineered A/B testing environments to compare execution plans for spatial queries before and after creating **GiST (Generalized Search Tree) indexes**[cite: 3] on large geographic datasets (roads, neighborhoods, and incidents)[cite: 3].

### 2. Point-in-Polygon & Proximity Queries
* **Spatial Joins:** Implemented `ST_Contains` to aggregate and count urban incidents within specific neighborhood polygons[cite: 3].
* **Distance Searching:** Utilized `ST_DWithin` combined with `ST_MakePoint` to query road networks (`vias`) within a strict 50-meter radius of specific geographic coordinates (X=996424, Y=995641)[cite: 3].

### 3. Bounding Box (BBOX) vs. Exact Intersection
* Conducted performance analysis comparing the PostGIS bounding box operator (`&&`)[cite: 3] against exact geometry intersection calculations (`ST_Intersects`)[cite: 3] to optimize query times for specific localities (e.g., 'OLAYA' neighborhood)[cite: 3].

## 🔗 Presentation
Check out the slides for a visual breakdown of the spatial indexing concepts: [Link to your Google Slides here](https://docs.google.com/presentation/d/1piX9UPCMsLtY1jNkJpQUujAkaTIdqln8kA3db7pgQ84/edit?usp=sharing)
