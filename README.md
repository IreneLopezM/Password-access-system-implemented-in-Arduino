# Password access system implemented in Arduino
## Index
1. Project
2. Run and deploy
   - 2.1. Setup
   - 2.2. Build the circuit
   - 2.3. Arduino setup
   - 2.4. Python
   - 2.5. Try the project 


## 1. Project 
Access Control developed in Assembler and implemented in an Arduino with a matrix keypad for the user to enter their name and password.

## 2. Run and deploy
In order to test the access system, you must first follow the steps below to install it.

> ### 2.1. Setup
You need to install the following:
* [Python 3.8 64bits](https://www.python.org/downloads/)
* [DB Browser for SQLite](https://sqlitebrowser.org/dl/)
* [AVRDUDESS](https://github.com/IreneLopezM/Password-access-system-implemented-in-Arduino/raw/main/setup-AVRDUDESS-2.4.exe)
* [Microchip Studio](https://www.microchip.com/en-us/tools-resources/develop/microchip-studio#Downloads)

<br>

> ### 2.2 Build the circuit
Materials:
* Arduino UNO
* Display LCD 16x2
* Matrix Membrane Keypad 4x4
* 1 red LED
* 1 green LED
* Potentiometer 10k
* 2 resistors 330 ohms 

Build the circuit as follows:

![circuit](https://user-images.githubusercontent.com/107958147/221370532-595e8fca-23ef-4cf1-a3ca-a7515763cca8.JPG)

<br>

> ### 2.3 Arduino setup 
1. Download the “arduino” folder.
2. Connect your Arduino to the computer.
3. Open the AVRDUDDES programmer.
   - 3.1. In the "Programmer" section choose the "Arduino" option.
   - 3.2. In the "Port (-P)" section choose the port where your Arduino is connected.
   - 3.3. Click on the "Detect" button, the program should detect the microchip of your Arduino, in this case it should be "ATmega328P".
   - 3.4. In the "Flash" section choose the path where the "arduino.hex" file is.
   - 3.5. Finally, click on "Program!" button and wait for the program to load on the Arduino.

It should look similar to this screenshot.

![arduino](https://user-images.githubusercontent.com/107958147/221370524-4b6879d2-1550-42c9-9289-6f68f52075d5.JPG)

4. In case you want to modify the program.
   - 4.1 Open Microchip Studio and select the "arduino.atsln" file.
   - 4.2 Make the changes you want.
   - 4.3 And click on the "Build" section and select "Rebuild Solution" to get the arduino.hex file.
   - 4.4 Go back to step 3 to upload the program to the arduino.

<br>

> ### 2.4 Python
1. Download the "python" folder. 
2. In the terminal, run the "main.py" file. `python main.py`

<br>

> ### 2.5 Try the project
The keypad layout is as follows:

![conf](https://user-images.githubusercontent.com/107958147/221371524-3d293e17-b5f3-4180-9a79-9a6001cdf269.JPG)

Access with the following names and passwords:

| Username | Password |
|  :---:   |  :---:   |
|  IRENE   |   1234   |
|   RAUL   |   5678   |
|  JIMENA  |   7863   |
|  ULISES  |   4854   |

1.	First, enter the username and press "Send" button.
2.	Next, enter the password and press "Send" button.

If you entered the data correctly, the message "Bienvenido" will appear on the display and the green led will light up.

Otherwise, the message "Error" will appear and the red LED will light up.

