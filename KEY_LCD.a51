ORG 00H
MOV P1,#0FFH        ; PORT WHICH KEYPAD ARE CONNECTED AND CONFIGURE IT AS OUTPUT  	
ACALL LCD_INT      ;INTIALIZE LCD
// THE COMMING PART TO PRINT WELCOME STATEMENTS 
MOV DPTR, #AVEAGE     ;PRINT "AVERAGE CALC"
ACALL MESSAGE
MOV A, #0C0H       ;TO MAKE CURSUR START OF LINE 2
ACALL LCD_CMD
MOV DPTR, #WELCOME
ACALL MESSAGE
ACALL WAITING     ;TO MAKE USER READ MESSAGE DELAY 2 SECOND  
ACALL WAITING
;*********** -- "ENTRY STATE"  -- ******************
ENTRY:
ACALL CLEAR
MOV R6,#0    ;SUM
MOV R3,#0     ;NUMBER OF ELEMENT 
CLR A
LOOP:
	
			ACALL KEYPAD
			MOV DPTR, #LOOK_UP_TABLE
			ACALL DISP1
			CJNE A,#'=',SKIP
			ACALL EVALUATE_AVG
			ACALL PRINT_INTEGER
			ACALL PRINT_DECIMAL_POINT
	STILL:  ACALL KEYPAD 
		    SJMP STILL
	SKIP:
			INC R3   //COUNTER
			SUBB A,#30h
			ADD A,R6
			MOV R6,A
			
SJMP LOOP

EVALUATE_AVG:
MOV A,R6
ADD A,R3
MOV B,R3
DIV AB
MOV R4,B //REMIDER 
RET
 
PRINT_INTEGER:
		ADD A,#30H
		ACALL LCD_DATA
		
RET
PRINT_DECIMAL_POINT:
		MOV A,#'.'
		ACALL LCD_DATA
		MOV B,R4
		MOV A, #10
		MUL AB
		MOV B, R3
		DIV AB
		ADD A, #30H
		ACALL LCD_DATA

RET

;*********** -- "LONG PRESS" -- ******************
//KEYPAD CODE 
KEYPAD:
N_1: MOV P1, #0F0H
	 MOV A, P1
	 CJNE A, #0F0H, N_1
;*********** -- "DEBOUNCING EFFECT" -- ******************
N_2: MOV P1, #0F0H
	 MOV A, P1
	 CJNE A, # 0F0H, N_3
	 SJMP N_2
N_3: ACALL LDELAY
	 MOV P1, #0F0H
	 MOV A, P1
	 CJNE A, # 0F0H, N_4
	 SJMP N_2
;*****************************
N_4:   MOV P1,#11111111B
   C1: CLR P1.0
   	   JB P1.4, C2
	   MOV A, #0
	   RET
   C2: JB P1.5, C3
	   MOV A, #1
	   RET
   C3: JB P1.6, C4
	   MOV A, #2
	   RET
   C4: JB P1.7, C5
	   MOV A, #3
	   RET
   C5: SETB P1.0
   	   CLR P1.1
	   JB P1.4, C6
	   MOV A, #4
	   RET	
   C6: JB P1.5, C7
	   MOV A, #5
	   RET
   C7: JB P1.6, C8
	   MOV A, #6
	   RET
   C8: JB P1.7, C9
	   MOV A, #7
	   RET
   C9: SETB P1.1
   	   CLR P1.2
	   JB P1.4, C10
	   MOV A, #8
	   RET
  C10: JB P1.5, C11
	   MOV A, #9
	   RET
  C11: JB P1.6, C12
	   MOV A, #10
	   RET
  C12: JB P1.7, C13
	   MOV A, #11
	   RET
  C13: SETB P1.2
  	   CLR P1.3
	   JB P1.4, C14
	   ;MOV A, #0FH
	   ;RET
	   ACALL ENTRY
  C14: JB P1.5, C15
	   MOV A, #13
	   RET
  C15: JB P1.6, C16
	   MOV A, #14
	   RET
  C16: JB P1.7, NEXT
	   MOV A, #15
	   RET
NEXT: LJMP KEYPAD
;*****************************
CLEAR: 
	   MOV A, #02H    ;RETURN HOME 
	   ACALL LCD_CMD
	   MOV A, #01H    ;CLEAR LCD 
	   ACALL LCD_CMD
	   MOV A, #80H    ;LINE ONE FIRST DIGIT 
	   ACALL LCD_CMD
	   MOV A, #0FH    ;DISPLAY ON CURSURE BILINKING 
	   ACALL LCD_CMD
RET
;*****************************

MESSAGE: 
AGAIN: MOV A, #0
	   MOVC A, @A+DPTR
	   JZ FINISH
	   ACALL LCD_DATA
	   INC DPTR
	   SJMP AGAIN
FINISH: RET
;*****************************
DISP1: 
   MOVC A, @A+DPTR
   ACALL LCD_DATA
RET

LCD_INT:
   MOV A, #38H    ;INTIALIZE MATRIX 
   ACALL LCD_CMD
   MOV A, #0CH    ;DISPLAY ON ,CURSUR OFF
   ACALL LCD_CMD
   MOV A, #01H    ;CLEAR LCD
   ACALL LCD_CMD
   MOV A, #06H    ;ENTRY MODE
   ACALL LCD_CMD
   MOV A, #80H    ;STARTE AT LINE 1
   ACALL LCD_CMD
RET
;*****************************
LCD_CMD:
   MOV P2, A
   CLR P3.6
   SETB P3.7
   ACALL SDELAY
   CLR P3.7
   ACALL LDELAY
RET
;*****************************
LCD_DATA:
   MOV P2, A
   SETB P3.6
   SETB P3.7
   ACALL SDELAY
   CLR P3.7
   ACALL LDELAY
RET
;*****************************
WAITING:
   MOV R6, #12
   WAIT2: ACALL LDELAY
   DJNZ R6, WAIT2
RET
;*****************************
LDELAY:
   MOV R0, #50
   G1: MOV R1, #255
   G2: NOP
   NOP
   DJNZ R1, G2
   DJNZ R0, G1
RET
;*****************************
SDELAY:
   MOV R0, #55
   H1: MOV R1, #7
   H2: DJNZ R1, H2
   DJNZ R0, H1
RET
;*****************************
AVEAGE: DB "AVERAGE CALC", 00H
WELCOME: DB "MAX NUM ENTER 12", 00H
LOOK_UP_TABLE:
	DB '7'   ; 0
	DB '8'   ; 1
	DB '9'   ; 2
	DB '/'   ; 3
	DB '4'   ; 4
	DB '5'   ; 5
	DB '6'   ; 6
	DB '*'   ; 7
	DB '1'   ; 8
	DB '2'   ; 9
	DB '3'   ; A
	DB '-'   ; B
	DB 'N'   ; C
	DB '0'   ; D
	DB '='   ; E
	DB '+'   ; F
END
