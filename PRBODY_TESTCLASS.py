import re

def extract_apex_classes(file_path):
    """Extracts Apex test class names from a file."""
    try:
        with open(file_path, 'r') as file:
            text_content = file.read()
    except FileNotFoundError:
        print(f"File not found: {file_path}")
        return []

    match = re.search(r"APEX TEST CLASS TO RUN\s*\[RUN:([^\]]+)\]", text_content)
    if match:
        apex_classes = [cls.strip() for cls in match.group(1).split(',')]
        apex_classes_string = ','.join(apex_classes)
        print("Apex classes found:", apex_classes_string)
        return apex_classes_string  # Or return apex_classes if you need a list
    else:
        print("No Apex classes found")
        return ""

if __name__ == "__main__":
    extract_apex_classes('pr_body.txt')
