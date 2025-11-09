-- Crea la base de datos en MySQL, con las claves primarias, claves foráneas, y todas
-- las columnas NOT NULL. En la tabla movimientos: la columna ‘tipo’ es de tipo
-- ENUM(‘CREDITO’, ‘DEBITO’), de esa forma sólo aceptará los strings que
-- coincidan con las opciones indicadas.
create database banco;
use banco;

create table Clientes(
	numero_cliente int not null,
	dni int not null, 
	apellido varchar(60) not null,
	nombre varchar(60) not null, 
	primary key(numero_cliente, dni)
);

CREATE TABLE Cuentas (
    numero_cuenta INT NOT NULL primary key,
    numero_cliente INT NOT NULL,
    saldo DECIMAL(10,2) NOT NULL,
    constraint cuentas_ibfk_1 FOREIGN KEY (numero_cliente) REFERENCES Clientes(numero_cliente)
);

CREATE TABLE movimientos (
    numero_movimiento INT AUTO_INCREMENT,
    numero_cuenta INT NOT NULL,
    fecha DATE NOT NULL,
    tipo ENUM('CREDITO', 'DEBITO') NOT NULL,
    importe DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (numero_movimiento),
    FOREIGN KEY (numero_cuenta) REFERENCES Cuentas(numero_cuenta)
);

CREATE TABLE historial_movimientos (
    id INT AUTO_INCREMENT,
    numero_cuenta INT NOT NULL,
    numero_movimiento INT NOT NULL,
    saldo_anterior DECIMAL(10,2) NOT NULL,
    saldo_actual DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id),
    foreign key (numero_cuenta) references Cuentas(numero_cuenta),
    foreign key (numero_movimiento) references movimientos(numero_movimiento)
    );
    
-- en los puntos que no hicimos el select al final (despues del call) fue por que no lo pedia el enunciado( y no lo pudimos hacer)