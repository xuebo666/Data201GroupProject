# US Accidents Database Project
## Project Overview

This project builds a relational database system to analyze traffic accidents across the United States using the US Accidents Dataset. The goal is to design a normalized database schema, import large-scale real-world data into MySQL, and perform SQL analysis to extract meaningful insights about accident patterns, weather conditions, and geographic trends.

The dataset contains millions of accident records collected from traffic sensors, police reports, and transportation agencies between 2016 and 2023.

# Dataset Information
## Source

Dataset obtained from Kaggle, published by Sobhan Moosavi.

Download command used in the project:

import kagglehub

#Download latest version
path = kagglehub.dataset_download("sobhanmoosavi/us-accidents")

print("Path to dataset files:", path)

## Dataset Size

7728394 accident records

46 columns 

# Example Features

Accident_ID

Start_Time

End_Time

City

State

Zipcode

Weather_Condition

Temperature

Visibility


## Project Goals

The project focuses on the following database concepts:

Designing an Entity Relationship schema

Implementing relational tables in MySQL

Applying database normalization (up to 3NF)

Importing and managing large-scale datasets

Writing SQL queries to analyze accident patterns

Extracting insights from real-world traffic data
