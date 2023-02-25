import serial

port_serial = serial.Serial('COM3')

def obtener_datos():
    cadena = ''
    while True:
        resultado = port_serial.read()
        if resultado == b'\x0e':
                print('Recibido')
                break
        cadena += resultado.decode('utf-8')
        if '\x00' in cadena:
            cadena = cadena[1:]
    return cadena

def mensaje_validacion(validacion):
    if validacion == True:
        port_serial.write(serial.to_bytes([0x31]))
    else:
        port_serial.write(serial.to_bytes([0x32]))
    return
