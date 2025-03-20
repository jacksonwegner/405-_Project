#!/usr/bin/env python3

import sys
import kagglehub
import os
import shutil

# List of available files
files = ["actors.csv", "countries.csv", "crew.csv", "genres.csv", "languages.csv",
         "movies.csv", "posters.csv", "releases.csv", "studios.csv", "themes.csv"]

# Function to display the usage message
def print_usage():
    print("Usage:")
    print("  ./getLetterboxdData.py               - Download all files from the dataset.")
    print("  ./getLetterboxdData.py [file_name]   - Download the specified file from the dataset.")
    print("Available files:")
    for file in files:
        print(f"  - {file}")

# Get home directory and set target folder
home_dir = os.path.expanduser("~")
target_dir = os.path.join(home_dir, "kaggle_data")  # Save files in ~/kaggle_data
os.makedirs(target_dir, exist_ok=True)  # Create target directory if it doesn't exist

# Check if a specific file is provided as a command-line argument
if len(sys.argv) > 1:
    file_to_download = sys.argv[1]  # Get the file name from the argument
    if file_to_download in files:
        # Download the file
        path = kagglehub.dataset_download("gsimonx37/letterboxd", file_to_download)
        
        # Dynamically find and move the file
        file_name = os.path.basename(path)  # Get file name from path
        new_path = os.path.join(target_dir, file_name)  # Set new location

        shutil.move(path, new_path)  # Move the file
        print(f"Moved {file_name} to {new_path}")
    else:
        print(f"Error: {file_to_download} not found in the list of available files.")
        print_usage()
else:
    # If no file is provided, download and move all files
    for f in files:
        path = kagglehub.dataset_download("gsimonx37/letterboxd", f)

        file_name = os.path.basename(path)  # Extract file name
        new_path = os.path.join(target_dir, file_name)  # Destination path

        shutil.move(path, new_path)  # Move the file
        print(f"Moved {file_name} to {new_path}")

print("Download complete!")
