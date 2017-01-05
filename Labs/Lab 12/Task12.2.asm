.MODEL SMALL
.STACK 100H
.DATA
  PROMPT1 DB 10, 13, "Enter a string: $"
  PROMPT2 DB 10, 13, "Length: $"
  STR1 DB 10 DUP('$')
.CODE
MAIN PROC
  MOV AX, @DATA
  MOV DS, AX ;DATA SEGMENT INITIALIZATION
  MOV ES, AX ;EXTRA SEGMENT INITIALIZATION SO STRING INTRUCTIONS CAN USE ES:DI

  LEA DX, PROMPT1
  MOV AH, 09H
  INT 21H ;DISPLAY PROMPT1

  CLD ;CLEAR DIRECTION FLAG SO ES:DI CAN MOVE FORWARDS
  LEA DI, STR1 ;ES:DI => DI IS POINTING TO STARTING ADDRESS OF STR1
  MOV CX, 9 ;MAX INPUT SIZE
  
  INPUT:
    MOV AH, 01H
    INT 21H ;SINGLE CHARACTER INPUT 
    CMP AL, 13D
    JE END_INPUT ;JUMP IF RETURN IS ENTERED
    STOSB ;MOV CONTENT OF AL TO ES:DI => WHERE DI IS POINTING AND INCREMENTING DI
    LOOP INPUT ;CHECK WHETHER CX IS ZERO TO STOP INPUT 
  
  END_INPUT:
  LEA DX, PROMPT2
  MOV AH, 09H
  INT 21H ;DISPLAY PROMPT2

  LEA DI, STR1 ;ES:DI IS POINTING TO STARTING ADDRESS OF STR1 
  MOV AL, '$' ;MOVING $ TO AL SO SCANSB CAN COMPARE CONTENT OF ES:DI TO AL
  MOV CX, 10 ;COUNTER TO REPEAT SCASB 
  
  REPNE SCASB ;REPEATING COMPARING CONTENT POINTED BY ES:DI TO AL UNTIL $ IS FOUND AUR CX IS ZERO
  
  MOV BX, CX ;MOVING (9 - NUMBER OF CHARACTERS IN STR1)
  MOV CX, 9 
  SUB CX, BX ; 9 - (NUMBER OF EMPTY PLACES IN STR1)
  MOV DL, CL ;MOVING LENGTH OF STR1 TO DL SO IT CAN BE DISPLAYED
  ADD DL, 30H ;CONVERTING IT TO A CHARACTER
  MOV AH, 02H 
  INT 21H ;DISPLAY LENGTH OF STR1

  ;EXIT DOS
  MOV AH, 4CH
  INT 21H
MAIN ENDP
END MAIN