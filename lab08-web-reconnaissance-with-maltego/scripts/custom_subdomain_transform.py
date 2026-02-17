#!/usr/bin/env python3

"""
Custom Maltego Transform for Subdomain Enumeration
Integrates Sublist3r output into Maltego XML format.
"""

import sys
import subprocess
import xml.etree.ElementTree as ET
import os

def create_maltego_entity(entity_type, value, additional_fields=None):
    entity = ET.Element("Entity", Type=entity_type)
    entity_value = ET.SubElement(entity, "Value")
    entity_value.text = value

    if additional_fields:
        additional = ET.SubElement(entity, "AdditionalFields")
        for field_name, field_value in additional_fields.items():
            field = ET.SubElement(additional, "Field", Name=field_name)
            field.text = str(field_value)

    return entity

def run_sublist3r(domain):
    try:
        result = subprocess.run(
            ["python3", os.path.expanduser("~/Sublist3r/sublist3r.py"), "-d", domain],
            capture_output=True,
            text=True,
            timeout=300
        )

        subdomains = []
        for line in result.stdout.split('\n'):
            line = line.strip()
            if line.endswith(domain) and line != domain:
                subdomains.append(line)

        return list(set(subdomains))

    except Exception:
        return []

def main():
    if len(sys.argv) != 2:
        print("Usage: python3 custom_subdomain_transform.py <domain>")
        sys.exit(1)

    domain = sys.argv[1]
    subdomains = run_sublist3r(domain)

    response = ET.Element("MaltegoMessage")
    transform_response = ET.SubElement(response, "MaltegoTransformResponseMessage")
    entities = ET.SubElement(transform_response, "Entities")

    for subdomain in subdomains:
        entity = create_maltego_entity(
            "maltego.Domain",
            subdomain,
            {"discovered_by": "Sublist3r"}
        )
        entities.append(entity)

    print(ET.tostring(response, encoding='unicode'))

if __name__ == "__main__":
    main()
