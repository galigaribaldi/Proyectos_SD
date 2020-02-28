import pymysql
from datetime import date
today = date.today()
def consulta_usuario(usuario_id):
    mariadb_conexion = pymysql.connect('localhost','gali','12345','base1')
    cursor = mariadb_conexion.cursor()
    cursor.execute("SELECT * FROM USUARIO WHERE USUARIO_ID=%s",(usuario_id,))
    datos = cursor.fetchall()
    mariadb_conexion.commit()
    mariadb_conexion.close()
    return datos

def consulta_usuario_all():
    mariadb_conexion = pymysql.connect('localhost','gali','12345','base1')
    cursor = mariadb_conexion.cursor()
    cursor.execute("SELECT * FROM USUARIO")
    datos = cursor.fetchall()
    mariadb_conexion.commit()
    mariadb_conexion.close()
    return datos

def consulta_cuenta(cuenta_id):
    mariadb_conexion = pymysql.connect('localhost','gali','12345','base1')
    cursor = mariadb_conexion.cursor()
    cursor.execute("SELECT * FROM CUENTA_BANCARIA WHERE CUENTA_BANCARIA_ID=%s",(cuenta_id,))
    datos = cursor.fetchall()
    print(datos)
    mariadb_conexion.commit()
    mariadb_conexion.close()
    return datos

def consulta_cuenta_all():
    mariadb_conexion = pymysql.connect('localhost','gali','12345','base1')
    cursor = mariadb_conexion.cursor()
    cursor.execute("SELECT * FROM CUENTA_BANCARIA")
    datos = cursor.fetchall()
    mariadb_conexion.commit()
    mariadb_conexion.close()
    return datos
#
def actualiza_fecha(cuenta_id):
    mariadb_conexion = pymysql.connect('localhost','gali','12345','base1')
    cursor = mariadb_conexion.cursor()
    cursor.execute("UPDATE CUENTA_BANCARIA SET FECHA_CONSULTA= %s WHERE CUENTA_BANCARIA_ID= %s",(today,cuenta_id, ))
    datos = cursor.fetchall()
    mariadb_conexion.commit()
    mariadb_conexion.close()
    return datos

#mariadb_conexion.close()