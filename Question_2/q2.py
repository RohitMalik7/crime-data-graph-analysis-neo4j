import pandas as pd
import numpy as np
from datetime import datetime
import os

# Function to create directory if it doesn't exist
def ensure_directory(directory):
    """
    Create directory if it doesn't exist
    
    Args:
        directory (str): Path to directory
    """
    if not os.path.exists(directory):
        os.makedirs(directory)

# Set the output directory for CSV files
output_dir = "csv_output"
ensure_directory(output_dir)

# Load the dataset (Only using first 100 rows as provided, but code works for full dataset)
print("Loading dataset...")
df = pd.read_csv('crime_subset.csv')  # Replace with your actual filename
df.rename(columns={
    'type': 'crime_type',
    'neighborhood': 'neighbourhood',
    'npu': 'zone',
    'location': 'property_type',
    'beat': 'beat'
}, inplace=True)
print(f"Loaded {len(df)} records")

# Data cleaning and preprocessing
print("Cleaning and preprocessing data...")

# Convert date strings to datetime objects and extract month and year
df['date'] = pd.to_datetime(df['date'], errors='coerce')
df['month'] = df['date'].dt.month
df['year'] = df['date'].dt.year
df['month_name'] = df['date'].dt.strftime('%B')  # Full month name

# Create unique IDs where needed
df['crime_id'] = df.index  # Use index as crime_id if not present in original data

# Generate CSV for Crime nodes
print("Generating Crime nodes CSV...")
crime_nodes = df[['crime_id', 'crime_type', 'date', 'month', 'year']].drop_duplicates()
crime_nodes['date'] = crime_nodes['date'].dt.strftime('%Y-%m-%d')  # Format date as string
crime_nodes.to_csv(f"{output_dir}/crime_nodes.csv", index=False)

# Generate CSV for Neighbourhood nodes
print("Generating Neighbourhood nodes CSV...")
neighbourhood_nodes = df[['neighbourhood']].drop_duplicates()
neighbourhood_nodes.rename(columns={'neighbourhood': 'name'}, inplace=True)
neighbourhood_nodes.to_csv(f"{output_dir}/neighbourhood_nodes.csv", index=False)

# Generate CSV for Zone nodes
print("Generating Zone nodes CSV...")
zone_nodes = df[['zone']].drop_duplicates()
zone_nodes.rename(columns={'zone': 'name'}, inplace=True)
zone_nodes.to_csv(f"{output_dir}/zone_nodes.csv", index=False)

# Generate CSV for PropertyType nodes
print("Generating PropertyType nodes CSV...")
property_nodes = df[['property_type']].drop_duplicates()
property_nodes.rename(columns={'property_type': 'type'}, inplace=True)
property_nodes.to_csv(f"{output_dir}/property_type_nodes.csv", index=False)

# Generate CSV for Beat nodes
print("Generating Beat nodes CSV...")
beat_nodes = df[['beat']].drop_duplicates()
beat_nodes.rename(columns={'beat': 'beat_id'}, inplace=True)
beat_nodes.to_csv(f"{output_dir}/beat_nodes.csv", index=False)

# Generate CSV for Month nodes
print("Generating Month nodes CSV...")
month_nodes = df[['month_name', 'year']].drop_duplicates()
month_nodes.to_csv(f"{output_dir}/month_nodes.csv", index=False)

# Generate relationship CSVs
print("Generating relationship CSVs...")

# COMMITTED_IN relationship (Crime → Neighbourhood)
crime_neighbourhood_rel = df[['crime_id', 'neighbourhood']].rename(
    columns={'neighbourhood': 'neighbourhood_name'}
)
crime_neighbourhood_rel.to_csv(f"{output_dir}/committed_in_relationships.csv", index=False)

# LOCATED_IN relationship (Neighbourhood → Zone)
neighbourhood_zone_rel = df[['neighbourhood', 'zone']].drop_duplicates().rename(
    columns={'neighbourhood': 'neighbourhood_name', 'zone': 'zone_name'}
)
neighbourhood_zone_rel.to_csv(f"{output_dir}/located_in_relationships.csv", index=False)

# HAPPENED_AT relationship (Crime → PropertyType)
crime_property_rel = df[['crime_id', 'property_type']].rename(
    columns={'property_type': 'property_type_type'}
)
crime_property_rel.to_csv(f"{output_dir}/happened_at_relationships.csv", index=False)

# OCCURRED_ON relationship (Crime → Month)
crime_month_rel = df[['crime_id', 'month_name', 'year']]
crime_month_rel.to_csv(f"{output_dir}/occurred_on_relationships.csv", index=False)

# ASSIGNED_TO relationship (Crime → Beat)
crime_beat_rel = df[['crime_id', 'beat']].rename(
    columns={'beat': 'beat_id'}
)
crime_beat_rel.to_csv(f"{output_dir}/assigned_to_relationships.csv", index=False)

print("CSV generation complete. Files are saved in the 'csv_output' directory.")
print(f"Generated {len(os.listdir(output_dir))} CSV files.")