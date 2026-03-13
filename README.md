# US Accidents Database Project

## Project Overview

This project builds a relational database system to analyze traffic
accidents across the United States using the **US Accidents Dataset**.

The objective is to design a normalized database schema, import a
large-scale real-world dataset into **MySQL**, and perform SQL analysis
to extract meaningful insights about accident patterns, weather
conditions, and geographic trends.

The dataset contains millions of accident records collected from traffic
sensors, police reports, and transportation agencies between **2016 and
2023**.

------------------------------------------------------------------------

# Dataset Information

## Source

The dataset was obtained from Kaggle, published by Sobhan Moosavi.

The dataset is downloaded automatically using Python and kagglehub:

``` python
import kagglehub

# Download latest version
path = kagglehub.dataset_download("sobhanmoosavi/us-accidents")

print("Path to dataset files:", path)
```

Because the dataset is very large, it is **not stored directly in this
repository**. Instead, it can be downloaded using the script above.

------------------------------------------------------------------------

# Dataset Size

The dataset contains:

-   **7,728,394 accident records**
-   **46 attributes (columns)**

This large dataset provides rich information for database design and
query analysis.

------------------------------------------------------------------------

# Example Features

Some of the important attributes in the dataset include:

-   **Accident_ID** -- Unique identifier of the accident
-   **Start_Time** -- Start time of the accident
-   **End_Time** -- End time of the accident
-   **City** -- City where the accident occurred
-   **State** -- State where the accident occurred
-   **Zipcode** -- Zip code of the accident location
-   **Weather_Condition** -- Weather conditions at the time of the
    accident
-   **Temperature** -- Temperature in Fahrenheit
-   **Visibility** -- Visibility distance in miles

These attributes allow analysis of temporal, geographic, and
environmental factors affecting traffic accidents.

------------------------------------------------------------------------

# Project Goals

This project focuses on applying key database management concepts,
including:

-   Designing an **Entity-Relationship (ER) schema**
-   Implementing **relational tables in MySQL**
-   Applying **database normalization up to Third Normal Form (3NF)**
-   Importing and managing **large-scale real-world datasets**
-   Writing **SQL queries** to analyze accident patterns
-   Extracting insights about **traffic safety, weather effects, and
    geographic accident trends**

------------------------------------------------------------------------

# Technologies Used

-   Python -- Data preprocessing and dataset handling\
-   Pandas -- Data cleaning and transformation\
-   MySQL -- Relational database implementation\
-   GitHub -- Version control and collaboration

------------------------------------------------------------------------

# Database Design

The dataset was normalized into four main tables:

-   **Accidents** -- Core accident records\
-   **Location** -- Geographic information\
-   **Weather** -- Weather conditions during accidents\
-   **Road** -- Nearby road features

This design reduces redundancy and improves query performance.

------------------------------------------------------------------------

# Future Work

Future improvements include:

-   Writing **advanced SQL queries** using joins, aggregations, and
    window functions\
-   Creating **data visualizations and dashboards** to illustrate
    accident trends\
-   Performing deeper analysis of **weather impacts and geographic
    accident hotspots**
