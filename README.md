# CALCULATOR-89c52-microcontroller-with-proteus-simulation
CALCULATOR 89c52 microcontroller with proteus simulation
video: https://youtu.be/0oNZom2P7FQ
##Introduction:-
We need to design a calculator using a microcontroller, LCD and a keypad smallcalc. first you 
need to enter the single-digit number then valid operators and in the last another single-digit number. The 
PIC Microcontroller will perform the mathematical operation as per the operator on the entered operands. 
The result will reflect on the LCD. If you will enter anything besides the mentioned steps you will get the 
warning message.

Definition of the problem: 
interface between keypad and lcd 
get average of N numbers given by keybad and display on lcd 
Project hardware requirement 
• One 89c52 microcontroller 
• Bread board or PCB (Making Circuit) 
• 16×2 lcd (Displaying Text) 
• 4×4 keypad (Taking Input) 
• Potentiometer (For setting lcd contrast) 
![image](https://github.com/AdhmElzewel/CALCULATOR-89c52-microcontroller-with-proteus-simulation/assets/108629950/f3be9cbf-c5fd-4a52-a405-2247ccd737c6)

##Components:-
1. LCD
We see in the figure above the LCD and every pin name and its function.
Pin 4 is responsible for register select. There are two options, if the input is zero, then it chooses 
command register. If the input is one, then it chooses data register.
![image](https://github.com/AdhmElzewel/CALCULATOR-89c52-microcontroller-with-proteus-simulation/assets/108629950/1e55cf61-7877-4584-be6e-e603dca42df2)

Command Register: The command register stores the command instruction given to the 
LCD. A command is an instruction given to an LCD to do a predefined task like:
o Initializing it.
o Clearing the screen.
o Setting the curser position.
o Controlling displa
o Data Register: The data register stores the data to be displayed on the LCD. The 
data is the ASCII value of the character to be displayed on the LCD. When we 
send data to LCD, it goes to the data register and is processed there

2. Keypad smallcalc
![image](https://github.com/AdhmElzewel/CALCULATOR-89c52-microcontroller-with-proteus-simulation/assets/108629950/787677d3-58d5-4ac9-bcd6-cd2ec14ef69f)

The keypad is a (4x4) matrix. There 
are four rows and four columns. 
There are eight pins. The first four 
pins for rows and the other four pins 
for columns.
The internal structure of the (4x4) keypad.
![image](https://github.com/AdhmElzewel/CALCULATOR-89c52-microcontroller-with-proteus-simulation/assets/108629950/5678dd93-619b-4c5f-b880-5776d16d9556)
![image](https://github.com/AdhmElzewel/CALCULATOR-89c52-microcontroller-with-proteus-simulation/assets/108629950/a1aefdde-50af-4c6c-9d82-dcf50faff796)

Start message with warn of maximum number to input is 12
![image](https://github.com/AdhmElzewel/CALCULATOR-89c52-microcontroller-with-proteus-simulation/assets/108629950/b3365469-dd7c-4b19-b9ba-9b33547e8f81)

