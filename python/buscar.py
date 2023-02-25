import sqlite3

def buscar_usuario(username, password):
    conexion = sqlite3.connect('dbUsers.db')
    cursor = conexion.cursor()

    cursor.execute(f"""
        SELECT * FROM user 
        where username = '{username}' and 
        password = '{password}'""") 

    if len(cursor.fetchall()) > 0:
        return True

    return False 

#print(buscar_usuario('EREN', '1834'))
