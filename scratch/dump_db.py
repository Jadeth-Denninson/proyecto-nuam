import os
import sys
import django

sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'nuam.settings')
django.setup()

from django.db import connection

sql_file_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'nuamdb_updated.sql'))

def escape_val(val):
    if val is None:
        return 'NULL'
    if isinstance(val, (int, float)):
        return str(val)
    if isinstance(val, bool):
        return '1' if val else '0'
    # For dates, datetimes, and strings, escape single quotes
    s = str(val).replace('\\', '\\\\').replace("'", "''")
    return f"'{s}'"

try:
    with connection.cursor() as cursor:
        cursor.execute("SHOW TABLES")
        tables = [t[0] for t in cursor.fetchall()]
        
        # We want to dump structure first or write in a simple script format
        lines = []
        lines.append("-- ========================================================")
        lines.append("-- Script de Base de Datos Actualizado para nuamdb")
        lines.append("-- Generado automaticamente por Antigravity AI")
        lines.append("-- Compatible con MariaDB / MySQL")
        lines.append("-- ========================================================\n")
        lines.append("CREATE DATABASE IF NOT EXISTS `nuamdb` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;")
        lines.append("USE `nuamdb`;\n")
        lines.append("SET FOREIGN_KEY_CHECKS = 0;\n")
        
        for table in tables:
            # Get creation syntax
            cursor.execute(f"SHOW CREATE TABLE `{table}`")
            create_stmt = cursor.fetchone()[1]
            
            lines.append(f"-- Table structure for table `{table}`")
            lines.append(f"DROP TABLE IF EXISTS `{table}`;")
            lines.append(create_stmt + ";\n")
            
            # Get data
            cursor.execute(f"SELECT * FROM `{table}`")
            columns = [col[0] for col in cursor.description]
            rows = cursor.fetchall()
            
            if rows:
                lines.append(f"-- Dumping data for table `{table}`")
                col_names = ", ".join([f"`{c}`" for c in columns])
                
                # Group inserts in batches
                batch_size = 100
                for i in range(0, len(rows), batch_size):
                    batch = rows[i:i+batch_size]
                    values_list = []
                    for row in batch:
                        vals = ", ".join([escape_val(v) for v in row])
                        values_list.append(f"({vals})")
                    
                    insert_stmt = f"INSERT INTO `{table}` ({col_names}) VALUES \n" + ",\n".join(values_list) + ";"
                    lines.append(insert_stmt)
                lines.append("")
                
        lines.append("SET FOREIGN_KEY_CHECKS = 1;")
        lines.append("COMMIT;")
        
    with open(sql_file_path, 'w', encoding='utf-8') as f:
        f.write("\n".join(lines))
        
    print(f"Database successfully dumped to: {sql_file_path}")

except Exception as e:
    print("Error dumping database:", e)
