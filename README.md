# Crime Graph Database Analysis using Neo4j

> **Author:** Rohit Malik | **Technologies:** Python, Neo4j, Cypher | **Type:** Academic Project | **Purpose:** Portfolio & Educational

---

## Overview

This project demonstrates how crime data can be transformed, modelled, and analysed using a graph database approach. Python is used for preprocessing and CSV generation, while Neo4j is used for graph storage, querying, and relationship analysis.

The repository is structured around assignment tasks, where each question represents a specific stage of the workflow, including data preprocessing, graph modelling, querying, and path analysis.

---

## Project Objective

The objective of this project is to model real-world crime data as a graph and analyse relationships between entities such as crimes, neighbourhoods, zones, property types, beats, and time periods.

By representing the dataset as a graph, the project enables more meaningful relationship analysis and path-based insights than a traditional relational model.

---

## Key Features

| Feature | Description |
|---|---|
| **Data Preprocessing** | Cleans and transforms raw crime data using Python |
| **CSV Generation** | Produces node and relationship CSV files for graph import |
| **Graph Data Modelling** | Designs entities and relationships for Neo4j |
| **Neo4j Implementation** | Stores and manages crime data in a graph database |
| **Cypher Querying** | Executes analytical and relationship-based queries |
| **Graph Visualisation** | Explores data patterns through graph structures |
| **Path Analysis** | Examines links and paths between connected entities |

---

## Repository Structure

```text
crime-graph-database-analysis/
│
├── Question_2/
│   ├── q2.py
│   ├── crime_subset.csv
│   └── csv_output/
│       ├── crime_nodes.csv
│       ├── neighbourhood_nodes.csv
│       ├── zone_nodes.csv
│       ├── property_type_nodes.csv
│       ├── beat_nodes.csv
│       ├── month_nodes.csv
│       ├── committed_in_relationships.csv
│       ├── located_in_relationships.csv
│       ├── happened_at_relationships.csv
│       ├── occurred_on_relationships.csv
│       └── assigned_to_relationships.csv
│
├── Question_3/
│   └── q3.cypher
│
├── Question_4/
│   └── q4.cypher
│
├── Question_5/
│   └── q5.cypher
│
└── README.md
```

---

## Question Breakdown

### Question 2 – Data Preprocessing (Python)

This stage processes the raw dataset (`crime_subset.csv`) and generates the CSV files required to build the graph in Neo4j.

**Node files generated:**
- `crime_nodes.csv`
- `neighbourhood_nodes.csv`
- `zone_nodes.csv`
- `property_type_nodes.csv`
- `beat_nodes.csv`
- `month_nodes.csv`

**Relationship files generated:**
- `committed_in_relationships.csv`
- `located_in_relationships.csv`
- `happened_at_relationships.csv`
- `occurred_on_relationships.csv`
- `assigned_to_relationships.csv`

### Question 3 – Graph Querying

This section contains Cypher queries for analysing crime patterns using filtering, grouping, and ordering operations.

### Question 4 – Advanced Queries

This section focuses on more complex Cypher queries, including aggregation and comparative analysis for deeper graph insights.

### Question 5 – Relationship and Path Analysis

This section explores advanced graph relationships and pathfinding logic to understand how entities are connected within the database.

---

## Technologies Used

| Category | Tools / Technologies |
|---|---|
| **Programming** | Python |
| **Libraries** | Pandas, NumPy |
| **Database** | Neo4j |
| **Query Language** | Cypher |
| **Data Format** | CSV |
| **Concepts** | Graph Database Modelling, Relationship Analysis, Pathfinding |

---

## How to Run

### Step 1 – Run Python Preprocessing

```bash
python Question_2/q2.py
```

This generates node and relationship CSV files inside the `csv_output/` folder.

### Step 2 – Import into Neo4j

- Import the generated CSV files from `csv_output/`
- Create nodes and relationships using Cypher scripts or Neo4j import commands

### Step 3 – Run Queries

Execute the Cypher query files from:

- `Question_3/`
- `Question_4/`
- `Question_5/`

---

## Key Concepts Demonstrated

| Concept | Application |
|---|---|
| **Graph Database Design** | Modelling real-world crime data as connected entities |
| **Data Preprocessing** | Cleaning and preparing source data for graph import |
| **Entity-Relationship Modelling** | Structuring nodes and relationships meaningfully |
| **CSV Data Transformation** | Generating import-ready files for Neo4j |
| **Cypher Query Writing** | Analysing graph data through query-based exploration |
| **Graph Visualisation** | Understanding insights through graph representations |
| **Pathfinding** | Exploring relationships and routes between connected nodes |
| **Graph-Based Data Analysis** | Extracting insights from interconnected data structures |

---

## My Role

This project involved developing the full workflow, including Python-based preprocessing, graph schema design, CSV generation for nodes and relationships, Neo4j database implementation, and Cypher query development for analysis and visualisation.

The project strengthened practical skills in graph databases, data transformation, database modelling, and analytical query design.

---

## Skills Demonstrated

- Python
- Data Preprocessing
- Neo4j
- Cypher
- Graph Databases
- Data Analysis
- CSV Processing
- Database Design
- Problem Solving

---

## Usage & Credit

This project is shared for **portfolio and educational purposes**. If you use or reference any part of this work, please provide appropriate credit to the author.

---

## Author

**Rohit Malik**  
Email: rohitmalik180904@gmail.com  
GitHub: [RohitMalik7](https://github.com/RohitMalik7)  
Location: Dubai, UAE
