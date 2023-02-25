import serial
from datos import obtener_datos, mensaje_validacion
from buscar import buscar_usuario

user = obtener_datos()
password = obtener_datos()

validacion = buscar_usuario(user, password)

mensaje_validacion(validacion)

print(user, password)
print(validacion)
