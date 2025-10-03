CREATE DATABASE tp2_grupo8;
USE tp2_grupo8;

CREATE TABLE Socios (
  id_socio INT primary key,
  nombre VARCHAR(100),
  direccion VARCHAR(255)
);

CREATE TABLE Barcos (
  matricula VARCHAR(20) primary key,
  nombre VARCHAR(100),
  numero_amarre INT,
  cuota DECIMAL(10, 2),
  id_socio INT,
  FOREIGN KEY(id_socio) REFERENCES Socios(id_socio)
);

CREATE TABLE Salidas(
  id_salida INT Primary Key,
  matricula VARCHAR(20),
  fecha_salida DATE,
  hora_salida TIME,
  destino VARCHAR(100),
  patron_nombre VARCHAR(100),
  patron_direccion VARCHAR(255),
  FOREIGN KEY(matricula) REFERENCES Barcos(matricula)
);