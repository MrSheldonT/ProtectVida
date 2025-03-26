DROP DATABASE ProtectVida ;
CREATE DATABASE IF NOT EXISTS ProtectVida;
USE ProtectVida;

CREATE TABLE cuenta (
    id INT AUTO_INCREMENT PRIMARY KEY
    , google_id VARCHAR(255) UNIQUE
    , nombre VARCHAR(100) NOT NULL
    , correo_electronico VARCHAR(255) UNIQUE NOT NULL
    , hash_contraseña CHAR(60) NOT NULL
    , peso DECIMAL(5,2)
    , altura DECIMAL(5,2)
    , sexo ENUM('M', 'F', 'Otro')
    , fecha_nacimiento DATE
);

CREATE TABLE condicion (
    id INT AUTO_INCREMENT PRIMARY KEY
    , nombre VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE cuenta_condicion (
    cuenta_id INT
    , condicion_id INT
    , PRIMARY KEY (cuenta_id, condicion_id)
    , FOREIGN KEY (cuenta_id) REFERENCES cuenta(id) ON DELETE CASCADE
    , FOREIGN KEY (condicion_id) REFERENCES condicion(id) ON DELETE CASCADE
);

CREATE TABLE grupo (
    id INT AUTO_INCREMENT PRIMARY KEY
    , nombre VARCHAR(100) NOT NULL
);

CREATE TABLE miembro_grupo (
    cuenta_id INT
    , grupo_id INT
    , es_administrador BOOLEAN DEFAULT FALSE
    , FOREIGN KEY (cuenta_id) REFERENCES cuenta(id) ON DELETE CASCADE
    , FOREIGN KEY (grupo_id) REFERENCES grupo(id) ON DELETE CASCADE
);

CREATE TABLE zona_segura (
    id INT AUTO_INCREMENT PRIMARY KEY
    , cuenta_id INT
    , nombre VARCHAR(100) NOT NULL
    , latitud DOUBLE NOT NULL
    , longitud DOUBLE NOT NULL
    , radio DOUBLE NOT NULL
    , FOREIGN KEY (cuenta_id) REFERENCES cuenta(id) ON DELETE CASCADE
);

CREATE TABLE tipo_signo_vital (
    id INT AUTO_INCREMENT PRIMARY KEY
    , nombre VARCHAR(100) UNIQUE NOT NULL
    , descripcion TEXT
    , unidad VARCHAR(50)
);

CREATE TABLE signo_vital (
    id INT AUTO_INCREMENT PRIMARY KEY
    , cuenta_id INT NOT NULL
    , tipo_id INT NOT NULL
    , fecha DATETIME DEFAULT CURRENT_TIMESTAMP
    , valor_numerico_1 DOUBLE -- Primer valor (frecuencia cardíaca o sistólica)
    , valor_numerico_2 DOUBLE -- Segundo valor (diastólica)
    , FOREIGN KEY (cuenta_id) REFERENCES cuenta(id) ON DELETE CASCADE
    , FOREIGN KEY (tipo_id) REFERENCES tipo_signo_vital(id) ON DELETE CASCADE
);

CREATE TABLE tipo_alerta (
    id INT AUTO_INCREMENT PRIMARY KEY
    , nombre VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE alerta (
    id INT AUTO_INCREMENT PRIMARY KEY
    , cuenta_id INT
    , tipo_id INT NOT NULL
    , fecha DATETIME DEFAULT CURRENT_TIMESTAMP
    , atendida BOOLEAN DEFAULT FALSE
    , FOREIGN KEY (cuenta_id) REFERENCES cuenta(id) ON DELETE CASCADE
    , FOREIGN KEY (tipo_id) REFERENCES tipo_alerta(id) ON DELETE CASCADE
);