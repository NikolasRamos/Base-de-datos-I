USE ejercicio2_grupo8;
CREATE TABLE clientes(
	dni_cliente INT PRIMARY KEY,
    nombre VARCHAR(100),
    direccion VARCHAR(255)
);

CREATE TABLE asuntos (
	numero_expediente INT PRIMARY KEY,
    dni_cliente INT,
    fecha_inicio DATE,
    fecha_fin DATE,
    estado VARCHAR(10),
    FOREIGN KEY(dni_cliente) REFERENCES clientes(dni_cliente) 
);
    
CREATE TABLE procuradores (
	id_procurador INT PRIMARY KEY,
    nombre VARCHAR(100),
    direccion VARCHAR(255)
);

CREATE TABLE asuntos_Procuradores (
	numero_expediente INT,
    id_procurador INT,
    FOREIGN KEY(numero_expediente) REFERENCES asuntos(numero_expediente),
    FOREIGN KEY(id_procurador) REFERENCES procuradores(id_procurador)
);