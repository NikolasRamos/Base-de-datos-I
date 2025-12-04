import mysql.connector
from mysql.connector import Error

# Conexion a MySQL
try:
    conexion = mysql.connector.connect(
        host="localhost",
        user="root",
        port="3306",
        password="administrador",
        database="Ventas_online"
    )

    if conexion.is_connected():
        print("Conexion exitosa.")
        cursor = conexion.cursor()

except Error as error:
    print("Error durante la conexion:", error)
    exit()


# Funciones de validaciones de datos
def pedir_entero_positivo(mensaje: str) -> int:
    repetir = True
    while repetir:
        try:
            numero = int(input(mensaje))
            if numero >= 0:
                repetir = False
            else:
                print("El numero ingresado debe ser un numero entero y positivo.")
        except ValueError:
            print("El numero ingresado debe ser un numero entero y positivo.")
    return numero

def pedir_float(mensaje: str) -> float:
    repetir = True
    while repetir:
        try:
            numero = float(input(mensaje))
            if numero >= 0:
                repetir = False
            else:
                print("El numero ingresado debe ser un numero positivo.")
        except ValueError:
            print("El numero ingresado debe ser un numero positivo.")
    return numero

# Otras funciones auxiliares
def existe_producto(codigo: int) -> bool:
    cursor.execute("SELECT 1 FROM Productos WHERE codigo_producto = %s", (codigo,))
    resultado = cursor.fetchone()
    return resultado is not None

def existe_dni(dni: int) -> bool:
    cursor.execute("SELECT 1 FROM Clientes WHERE dni_cliente = %s", (dni,))
    resultado = cursor.fetchone()
    return resultado is not None

def pausa():
    input("\nPresioná ENTER para continuar...")

# ============================================
# FUNCIONES DE PRODUCTOS
# ============================================

def agregar_producto():
    print("\n--- AGREGAR PRODUCTO ---")

    existe = True
    while existe:
        codigo = pedir_entero_positivo("Codigo del producto: ")
        if existe_producto(codigo):
            print("Ya existe un producto con el codigo ingresado.")
        else:
            existe = False

    nombre = input("Nombre del producto: ")
    precio = pedir_float("Precio: ")
    stock = pedir_entero_positivo("Stock inicial: ")

    cursor.execute("INSERT INTO Productos (codigo_producto, nombre_producto, precio, stock) VALUES (%s, %s, %s, %s)", (codigo, nombre, precio, stock))
    conexion.commit()
    print("Producto agregado con exito.")
    pausa()


def actualizar_producto():
    print("\n--- ACTUALIZAR PRODUCTO ---")
    codigo = pedir_entero_positivo("Codigo del producto: ")
    if not existe_producto(codigo):
        print("El producto no existe.")
        pausa()
        return
    
    nombre = input("Nombre del producto: ")
    precio = pedir_float("Precio: ")
    stock = pedir_entero_positivo("Stock inicial: ")

    cursor.execute("UPDATE Productos SET nombre_producto = %s, precio = %s, stock = %s WHERE codigo_producto = %s", (nombre, precio, stock, codigo))
    conexion.commit()
    print("Producto actualizado con exito.")
    pausa()

def buscar_producto():
    print("\n--- BUSCAR PRODUCTO ---")
    codigo = pedir_entero_positivo("Codigo del producto: ")
    if not existe_producto(codigo):
        print("El producto no existe.")
        pausa()
        return

    cursor.execute("SELECT * FROM Productos WHERE codigo_producto = %s", (codigo,))
    busqueda = cursor.fetchone()

    if busqueda:
        print("\n--- PRODUCTO ENCONTRADO ---")
        print(f"Código:  {busqueda[0]}")
        print(f"Nombre:  {busqueda[1]}")
        print(f"Precio:  ${busqueda[2]:.2f}")
        print(f"Stock:   {busqueda[3]}")
    pausa()

def ver_productos():
    print("\n--- LISTA DE PRODUCTOS ---")
    
    cursor.execute("SELECT * FROM Productos")
    productos = cursor.fetchall()

    if not productos:
        print("No se encontraron productos.")
        pausa()
        return
    
    for prod in productos:
        print(f"\nCodigo:  {prod[0]}")
        print(f"Nombre:  {prod[1]}")
        print(f"Precio:  ${prod[2]:.2f}")
        print(f"Stock:   {prod[3]}")
    pausa()

def eliminar_producto():
    print("\n--- ELIMINAR PRODUCTO ---")
    codigo = pedir_entero_positivo("Codigo del producto: ")
    if not existe_producto(codigo):
        print("El producto no existe.")
        pausa()
        return
    
    cursor.execute("DELETE FROM Productos WHERE codigo_producto = %s", (codigo,))
    conexion.commit()
    print("Producto eliminado con exito.")
    pausa()


