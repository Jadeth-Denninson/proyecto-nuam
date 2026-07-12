import os

sql_path = 'c:/Users/rooki/Downloads/pycto-integrado-nuam-main/nuamdb_updated.sql'
with open(sql_path, 'r', encoding='utf-8', errors='ignore') as f:
    lines = f.readlines()

print(f"Total lines in {os.path.basename(sql_path)}: {len(lines)}")
for idx, line in enumerate(lines):
    if 'calificacion' in line.lower() or 'tributaria' in line.lower():
        print(f"Line {idx+1}: {line.strip()}")
