-- Archivo preparado para configurar la base de datos MySQL en AWS RDS
-- Debes conectar a tu instancia RDS mediante un cliente MySQL (ej: MySQL Workbench o CLI)
-- utilizando el usuario maestro (admin) que definiste al crear la RDS.

-- 1. Crear la base de datos
CREATE DATABASE IF NOT EXISTS nuamdb
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- 2. Crear usuario para la aplicación Django
-- Reemplaza 'django_user' y 'tu_contraseña_segura' con los credenciales que configurarás en settings.py
CREATE USER IF NOT EXISTS 'django_user'@'%' IDENTIFIED BY 'tu_contraseña_segura';

-- 3. Otorgar los privilegios sobre la base de datos al usuario
GRANT ALL PRIVILEGES ON nuamdb.* TO 'django_user'@'%';

-- 4. Aplicar cambios de privilegios
FLUSH PRIVILEGES;

-- 5. (Opcional) Puedes comprobar que la base de datos existe con:
-- SHOW DATABASES;
-- Y comprobar los usuarios con:
-- SELECT user, host FROM mysql.user;