# ============================================
# FUNCIONES DE CLIENTES
# ============================================

def registrar_cliente():
    print("\n--- REGISTRAR CLIENTE ---")
    dni_cliente = pedir_entero_positivo("Ingrese DNI del cliente: ")
    if existe_dni(dni_cliente):
        print("El DNI ya está registrado. No se puede registrar el cliente.")
        pausa()
        return
    else:

     nombre = input("Ingrese nombre del cliente: ")
     apellido = input("Ingrese apellido del cliente: ")
     email = input("Ingrese email del cliente: ")

     sql = "INSERT INTO Clientes (dni_cliente, nombre, apellido, email) VALUES (%s, %s, %s, %s)"
     valores = (dni_cliente, nombre, apellido, email)

     cursor.execute(sql, valores)
     conexion.commit()
     print("Cliente registrado exitosamente.")
     pausa()


def actualizar_cliente():
    print("\n--- ACTUALIZAR CLIENTE ---")
    dni_cliente = pedir_entero_positivo("Ingrese DNI del cliente a actualizar: ")
    if not existe_dni(dni_cliente):
        print("El DNI no está registrado. No se puede actualizar el cliente.")
    else:
        nombre = input("Ingrese nuevo nombre del cliente: ")
        apellido = input("Ingrese nuevo apellido del cliente: ")
        email = input("Ingrese nuevo email del cliente: ")

        sql = "UPDATE Clientes SET nombre = %s, apellido = %s, email = %s WHERE dni_cliente = %s"
        valores = (nombre, apellido, email, dni_cliente)

        cursor.execute(sql, valores)
        conexion.commit()
        print("Cliente actualizado exitosamente.")
    pausa()


def ver_clientes():
    print("\n--- LISTA DE CLIENTES ---")
    sql = "SELECT dni_cliente, nombre, apellido, email FROM Clientes"
    cursor.execute(sql)
    clientes = cursor.fetchall()

    for cliente in clientes:
        print(f"DNI: {cliente[0]}, Nombre: {cliente[1]}, Apellido: {cliente[2]}, Email: {cliente[3]}")
    pausa()

def buscar_cliente_por_dni():
    print("\n--- BUSCAR CLIENTE POR DNI ---")
    dni_cliente = pedir_entero_positivo("Ingrese DNI del cliente a buscar: ")
    if existe_dni(dni_cliente) == False:
        print("El DNI no está registrado.")

    else:
        sql = "SELECT dni_cliente, nombre, apellido, email FROM Clientes WHERE dni_cliente = %s"
        cursor.execute(sql, (dni_cliente,))
        cliente = cursor.fetchone()
        print(f"DNI: {cliente[0]}, Nombre: {cliente[1]}, Apellido: {cliente[2]}, Email: {cliente[3]}")
    pausa()

def eliminar_cliente():
    print("\n--- ELIMINAR CLIENTE ---")
    dni_cliente = pedir_entero_positivo("Ingrese DNI del cliente a eliminar: ")
    if not existe_dni(dni_cliente):
        print("El DNI no está registrado. No se puede eliminar el cliente.")
    else:
        sql = "DELETE FROM Clientes WHERE dni_cliente = %s"
        cursor.execute(sql, (dni_cliente,))
        conexion.commit()
        print("Cliente eliminado exitosamente.")
    pausa()

# ============================================
# FUNCIONES DE ÓRDENES
# ============================================

def crear_orden():
    cursor = conexion.cursor()

    try:

        conexion.start_transaction()

        codigo = int(input("Código del producto: "))
        dni = int(input("DNI del cliente: "))
        cantidad = int(input("Cantidad pedida: "))


        sql_stock = "SELECT stock, precio FROM Productos WHERE codigo_producto = %s"
        cursor.execute(sql_stock, (codigo,))
        producto = cursor.fetchone()

        if producto is None:
            print("El producto no existe.")
            conexion.rollback()
            return

        stock_actual, precio = producto

        if cantidad > stock_actual:
            print("No hay suficiente stock.")
            conexion.rollback()
            return

        nuevo_stock = stock_actual - cantidad
        sql_update = "UPDATE Productos SET stock = %s WHERE codigo_producto = %s"
        cursor.execute(sql_update, (nuevo_stock, codigo))


        sql_insert = """
            INSERT INTO Ordenes (id_orden, codigo_producto, dni_cliente, cantidad, fecha, total)
            VALUES (%s, %s, %s, %s, CURDATE(), %s)
        """
        total = cantidad * precio

        id_orden = int(input("ID de la orden: "))

        cursor.execute(sql_insert, (id_orden, codigo, dni, cantidad, total))

        conexion.commit()
        print("Orden creada exitosamente.")

    except mysql.connector.Error as error:
        conexion.rollback()
        print("Ocurrió un error. Se canceló la operación:", error)

