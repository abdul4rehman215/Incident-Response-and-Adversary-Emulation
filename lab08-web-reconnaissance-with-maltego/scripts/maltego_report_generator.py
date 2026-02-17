#!/usr/bin/env python3

"""
Maltego CSV to HTML Report Generator
"""

import csv
from datetime import datetime
import os

def generate_html_report(csv_file, output_file):

    entities = []
    entity_counts = {}

    try:
        with open(csv_file, 'r', newline='', encoding='utf-8') as f:
            reader = csv.DictReader(f)
            for row in reader:
                entities.append(row)
                entity_type = row.get('Entity Type', 'Unknown')
                entity_counts[entity_type] = entity_counts.get(entity_type, 0) + 1

    except FileNotFoundError:
        print(f"CSV file {csv_file} not found.")
        return

    table_rows = ""
    for entity in entities:
        entity_type = entity.get('Entity Type', 'Unknown')
        value = entity.get('Entity Value', 'Unknown')
        table_rows += f"<tr><td>{entity_type}</td><td>{value}</td></tr>\n"

    html_content = f"""
    <html>
    <head>
        <title>Maltego Reconnaissance Report</title>
    </head>
    <body>
        <h1>Reconnaissance Report</h1>
        <p>Generated: {datetime.now()}</p>
        <p>Total Entities: {len(entities)}</p>
        <table border="1">
            <tr><th>Entity Type</th><th>Value</th></tr>
            {table_rows}
        </table>
    </body>
    </html>
    """

    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(html_content)

    print(f"Report generated: {output_file}")

def main():
    csv_file = "maltego_export.csv"
    output_file = "reconnaissance_report.html"

    if os.path.exists(csv_file):
        generate_html_report(csv_file, output_file)
    else:
        print("Please export Maltego graph to CSV as maltego_export.csv")

if __name__ == "__main__":
    main()
