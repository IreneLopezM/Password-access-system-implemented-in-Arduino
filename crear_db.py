import sqlite3

conexion = sqlite3.connect('dbUsers.db')
cursorObj = conexion.cursor()

cursorObj.execute('CREATE TABLE user(username text, password text)')
conexion.commit()