def mostrar_ordenes_por_cliente():
    print("\n ÓRDENES POR CLIENTE ")
    repetir = True
    while repetir:
        Dni_Cliente = pedir_entero_positivo(
            "Ingrese su DNI (0 para volver): "
        )
        if Dni_Cliente == 0:
            repetir = False
        query = """
            SELECT Ordenes.id_orden, Ordenes.codigo_producto, Productos.nombre_producto, Productos.precio, Ordenes.cantidad, Ordenes.fecha
            FROM Ordenes
            JOIN Productos ON Ordenes.codigo_producto = Productos.codigo_producto JOIN Clientes ON Clientes.dni_cliente = Ordenes.dni_cliente 
            WHERE Clientes.dni_cliente = %s
        """
        cursor.execute(query, (Dni_Cliente,))
        resultados = cursor.fetchall()
        if resultados:
            print("\n Órdenes encontradas:")
            for orden in resultados:
                print(
                    f"ID: {orden[0]} | "
                    f"Nombre De Producto: {orden[2]} | "
                    f"Codigo De Producto: {orden[1]} | "
                    f"Fecha: {orden[5]} | "
                    f"Cantidad: {orden[4]} | "
                    f"Precio: {orden[3]} |"
                )
        else:
            print("\n No se encontraron órdenes para ese DNI...")
    pausa()


# ============================================
# BÚSQUEDAS AVANZADAS
# ============================================

def productos_mas_vendidos():
    print("\n--- PRODUCTOS MÁS VENDIDOS ---")
    cursor = conexion.cursor()
    query = """
        SELECT p.codigo_producto, p.nombre_producto, SUM(o.cantidad) AS total_vendidos
        FROM Ordenes o
        JOIN Productos p ON o.codigo_producto = p.codigo_producto
        GROUP BY p.codigo_producto, p.nombre_producto ORDER BY total_vendidos DESC;
    """
    cursor.execute(query)
    resultados = cursor.fetchall()
    if resultados:
        print("\n Código | Nombre del Producto | Cantidad Vendida")
        print("-----------------------------------------------")
        for codigo, nombre, vendidos in resultados:
            print(f"{codigo} | {nombre} | {vendidos}")
    else:
        print("\nNo hay registros de ventas todavía.")
    cursor.close()
    pausa()


def buscar_productos_por_filtro():
    repet = True
    while repet:
        print("\n BÚSQUEDA AVANZADA DE PRODUCTOS (CON JOIN) ---")
        cursor = conexion.cursor()
        precio_min = float(input("Precio mínimo: "))
        query = """
            SELECT p.codigo_producto, p.nombre_producto, p.precio, SUM(o.cantidad) AS total_vendidos
            FROM Productos p
            JOIN Ordenes o ON p.codigo_producto = o.codigo_producto
            WHERE p.precio > %s
            GROUP BY p.codigo_producto, p.nombre_producto, p.precio ORDER BY total_vendidos DESC;
        """
        cursor.execute(query, (precio_min,))
        resultados = cursor.fetchall()
        print("\n Código | Nombre | Precio | Vendidos")
        print("------------------------------------")
        if resultados:
            for codigo, nombre, precio, vendidos in resultados:
                print(f"{codigo} | {nombre} | ${precio} | {vendidos}")
        else:
            print("No se encontraron productos con ese filtro.")
        cursor.close()
        r = input("\n¿Desea realizar otra búsqueda? (s/n): ").strip().lower()
        if r != "s":
            repet = False
    pausa()

def buscar_clientes_por_filtro():
    repet = True
    while repet:
        print("\n BÚSQUEDA AVANZADA DE CLIENTES POR NOMBRE ---")
        cursor = conexion.cursor()
        nombre = input("Ingrese parte del nombre a buscar: ")
        query = """
            SELECT c.dni_cliente, c.nombre, c.apellido, c.email, COUNT(o.id_orden) AS compras_realizadas
            FROM Clientes c
            LEFT JOIN Ordenes o ON c.dni_cliente = o.dni_cliente
            WHERE c.nombre LIKE %s
            GROUP BY c.dni_cliente, c.nombre, c.apellido, c.email
            ORDER BY compras_realizadas DESC;
        """
        cursor.execute(query, ('%' + nombre + '%',))
        resultados = cursor.fetchall()
        print("\nDNI | Nombre | Apellido | Email | Compras")
        print("------------------------------------------")
        if resultados:
            for dni, nom, ape, mail, compras in resultados:
                print(f"{dni} | {nom} | {ape} | {mail} | {compras}")
        else:
            print("\nNo se encontraron clientes con ese nombre.")
        cursor.close()
        repetir = input("\n¿Desea buscar otro cliente? (s/n): ").strip().lower()
        if repetir != "s":
            repet = False
    pausa()

