import json
import csv
import sys
from pathlib import Path

def jsonlines_to_csv(input_file, output_file):
    """
    Convert a JSONL (JSON Lines) file to CSV format.
    Only converts the properties of each feature to columns.
    
    Args:
        input_file (str): Path to the input JSONL file
        output_file (str): Path to the output CSV file
    """
    # Read the entire file content
    with open(input_file, 'r') as f:
        content = f.read()
        # Remove any trailing commas between objects
        content = content.replace('},\n{', '}\n{')
        # Split into lines
        lines = [line.strip() for line in content.split('\n') if line.strip()]
    
    records = []
    headers = ["NAME", "LISTNAME", "MAPNAME", "Shape_Leng", "Shape_Area", "Geometry"]  # Predefined headers
    
    # Process each line
    for line in lines:
        try:
            record = json.loads(line)
            if not headers:
                headers = list(record['properties'].keys())
            records.append(record['properties'] | {"Geometry": json.dumps(record['geometry'])})  # Merge properties and geometry
            print(record['properties'] | {"Geometry": record['geometry']})  # Debug print
        except json.JSONDecodeError as e:
            print(f"Warning: Skipping invalid JSON line: {e}")
            continue
    
    if not records:
        print("No valid records found in the file")
        return
    
    # Write to CSV
    with open(output_file, 'w', newline='') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=headers)
        writer.writeheader()
        for record in records:
            writer.writerow(record)

def main():
    if len(sys.argv) < 2:
        print("Usage: python jsonlines_to_csv.py <input_file> [output_file]")
        print("If output_file is not specified, will use input_file with .csv extension")
        sys.exit(1)
    
    input_file = sys.argv[1]
    if len(sys.argv) > 2:
        output_file = sys.argv[2]
    else:
        # Use the same name but with .csv extension
        output_file = str(Path(input_file).with_suffix('.csv'))
    
    print(f"Converting {input_file} to {output_file}")
    jsonlines_to_csv(input_file, output_file)
    print("Conversion complete!")

if __name__ == "__main__":
    main()