# ============================================
# 6. MODIFICAR VALOR DE UN PRODUCTO EN ÓRDENES
# ============================================

def modificar_ordenes_por_limite():
    repet = True
    while repet:
        print("\n AJUSTAR ÓRDENES DE UN PRODUCTO ---")
        cursor = conexion.cursor()
        codigo = int(input("Ingrese el código del producto: "))
        limite = int(input("Nueva cantidad máxima permitida: "))
        query = """
            UPDATE Ordenes o
            JOIN Productos p ON o.codigo_producto = p.codigo_producto
            SET o.cantidad = %s
            WHERE o.cantidad > %s AND o.codigo_producto = %s;
        """
        cursor.execute(query, (limite, limite, codigo))
        conexion.commit()
        filas = cursor.rowcount
        if filas > 0:
            print(f"\n Órdenes ajustadas correctamente. ({filas} modificadas)")
        else:
            print("\n No había órdenes que superar el límite dado.")
        cursor.close()
        repetir = input("\n¿Desea modificar otro producto? (s/n): ").strip().lower()
        if repetir != "s":
            repet = False
    pausa()

# ============================================
# MENÚS DEL PROGRAMA
# ============================================

def menu_productos():
    repetir = True
    while repetir:
        print("\n--- GESTIÓN DE PRODUCTOS ---")
        print("1. Agregar producto")
        print("2. Actualizar producto")
        print("3. Ver productos")
        print("4. Eliminar producto")
        print("5. Buscar producto por codigo")
        print("6. Volver al menú principal")

        opcion = input("Elegí una opción: ")

        if opcion == "1":
            agregar_producto()
        elif opcion == "2":
            actualizar_producto()
        elif opcion == "3":
            ver_productos()
        elif opcion == "4":
            eliminar_producto()
        elif opcion == "5":
            buscar_producto()
        elif opcion == "6":
            repetir = False
        else:
            print("Opción inválida.")


def menu_clientes():
    repetir = True
    while repetir:
        print("\n--- GESTIÓN DE CLIENTES ---")
        print("1. Registrar cliente")
        print("2. Actualizar cliente")
        print("3. Ver clientes")
        print("4. Eliminar cliente")
        print("5. Buscar cliente por dni")
        print("6. Volver al menú principal")

        opcion = input("Elegí una opción: ")

        if opcion == "1":
            registrar_cliente()
        elif opcion == "2":
            actualizar_cliente()
        elif opcion == "3":
            ver_clientes()
        elif opcion == "4":
            eliminar_cliente()
        elif opcion == "5":
            buscar_cliente_por_dni()
        elif opcion == "6":
            repetir = False
        else:
            print("Opción inválida.")


def menu_ordenes():
    repetir = True
    while repetir:
        print("\n--- GESTIÓN DE ÓRDENES ---")
        print("1. Mostrar ordenes de un cliente")
        print("2. Crear orden")
        print("3. Volver")

        opcion = input("Elegí una opción: ")

        if opcion == "1":
            mostrar_ordenes_por_cliente()
        elif opcion == "2":
            crear_orden()
        elif opcion == "3":
            repetir = False
        else:
            print("Opción inválida.")


def menu_busquedas():
    repetir = True
    while repetir:
        print("\n--- BÚSQUEDAS AVANZADAS ---")
        print("1. Productos más vendidos")
        print("2. Buscar productos con filtros")
        print("3. Buscar clientes con filtros")
        print("4. Volver")

        opcion = input("Elegí una opción: ")

        if opcion == "1":
            productos_mas_vendidos()
        elif opcion == "2":
            buscar_productos_por_filtro()
        elif opcion == "3":
            buscar_clientes_por_filtro()
        elif opcion == "4":
            repetir = False
        else:
            print("Opción inválida.")


# ============================================
# MENÚ PRINCIPAL
# ============================================

def menu_principal():
    repetir = True
    while repetir:
        print("\n=== SISTEMA DE VENTAS EN LÍNEA ===")
        print("1. Gestión de Productos")
        print("2. Gestión de Clientes")
        print("3. Procesamiento de Órdenes")
        print("4. Búsquedas Avanzadas")
        print("5. Modificar órdenes por límite")
        print("6. Salir")

        opcion = input("Elegí una opción: ")

        if opcion == "1":
            menu_productos()
        elif opcion == "2":
            menu_clientes()
        elif opcion == "3":
            menu_ordenes()
        elif opcion == "4":
            menu_busquedas()
        elif opcion == "5":
            modificar_ordenes_por_limite()
        elif opcion == "6":
            print("\nSaliendo...")
            repetir = False
        else:
            print("Opción inválida.")

menu_principal()

try:
    if conexion.is_connected():
        cursor.close()
        conexion.close()
        print("Conexion cerrada.")
except:
    pass